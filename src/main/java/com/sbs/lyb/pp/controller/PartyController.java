package com.sbs.lyb.pp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dto.Party;
import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.service.PartyService;
import com.sbs.lyb.pp.service.MemberService;
import com.sbs.lyb.pp.util.Util;

@Controller
public class PartyController {
	@Autowired
	private PartyService partyService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/usr/party/createParty")
	public String showCreateParty(HttpServletRequest req, Model model) {
		
		Member member = (Member) req.getAttribute("loginedMember");
		if ( member.getPartyId() > 0 ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("소속된 그룹은 한개여야 합니다."));
			return "/common/redirect";
		}
		return "/party/createParty";
	}
	
	@RequestMapping("/usr/party/doCreateParty")
	public String doCreateParty(@RequestParam Map<String, Object> param, String redirectUrl, HttpServletRequest req, Model model) {
		int id = Util.getAsInt(param.get("id"));
		String name = Util.getAsStr(param.get("name"));
		Party party = partyService.getPartyByName(name);
		
		Member member = (Member) req.getAttribute("loginedMember");
		if ( member.getPartyId() > 0 ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("소속된 그룹은 한개여야 합니다."));
			return "/common/redirect";
		}
		
		if ( party != null ) {
			redirectUrl = "/usr/party/partyPage?id=" + party.getId();
			model.addAttribute("alertMsg", String.format("해당 그룹은 이미 존재합니다."));
			model.addAttribute("redirectUrl", redirectUrl);
			return "/common/redirect";
		}
		
		int newPartyId = partyService.createParty(param);
		memberService.joinParty(id, newPartyId);
		redirectUrl = redirectUrl.replace("#id", newPartyId + "");
		model.addAttribute("alertMsg", String.format("%s 그룹이 생성 되었습니다.", name));
		model.addAttribute("redirectUrl", redirectUrl);
		return "/common/redirect";
	}
	
	@RequestMapping("/usr/party/partyPage")
	public String showPartyPage(int id, Model model) {
		Party party = partyService.getPartyById(id);
		
		if ( party == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("잘못된 경로!"));
			return "/common/redirect";
		}
		
		model.addAttribute("party", party);
		return "/party/partyPage";
	}
	
	@RequestMapping("/usr/party/doJoinParty")
	public String doJoinParty(int id, int partyId, Model model) {
		Party party = partyService.getPartyById(partyId);
		Member member = memberService.getMemberById(id);
		
		if ( member.getPartyId() > 0 ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("소속된 그룹은 한개여야 합니다."));
			return "/common/redirect";
		}
		
		memberService.joinParty(id, partyId);
		String redirectUrl = "/usr/party/partyPage?id=" + partyId;
		model.addAttribute("alertMsg", String.format("%s 그룹에 가입되었습니다.", party.getName()));
		model.addAttribute("redirectUrl", redirectUrl);
		return "/common/redirect";
	}
	
	@RequestMapping("/usr/party/doSignOutParty")
	public String doSignOutParty(int id, int partyId, Model model) {
		Member member = memberService.getMemberById(id);
		Party party = partyService.getPartyById(partyId);
		
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "잘못된 경로!");
			return "/common/redirect";
		}
		
		if ( member.getPartyId() == 0 ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "잘못된 경로!");
			return "/common/redirect";
		}
		
		if ( party.getMemberCount() == 1 ) {
			memberService.resetPartyId(id, party.getId());
			partyService.delete(party.getId(), party.getCode());
		}
		else {
			memberService.resetPartyId(id, party.getId());
		}
		
		model.addAttribute("alertMsg", String.format("%s그룹에서 탈퇴하셨습니다.", party.getName()));
		model.addAttribute("redirectUrl", "/usr/home/main");
		return "/common/redirect";
	}
	
	@RequestMapping("/usr/party/seekParty")
	public String showSeekParty(String searchKeyword, Model model) {
		if ( searchKeyword == null ) {
			return "/party/seekParty";
		}
		
		List<Party> partyList = partyService.getPartyListBySearchKeyword(searchKeyword);
		int partyCount = partyList.size();
		System.out.println("partyCount: " + partyCount);
		model.addAttribute("partyCount", partyCount);
		model.addAttribute("partyList", partyList);
		return "/party/seekParty";
	}
}
