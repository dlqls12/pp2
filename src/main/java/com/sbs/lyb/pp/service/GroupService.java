package com.sbs.lyb.pp.service;

import java.util.List;
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
	@Autowired
	private BoardService boardService;

	public int createGroup(@RequestParam Map<String, Object> param) {
		groupDao.createGroup(param);
		String code = Util.getAsStr(param.get("code"));
		boardService.createGroupBoard(code);
		String name = Util.getAsStr(param.get("name"));
		Group group = getGroupByName(name);
		int id = group.getId();
		return id;
	}

	public Group getGroupByName(String name) {
		return groupDao.getGroupByName(name);
	}

	public Group getGroupById(int id) {
		return groupDao.getGroupById(id);
	}

	public void delete(int id, String code) {
		groupDao.delete(id);
		boardService.deleteBoard(code);
	}

	public List<Group> getGroupListBySearchKeyword(String searchKeyword) {
		return groupDao.getGroupListBySearchKeyword(searchKeyword);
	}

	public void sizeUp(int newGroupId) {
		int id = newGroupId;
		groupDao.sizeUp(id);
	}

	public void sizeDown(int groupId) {
		int id = groupId;
		groupDao.sizeDown(id);
	}
}
