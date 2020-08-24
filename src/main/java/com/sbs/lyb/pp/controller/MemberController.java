package com.sbs.lyb.pp.controller;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.dto.ResultData;
import com.sbs.lyb.pp.service.MemberService;
import com.sbs.lyb.pp.util.Util;

@Controller
public class MemberController {
	@Autowired
	MemberService memberService;

	@RequestMapping("/usr/member/join")
	public String join() {
		return "/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		ResultData checkLoginIdJoinableResultData = memberService
				.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));

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
	public String login() {
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

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());
		model.addAttribute("redirectUrl", redirectUrl);
		model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));

		return "common/redirect";
	}

	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUrl) {
		session.removeAttribute("loginedMemberId");

		if (redirectUrl == null || redirectUrl.length() == 0) {
			redirectUrl = "/usr/home/main";
		}

		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/modifyMemberInfo")
	public String modifyMemberInfo(Model model, HttpSession session, String uuid) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService
				.checkValidCheckPasswordAuthCode(loginedMemberId, uuid);

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
		model.addAttribute("loginedMember", loginedMember);
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
	public String modifyPw() {
		return "/member/modifyPw";
	}

	@RequestMapping("/usr/member/doModifyPw")
	public String doModifyPw(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		memberService.modifyMemberPw(param);

		model.addAttribute("alertMsg", String.format("비밀번호가 변경되었습니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/checkPw")
	public String checkPw() {
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
		System.out.println("UUID: " + uuid);

		redirectUrl = redirectUrl.replace("#uuid", uuid + "");
		System.out.println("uuid:" + uuid);
		model.addAttribute("alertMsg", String.format("마이페이지로 이동합니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}

	@RequestMapping("/usr/member/seekLoginId")
	public String seekLoginId() {
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
	public String seekLoginPw() {
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
		System.out.println(tmpPw);
		memberService.modifyMemberPwTemp(tmpPw, member.getId());
		String title = "비밀번호 찾기 결과입니다.";
		String body = String.format("임시 비밀번호를 발급합니다.\n 임시 비밀번호는 [%s] 입니다.", tmpPw);
		memberService.sendMail(email, title, body);
		model.addAttribute("alertMsg", String.format("해당 이메일로 아이디를 발송합니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
}