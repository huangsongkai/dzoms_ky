package com.dz.module.charge.receipt;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 16-3-6.
 */
@Repository
public class RemoveRecordDaoImp {
    public boolean addOne(RemoveRecord rr){
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            session.save(rr);
            trans.commit();
            return true;
        }catch (HibernateException he){
            he.printStackTrace();
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
    public List<RemoveRecord> searchRecord(Date startTime,Date endTime){
        if(startTime == null){
            startTime = new Date();
            startTime.setYear(0);
        }
        if(endTime == null){
            endTime = new Date();
            endTime.setYear(2555);
        }
        List<RemoveRecord> rrs = new ArrayList<>();
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("from RemoveRecord where recordTime between :startTime and :endTime");
            query.setDate("startTime",startTime);
            query.setDate("endTime",endTime);
            rrs = query.list();
            trans.commit();
        }catch (HibernateException he){
            he.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return rrs;
    }
}
