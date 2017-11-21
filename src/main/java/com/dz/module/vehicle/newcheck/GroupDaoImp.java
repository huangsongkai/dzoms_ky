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
public class GroupDaoImp implements GroupDao {
    @Override
    public boolean addOne(Plan plan, Group group) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            group.setPlan(plan);
            session.save(group);
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

    @Override
    public boolean deleteById(int id) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Group g = (Group)session.get(Group.class,id);
            session.delete(g);
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

    @Override
    public Group getGroupById(int id) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Group g = (Group)session.get(Group.class,id);
            Set<Integer> users = new HashSet<Integer>();
            for(Integer x : g.getCheckerIds()){
                users.add(x);
            }
            g.setCheckerIds(users);
//            session.evict(g);
            trans.commit();
            return g;
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
            return null;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<Group> searchGroupByTimeAndUser(final int userId, final Date time) {
        List<Group> groups = new ArrayList<>();
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();

            Query query = session.createQuery("from Group");
            groups = query.list();
            CollectionUtils.filter(groups, new Predicate() {
                @Override
                public boolean evaluate(Object o) {
                    if(o == null) return false;
                    Group group = (Group)o;
                    if(time == null || Global.isYearAndMonth(time,group.getPlan().getTime())){
                        if(group.getCheckerIds().contains(userId))
                            return true;
                    }
                    return false;
                }
            });

            trans.commit();
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return groups;
    }

    @Override
    public Group getGroupWithRecord(int id) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Group g = (Group)session.get(Group.class,id);
            Set<CheckRecord> records = new HashSet<>();
            Set<CheckRecord> sql_ = g.getCheckRecords();
            if(sql_ == null)
                sql_ = records;
            for(CheckRecord cr:sql_){
                records.add(cr);
            }
            g.setCheckRecords(records);
//            session.evict(g);
            trans.commit();
            return g;
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
            return null;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
}
