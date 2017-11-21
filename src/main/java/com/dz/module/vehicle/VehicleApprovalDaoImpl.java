package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository(value = "vehicleApprovalDao")
public class VehicleApprovalDaoImpl implements VehicleApprovalDao{

	@Override
	public boolean addVehicleApproval(VehicleApproval vehicleApproval)
			throws HibernateException {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			vehicleApproval.setApprovalBranchDate(new Date());
			session.save(vehicleApproval);
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
	public List<VehicleApproval> queryVehicleApprovalByState(Short checkType,Integer state)
			throws HibernateException {
		// TODO Auto-generated method stub
		Session session = null;
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from VehicleApproval va where va.checkType="+checkType+" and va.state="+state+"");
			return query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public VehicleApproval queryVehicleApprovalById(Integer approvalId)
			throws HibernateException {
		// TODO Auto-generated method stub
		Session session = null;
		VehicleApproval result = new VehicleApproval();
		//ArrayList<String> result = new ArrayList<String>();
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from VehicleApproval where id="+approvalId+"");
			result = (VehicleApproval)query.uniqueResult();
		} catch (HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
		return result;
	}
	
	@Override
	public VehicleApproval queryVehicleApprovalByContractId(Integer contractId)
			throws HibernateException {
		// TODO Auto-generated method stub
		Session session = null;
		VehicleApproval result = new VehicleApproval();
		//ArrayList<String> result = new ArrayList<String>();
		try {	
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from VehicleApproval where contractId="+contractId+"");
			result = (VehicleApproval)query.uniqueResult();
		} catch (HibernateException e) {
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
		return result;
	}
	
	public boolean executeUpdate(VehicleApproval vehicleApproval) {

        Session session = HibernateSessionFactory.getSession();
        Transaction tx = null;
        boolean flag = true;
        try {
            tx = session.beginTransaction();
			session.update(vehicleApproval);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
            {
                tx.rollback();
                flag = false;
            }
            throw new RuntimeException(e.getMessage());
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
        return flag;
    }

}
