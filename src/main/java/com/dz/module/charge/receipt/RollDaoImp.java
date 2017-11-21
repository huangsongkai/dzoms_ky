package com.dz.module.charge.receipt;

import java.util.Date;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
@Repository
public class RollDaoImp implements RollDao {
    @Override
    public boolean addFromSeg(int startNum, int endNum,int year) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Roll roll = new Roll();
                roll.setSolded(0);
                roll.setStartNum(start);
                roll.setEndNum(end);
                roll.setYear(year);
                start += 100;
                end += 100;
                session.save(roll);
            }
            trans.commit();
            return true;
        }catch (Exception e){
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
    
    @Override
    public void addFromSeg(int startNum, int endNum,int year,Session session) {
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Roll roll = new Roll();
                roll.setSolded(0);
                roll.setStartNum(start);
                roll.setEndNum(end);
                roll.setYear(year);
                start += 100;
                end += 100;
                session.save(roll);
            }        
    }


    @Override
    public boolean markAsUnUsed(int startNum, int endNum) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Query query = session.createQuery("from Roll where startNum = :start");
                query.setInteger("start",start);
                Roll roll = (Roll)query.uniqueResult();
                roll.setSolded(0);
                session.update(roll);
                start += 100;
                end += 100;
            }
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

    @Override
    public boolean markAsUsed(int startNum, int endNum) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Query query = session.createQuery("from Roll where startNum = :start");
                query.setInteger("start",start);
                Roll roll = (Roll)query.uniqueResult();
                if(roll==null){
                	System.err.println("Start:"+start);
                	start += 100;
                    end += 100;
                	continue;
                }
                roll.setSolded(1);
                session.update(roll);
                start += 100;
                end += 100;
            }
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
    
    @Override
    public void markAsUsed(int startNum, int endNum,Session session) {
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Query query = session.createQuery("from Roll where startNum = :start");
                query.setInteger("start",start);
                Roll roll = (Roll)query.uniqueResult();
                if(roll==null){
                	System.err.println("Start:"+start);
                	start += 100;
                    end += 100;
                	continue;
                }
                roll.setSolded(1);
                session.update(roll);
                start += 100;
                end += 100;
            }
    }

    @Override
    public boolean isValidForIn(int startNum, int endNum) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("select count(*) from Roll where year=:year and ( startNum between :start and :end) or (endNum between :start and :end)");
            query.setLong("start",startNum);
            query.setLong("end",endNum);
            query.setInteger("year", new Date().getYear()+1900);
            long x = (Long)query.uniqueResult();
//            System.out.println(x);
            if(x == 0){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    @Override
    public boolean deleteRoll(int startNum, int endNum) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("delete from Roll where startNum between :start and :end");
            query.setLong("start", startNum);
            query.setLong("end", endNum);
            query.executeUpdate();
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
    public boolean isValidForSold(int startNum, int endNum,int year) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("select count(*) from Roll where year=:year and (startNum between :start and :end) and (endNum between :start and :end) and solded = 0");
            query.setLong("start",startNum);
            query.setLong("end", endNum);
            query.setInteger("year", year);
            long x = (Long)query.uniqueResult();
            if(x == (endNum-startNum+1)/100){
                return true;
            }else{
                return false;
            }
        }catch (Exception e){
            trans.rollback();
            e.printStackTrace();
            return false;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    @Override
    public long getStorage() {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("select count(*) from Roll where solded = 0");
            long x = (Long)query.uniqueResult();
            return x;
        }catch (Exception e){
            e.printStackTrace();
            trans.rollback();
            return 0;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
}
