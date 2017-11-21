package com.dz.module.user;

import org.springframework.stereotype.Service;

@Service
public class Relation_raService {
	public boolean addRealtion_ra(RelationRa relation_ra){
		if (relation_ra == null) {
			return false;
		} 
		
		Relation_raDao relation_raDao = new Relation_raDaoImpl();
		
		return relation_raDao.addRelation_ra(relation_ra);
	}
}
