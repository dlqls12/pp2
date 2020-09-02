package com.sbs.lyb.pp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.BoardDao;

@Service
public class BoardService {
	@Autowired
	private BoardDao boardDao;

	public void createGroupBoard(String code) {
		boardDao.createGroupBoard(code);
	}

	public void deleteBoard(String code) {
		boardDao.deleteBoard(code);
	}
	
} 