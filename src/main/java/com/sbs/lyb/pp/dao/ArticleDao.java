package com.sbs.lyb.pp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.Board;

@Mapper
public interface ArticleDao {

	List<Article> getForPrintArticles();

	Article getForPrintArticleById(int id);

	Board getBoardByCode(String code);

	void write(@Param("id") String title, String body, int memberId , int boardId);
}
