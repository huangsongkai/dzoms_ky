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
 *         Created on 15-12-28.
 */
@Repository
public class ReceiptDaoImp implements ReceiptDao {
    @Override
    public boolean deleteRecord(int id) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("delete from ReceiptRecord where id = :id");
            query.setInteger("id",id);
            query.executeUpdate();
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

    @Override
    public List<ReceiptRecord> searchRecordsByProveNum(String proveNum) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        List<ReceiptRecord> rrs = new ArrayList<>();
        try{
            proveNum = proveNum.trim();
            Query query = session.createQuery("from ReceiptRecord where proveNum=:proveNum");
            query.setString("proveNum", proveNum);
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

    @Override
    public ReceiptRecord getRecord(int id) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        ReceiptRecord rr = null;
        try{
            rr = (ReceiptRecord)session.get(ReceiptRecord.class,id);
            trans.commit();
        }catch (HibernateException he){
            he.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return rr;
    }

    @Override
    public int getNextAvaliable(String proveNum) {
        int x = -1;
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("select min(roll.startNum) from ReceiptRecord rr,Roll roll where rr.proveNum=:proveNum and rr.startNum <= roll.startNum and rr.endNum >= roll.endNum and roll.solded=0");
            query.setString("proveNum",proveNum);
            Object o = query.uniqueResult();
            if(o != null){
                x = (Integer)o;
            }
            trans.commit();
        }catch (HibernateException he){
            he.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return x;
    }

    @Override
    public void addRecord(ReceiptRecord rr,Session session) {
        rr.setYear(rr.getHappenTime().getYear()+1900);
        session.save(rr);        
    }

    @Override
    public List<ReceiptRecord> searchRecords(Date start, Date end) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("from ReceiptRecord where (happenTime is null) or (happenTime between :start and :end)");
            query.setDate("start",start);
            query.setDate("end",end);
            @SuppressWarnings("unchecked")
			List<ReceiptRecord> rrs = query.list();
            trans.commit();
            if(rrs == null)
                return new ArrayList<ReceiptRecord>();
            else return rrs;
        }catch (HibernateException he){
            he.printStackTrace();
            trans.rollback();
            return new ArrayList<ReceiptRecord>();
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
}
