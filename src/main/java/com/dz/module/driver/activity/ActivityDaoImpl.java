package com.dz.module.driver.activity;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository(value="activityDao")
public class ActivityDaoImpl implements ActivityDao {
	@SuppressWarnings("unchecked")
	@Override
	public List<Activity> selectAllActivity(Page page,Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from Activity c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.activityTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.activityTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			//Query query = session.createQuery("from Activity");
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public int selectAllActivityCount(Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Activity c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.activityTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.activityTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			//Query query = session.createQuery("select count(*) from Activity");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void addActivity(Activity activity) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(activity);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void addActivityDriver(ActivityDriver activity) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(activity);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void updateActivity(Activity activity) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.update(activity);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void deleteActivity(Activity activity) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.delete(activity);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
}
