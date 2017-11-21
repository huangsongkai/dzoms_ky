package com.dz.module.charge;

import java.util.Date;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

/**
 * @author doggy
 *         Created on 15-11-20.
 */
@Repository
public class BankFileDaoImp implements BankFileDao{
    @Override
    public boolean isFileImported(String md5) {
        Session session = null;
        session = HibernateSessionFactory.getSession();
        Query query = session.createQuery("select count(*) from BankFile where md5 = :md5");
        query.setString("md5",md5);
        int x = Integer.parseInt(query.uniqueResult().toString());
        if(x == 1){
            return true;
        }else{
            return false;
        }
    }

    @Override
    public int importFile(String md5,Date insertMonth) {
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            BankFile bf = new BankFile();
            bf.setInsertMonth(insertMonth);
            bf.setInsertTime(new Date());
            bf.setMd5(md5);
            session.save(bf);
            trans.commit();
            return bf.getId();
        }catch (Exception e){
            trans.rollback();
            return -1;
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }
}
