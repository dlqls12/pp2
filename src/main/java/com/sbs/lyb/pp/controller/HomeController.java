package com.sbs.lyb.pp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.service.ArticleService;

@Controller
public class HomeController {
	@Autowired
	private ArticleService articleService;
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		List<Article> noticeArticleList = articleService.getArticlesSortByBoard(2, 0, 5, 0, "");
		List<Article> freeArticleList = articleService.getArticlesSortByBoard(1, 0, 5, 0, "");
		
		model.addAttribute("noticeArticleList", noticeArticleList);
		model.addAttribute("freeArticleList", freeArticleList);
		
		return "/home/main";
	}
}