package com.sbs.lyb.pp.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lyb.pp.dto.ResultData;
import com.sbs.lyb.pp.service.ReplyService;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/usr/reply/doReplyWriteAjax")
	@ResponseBody
	public ResultData doReplyWrite(@RequestParam Map<String, Object> param) {
		replyService.replyWrite(param);
		return new ResultData("S-1", String.format("댓글 작성완료."));
	}
	
	@RequestMapping("/usr/reply/doReplyModifyAjax")
	@ResponseBody
	public ResultData doReplyModify(@RequestParam Map<String, Object> param) {
		replyService.replyModify(param);
		return new ResultData("S-1", String.format("댓글 수정완료."));
	}	
}