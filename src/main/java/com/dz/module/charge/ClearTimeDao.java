package com.dz.module.charge;

import java.util.Date;

import org.hibernate.HibernateException;
import org.hibernate.Session;

/**
 * @author doggy
 *         Created on 15-11-18.
 */
public interface ClearTimeDao {
    Date getCurrent(String department);
    Date getCurrent(String department, Session session) throws HibernateException;
    boolean plusAMonth(String department);
	boolean plusAMonth(String dept, Session session) throws HibernateException;
}
