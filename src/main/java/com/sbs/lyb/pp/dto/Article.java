package com.sbs.lyb.pp.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private int delStatus;
	private int displayStatus;
	private String title;
	private String body;
	private int memberId;
	private int boardId;
	private Map<String, Object> extra;
	
	public String getDetailLink(String boardCode) {
		return "/article/" + boardCode + "-detail?id=" + id;
	}
}