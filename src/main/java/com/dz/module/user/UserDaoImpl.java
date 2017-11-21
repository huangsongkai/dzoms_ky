package com.dz.module.user;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository(value = "userdao")
public class UserDaoImpl implements UserDao {


	@Override
	public boolean saveUser(User user) throws HibernateException{
		// TODO Auto-generated method stub	
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.save(user);
			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	/**
	 * �û���¼��֤
	 */
	public String userLogin(User user) throws HibernateException {
		// TODO Auto-generated method stub
		String result = "success";
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();

			Query query = session.createQuery("from User where uname=:uname");
			query.setString("uname",user.getUname());
			//query.setString(0, "admin");
			User userQ = (User)query.uniqueResult();
			if(userQ==null)
			{
				return "error_uname";
			}
			else if(!userQ.getUpwd().equals(user.getUpwd()))
			{
				return "error_upwd";
			}
			result = userQ.getUid().toString();
			query = null;
			tx.commit();	
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
		return result;
	}

	@Override
	public User getUser(User user) {
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("from User where uname='"+user.getUname()+"'");
			//query.setString(0, "admin");
			User userQ = (User)query.uniqueResult();
			return userQ;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	@SuppressWarnings("unchecked")
	public List<User> getAll(){
		List<User> users = null;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("from User");
			users = query.list();
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return users;
	}

	@Override
	public User getUserByUid(Integer uid) {
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("from User where uid='"+uid+"'");
			//query.setString(0, "admin");
			User userQ = (User)query.uniqueResult();
			return userQ;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
}
