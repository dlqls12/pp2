package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Reply;

@Mapper
public interface ReplyDao {

	void replyWrite(Map<String, Object> param);

	List<Reply> getForPrintReplies(int id);

	void replyModify(Map<String, Object> param);
}