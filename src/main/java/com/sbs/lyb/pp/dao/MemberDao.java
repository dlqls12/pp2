package com.sbs.lyb.pp.dao;

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
}
