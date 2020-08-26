package com.sbs.lyb.pp.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyDao {

	void replyWrite(Map<String, Object> param);
}