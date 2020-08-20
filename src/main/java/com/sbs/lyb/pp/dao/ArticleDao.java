package com.sbs.lyb.pp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Article;

@Mapper
public interface ArticleDao {

	List<Article> getForPrintArticles();

	Article getForPrintArticleById(int id);
}
