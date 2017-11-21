package com.dz.module.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthorityService {
	@Autowired
	AuthorityDao authorityDao;
	public boolean addAuthority(Authority authority){
		if (authority == null) {
			return false;
		}
		
		return authorityDao.addAuthority(authority);
	}

	public AuthorityDao getAuthorityDao() {
		return authorityDao;
	}

	public void setAuthorityDao(AuthorityDao authorityDao) {
		this.authorityDao = authorityDao;
	}
}
