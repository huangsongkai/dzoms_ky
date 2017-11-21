package com.dz.module.driver.homevisit;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.global.BaseAction;
import com.dz.common.global.Page;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.PageUtil;

@Controller
@Scope("prototype")
public class HomeVisitAction extends BaseAction {
	
	private HomeVisit homeVisit;
	private String condition;
	
	public String addHomeVisit(){
		if(homeVisit!=null)
			ObjectAccess.saveOrUpdate(homeVisit);
		else{
			return ERROR;
		}
		return SUCCESS;
	}
	
	public String searchHomeVisit(){
		int currentPage = 0;
		if (request.getParameter("currentPage") != null
				&& !(request.getParameter("currentPage")).isEmpty()) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));

		//	System.out.println(request.getParameter("currentPage"));
		} else {
			currentPage = 1;
		}
		
		
		String hql = " 1=1 ";
		if(!StringUtils.isEmpty(condition)){
			hql+=condition;
		}
		
		long count = ObjectAccess.execute("select count(*) from HomeVisit where "+hql);
		
		Page page = PageUtil.createPage(15,(int)count, currentPage);
		
		List<HomeVisit> hlist = ObjectAccess.query(HomeVisit.class, hql, null, null, null, page);
		
		session.setAttribute("page", page);
		session.setAttribute("list", hlist);
		
		return SUCCESS;
	}

	public HomeVisit getHomeVisit() {
		return homeVisit;
	}

	public void setHomeVisit(HomeVisit homeVisit) {
		this.homeVisit = homeVisit;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	
}
