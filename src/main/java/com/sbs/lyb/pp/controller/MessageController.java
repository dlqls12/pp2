package com.sbs.lyb.pp.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.service.MessageService;

@Controller
public class MessageController {
	@Autowired
	private MessageService messageService;
	
	@RequestMapping("/usr/message/doSendMessage")
	public String doSendMessage(@RequestParam Map<String, Object> param, Model model, String redirectUrl) {
		messageService.sendMessage(param);
		model.addAttribute("alertMsg", String.format("쪽지를 보냈습니다."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}	
}
