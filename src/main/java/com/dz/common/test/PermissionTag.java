package com.dz.common.test;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.struts2.ServletActionContext;

import com.dz.module.user.Role;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang3.StringUtils;

public class PermissionTag extends TagSupport {
	private String role;
	private boolean any;
	
	@Override
	public int doStartTag() throws JspException{
		boolean hasAuthority = false;
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		String[] rlist = StringUtils.split(role, ',');
		List<Role> rs = (List<Role>)session.getAttribute("roles");
		
		
		for (String rname : rlist) {
			System.out.println("Check role"+rname);
			final String[] prname = new String[1];
			prname[0] = rname;
			hasAuthority = CollectionUtils.exists(rs, new Predicate() {
				@Override
				public boolean evaluate(Object arg0) {
					Role r = (Role) arg0;
					return r.getRname().equals(prname[0]);
				}
			});
			System.out.println(hasAuthority?"pass":"unpass");
			
			if (!hasAuthority ^ any) {
				break;
			}
		}
		
//System.out.println("Check role"+role);
		
//		for( Role r : rs){
//			if(r.getRname().equals(role)){
//				hasAuthority = true;
//				break;
//			}
//		}
//		System.out.println(hasAuthority?"pass":"unpass");
		return hasAuthority? SKIP_BODY : EVAL_BODY_INCLUDE;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean getAny() {
		return any;
	}

	public void setAny(boolean any) {
		this.any = any;
	}
}
