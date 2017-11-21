package com.dz.module.driver.praise;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.driver.Driver;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository(value="praiseDao")
public class PraiseDaoImpl implements PraiseDao{
	
	@Override
	public Praise selectById(Praise praise){
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			return (Praise) session.get(Praise.class, praise.getId());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Praise> selectAll(Page page,Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from Praise c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
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
	public int selectAllCount(Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Praise c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			//Query query = session.createQuery("select count(*) from Praise");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	/**
	 * ���д���ı���
	 * @return
	 * @throws HibernateException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Praise> selectAllWaitForDeal(Page page,Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from Praise c where c.alreadyDeal is null or alreadyDeal = 0";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			//Query query = session.createQuery("from Praise c where c.alreadyDeal is null or alreadyDeal = '��'");
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
	public int selectAllWaitForDealCount(Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Praise c where c.alreadyDeal is null or alreadyDeal = 0";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			//Query query = session.createQuery("select count(*) from Praise c where c.alreadyDeal is null or alreadyDeal = '��'");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public int selectAllHandledCount(Date beginDate, Date endDate) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from Praise c where c.alreadyDeal = 1";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Praise> selectAllHandled(Page page, Date beginDate, Date endDate) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from Praise c where c.alreadyDeal = 1";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			//Query query = session.createQuery("from Praise c where c.alreadyDeal is null or alreadyDeal = '��'");
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Praise> selectByDriver(Driver driver,Page page) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Praise c where c.idNum = :idnum");
			query.setString("idnum", driver.getIdNum());
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
	public int selectByDriverCount(Driver driver,Page page) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("select count(*) from Praise c where c.idNum = :idnum");
			query.setString("idnum", driver.getIdNum());
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public void addPraise(Praise praise) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(praise);
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
	public void updatePraise(Praise praise) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.update(praise);
			t.commit();
		}catch(HibernateException e) {
			if(t!=null)
				t.rollback();
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<GroupPraise> selectAllGroupPraise(Page page,Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "from GroupPraise c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			//Query query = session.createQuery("from GroupPraise");
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
	public int selectAllGroupPraiseCount(Date beginDate, Date endDate) throws HibernateException{
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();
			
			String hql = "select count(*) from GroupPraise c where 1=1";
			
			if(beginDate!=null){
				hql+=" and c.praiseTime >= :beginDate";
			}
			
			if(endDate!=null){
				hql+=" and c.praiseTime <= :endDate";
			}
			
			Query query = session.createQuery(hql);
			
			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}
			
			if(endDate!=null){
				query.setDate("endDate", endDate);
			}
			
			//Query query = session.createQuery("select count(*) from GroupPraise");
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void addGroupPraise(GroupPraise praise) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(praise);
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
	public void updateGroupPraise(GroupPraise praise) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.update(praise);
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
	public void deleteGroupPraise(GroupPraise praise) throws HibernateException{
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.delete(praise);
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
	public void addGroupPraiseDriver(GroupPraiseDriver groupPraiseDriver) {
		Session session = null;
		Transaction t = null;
		try{
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			session.save(groupPraiseDriver);
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
