package com.dz.module.user;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dz.common.factory.HibernateSessionFactory;

import java.util.List;

/**
 * @author doggy
 *         Created on 16-3-16.
 */
@Service
public class ManagerService {
    @Autowired
    private ManagerDao managerDao;
    public void addUser(User user){
        managerDao.addUser(user);
    }
    public void deleteUser(User user){
        managerDao.deleteUser(user);
    }
    public List<User> searchAllUser(){
        return managerDao.selectAllUser();
    }
    public void assignAuthority(User user,int[] roleIds){
    	 Session session = null;
         Transaction transaction = null;
         try{
             session = HibernateSessionFactory.getSession();
             transaction = session.beginTransaction();
             managerDao.deleteRelationUrs(user);
             for(int roleId:roleIds){
            	 RelationUr relationUr = new RelationUr();
            	 relationUr.setRid(roleId);
            	 relationUr.setUid(user.getUid());
            	 managerDao.addRelationUr(relationUr);
             }
             transaction.commit();
         }catch (HibernateException e){
             e.printStackTrace();
             if(transaction!=null)
            	 transaction.rollback();
         }finally {
             HibernateSessionFactory.closeSession();
         }
    }
    public List<RelationUr> searchAuthoritiesByUser(User user){
        return managerDao.getRelationsByUser(user);
    }
}
