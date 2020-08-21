package com.sbs.lyb.pp.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.Board;
import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		List<Article> articles = articleService.getArticlesSortByBoard(board.getId());

		model.addAttribute("articles", articles);

		return "/article/list";
	}
	
	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, @PathVariable("boardCode") String boardCode, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Article article = articleService.getForPrintArticleById(id);

		model.addAttribute("article", article);

		return "/article/detail";
	}
	
	@RequestMapping("/usr/article/{boardCode}-write")
	public String write(@PathVariable("boardCode") String boardCode, Model model, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		return "/article/write";
	}
	
	@RequestMapping("/usr/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, @PathVariable("boardCode") String boardCode, Model model, String redirectUrl, HttpServletRequest req) {
		Board board = articleService.getBoardByCode(boardCode);
		int boardId = board.getId();
		Member member = (Member) req.getAttribute("loginedMember");
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("로그인 후 이용하실 수 있습니다.12323231131"));
			return "common/redirect";
		}
		int memberId = member.getId(); 
		param.put("boardId", boardId);
		param.put("memberId", memberId);
		System.out.println(param);
		int newArticleId = articleService.write(param);
		
		redirectUrl = redirectUrl.replace("#id", newArticleId + "");
		model.addAttribute("alertMsg", String.format("%d번 글 작성 완료.", newArticleId));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
}
