package com.sbs.lyb.pp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@RequestMapping("/member/join")
	public String showJoin() {
		return "member/join";
	}
}
