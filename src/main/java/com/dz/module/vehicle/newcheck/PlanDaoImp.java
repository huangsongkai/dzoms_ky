package com.dz.module.vehicle.newcheck;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Global;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.*;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Repository
public class PlanDaoImp implements PlanDao {
    @Override
    public boolean addOne(Plan plan) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            session.save(plan);
            trans.commit();
            return true;
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<Plan> getPlans(final Date time) {
        List<Plan> plans  = new ArrayList<>();
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Query query = session.createQuery("from Plan");
            plans = query.list();
            CollectionUtils.filter(plans,new Predicate(){

				@Override
				public boolean evaluate(Object object) {
					Plan p = (Plan)object;
	                if(time == null) return true;
	                else return Global.isYearAndMonth(time,p.getTime());
				}
            
            });
            trans.commit();
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return plans;
    }

    @Override
    public Plan getPlanById(int id) {
        Plan p = null;
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            p = (Plan)session.get(Plan.class,id);
            List<Group> groups = p.getGroups();
            for(Group group:groups){
                Set<CheckRecord> records = new HashSet<>();
                if(group.getCheckRecords() == null)
                    group.setCheckRecords(records);
                for(CheckRecord i:group.getCheckRecords()){
                    records.add(i);
                }
                group.setCheckRecords(records);
            }
//            session.evict(p);
            trans.commit();
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return p;
    }

}
