package com.sbs.lyb.pp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.lyb.pp.dto.Party;

@Mapper
public interface PartyDao {

	Party getPartyByName(String name);

	void createParty(Map<String, Object> param);

	Party getPartyById(int id);

	void delete(int id);

	List<Party> getPartyListBySearchKeyword(String searchKeyword);

	void sizeUp(int id);

	void sizeDown(int id);
}