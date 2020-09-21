package com.sbs.lyb.pp.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Party {
	private int id;
	private String regDate;
	private String updateDate;
	private String delDate;
	private String delStatus;
	private String name;
	private String body;
	private int memberCount;
	private Map<String, Object> extra;
}