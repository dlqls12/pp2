package com.sbs.lyb.pp.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.service.ReplyService;
import com.sbs.lyb.pp.util.Util;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/usr/reply/doReplyWrite")
	public String doReplyWrite(@RequestParam Map<String, Object> param, Model model, String redirectUrl, HttpServletRequest req) {
		replyService.replyWrite(param);
		int articleId = Util.getAsInt(param.get("articleId"));
				
		redirectUrl = redirectUrl.replace("#id", articleId + "");
		model.addAttribute("alertMsg", String.format("댓글 작성 완료."));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/reply/doReplyModify")
	public String doReplyModify(@RequestParam Map<String, Object> param, Model model, String redirectUrl, HttpServletRequest req) {
		replyService.replyModify(param);
		int id = Util.getAsInt(param.get("id"));
		int articleId = Util.getAsInt(param.get("articleId"));
		
		redirectUrl = redirectUrl.replace("#id", articleId + "");
		model.addAttribute("alertMsg", String.format("%d번 댓글 수정 완료.", id));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}	
}