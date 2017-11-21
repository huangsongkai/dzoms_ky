package com.dz.module.user;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;


public class Relation_urDaoImpl implements Relation_urDao{

	@Override
	public boolean addRelation_ur(RelationUr relation_ur) {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.save(relation_ur);
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

	@SuppressWarnings("rawtypes")
	@Override
	public ArrayList<Authority> queryAuthorityByUser(String uid) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		ArrayList<Authority> result = new ArrayList<Authority>();
		//ArrayList<String> result = new ArrayList<String>();
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			Query query = session.createQuery("from RelationUr where uid='"+uid+"'");
			for(Iterator it = query.list().iterator(); it.hasNext(); )
			{
				RelationUr re = (RelationUr)it.next();
				query = session.createQuery("from RelationRa where rid='"+re.getRid()+"'");
				for(Iterator it1 = query.list().iterator(); it1.hasNext(); )
				{								
					RelationRa ra = (RelationRa)it1.next();
					query = session.createQuery("from Authority where aid='"+ra.getAid()+"'");
					Authority aut = (Authority)query.uniqueResult();
					if(aut!=null&&!result.contains(aut))
						result.add(aut);
					//add(aut.getAname()+"+"+aut.getGname()+"+"+aut.getUrl());
				}
			}
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
		
		Collections.sort(result, new Comparator<Authority>(){

			@Override
			public int compare(Authority o1, Authority o2) {
				// TODO 自动生成的方法存根
				return o1.getOrder()-o2.getOrder();
			}
		
		});
		
		return result;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Role> queryRoleByUser(String uid) {
		// TODO Auto-generated method stub
		ArrayList<Role> rs = new ArrayList<Role>();
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from RelationUr where uid='"+uid+"'");
			for(Iterator<RelationUr> it = query.list().iterator(); it.hasNext(); )
			{
				RelationUr re = (RelationUr)it.next();
				query = session.createQuery("from Role where rid='"+re.getRid()+"'");
				rs.addAll((List<Role>) query.list());
			}
			return rs;
		} catch (HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

}
