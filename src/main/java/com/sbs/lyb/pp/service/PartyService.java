package com.sbs.lyb.pp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dao.PartyDao;
import com.sbs.lyb.pp.dto.Party;
import com.sbs.lyb.pp.util.Util;

@Service
public class PartyService {
	@Autowired
	private PartyDao partyDao;

	public int createParty(@RequestParam Map<String, Object> param) {
		partyDao.createParty(param);
		String name = Util.getAsStr(param.get("name"));
		Party party = getPartyByName(name);
		int id = party.getId();
		return id;
	}

	public Party getPartyByName(String name) {
		return partyDao.getPartyByName(name);
	}

	public Party getPartyById(int id) {
		return partyDao.getPartyById(id);
	}

	public void delete(int id, String code) {
		partyDao.delete(id);
	}

	public List<Party> getPartyListBySearchKeyword(String searchKeyword) {
		return partyDao.getPartyListBySearchKeyword(searchKeyword);
	}

	public void sizeUp(int newpartyId) {
		int id = newpartyId;
		partyDao.sizeUp(id);
	}

	public void sizeDown(int partyId) {
		int id = partyId;
		partyDao.sizeDown(id);
	}
}
