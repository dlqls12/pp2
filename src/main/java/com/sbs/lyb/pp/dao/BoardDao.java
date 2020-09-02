package com.sbs.lyb.pp.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDao {
	void createGroupBoard(String code);

	void deleteBoard(String code);
}
