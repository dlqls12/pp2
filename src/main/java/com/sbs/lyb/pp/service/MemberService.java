package com.sbs.lyb.pp.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.MemberDao;
import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.dto.ResultData;
import com.sbs.lyb.pp.util.Util;

@Service
public class MemberService {
	@Autowired
	MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Value("${custom.siteMainUrl}")
	private String siteMainUrl;
	@Value("${custom.siteName}")
	private String siteName;
	
	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}
	
	public int join(Map<String, Object> param) {
		memberDao.join(param);
		
		sendJoinCompleteMail((String) param.get("email"));
		
		return Util.getAsInt(param.get("id"));
	}
	
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");

		mailService.send(email, mailTitle, mailBodySb.toString());
	}
	
	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	public void modifyMemberInfo(Map<String, Object> param) {
		memberDao.modifyMemberInfo(param);
	}

	public void modifyMemberPw(Map<String, Object> param) {
		memberDao.modifyMemberPw(param);
	}

	public Member getMemberByEmail(String email) {
		return memberDao.getMemberByEmail(email);
	}

	public void sendMail(String email, String title, String body) {
		mailService.send(email, title, body);
	}

	public void modifyMemberPwTemp(String tmpPw, int id) {
		memberDao.modifyMemberPwTemp(tmpPw, id);
	}
	
	public UUID createUUID() {
		UUID uuid = UUID.randomUUID();
		return uuid;
	}
}
