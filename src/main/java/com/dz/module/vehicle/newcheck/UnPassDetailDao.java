package com.dz.module.vehicle.newcheck;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

/**
 * @author doggy
 *         Created on 16-3-25.
 */
@Repository("unpassdetaildao")
public class UnPassDetailDao {
    public boolean addOne(UnPassDetail upd){
        Session session = HibernateSessionFactory.getSession();
        Transaction transaction = session.beginTransaction();
        try{
            session.save(upd);
            transaction.commit();
            return true;
        }catch (HibernateException he){
            he.printStackTrace();
            transaction.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
    public boolean updateOne(UnPassDetail upd){
        Session session = HibernateSessionFactory.getSession();
        Transaction transaction = session.beginTransaction();
        try{
            session.update(upd);
            transaction.commit();
            return true;
        }catch (HibernateException he){
            he.printStackTrace();
            transaction.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }

    }
    public boolean deleteOne(UnPassDetail upd){
        Session session = HibernateSessionFactory.getSession();
        Transaction transaction = session.beginTransaction();
        try{
            session.delete(upd);
            transaction.commit();
            return true;
        }catch (HibernateException he){
            he.printStackTrace();
            transaction.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }

    }
}
