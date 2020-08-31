package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Message;

@Mapper
public interface MessageDao {

	void sendMessage(Map<String, Object> param);

	List<Message> getMessageList(int id);

	Message getMessageById(int id);

	void deleteMessage(int id);
}