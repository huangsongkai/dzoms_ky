package com.dz.common.seqence;

import com.dz.common.factory.HibernateSessionFactory;
import com.opensymphony.xwork2.ActionSupport;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

/**
 * @author doggy
 *         Created on 16-3-2.
 */
@Controller(value = "seqaction")
@Scope(value = "prototype")
public class SeqAction extends ActionSupport{
    private int kind;
    private String ajax_message;
    public String get(){
        Session session = null;
        try{
            session = HibernateSessionFactory.getSession();
            Seq seq = (Seq)session.get(Seq.class,kind);
            ajax_message = seq.getNum()+"";
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }
        return "stringresult";
    }

    public String increment(){
        Session session = null;
        try{
            session = HibernateSessionFactory.getSession();
            Transaction trans = session.beginTransaction();
            Seq seq = (Seq)session.get(Seq.class,kind);
            seq.setNum(seq.getNum()+1);
            trans.commit();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            session.close();
        }
        return SUCCESS;
    }

    public int getKind() {
        return kind;
    }

    public void setKind(int kind) {
        this.kind = kind;
    }

    public String getAjax_message() {
        return ajax_message;
    }

    public void setAjax_message(String ajax_message) {
        this.ajax_message = ajax_message;
    }
}
