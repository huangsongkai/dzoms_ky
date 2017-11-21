package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

/**
 * @author doggy
 *         Created on 16-3-23.
 */
@Repository
public class AIDao {
    public boolean addOne(AccidentInsurance ai){
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            session.save(ai);
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
    public boolean deleteAndAddOne(AccidentInsurance ai){
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("delete from AccidentInsurance where accId=:accId");
            query.setInteger("accId",ai.getAccId());
            query.executeUpdate();

            session.save(ai);

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
    public AccidentInsurance selectAIByAccId(int accId){
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        AccidentInsurance accidentInsurance = null;
        try{
            Query query = session.createQuery("from AccidentInsurance where accId=:accId");
            query.setInteger("accId",accId);
            Object o = query.uniqueResult();
            if(o != null){
                accidentInsurance = (AccidentInsurance)o;
            }
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
            return accidentInsurance;
        }
    }
}
