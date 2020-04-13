package com.dz.module.charge.receipt;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.test.LogExecuteTime;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Date;

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
    @LogExecuteTime
    public void addFromSeg(int startNum, int endNum,int numberSize,String prefix,int year,Session session) {
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Roll roll = new Roll();
                roll.setSolded(0);
                roll.setStartNum(start);
                roll.setEndNum(end);
                roll.setPrefix(prefix);
                roll.setNumberSize(numberSize);
                roll.setStartFullNum(prefix+start);
                roll.setEndFullNum(prefix+end);
                roll.setYear(year);
                start += 100;
                end += 100;
                session.save(roll);
            }        
    }


    @Override
    @LogExecuteTime
    public boolean markAsUnUsed(int startNum, int endNum,String prefix) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Query query = session.createQuery("from Roll where startNum = :start and prefix=:prefix ");
                query.setInteger("start",start);
                query.setString("prefix",prefix);
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

//    @Override
//    public boolean markAsUsed(int startNum, int endNum) {
//        Session session = HibernateSessionFactory.getSession();
//        Transaction trans = session.beginTransaction();
//        try{
//            int start = startNum;
//            int end = start + 99;
//            while(end <= endNum){
//                Query query = session.createQuery("from Roll where startNum = :start");
//                query.setInteger("start",start);
//                Roll roll = (Roll)query.uniqueResult();
//                if(roll==null){
//                	System.err.println("Start:"+start);
//                	start += 100;
//                    end += 100;
//                	continue;
//                }
//                roll.setSolded(1);
//                session.update(roll);
//                start += 100;
//                end += 100;
//            }
//            trans.commit();
//            return true;
//        }catch (Exception e){
//            e.printStackTrace();
//            trans.rollback();
//            return false;
//        }finally {
//            HibernateSessionFactory.closeSession();
//        }
//    }
    
    @Override
    @LogExecuteTime
    public void markAsUsed(int startNum, int endNum, int numberSize, String prefix, Session session){
            int start = startNum;
            int end = start + 99;
            while(end <= endNum){
                Query query = session.createQuery(
                        "from Roll where prefix=:prefix " +
                                "and startNum = :start ");
//                query.setInteger("numberSize",numberSize);
                query.setString("prefix",prefix);
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
    public boolean isValidForIn(int startNum, int endNum,String prefix) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("select count(*) from Roll" +
                    " where year=:year " +
                    " and ( startNum between :start and :end) " +
                    "    or (endNum between :start and :end) " +
                    " and prefix=:prefix ");
            query.setLong("start",startNum);
            query.setLong("end",endNum);
            query.setString("prefix",prefix);
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
    public boolean deleteRoll(int startNum, int endNum,String prefix) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery("delete from Roll where (startNum between :start and :end) and prefix=:prefix ");
            query.setLong("start", startNum);
            query.setLong("end", endNum);
            query.setString("prefix",prefix);
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
    public boolean isValidForSold(int startNum, int endNum,int year,String prefix) {
        Session session = HibernateSessionFactory.getSession();
        Transaction trans = session.beginTransaction();
        try{
            Query query = session.createQuery(
                    "select count(*) from Roll " +
                            "where year=:year " +
                            "and (startNum between :start and :end) " +
                            "and (endNum between :start and :end) " +
                            "and solded = 0 " +
                            "and prefix=:prefix ");
            query.setLong("start",startNum);
            query.setLong("end", endNum);
            query.setInteger("year", year);
            query.setString("prefix",prefix);
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
