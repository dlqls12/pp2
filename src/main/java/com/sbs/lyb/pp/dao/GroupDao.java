package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Group;

@Mapper
public interface GroupDao {

	Group getGroupByName(String name);

	void createGroup(Map<String, Object> param);

	Group getGroupById(int id);

	void delete(int id);

	List<Group> getGroupListBySearchKeyword(String searchKeyword);

	void sizeUp(int id);

	void sizeDown(int id);
}