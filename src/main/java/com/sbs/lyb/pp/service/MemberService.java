package com.sbs.lyb.pp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.MemberDao;
import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.dto.ResultData;
import com.sbs.lyb.pp.util.Util;

@Service
public class MemberService {
	@Autowired
	MemberDao memberDao;
	
	public int join(Map<String, Object> param) {
		memberDao.join(param);

		return Util.getAsInt(param.get("id"));
	}

	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}
}
