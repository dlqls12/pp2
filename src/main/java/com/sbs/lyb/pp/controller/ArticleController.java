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
import com.sbs.lyb.pp.dto.Reply;
import com.sbs.lyb.pp.dto.Tag;
import com.sbs.lyb.pp.service.ArticleService;
import com.sbs.lyb.pp.service.ReplyService;
import com.sbs.lyb.pp.service.TagService;
import com.sbs.lyb.pp.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private TagService tagService;

	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode, int page, int sortId, String searchKeyword, String searchTag) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		List<Article> allArticles = articleService.getForPrintArticles(board.getId(), sortId, searchKeyword);
		
		int size = allArticles.size();
		int limitFrom = (page - 1) * 10;
		int itemsInAPage = 10;
		int fullPage = 0;
		if (size % itemsInAPage == 0) {
			fullPage = size / itemsInAPage;
		} else {
			fullPage = size / itemsInAPage + 1;
		}
		
		List<Article> articles = articleService.getArticlesSortByBoard(board.getId(), sortId, itemsInAPage, limitFrom, searchKeyword);
		model.addAttribute("articles", articles);
		model.addAttribute("fullPage", fullPage);
		model.addAttribute("page", page);
		if ( board.getId() > 2 ) {
			model.addAttribute("sortId", sortId);
		}
		
		return "/article/list";
	}

	@RequestMapping("/usr/article/{boardCode}-detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl, int page) {
		if (listUrl == null) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);

		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);

		int id = Integer.parseInt((String) param.get("id"));
		Member loginedMember = (Member)req.getAttribute("loginedMember");

		Article article = articleService.getForPrintArticleById(loginedMember, id);
		List<Reply> allReplies = replyService.getReplies(id);
		
		int size = allReplies.size();
		int limitFrom = (page - 1) * 10;
		int itemsInAPage = 10;
		int fullPage = 0;
		if (size % itemsInAPage == 0) {
			fullPage = size / itemsInAPage;
		} else {
			fullPage = size / itemsInAPage + 1;
		}
		List<Reply> replies = replyService.getForPrintReplies(id, itemsInAPage, limitFrom);
		
		model.addAttribute("replies", replies);
		model.addAttribute("article", article);
		model.addAttribute("fullPage", fullPage);
		model.addAttribute("page", page);
		
		List<Tag> tagList = tagService.getTagList(id);
		model.addAttribute("tagList", tagList);
		
		return "/article/detail";
	}

	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, Model model, String listUrl) {
		if (listUrl == null) {
			listUrl = "./" + boardCode + "-list?page=1&sortId=0";
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
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "sortId", "fileIdsStr");
		
		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("로그인 후 이용하실 수 있습니다."));
			return "common/redirect";
		}
		
		int memberId = member.getId();
		newParam.put("boardId", boardId);
		newParam.put("memberId", memberId);
		int newArticleId = articleService.write(newParam);
		
		String tag = Util.getAsStr(param.get("tag"));
		tagService.addTag(newArticleId, tag);

		redirectUrl = redirectUrl.replace("#id", newArticleId + "");
		model.addAttribute("alertMsg", String.format("%d번 글 작성 완료.", newArticleId));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/article/{boardCode}-doDelete")
	public String doDelete(@PathVariable("boardCode") String boardCode, Model model, int id) {
		String redirectUrl = String.format("/usr/article/%s-list?page=1&sortId=0", boardCode);
		
		articleService.delete(id);
		tagService.deleteTag(id);
		
		
		model.addAttribute("alertMsg", String.format("%d번 글이 삭제되었습니다.", id));
		model.addAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/article/{boardCode}-modify")
	public String showModify(@PathVariable("boardCode") String boardCode, HttpServletRequest req, Model model, int id, String listUrl) {
		if (listUrl == null) {
			listUrl = "./" + boardCode + "-list?page=1";
		}
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		Member member = (Member)req.getAttribute("loginedMember");
		Article article = articleService.getForPrintArticleById(member, id);
		model.addAttribute("listUrl", listUrl);
		model.addAttribute("article", article);

		return "article/modify";
	}
	
	@RequestMapping("/usr/article/{boardCode}-doModify")
	public String doModify(@RequestParam Map<String, Object> param, Model model, String redirectUrl, HttpServletRequest req) {
		
		Member member = (Member) req.getAttribute("loginedMember");
		
		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("로그인 후 이용하실 수 있습니다."));
			return "common/redirect";
		}
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		int id = Util.getAsInt(param.get("id"));
		articleService.modify(newParam);
		
		String tag = Util.getAsStr(param.get("tag"));
		tagService.modifyTag(id, tag);

		model.addAttribute("alertMsg", String.format("%d번 글 수정 완료.", id));
		model.addAttribute("redirectUrl", redirectUrl);
		
		return "common/redirect";
	}
}
