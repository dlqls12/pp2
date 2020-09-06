package com.sbs.lyb.pp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Tag {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private int delStatus;
	private String body;
	private int articleId;
}
