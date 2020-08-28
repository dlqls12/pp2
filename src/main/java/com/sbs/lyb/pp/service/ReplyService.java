package com.sbs.lyb.pp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.ReplyDao;
import com.sbs.lyb.pp.dto.Reply;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;
	
	public void replyWrite(Map<String, Object> param) {
		replyDao.replyWrite(param);
	}

	public List<Reply> getReplies(int id) {
		return replyDao.getReplies(id);
	}

	public void replyModify(Map<String, Object> param) {
		replyDao.replyModify(param);
	}

	public void replyDelete(Map<String, Object> param) {
		replyDao.replyDelete(param);
	}

	public List<Reply> getForPrintReplies(int id, int itemsInAPage, int limitFrom) {
		return replyDao.getForPrintReplies(id, itemsInAPage, limitFrom);
	}

}
