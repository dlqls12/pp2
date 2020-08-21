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
		
	public List<Article> getForPrintArticles() {
		return articleDao.getForPrintArticles();
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

	public List<Article> getArticlesSortByBoard(int id) {
		return articleDao.getArticlesSortByBoard(id);
	}
}