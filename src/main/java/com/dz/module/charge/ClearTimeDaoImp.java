package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Calendar;
import java.util.Date;

/**
 * @author doggy
 *         Created on 15-11-18.
 */
@Repository(value="clearTimeDao")
public class ClearTimeDaoImp implements ClearTimeDao {
	private static Logger logger = Logger.getLogger(ClearTimeDaoImp.class);
	
    @Override
    public Date getCurrent(String dept) {
    	logger.debug("invoking");
        Session session = null;
        session = HibernateSessionFactory.getSession();
        Query query = session.createQuery("from ClearTime where department = :dept");
        query.setString("dept",dept);
        Object obj = query.uniqueResult();
        ClearTime ct = (ClearTime)obj;
        HibernateSessionFactory.closeSession();
        logger.debug(ct);
        return ct.getCurrent();
    }
    
    @Override
    public Date getCurrent(String dept,Session session) {
    	logger.debug("invoking");
        Query query = session.createQuery("from ClearTime where department = :dept");
        query.setString("dept",dept);
        Object obj = query.uniqueResult();
        ClearTime ct = (ClearTime)obj;
        logger.debug(ct);
        return ct.getCurrent();
    }

    @Override
    public boolean plusAMonth(String dept) {
        Session session = null;
        Transaction tran = null;
        try{
            session = HibernateSessionFactory.getSession();
            tran = session.beginTransaction();
            Query query = session.createQuery("from ClearTime where department = :dept");
            query.setString("dept",dept);
            Object obj = query.uniqueResult();
            if(obj == null){
                return false;
            }else{
                ClearTime ct = (ClearTime)obj;
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(ct.getCurrent());
                int month = calendar.get(Calendar.MONTH);
                if(month != 11){
                    calendar.set(Calendar.MONTH,month+1);
                }else {
                    calendar.set(Calendar.YEAR,calendar.get(Calendar.YEAR)+1);
                    calendar.set(Calendar.MONTH,0);
                }
                ct.setCurrent(calendar.getTime());
                session.update(ct);
                tran.commit();
                return true;
            }
        }catch (Exception e){
            tran.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return false;
    }
    
    @Override
    public boolean plusAMonth(String dept,Session session) throws HibernateException {
            Query query = session.createQuery("from ClearTime where department = :dept");
            query.setString("dept",dept);
            Object obj = query.uniqueResult();
            if(obj == null){
                return false;
            }else{
                ClearTime ct = (ClearTime)obj;
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(ct.getCurrent());
                int month = calendar.get(Calendar.MONTH);
                if(month != 11){
                    calendar.set(Calendar.MONTH,month+1);
                }else {
                    calendar.set(Calendar.YEAR,calendar.get(Calendar.YEAR)+1);
                    calendar.set(Calendar.MONTH,0);
                }
                ct.setCurrent(calendar.getTime());
                session.update(ct);
                return true;
            }
    }

}
