package com.dz.kaiying.util;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by song on 2017/7/5.
 */
@Service
public class HibernateUtil<T> {
    @Autowired
    HibernateTemplate hibernateTemplate;
    public List queryBySql(final String sql){
        return (List) hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException {
                SQLQuery query = session.createSQLQuery(sql);
                return query.list();
            }
        });
    }
    public List queryBySql(final String sql, final Class c){
        return (List) hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException {
                SQLQuery query = session.createSQLQuery(sql).addEntity(c);
                return query.list();
            }
        });
    }
}
