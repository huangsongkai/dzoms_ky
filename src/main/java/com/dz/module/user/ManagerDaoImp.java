package com.dz.module.user;

import com.dz.common.factory.HibernateSessionFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * @author doggy
 *         Created on 16-3-16.
 */
@Repository
public class ManagerDaoImp implements ManagerDao{
    @Override
    public void addUser(User user) {
        Session session = null;
        Transaction transaction = null;
        try{
            session = HibernateSessionFactory.getSession();
            transaction = session.beginTransaction();

            session.save(user);

            transaction.commit();
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    @Override
    public void deleteUser(User user) {
        Session session = null;
        Transaction transaction = null;
        try{
            session = HibernateSessionFactory.getSession();
            transaction = session.beginTransaction();
            User sql_user = (User)session.get(User.class,user.getUid());
            session.delete(sql_user);
            transaction.commit();
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }

    @Override
    public List<User> selectAllUser() {
        Session session = null;
        Transaction transaction = null;
        List<User> users = new ArrayList<>();
        try{
            session = HibernateSessionFactory.getSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from User");
            users = query.list();
            transaction.commit();
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return users;
    }

    @Override
    public List<RelationUr> getRelationsByUser(User user) {
        Session session = null;
        Transaction transaction = null;
        List<RelationUr> urs = new ArrayList<>();
        try{
            session = HibernateSessionFactory.getSession();
            transaction = session.beginTransaction();
            Query query = session.createQuery("from RelationUr where uid = :uid");
            query.setInteger("uid",user.getUid());
            urs = query.list();
            transaction.commit();
        }catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
        }finally {
            HibernateSessionFactory.closeSession();
        }
        return urs;
    }

    @Override
    public void addRelationUr(RelationUr relationUr) throws HibernateException {
    	Session session = HibernateSessionFactory.getSession();
        session.save(relationUr);
    }

    @Override
    public void deleteRelationUrs(User user) throws HibernateException {
    	 Session session = HibernateSessionFactory.getSession();
         Query query = session.createQuery("delete from RelationUr where uid = :uid");
         query.setInteger("uid",user.getUid());
         query.executeUpdate();
    }
}
