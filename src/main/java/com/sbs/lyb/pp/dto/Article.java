package com.sbs.lyb.pp.dto;

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
	private int delStatus;
	private String delDate;
	private int displayStatus;
	private String title;
	private String body;
	private int memberId;
}