package com.sbs.lyb.pp.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.lyb.pp.dto.Group;
import com.sbs.lyb.pp.dto.Member;
import com.sbs.lyb.pp.service.GroupService;
import com.sbs.lyb.pp.service.MemberService;
import com.sbs.lyb.pp.util.Util;

@Controller
public class GroupController {
	@Autowired
	private GroupService groupService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/usr/group/createGroup")
	public String showCreateGroup() {
		return "/group/createGroup";
	}
	
	@RequestMapping("/usr/group/doCreateGroup")
	public String doCreateGroup(@RequestParam Map<String, Object> param, String redirectUrl, Model model) {
		int id = Util.getAsInt(param.get("id"));
		String name = Util.getAsStr(param.get("name"));
		int newGroupId = groupService.createGroup(param);
		memberService.joinGroup(id, newGroupId);
		redirectUrl = redirectUrl.replace("#id", newGroupId + "");
		model.addAttribute("alertMsg", String.format("%s 그룹이 생성 되었습니다.", name));
		model.addAttribute("redirectUrl", redirectUrl);
		return "/common/redirect";
	}
	
	@RequestMapping("/usr/group/groupPage")
	public String showGroupPage(int id, Model model) {
		List<Member> memberList = memberService.getMemberListByGroupId(id);
		int groupSize = memberList.size();
		Group group = groupService.getGroupById(id);
		
		if ( group == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("잘못된 경로!"));
			return "/common/redirect";
		}
		
		model.addAttribute("group", group);
		model.addAttribute("groupSize", groupSize);
		return "/group/groupPage";
	}
	
	@RequestMapping("/usr/group/doJoinGroup")
	public String doJoinGroup(int id, int groupId, Model model) {
		memberService.joinGroup(id, groupId);
		Group group = groupService.getGroupById(groupId);
		model.addAttribute("alertMsg", String.format("%s 그룹에 가입되었습니다.", group.getName()));
		String redirectUrl = "/usr/group/groupPage?id=" + groupId;
		model.addAttribute("redirectUrl", redirectUrl);
		return "/common/redirect";
	}
}
