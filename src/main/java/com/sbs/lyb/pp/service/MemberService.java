package com.sbs.lyb.pp.service;

import java.util.List;
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
	@Autowired
	private AttrService attrService;
	@Autowired
	private PartyService partyService;
	
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
		int id = Util.getAsInt(param.get("id"));
		attrService.setValue("member__" + id + "__extra__isUsingTmpPw", "N", null);
	}

	public Member getMemberByEmail(String email) {
		return memberDao.getMemberByEmail(email);
	}

	public void sendMail(String email, String title, String body) {
		mailService.send(email, title, body);
	}

	public void modifyMemberPwTemp(String tmpPw, int id) {
		memberDao.modifyMemberPwTemp(tmpPw, id);
		attrService.setValue("member__" + id + "__extra__isUsingTmpPw", "Y", null);
	}
	
	public String genCheckPasswordAuthCode(int actorId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + actorId + "__extra__modifyPrivateAuthCode", authCode, Util.getDateStrLater(60*10));

		return authCode;
	}

	public ResultData checkValidCheckPasswordAuthCode(int actorId, String checkPasswordAuthCode) {
		if (attrService.getValue("member__" + actorId + "__extra__modifyPrivateAuthCode").equals(checkPasswordAuthCode)) {
			return new ResultData("S-1", "유효한 키 입니다.");
		}

		return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}

	public void signOut(int id) {
		memberDao.signOut(id);
	}

	public boolean isUsingTmpPw(int actorId) {
		String value = attrService.getValue("member__" + actorId + "__extra__isUsingTmpPw");
		if ( value == null ) {
			return false;
		}
		if ( value.equals("Y") ) {
			return true;
		}
		return false;
	}

	public void joinParty(int id, int newPartyId) {
		memberDao.joinParty(newPartyId, id);
		partyService.sizeUp(newPartyId);
	}

	public List<Member> getMemberListByPartyId(int id) {
		return memberDao.getMemberListByPartyId(id);
	}

	public void resetPartyId(int id, int partyId) {
		memberDao.resetPartyId(id);
		partyService.sizeDown(partyId);
	}

	public List<Member> getMemberList() {
		return memberDao.getMemberList();
	}

	public void setAuthCode(String authCode, String email) {
		attrService.setValue("member__0__" + email + "__joinEmailAuthCode", authCode, Util.getDateStrLater(60*2));
	}

	public String getJoinMailAuthCode(String email) {
		String authCode = attrService.getValue("member__0__" + email + "__joinEmailAuthCode");
		return authCode;
	}
}
