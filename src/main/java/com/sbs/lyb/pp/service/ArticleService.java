package com.sbs.lyb.pp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.ArticleDao;
import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.Board;

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

	public void write(String title, String body, int memberId, int boardId) {
		articleDao.write(title, body, memberId, boardId);
	}
}