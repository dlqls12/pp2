package com.sbs.lyb.pp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.ReplyDao;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;
	
	public void replyWrite(Map<String, Object> param) {
		replyDao.replyWrite(param);
	}

}
