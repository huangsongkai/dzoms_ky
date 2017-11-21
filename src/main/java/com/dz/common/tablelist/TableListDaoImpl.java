package com.dz.common.tablelist;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

@Repository(value="tableListDao")
public class TableListDaoImpl implements TableListDao{
	@Override
	public TableList get(String name) throws HibernateException{
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from TableList tl where tl.name=:name");
			query.setString("name", name);
			@SuppressWarnings("unchecked")
			List<TableList> l = query.list();
			if(CollectionUtils.isEmpty(l)){
				return null;
			}
			return l.get(0);
		}
		catch(HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public void deleteTableList(int id) throws HibernateException{
		TableList tl = this.getById(id);
		if(tl!=null){
			ListValue root = this.getRoot(tl);
			Session session = null;
			Transaction t = null;
			try {	
				session = HibernateSessionFactory.getSession();
				t = session.beginTransaction();
				
				Queue<ListValue> idLine = new LinkedList<ListValue>();
				idLine.add(root);
				while(!idLine.isEmpty()){
					ListValue flv = idLine.poll();
					idLine.addAll(this.getChildren(flv));
					session.delete(flv);
				}
				
				session.delete(tl);
				
				t.commit();
			}catch(HibernateException e) {
				t.rollback();
				throw e;
			} finally {			
				HibernateSessionFactory.closeSession();
			}
		}
	}
	
	@Override
	public ListValue getListValue(int id){
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			ListValue l = (ListValue) session.get(ListValue.class, id);
			return l;
		}
		catch(HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public ListValue getRoot(TableList tl) throws HibernateException {
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from ListValue tl where tl.id=:id");
			query.setInteger("id", tl.getRoot());
			@SuppressWarnings("unchecked")
			List<ListValue> l = query.list();
			if(CollectionUtils.isEmpty(l)){
				return null;
			}
			return l.get(0);
		}
		catch(HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	
	@Override
	public List<ListValue> getChildren(ListValue lf) throws HibernateException {
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from ListValue tl where tl.fid=:fid");
			query.setInteger("fid", lf.getId());
			@SuppressWarnings("unchecked")
			List<ListValue> l = query.list();
			return l;
		}
		catch(HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public ListValue getFather(ListValue lf) throws HibernateException {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from ListValue tl where tl.id=:id");
			if(lf.getFid()==null){
				return null;
			}
			query.setInteger("id", lf.getFid());
			@SuppressWarnings("unchecked")
			List<ListValue> l = query.list();
			if(!CollectionUtils.isEmpty(l))
				return l.get(0);
			return null;
		}
		catch(HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public void addTableList(TableList tl) throws HibernateException {
		Session session = null;
		Transaction t = null;
		try {	
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			
			ListValue lv = new ListValue();
			lv.setValue(tl.getName());
			//lv.setVisible(true);
			session.save(lv);
			
			tl.setRoot(lv.getId());
			session.save(tl);
			t.commit();
		}catch(HibernateException e) {
			t.rollback();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public void addSubItems(ListValue flv,ListValue... lvs) throws HibernateException {
		Session session = null;
		Transaction t = null;
		try {	
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			
			for(ListValue lv : lvs){
				lv.setFid(flv.getId());
				session.saveOrUpdate(lv);
			}
			
			t.commit();
		}catch(HibernateException e) {
			t.rollback();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public void hideItem(ListValue lv) throws HibernateException {
		Session session = null;
		Transaction t = null;
		try {	
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			
			ListValue olv = (ListValue) session.get(ListValue.class, lv.getId());
			olv.setVisible(false);
			session.update(olv);
			
			t.commit();
		}catch(HibernateException e) {
			t.rollback();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
	@Override
	public void deleteItem(ListValue lv) throws HibernateException {
		Session session = null;
		Transaction t = null;
		try {	
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			
			ListValue olv = (ListValue) session.get(ListValue.class, lv.getId());
			session.delete(olv);
			
			t.commit();
		}catch(HibernateException e) {
			t.rollback();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public TableList getById(int id) {
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			TableList l = (TableList) session.get(TableList.class, id);
			return l;
		}
		catch(HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public int addSubItem(ListValue flv, ListValue lv) throws HibernateException {
		Session session = null;
		Transaction t = null;
		try {	
			session = HibernateSessionFactory.getSession();
			t = session.beginTransaction();
			
			lv.setFid(flv.getId());
			session.saveOrUpdate(lv);
			
			t.commit();
			return lv.getId();
		}catch(HibernateException e) {
			t.rollback();
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}
}
