package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

@Repository(value = "peopleLossDao")
public class PeopleLossDaoImp implements PeopleLossDao{
	public void addOne(PeopleLoss pl){
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			session.save(pl);
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	public void removeOne(PeopleLoss pl){
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			pl = (PeopleLoss)session.get(PeopleLoss.class,pl.getPlId());
			session.delete(pl);
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public PeopleLoss selectById(int id) {
		Transaction trans = null;
		PeopleLoss loss = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			loss = (PeopleLoss) session.get(PeopleLoss.class, id);
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return loss;
	}
}
