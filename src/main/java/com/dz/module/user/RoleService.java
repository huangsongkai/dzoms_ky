package com.dz.module.user;

import org.springframework.stereotype.Service;

@Service
public class RoleService {
	public boolean addRole(Role role){
		if (role == null) {
			return false;
		} 
		
		RoleDao roleDao = new RoleDaoImpl();	
		
		return roleDao.addRole(role);
	}
	
}
