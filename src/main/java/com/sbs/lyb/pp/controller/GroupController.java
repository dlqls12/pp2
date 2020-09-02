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
		Group group = groupService.getGroupByName(name);
		
		if ( group != null ) {
			redirectUrl = "/usr/group/groupPage?id=" + group.getId();
			model.addAttribute("alertMsg", String.format("해당 그룹은 이미 존재합니다."));
			model.addAttribute("redirectUrl", redirectUrl);
			return "/common/redirect";
		}
		
		int newGroupId = groupService.createGroup(param);
		memberService.joinGroup(id, newGroupId);
		redirectUrl = redirectUrl.replace("#id", newGroupId + "");
		model.addAttribute("alertMsg", String.format("%s 그룹이 생성 되었습니다.", name));
		model.addAttribute("redirectUrl", redirectUrl);
		return "/common/redirect";
	}
	
	@RequestMapping("/usr/group/groupPage")
	public String showGroupPage(int id, Model model) {
		Group group = groupService.getGroupById(id);
		
		if ( group == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("잘못된 경로!"));
			return "/common/redirect";
		}
		
		model.addAttribute("group", group);
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
	
	@RequestMapping("/usr/group/doSignOutGroup")
	public String doSignOutGroup(int id, int groupId, Model model) {
		Member member = memberService.getMemberById(id);
		Group group = groupService.getGroupById(groupId);
		
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "잘못된 경로!");
			return "/common/redirect";
		}
		
		if ( member.getGroupId() == 0 ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "잘못된 경로!");
			return "/common/redirect";
		}
		
		if ( group.getMemberCount() == 1 ) {
			memberService.resetGroupId(id, group.getId());
			groupService.delete(group.getId());
		}
		else {
			memberService.resetGroupId(id, group.getId());
		}
		
		model.addAttribute("alertMsg", String.format("%s그룹에서 탈퇴하셨습니다.", group.getName()));
		model.addAttribute("redirectUrl", "/usr/home/main");
		return "/common/redirect";
	}
	
	@RequestMapping("/usr/group/seekGroup")
	public String showSeekGroup(String searchKeyword, Model model) {
		if ( searchKeyword == null ) {
			return "/group/seekGroup";
		}
		
		List<Group> groupList = groupService.getGroupListBySearchKeyword(searchKeyword);
		int groupCount = groupList.size();
		System.out.println("groupCount: " + groupCount);
		model.addAttribute("groupCount", groupCount);
		model.addAttribute("groupList", groupList);
		return "/group/seekGroup";
	}
}
