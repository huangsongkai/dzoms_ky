package com.dz.module.user;

import org.springframework.stereotype.Service;

@Service
public class Relation_urService {
	public boolean addRealtion_ur(RelationUr Relation_ur){
		if (Relation_ur == null) {
			return false;
		} 
		
		Relation_urDao relation_urDao = new Relation_urDaoImpl();	
		
		return relation_urDao.addRelation_ur(Relation_ur);
	}
}
