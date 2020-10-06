package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.Board;

@Mapper
public interface ArticleDao {

	List<Article> getForPrintArticles(@Param("boardId") int boardId, @Param("sortId") int sortId, @Param("searchKeyword") String searchKeyword);

	Article getForPrintArticleById(@Param("id") int id);

	Board getBoardByCode(@Param("boardCode") String code);

	void write(Map<String, Object> param);

	List<Article> getArticlesSortByBoard(@Param("id") int id, @Param("sortId") int sortId, @Param("itemsInAPage")int itemsInAPage
			, @Param("limitFrom")int limitFrom, @Param("searchKeyword") String searchKeyword);

	void delete(int id);

	void modify(Map<String, Object> param);

	List<Article> getArticlesByMemberId(int memberId);

	void addHit(int id);

	void dealComplete(int articleId);

	List<Article> getArticles(String searchKeyword);
}
