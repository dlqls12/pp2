package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.Board;

@Mapper
public interface ArticleDao {

	List<Article> getForPrintArticles(int boardId);

	Article getForPrintArticleById(int id);

	Board getBoardByCode(String code);

	void write(Map<String, Object> param);

	List<Article> getArticlesSortByBoard(int id, int itemsInAPage, int limitFrom);

	void delete(int id);
}
