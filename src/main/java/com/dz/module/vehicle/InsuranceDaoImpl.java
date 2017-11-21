package com.dz.module.vehicle;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
@Repository(value = "insuranceDao")
public class InsuranceDaoImpl implements InsuranceDao {

	@Override
	public void addInsurance(Insurance insurance) throws HibernateException {
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			insurance.setInsuranceNum(StringUtils.upperCase(insurance.getInsuranceNum()));
			session.saveOrUpdate(insurance);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void updateInsurance(Insurance insurance)
			throws HibernateException {
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			insurance.setInsuranceNum(StringUtils.upperCase(insurance.getInsuranceNum()));
			session.update(insurance);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void deleteInsurance(Insurance insurance)
			throws HibernateException {
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.delete(insurance);
			tx.commit();
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
	@Override
	public List<Insurance> selectAll() {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Insurance where state>0 ");
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Insurance> selectByVehicle(Vehicle vehicle) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Insurance where state>0 and carframeNum=:carframeNum");
			query.setString("carframeNum", vehicle.getCarframeNum());
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Insurance> selectByDriver(Driver driver) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Insurance where state>0 and driverId=:driverId");
			query.setString("driverId", driver.getIdNum());
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public int selectByConditionCount(Insurance insurance, Vehicle vehicle) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql="select count(*) from Insurance where state>0 ";
			
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				sql+="and carframeNum like :carframeNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				sql+="and insuranceNum like :insuranceNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				sql+="and insuranceClass like :insuranceClass ";
			}
			
			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					sql+="and carframeNum in (select carframeNum from Vehicle where licenseNum  like :licenseNum ) ";
				}
			}
			
			Query query = session.createQuery(sql);
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				query.setString("carframeNum", "%"+insurance.getCarframeNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				query.setString("insuranceNum", "%"+insurance.getInsuranceNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				query.setString("insuranceClass", "%"+insurance.getInsuranceClass()+"%");
			}
			
			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
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
	public List<Insurance> selectByCondition(Page page, Insurance insurance, Vehicle vehicle) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql="from Insurance where state>0 ";
			
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				sql+="and carframeNum like :carframeNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				sql+="and insuranceNum like :insuranceNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				sql+="and insuranceClass like :insuranceClass ";
			}
			
			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					sql+="and carframeNum in (select carframeNum from Vehicle where licenseNum  like :licenseNum ) ";
				}
			}
			
			Query query = session.createQuery(sql);
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				query.setString("carframeNum","%"+ insurance.getCarframeNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				query.setString("insuranceNum","%"+ insurance.getInsuranceNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				query.setString("insuranceClass", "%"+insurance.getInsuranceClass()+"%");
			}
			
			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
				}
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

}
