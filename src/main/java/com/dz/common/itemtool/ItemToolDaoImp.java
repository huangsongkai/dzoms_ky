package com.dz.common.itemtool;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository(value = "itemToolDao")
public class ItemToolDaoImp implements ItemToolDao {

	@Override
	public void addItem(ItemTool it) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			session.save(it);
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void removeItem(ItemTool it) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			session.delete(it);
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ItemTool> selectByKey(ItemTool it) {
		Transaction tx = null;
		List<ItemTool> list = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			String sql = "from ItemTool where key = :key";
			Query query = session.createQuery(sql);
			query.setString("key",it.getKey());
			list = (List<ItemTool>)query.list();
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			list = new ArrayList<ItemTool>();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return list;
	}

	@Override
	public void changeItem(ItemTool newIt) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			session.update(newIt);
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ItemTool> selectByKeyValue(ItemTool it) {
		Transaction tx = null;
		List<ItemTool> list = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			String sql = "from ItemTool where key = :key and value = :value";
			Query query = session.createQuery(sql);
			query.setString("key",it.getKey());
			query.setString("value",it.getValue());
			list = (List<ItemTool>)query.list();
			System.out.println(list.size());
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			list = new ArrayList<ItemTool>();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return list;
	}
}
