package com.dz.module.vehicle.check;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.TimePass;

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
@Repository(value = "selfCheckDao")
public class SelfCheckPlanDaoImp implements SelfCheckPlanDao {
    public boolean addPlan(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            session.save(plan);
            trans.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return false;
    }
    public boolean removePlan(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            SelfCheckPlan p = (SelfCheckPlan)session.get(SelfCheckPlan.class,plan.getId());
            if(p != null){
                session.delete(p);
            }
            trans.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return false;
    }
    public boolean changePlan(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            session.update(plan);
            trans.commit();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return false;
    }
    @SuppressWarnings("unchecked")
	public List<SelfCheckPlan> searchPlan(TimePass tp){
        Session session = null;
        Transaction trans = null;
        List<SelfCheckPlan> list = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            String sql = "from SelfCheckPlan where startTime between :st and :et or endTime between :st and :et";
            Query query = session.createQuery(sql);
            tp.checkNotNull();
            query.setDate("st",tp.getStartTime());
            query.setDate("et",tp.getEndTime());
            list = query.list();
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            list = new ArrayList<>();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return list;
    }
    @Override
    public SelfCheckPlan selectPlanById(SelfCheckPlan plan){
        Session session = null;
        Transaction trans = null;
        SelfCheckPlan sql_plan = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            sql_plan = (SelfCheckPlan)session.get(SelfCheckPlan.class,plan.getId());
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return sql_plan;
    }
}
