package com.sbs.lyb.pp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.lyb.pp.dao.TagDao;
import com.sbs.lyb.pp.dto.Tag;

@Service
public class TagService {
	@Autowired
	private TagDao tagDao;

	public void addTag(int id, String tag) {
		String[] tagList = tag.trim().split("#");

		for ( int i = 1; i < tagList.length; i++ ) {
			tagDao.addTag(id, tagList[i]);
		}
	}

	public List<Tag> getTagList(int id) {
		return tagDao.getTagList(id);
	}

	public void modifyTag(int id, String tag) {
		tagDao.deleteTag(id);
		addTag(id, tag);
	}

	public void deleteTag(int id) {
		tagDao.deleteTag(id);
	}
}
