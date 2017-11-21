package com.dz.module.vehicle;

import java.util.List;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

@Repository(value = "vehicleModeDao")
public class VehicleModeDaoImpl implements VehicleModeDao{

	@Override
	public boolean addVehicleMode(VehicleMode vehicleMode)
			throws HibernateException {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.save(vehicleMode);
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

	@Override
	public boolean vehicleModeUpdate(VehicleMode vehicleMode)
			throws HibernateException {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.update(vehicleMode);
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

	@Override
	public boolean delevehicleMode(VehicleMode vehicleMode)
			throws HibernateException {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.delete(vehicleMode);
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
	
	@SuppressWarnings("unchecked")
	@Override
	public List<VehicleMode> selectAll(){
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from VehicleMode");
			return (List<VehicleMode>) query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public int selectByConditionCount(VehicleMode vehicleMode) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql="select count(*) from VehicleMode where 1=1 ";
			
			if(vehicleMode!=null){
				if(!StringUtils.isEmpty(vehicleMode.getFuel())){
					sql+="and fuel=:fuel ";
				}
			}
			
			Query query = session.createQuery(sql);
			
			if(vehicleMode!=null){
				if(!StringUtils.isEmpty(vehicleMode.getFuel())){
					query.setString("fuel", vehicleMode.getFuel());
				}
			}
			
			return Integer.parseInt(query.uniqueResult().toString());
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Insurance> selectByCondition(Page page, VehicleMode vehicleMode) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql="from VehicleMode where 1=1 ";
		
			if(vehicleMode!=null&&!StringUtils.isEmpty(vehicleMode.getFuel())){
				sql+="and fuel=:fuel ";
			}
			
			Query query = session.createQuery(sql);

			if(vehicleMode!=null&&!StringUtils.isEmpty(vehicleMode.getFuel())){
				query.setString("fuel", vehicleMode.getFuel());
			}
			
			query.setFirstResult(page.getBeginIndex());
			query.setMaxResults(page.getEveryPage());
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public boolean updateVehicleMode(VehicleMode vehicleMode) {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.update(vehicleMode);
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

}
