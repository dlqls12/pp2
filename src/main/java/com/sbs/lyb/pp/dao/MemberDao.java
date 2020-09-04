package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.lyb.pp.dto.Member;

@Mapper
public interface MemberDao {

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);

	Member getMemberByLoginId(String loginId);

	Member getMemberById(int id);

	void modifyMemberInfo(Map<String, Object> param);

	void modifyMemberPw(Map<String, Object> param);

	Member getMemberByEmail(String email);

	void modifyMemberPwTemp(String tmpPw, int id);

	void signOut(int id);

	void joinParty(int newPartyId, int id);

	List<Member> getMemberListByPartyId(int id);

	void resetPartyId(int id);
}
