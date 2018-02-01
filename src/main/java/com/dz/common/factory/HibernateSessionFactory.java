package com.dz.common.factory;

import com.dz.common.test.SpringContextListener;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.stereotype.Service;

@Service
public class HibernateSessionFactory {
    @Autowired
    public void setLocalSessionFactoryBean(LocalSessionFactoryBean localSessionFactoryBean) {
        HibernateSessionFactory.localSessionFactoryBean = localSessionFactoryBean;
    }

    /**
     * Location of hibernate.cfg.xml file.
     * Location should be on the classpath as Hibernate uses
     * #resourceAsStream style lookup for its configuration file.
     * The default classpath location of the hibernate config file is
     * in the default package. Use #setConfigFile() to update
     * the location of the configuration file for the current session.
     */
    private static LocalSessionFactoryBean localSessionFactoryBean;
    private static HibernateSessionFactory instance;
    private static SessionFactory sessionFactory;
    private static final ThreadLocal<Session> threadLocal = new ThreadLocal<Session>();

    public HibernateSessionFactory() {
    }

    /**
     * Returns the ThreadLocal Session instance.  Lazy initialize
     * the <code>SessionFactory</code> if needed.
     *
     *  @return Session
     *  @throws HibernateException
     */
    public static Session getSession() throws HibernateException {
        Session session = threadLocal.get();
        if (session == null || !session.isOpen()) {
            if (sessionFactory==null||sessionFactory.isClosed()){
                rebuildSessionFactory();
            }
            session = sessionFactory.openSession();
            threadLocal.set(session);
        }
        return session;
    }

    /**
     *  Rebuild hibernate session factory
     *
     */
    public static void rebuildSessionFactory() {
        ApplicationContext app = SpringContextListener.getApplicationContext();
        instance = app.getBean(HibernateSessionFactory.class);
        sessionFactory = localSessionFactoryBean.getObject();
    }

    /**
     *  Close the single hibernate session instance.
     *
     *  @throws HibernateException
     */
    public static void closeSession() throws HibernateException {
        Session session = threadLocal.get();
        threadLocal.set(null);

        if (session != null) {
            session.close();
        }
    }

    /**
     *  return session factory
     *
     */
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }


}