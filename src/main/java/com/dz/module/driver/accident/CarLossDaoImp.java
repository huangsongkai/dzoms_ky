package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

@Repository
public class CarLossDaoImp implements CarLossDao{
	@Override
	public void addOne(CarLoss cl) {
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			session.save(cl);
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void removeOne(CarLoss cl) {
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			cl = (CarLoss)session.get(CarLoss.class,cl.getClId());
			session.delete(cl);
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		
	}

	@Override
	public CarLoss selectById(int  id) {
		Transaction trans = null;
		CarLoss loss = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			loss = (CarLoss) session.get(CarLoss.class, id);
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
