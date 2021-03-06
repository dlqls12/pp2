package com.sbs.lyb.pp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lyb.pp.dto.Party;
import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.dto.Message;
import com.sbs.lyb.pp.dto.ResultData;
import com.sbs.lyb.pp.service.PartyService;
import com.sbs.lyb.pp.service.MemberService;
import com.sbs.lyb.pp.service.MessageService;
import com.sbs.lyb.pp.util.Util;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;
	@Autowired
	MessageService messageService;
	@Autowired
	PartyService partyService;

	@RequestMapping("/usr/member/signOut")
	public String showSignOut() {
		return "/member/signOut";
	}
	
	@RequestMapping("/usr/member/doSignOut")
	public String doSignOut(HttpSession session, @RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		int id = Util.getAsInt(param.get("id"));
		String loginPw = Util.getAsStr(param.get("loginPwReal"));
		Member member = memberService.getMemberById(id);

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		memberService.signOut(id);
		session.removeAttribute("loginedMemberId");
		
		model.addAttribute("alertMsg", String.format("회원탈퇴가 완료되었습니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/join")
	public String showJoin() {
		return "/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		String authCode = (String)param.get("authCode");
		
		if ( authCode == null || authCode.trim().length() == 0 ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "인증코드를 입력해주세요.");
			return "common/redirect";
		}
		
		ResultData checkLoginIdJoinableResultData = memberService.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String newMemberNickname = Util.getAsStr(param.get("nickname"));
		String msg = newMemberId + "." + newMemberNickname + "님 환영합니다.";
		String redirectUrl = (String) param.get("redirectUrl");
		model.addAttribute("alertMsg", msg);
		model.addAttribute("redirectUrl", redirectUrl);

		return "common/redirect";
	}

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUrl, Model model, HttpSession session) {
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}
		
		int id = member.getId();
		
		if (member.getDelStatus() == 1) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		session.setAttribute("loginedMemberId", id);
		model.addAttribute("redirectUrl", redirectUrl);
		
		List<Message> messageList = messageService.getAllMessageList(id);
		System.out.println("messageList:" + messageList);
		int count = 0;
		for (int i = 0; i < messageList.size(); i++) {
			if ( messageList.get(i).isReadStatus() == false ) {
				count++;
			}
		}
		System.out.println("count:" + count);
		
		
		if (count > 0) {
			model.addAttribute("alertMsg", String.format("읽지 않은 메세지가 %d개 있습니다.", count));
			return "common/redirect";
		}
		
		if (memberService.isUsingTmpPw(id)) {
			model.addAttribute("alertMsg", String.format("현재 임시 비밀번호를 사용중입니다. 비밀번호를 변경해주세요."));
		}
		else {
			model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));
		}

		return "common/redirect";
	}

	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUrl) {
		session.removeAttribute("loginedMemberId");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/usr/home/main";
		}
		
		model.addAttribute("alertMsg", "로그아웃 되었습니다.");
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/modifyMemberInfo")
	public String showModifyMemberInfo(int page, Model model, HttpSession session, String uuid) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService.checkValidCheckPasswordAuthCode(loginedMemberId, uuid);

		if (uuid == null || uuid.length() == 0) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호 체크 인증코드가 없습니다.");
			return "common/redirect";
		}

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			model.addAttribute("redirectUrl", "/usr/member/checkPw");
			model.addAttribute("alertMsg", checkValidCheckPasswordAuthCodeResultData.getMsg());
			return "common/redirect";
		}
		
		Member loginedMember = memberService.getMemberById(loginedMemberId);
		List<Message> allMessageList = messageService.getAllMessageList(loginedMemberId);
		
		int size = allMessageList.size();
		int limitFrom = (page - 1) * 10;
		int itemsInAPage = 10;
		int fullPage = 0;
		if (size % itemsInAPage == 0) {
			fullPage = size / itemsInAPage;
		} else {
			fullPage = size / itemsInAPage + 1;
		}
		
		List<Message> messageList = messageService.getMessageList(loginedMemberId, itemsInAPage, limitFrom);
		if ( loginedMember.getPartyId() > 0 ) {
			Party party = partyService.getPartyById(loginedMember.getPartyId());
			model.addAttribute("partyName", party.getName());
		}
		
		model.addAttribute("page", page);
		model.addAttribute("loginedMember", loginedMember);
		model.addAttribute("messageList", messageList);
		model.addAttribute("uuid", uuid);
		model.addAttribute("fullPage", fullPage);
		return "/member/modifyMemberInfo";
	}

	@RequestMapping("/usr/member/doModifyMemberInfo")
	public String doModifyMemberInfo(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		memberService.modifyMemberInfo(param);

		model.addAttribute("alertMsg", String.format("회원 정보가 수정되었습니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/modifyPw")
	public String showModifyPw(HttpSession session, String uuid, Model model) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService.checkValidCheckPasswordAuthCode(loginedMemberId, uuid);

		if (uuid == null || uuid.length() == 0) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호 체크 인증코드가 없습니다.");
			return "common/redirect";
		}

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			model.addAttribute("redirectUrl", "/usr/member/checkPw");
			model.addAttribute("alertMsg", checkValidCheckPasswordAuthCodeResultData.getMsg());
			return "common/redirect";
		}
		
		model.addAttribute("uuid", uuid);
		return "/member/modifyPw";
	}

	@RequestMapping("/usr/member/doModifyPw")
	public String doModifyPw(@RequestParam Map<String, Object> param, Model model, String redirectUrl, String uuid) {
		memberService.modifyMemberPw(param);

		model.addAttribute("alertMsg", String.format("비밀번호가 변경되었습니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/checkPw")
	public String showCheckPw() {
		return "/member/checkPw";
	}

	@RequestMapping("/usr/member/doCheckPw")
	public String doCheckPw(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		int id = Util.getAsInt(param.get("id"));
		String loginPw = Util.getAsStr(param.get("loginPwReal"));
		Member member = memberService.getMemberById(id);

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		String uuid = memberService.genCheckPasswordAuthCode(member.getId());

		redirectUrl = redirectUrl.replace("#uuid", uuid + "");
		System.out.println("uuid:" + uuid);
		model.addAttribute("alertMsg", String.format("마이페이지로 이동합니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/seekLoginId")
	public String showSeekLoginId() {
		return "/member/seekLoginId";
	}

	@RequestMapping("/usr/member/doSeekLoginId")
	public String doSeekLoginId(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		String name = Util.getAsStr(param.get("name"));
		String email = Util.getAsStr(param.get("email"));
		Member member = memberService.getMemberByEmail(email);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getName().equals(name) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "일치하는 회원을 찾을 수 없습니다.");
			return "common/redirect";
		}
		String title = "아이디 찾기 결과입니다.";
		String body = String.format("아이디는 [%s] 입니다.", member.getLoginId());
		memberService.sendMail(email, title, body);
		model.addAttribute("alertMsg", String.format("해당 이메일로 아이디를 발송합니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/seekLoginPw")
	public String showSeekLoginPw() {
		return "/member/seekLoginPw";
	}

	@RequestMapping("/usr/member/doSeekLoginPw")
	public String doSeekLoginPw(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		String loginId = Util.getAsStr(param.get("loginId"));
		String email = Util.getAsStr(param.get("email"));
		Member member = memberService.getMemberByEmail(email);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "일치하는 회원을 찾을 수 없습니다.");
			return "common/redirect";
		}

		if (member.getLoginId().equals(loginId) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "일치하는 회원을 찾을 수 없습니다.");
			return "common/redirect";
		}
		String tmpPw = Util.numberGen(6, 2);
		
		memberService.modifyMemberPwTemp(tmpPw, member.getId());
		String title = "비밀번호 찾기 결과입니다.";
		String body = String.format("임시 비밀번호를 발급합니다.\n 임시 비밀번호는 [%s] 입니다.", tmpPw);
		memberService.sendMail(email, title, body);
		model.addAttribute("alertMsg", String.format("해당 이메일로 아이디를 발송합니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	public ResultData doGetLoginIdDup(@RequestParam Map<String, Object> param) {
		String loginId = Util.getAsStr(param.get("loginId"));
		Member member = memberService.getMemberByLoginId(loginId);
		
		if ( member == null ) {
			return new ResultData("S-1", String.format("입력하신 아이디는 사용하실 수 있습니다."), loginId);
		}
		return new ResultData("F-1", String.format("입력하신 아이디가 이미 존재합니다."), loginId);
	}
	
	@RequestMapping("/usr/member/getEmailDup")
	@ResponseBody
	public ResultData doGetEmailDup(@RequestParam Map<String, Object> param) {
		String email = Util.getAsStr(param.get("email"));
		Member member = memberService.getMemberByEmail(email);
		
		if ( member == null ) {
			String authCode = Util.numberGen(6, 2);
			String title = "이메일 인증";
			String body = String.format("이메일 인증코드 : [%s]", authCode);
			memberService.setAuthCode(authCode, email);
			memberService.sendMail(email, title, body);
			return new ResultData("S-1", String.format("인증 메일을 발송했습니다. 이메일을 확인해주세요."), email);
		}
		return new ResultData("F-1", String.format("입력하신 이메일이 이미 존재합니다."), email);
	}
	
	@RequestMapping("/usr/member/checkAuthCode")
	@ResponseBody
	public ResultData doCheckAuthCode(@RequestParam Map<String, Object> param) {
		String authCode = Util.getAsStr(param.get("authCode"));
		String email = Util.getAsStr(param.get("email"));
		
		String authCode2 = memberService.getJoinMailAuthCode(email);
		
		if ( authCode.equals(authCode2) ) {
			return new ResultData("S-1", String.format("인증이 완료되었습니다."), authCode);
		}
		return new ResultData("F-1", String.format("인증번호가 일치하지 않습니다."), authCode);
	}
	
	@RequestMapping("/usr/member/memberPage")
	public String showMemberPage(Model model, int id) {
		Member member = memberService.getMemberById(id);
		Party party = partyService.getPartyById(member.getPartyId());
	
		model.addAttribute("member", member);
		model.addAttribute("party", party);
		return "/member/memberPage";
	}
}