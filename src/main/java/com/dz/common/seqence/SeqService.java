package com.dz.common.seqence;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

/**
 * @author doggy
 *         Created on 16-3-4.
 */
@Service
@Scope(value = "prototype")
public class SeqService {
    public void increment(){
        Session session = null;
        Transaction trans = null;
        try{
            session = HibernateSessionFactory.getSession();
            trans = session.beginTransaction();
            Seq seq = (Seq)session.get(Seq.class,1);
            seq.setNum(seq.getNum()+1);
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
            if(trans!=null){
            	trans.rollback();
            }
        }finally {
        	HibernateSessionFactory.closeSession();
        }
    }
}
