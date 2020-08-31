package com.sbs.lyb.pp.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.dto.Message;
import com.sbs.lyb.pp.dto.ResultData;
import com.sbs.lyb.pp.service.MemberService;
import com.sbs.lyb.pp.service.MessageService;

@Controller
public class MessageController {
	@Autowired
	private MessageService messageService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/usr/message/sendMessage")
	public String showSendMessage(int getterId, Model model) {
		
		Member member = memberService.getMemberById(getterId);
		model.addAttribute("getterId", getterId);
		model.addAttribute("member", member);
		return "/message/sendMessage";
	}
	
	@RequestMapping("/usr/message/doSendMessage")
	public String doSendMessage(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		messageService.sendMessage(param);
		model.addAttribute("alertMsg", String.format("쪽지를 보냈습니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/message/detail")
	public String showDetail(int id, String uuid, Model model, HttpSession session) {
		int loginedMemberId = (int) session.getAttribute("loginedMemberId");

		ResultData checkValidCheckPasswordAuthCodeResultData = memberService.checkValidCheckPasswordAuthCode(loginedMemberId, uuid);

		if (uuid == null || uuid.length() == 0) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "인증코드가 없습니다.");
			return "common/redirect";
		}

		if (checkValidCheckPasswordAuthCodeResultData.isFail()) {
			model.addAttribute("redirectUrl", "/usr/member/checkPw");
			model.addAttribute("alertMsg", checkValidCheckPasswordAuthCodeResultData.getMsg());
			return "common/redirect";
		}
		
		Message message = messageService.getMessageById(id);
		if (message == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "잘못된 경로.");
			return "common/redirect";
		}
		model.addAttribute("message", message);
		return "/message/detail";
	}
	
	@RequestMapping("/usr/message/deleteMessage")
	public String doDeleteMessage(int id, Model model) {
		messageService.deleteMessage(id);
		model.addAttribute("historyBack", true);
		model.addAttribute("alertMsg", "쪽지를 삭제하였습니다.");
		return "common/redirect";
	}
}
