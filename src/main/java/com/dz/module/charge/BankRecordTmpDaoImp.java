package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
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
 *         Created on 15-11-24.
 */
@Repository(value="bankRecordTmpDao")
public class BankRecordTmpDaoImp implements BankRecordTmpDao {
    @Override
    public boolean saveList(List<BankRecordTmp> list) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            for(BankRecordTmp brt:list){
                if(brt != null){
                    session.save(brt);
                }
            }
            trans.commit();
        }catch(HibernateException he){
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return true;
    }

	@SuppressWarnings("unchecked")
	@Override
    public List<BankRecordTmp> selectByTimeAndStaus(final Date time, int status) {
        List<BankRecordTmp> brts = new ArrayList<>();
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        Query query = session.createQuery("from BankRecordTmp where status = :status");
        query.setInteger("status",status);
        brts = query.list();

        brts = (List<BankRecordTmp>)CollectionUtils.select(brts, new Predicate() {
            @Override
            public boolean evaluate(Object p) {
                if (p == null) return false;
                else {
                    BankRecordTmp brt = (BankRecordTmp) p;
                    if (!isYearAndMonth(brt.getInTime(), time))
                        return false;
                    return true;
                }
            }
        });
        trans.commit();
        return brts;
    }

    @Override
    public boolean clearBadRecord() {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Query query = session.createQuery("delete from BankRecordTmp where status = 2");
            query.executeUpdate();
            trans.commit();
        }catch(HibernateException he){
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return true;
    }

    @Override
    public boolean importToSql() {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Query query = session.createQuery("update BankRecordTmp set status = 1 where status = 0");
            query.executeUpdate();
            trans.commit();
        }catch(HibernateException he){
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return true;
    }

    @Override
    public boolean addBadList(List<BankRecordTmp> brts) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            for(BankRecordTmp brt:brts){
                brt.setStatus(2);
                session.update(brt);
            }
            trans.commit();
        }catch(HibernateException he){
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return true;
    }

    @SuppressWarnings("deprecation")
	private boolean isYearAndMonth(Date date1,Date date2){
        if(date1 == null||date2 == null) return false;
        return date1.getYear() == date2.getYear() && date1.getMonth() == date2.getMonth();
    }
}
