package com.dz.module.user;

import com.dz.common.global.BaseAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller
@Scope("prototype")
public class Relation_raAction extends BaseAction{
	private RelationRa relation_ra;
	@Autowired
	private Relation_raService relation_raService;		
	public String relation_raAdd() {
		System.out.println(relation_ra);
		
		boolean flag = relation_raService.addRealtion_ra(relation_ra);
		
		if (!flag) {
			return ERROR;
		}
		
		return "add_success";
	}

	public RelationRa getRelation_ra() {
		return relation_ra;
	}

	public void setRelation_ra(RelationRa relation_ra) {
		this.relation_ra = relation_ra;
	}

	public Relation_raService getRelation_raService() {
		return relation_raService;
	}

	public void setRelation_raService(Relation_raService relation_raService) {
		this.relation_raService = relation_raService;
	}

	
}
