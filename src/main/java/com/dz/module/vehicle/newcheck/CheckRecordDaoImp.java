package com.dz.module.vehicle.newcheck;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Repository
public class CheckRecordDaoImp implements CheckRecordDao {
    @Override
    public boolean addOne(Group group, CheckRecord checkRecord) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            checkRecord.setGroup(group);
            session.save(checkRecord);
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
    public boolean deleteOneById(int id) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            CheckRecord checkRecord = (CheckRecord)session.get(CheckRecord.class,id);
            session.delete(checkRecord);
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
    public boolean rePass(int id, String reason) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            CheckRecord checkRecord = (CheckRecord)session.get(CheckRecord.class,id);
            checkRecord.setRepass(true);
            checkRecord.setRepassReason(reason);
            session.update(checkRecord);
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
    public List<CheckRecord> selectRecordsByTimePass(Date startTime, Date endTime) {
        Session session = null;
        Transaction trans = null;
        List<CheckRecord> checkRecords = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Query query = session.createQuery("from CheckRecord where recordTime between :startTime and :endTime");
            query.setDate("startTime", startTime);
            query.setDate("endTime",endTime);
            checkRecords = query.list();
            trans.commit();
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
            checkRecords = new ArrayList<>();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return checkRecords;
    }
}
