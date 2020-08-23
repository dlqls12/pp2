package com.sbs.lyb.pp.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.lyb.pp.service.AttrService;

@Controller
public class TestController {
	@Autowired
	private AttrService attrService;

	@RequestMapping(value = "/usr/test/getAttr", method = RequestMethod.GET)
	@ResponseBody
	public String getAttr(HttpServletResponse response) throws IOException {
		attrService.setValue("member__4__common__a", "안녕", null);

		return attrService.getValue("member__4__common__a");
	}
}