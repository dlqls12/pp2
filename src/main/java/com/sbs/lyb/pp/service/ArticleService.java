package com.sbs.lyb.pp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.ArticleDao;
import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.Board;
import com.sbs.lyb.pp.util.Util;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
		
	public List<Article> getForPrintArticles(int boardId) {
		return articleDao.getForPrintArticles(boardId);
	}

	public Article getForPrintArticleById(int id) {
		return articleDao.getForPrintArticleById(id);
	}

	public Board getBoardByCode(String code) {
		return articleDao.getBoardByCode(code);
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);
		int id = Util.getAsInt(param.get("id"));
		return id;
	}

	public List<Article> getArticlesSortByBoard(int id, int itemsInAPage, int limitFrom) {
		return articleDao.getArticlesSortByBoard(id, itemsInAPage, limitFrom);
	}

	public void delete(int id) {
		articleDao.delete(id);
	}

	public void modify(Map<String, Object> param) {
		articleDao.modify(param);
	}
}