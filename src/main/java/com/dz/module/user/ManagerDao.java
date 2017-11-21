package com.dz.module.user;

import java.util.List;

import org.hibernate.HibernateException;

/**
 * @author doggy
 *         Created on 16-3-16.
 */
public interface ManagerDao {
    void addUser(User user);
    void deleteUser(User user);
    List<User> selectAllUser();
    List<RelationUr> getRelationsByUser(User user);
    void addRelationUr(RelationUr relationUr) throws HibernateException;
    void deleteRelationUrs(User user) throws HibernateException;
}
