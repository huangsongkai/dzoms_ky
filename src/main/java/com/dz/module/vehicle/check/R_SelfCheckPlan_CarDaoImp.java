package com.dz.module.vehicle.check;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-10-14.
 */
@Repository(value = "r_SelfCheckPlan_CarDao")
public class R_SelfCheckPlan_CarDaoImp implements R_SelfCheckPlan_CarDao {
    @SuppressWarnings("unchecked")
	@Override
    public List<R_SelfCheckPlan_Car> selectByPlan(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        List<R_SelfCheckPlan_Car> list = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            String sql = "from R_SelfCheckPlan_Car where planId = :planId";
            Query query = session.createQuery(sql);
            query.setInteger("planId",plan.getId());
            list = query.list();
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            list = new ArrayList<R_SelfCheckPlan_Car>();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return list;
    }
    @SuppressWarnings("unchecked")
	@Override
    public List<R_SelfCheckPlan_Car> selectDisPass(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        List<R_SelfCheckPlan_Car> list = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            String sql = "from R_SelfCheckPlan_Car where planId = :planId and isPass=false";
            Query query = session.createQuery(sql);
            query.setInteger("planId",plan.getId());
            list = query.list();
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            list = new ArrayList<R_SelfCheckPlan_Car>();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return list;
    }
    public boolean addList(SelfCheckPlan plan,List<String> ids){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            if(ids == null) return true;
            for(String id:ids){
                R_SelfCheckPlan_Car rsc = new R_SelfCheckPlan_Car();
                rsc.setPlanId(plan.getId());
                rsc.setCarId(id);
                trans = session.beginTransaction();
                session.save(rsc);
                trans.commit();
                session.clear();
            }
            return true;
        }catch (Exception e){
            e.printStackTrace();
            if(trans != null){
                trans.rollback();
            }
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
    public boolean removeByPlan(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            String sql = "delete from R_SelfCheckPlan_Car where planId = :planId";
            Query query = session.createQuery(sql);
            query.setInteger("planId",plan.getId());
            query.executeUpdate();
            trans.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
    public boolean updateByPlan(SelfCheckPlan plan,List<String> ids){
        if(removeByPlan(plan) && addList(plan,ids)){
            return true;
        }else{
            return false;
        }
    }
    @Override
    public boolean disPass(SelfCheckPlan plan, String carId, String reason){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            String sql = "from R_SelfCheckPlan_Car where planId = :planId and carId = :carId";
            Query query = session.createQuery(sql);
            query.setInteger("planId", plan.getId());
            query.setString("carId", carId);
            R_SelfCheckPlan_Car rsc = (R_SelfCheckPlan_Car)query.uniqueResult();
            rsc.setIsPass(false);
            rsc.setReason(reason);
            session.update(rsc);
            trans.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
    public boolean pass(SelfCheckPlan plan,String carFrameId){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            String sql = "from R_SelfCheckPlan_Car where planId = :planId and carId = :carId";
            Query query = session.createQuery(sql);
            query.setInteger("planId", plan.getId());
            query.setString("carId", carFrameId);
            R_SelfCheckPlan_Car rsc = (R_SelfCheckPlan_Car)query.uniqueResult();
            rsc.setIsPass(true);
            rsc.setReason("");
            session.update(rsc);
            trans.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
}
