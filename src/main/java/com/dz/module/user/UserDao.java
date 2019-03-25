package com.dz.module.user;

import org.hibernate.HibernateException;

import java.util.List;

public interface UserDao {
	public boolean saveUser(User user) throws HibernateException;
	public String verifyUser(User user) throws HibernateException;
	public User getUserByUid(Integer uid) throws HibernateException;
	User getUser(User user);
	List<User> getAll();
}

