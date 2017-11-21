package com.dz.module.user;

import org.hibernate.HibernateException;

import java.util.List;

public interface UserDao {
	public boolean saveUser(User user) throws HibernateException;//����û�
	public String userLogin(User user) throws HibernateException;//�û���¼
	public User getUserByUid(Integer uid) throws HibernateException;//�û���¼
	User getUser(User user);
	List<User> getAll();
}

