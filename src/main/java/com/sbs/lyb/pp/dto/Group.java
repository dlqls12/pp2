package com.sbs.lyb.pp.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Group {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private String delStatus;
	private String name;
	private String body;
	private String code;
	private int memberCount;
	private Map<String, Object> extra;
}