package com.dz.module.user;

import java.util.ArrayList;
import java.util.List;

public interface Relation_urDao {
	public boolean addRelation_ur(RelationUr relation_ur);
	public ArrayList<Authority> queryAuthorityByUser(String uid);
	List<Role> queryRoleByUser(String uid);
}
