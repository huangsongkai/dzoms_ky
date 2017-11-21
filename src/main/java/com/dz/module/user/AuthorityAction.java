package com.dz.module.user;

import com.dz.common.global.BaseAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


@Controller
@Scope("prototype")
public class AuthorityAction extends BaseAction {
	private Authority authority;
	@Autowired
	private AuthorityService authorityService;		
	public String authorityAdd() {
		System.out.println(authority);

		boolean flag = authorityService.addAuthority(authority);
		
		if (!flag) {
			return ERROR;
		}
		return "add_success";
	}

	public Authority getAuthority() {
		return authority;
	}

	public void setAuthority(Authority authority) {
		this.authority = authority;
	}

	public AuthorityService getAuthorityService() {
		return authorityService;
	}

	public void setAuthorityService(AuthorityService authorityService) {
		this.authorityService = authorityService;
	}

}
