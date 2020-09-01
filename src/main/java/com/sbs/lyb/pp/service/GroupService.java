package com.sbs.lyb.pp.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dao.GroupDao;
import com.sbs.lyb.pp.dto.Group;
import com.sbs.lyb.pp.util.Util;

@Service
public class GroupService {
	@Autowired
	private GroupDao groupDao;

	public int createGroup(@RequestParam Map<String, Object> param) {
		groupDao.createGroup(param);
		String name = Util.getAsStr(param.get("name"));
		Group group = getGroupByName(name);
		int id = group.getId();
		return id;
	}

	private Group getGroupByName(String name) {
		return groupDao.getGroupByName(name);
	}

	public Group getGroupById(int id) {
		return groupDao.getGroupById(id);
	}
}
