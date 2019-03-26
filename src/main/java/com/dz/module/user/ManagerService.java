package com.dz.module.user;

import com.dz.common.global.GenerateKeyHash;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.support.ClassPathXmlApplicationContext;
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
        GenerateKeyHash generateKeyHash = GenerateKeyHash.getInstance();
        String salt = generateKeyHash.generateSaltAsString();
        String hash = generateKeyHash.encodedHash(salt,"123");
        user.setPasswordSalt(salt);
        user.setPasswordHash(hash);
        managerDao.addUser(user);
    }

    public void updateUserPassword(User user,String newPassword){
        GenerateKeyHash generateKeyHash = GenerateKeyHash.getInstance();
        user = userDao.getUser(user);
        String salt = user.getPasswordSalt();
        if(salt==null || StringUtils.isBlank(salt)){
            salt = generateKeyHash.generateSaltAsString();
        }
        String hash = generateKeyHash.encodedHash(salt,newPassword);
        user.setPasswordSalt(salt);
        user.setPasswordHash(hash);
        managerDao.updateUser(user);
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

    @Autowired
    @Qualifier("userDaoImpl")
    private UserDao userDao;
    public String userLogin(User user){
        if (user == null) {
            return "user_null";
        }

        return userDao.verifyUser(user);
    }

    public boolean verifyUser(User user){
        if (user==null || user.getUpwd()==null)
            return false;
        return StringUtils.isNumeric(userDao.verifyUser(user));
    }

    public User getUser(User user){
        return userDao.getUser(user);
    }

    public static void main(String[] args){
        ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        HibernateSessionFactory.rebuildSessionFactory(applicationContext);

        ManagerService managerService = applicationContext.getBean(ManagerService.class);
        managerService.searchAllUser().forEach(user -> managerService.updateUserPassword(user,"123"));
    }

    public void updateUserInfo(User user) {
        userDao.saveUser(user);
    }

    public void setManagerDao(ManagerDao managerDao) {
        this.managerDao = managerDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
}
