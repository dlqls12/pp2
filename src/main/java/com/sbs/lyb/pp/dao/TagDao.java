package com.sbs.lyb.pp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Tag;

@Mapper
public interface TagDao {

	void addTag(int id, String tag);

	List<Tag> getTagList(int id);
}