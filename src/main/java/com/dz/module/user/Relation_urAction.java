package com.dz.module.user;

import com.dz.common.global.BaseAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller
@Scope("prototype")
public class Relation_urAction extends BaseAction{
	private RelationUr relation_ur;
	@Autowired
	private Relation_urService relation_urService;		
	public String relation_urAdd() {
		System.out.println(relation_ur);
		
		boolean flag = relation_urService.addRealtion_ur(relation_ur);
		
		if (!flag) {
			return ERROR;
		}
		
		return "add_success";
	}

	public RelationUr getRelation_ur() {
		return relation_ur;
	}

	public void setRelation_ur(RelationUr relation_ur) {
		this.relation_ur = relation_ur;
	}

	public Relation_urService getRelation_urService() {
		return relation_urService;
	}

	public void setRelation_urService(Relation_urService relation_urService) {
		this.relation_urService = relation_urService;
	}
	
}
