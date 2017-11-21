package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository(value = "accidentCheckDao")
public class AccidentCheckDaoImp implements AccidentCheckDao{

	@SuppressWarnings("unchecked")
	@Override
	public AccidentCheck recentAccidentCheck(Accident ac) {
		List<AccidentCheck> list = null;
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			String sql = "from AccidentCheck where aId = :aId";
			Query query = session.createQuery(sql);
			query.setInteger("aId", ac.getAccId());
			list = (List<AccidentCheck>)query.list();
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
			list = new ArrayList<AccidentCheck>();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		AccidentCheck latestAc = null;
		if(list.size() != 0){
			latestAc = list.get(0);
			for(AccidentCheck acc : list){
				if(acc.getAcTime().compareTo(latestAc.getAcTime()) > 0){
					latestAc = acc;
				}
			}
		}
		return latestAc;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AccidentCheck> allAccidentCheck(Accident ac) {
		List<AccidentCheck> list = null;
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			String sql = "from AccidentCheck where aId = :aId";
			Query query = session.createQuery(sql);
			query.setInteger("aId", ac.getAccId());
			list = (List<AccidentCheck>)query.list();
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
			list = new ArrayList<AccidentCheck>();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return list;
	}
	
	@Override
	public boolean addOne(AccidentCheck ac) {
		Transaction trans = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			session.save(ac);
			trans.commit();
			return true;
		}catch(HibernateException he){
			he.printStackTrace();
			trans.rollback();
			return false;
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	
}
