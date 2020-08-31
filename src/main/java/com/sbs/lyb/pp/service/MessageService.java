package com.sbs.lyb.pp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.MessageDao;
import com.sbs.lyb.pp.dto.Message;

@Service
public class MessageService {
	@Autowired
	private MessageDao messageDao;

	public void sendMessage(Map<String, Object> param) {
		messageDao.sendMessage(param);
	}

	public List<Message> getMessageList(int id) {
		return messageDao.getMessageList(id);
	}

}
