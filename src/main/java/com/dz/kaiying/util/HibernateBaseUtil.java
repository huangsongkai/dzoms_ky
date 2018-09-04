package com.dz.kaiying.util;

import com.dz.kaiying.util.IHibernateBaseUtil;
import com.dz.kaiying.util.PageResults;
import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


public class HibernateBaseUtil<T, ID extends Serializable> implements IHibernateBaseUtil<T, ID> {

    protected Class<T> entityClass;

    public HibernateBaseUtil() {

    }

    private SessionFactory sessionFactory;

    @Autowired
    private void sessionFactory(SessionFactory sessionFactory) {
        // TODO set sessionFactory
        this.sessionFactory = sessionFactory;
    }

    /**
     *
     * @return session
     */
    public Session getSession() {
        //需要开启事物，才能得到CurrentSession,这里我采用aop事务配置，你也可以采用@Transactional进行声明式事务配置
        return this.sessionFactory.getCurrentSession();
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    protected Class getEntityClass() {
        if (entityClass == null) {
            Type type = getClass().getGenericSuperclass();  //反射方式获取父类全称 即com.chat.common.dao.impl.HibernateBaseUtil<com.chat.dao.impl.ChatUserDao, com.chat.dao.impl.ChatUserDao>
            Type[] t  = ((ParameterizedType) type).getActualTypeArguments();    //获取父类的泛型参数,并存为数组
            entityClass = (Class<T>) t[0];  //获取第一个参数，即com.chat.dao.impl.ChatUserDao
            //entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        }
        return entityClass;
    }


    /**
     * <保存实体>
     * <完整保存实体>
     * @param t 实体参数
     * @see com.chat.common.dao.IHibernateBaseUtil#saveEntity(java.lang.Object)
     */
    @Override
    public void saveEntity(T t) {
        getSession().save(t);
        getSession().flush(); //刷新事务，执行之后将会提交事务，可以防止事务堆积在缓存里

    }

    /**
     * <保存或者更新实体>
     * @param t 实体
     * @see com.chat.common.dao.IHibernateBaseUtil#saveOrUpdate(java.lang.Object)
     */
    @Override
    public void saveOrUpdate(T t) {
        getSession().saveOrUpdate(t);
        getSession().flush(); //刷新事务，执行之后将会提交事务，可以防止事务堆积在缓存里

    }

    /**
     * <get>
     * <查找的get方法>
     * @param id 实体的id
     * @return 查询出来的实体
     * @see com.chat.common.dao.IHibernateBaseUtil#get(java.io.Serializable)
     */
    @SuppressWarnings("unchecked")
    @Override
    public T get(ID id) {
        T load = (T)getSession().get(getEntityClass(), id);

        return load;
    }

    /**
     * <contains>
     * @param t 实体
     * @return 是否包含
     * @see com.chat.common.dao.IHibernateBaseUtil#contains(java.lang.Object)
     */
    @Override
    public boolean contains(T t) {
        return getSession().contains(t);
    }

    /**
     * <delete>
     * <删除表中的t数据>
     * @param t 实体
     * @see com.chat.common.dao.IHibernateBaseUtil#delete(java.lang.Object)
     */
    @Override
    public void delete(T t) {
        getSession().delete(t);

    }

    /**
     * <delete>
     * <删除表中的t数据>
     * @param hqlString hql语句
     * @param values 不定参数数组
     * @see com.chat.common.dao.IHibernateBaseUtil#deleteSql(java.lang.Object)
     */
    @Override
    public void deleteSql(String sqlString, Object... values) {
        Query query = getSession().createQuery(sqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }
        query.executeUpdate();

    }

    /**
     * <根据ID删除数据>
     * @param Id 实体id
     * @return 是否删除成功
     * @see com.chat.common.dao.IHibernateBaseUtil#deleteById(java.io.Serializable)
     */
    @Override
    public boolean deleteById(ID Id) {
        T t = get(Id);
        if(t == null){
            return false;
        }
        delete(t);

        return true;
    }

    /**
     * <删除所有>
     * @param entities 实体的Collection集合
     * @see com.chat.common.dao.IHibernateBaseUtil#deleteAll(java.util.Collection)
     */
    @Override
    public void deleteAll(Collection<T> entities) {
        for(Object entity : entities) {
            getSession().delete(entity);
        }

    }

    /**
     * <执行Hql语句>
     * @param hqlString hql语句
     * @param values 不定参数数组
     * @see com.chat.common.dao.IHibernateBaseUtil#queryHql(java.lang.String, java.lang.Object[])
     */
    @Override
    public void queryHql(String hqlString, Object... values) {
        Query query = getSession().createQuery(hqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        query.executeUpdate();

    }

    /**
     * <执行Sql语句>
     * @param sqlString sql语句
     * @param values 不定参数数组
     * @see com.chat.common.dao.IHibernateBaseUtil#querySql(java.lang.String, java.lang.Object[])
     */
    @Override
    public void querySql(String sqlString, Object... values) {
        Query query = getSession().createSQLQuery(sqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        query.executeUpdate();

    }

    /**
     * <根据HQL语句查找唯一实体>
     * @param hqlString HQL语句
     * @param values 不定参数的Object数组
     * @return 查询实体
     * @see com.chat.common.dao.IHibernateBaseUtil#getByHQL(java.lang.String, java.lang.Object[])
     */
    @SuppressWarnings("unchecked")
    @Override
    public T getByHQL(String hqlString, Object... values) {
        Query query = getSession().createQuery(hqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        return (T) query.uniqueResult();
    }

    /**
     * <根据SQL语句查找唯一实体>
     * @param sqlString SQL语句
     * @param values 不定参数的Object数组
     * @return 查询实体
     * @see com.chat.common.dao.IHibernateBaseUtil#getBySQL(java.lang.String, java.lang.Object[])
     */
    @SuppressWarnings("unchecked")
    @Override
    public T getBySQL(String sqlString, Object... values) {
        Query query = getSession().createSQLQuery(sqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        return (T) query.uniqueResult();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<T> getAllByHQL(String hqlString){
        Query query = getSession().createQuery(hqlString);

        return query.list();
    }
    /**
     * <根据HQL语句，得到对应的list>
     * @param hqlString HQL语句
     * @param values 不定参数的Object数组
     * @return 查询多个实体的List集合
     * @see com.chat.common.dao.IHibernateBaseUtil#getListByHQL(java.lang.String, java.lang.Object[])
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> getListByHQL(String hqlString, Object... values) {
        Query query = getSession().createQuery(hqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        return query.list();
    }

    /**
     * <根据SQL语句，得到对应的list>
     * @param sqlString HQL语句
     * @param values 不定参数的Object数组
     * @return 查询多个实体的List集合
     * @see com.chat.common.dao.IHibernateBaseUtil#getListBySQL(java.lang.String, java.lang.Object[])
     */
    @SuppressWarnings("unchecked")
    @Override
    public List<T> getListBySQL(String sqlString, Object... values ) {
        Query query = getSession().createSQLQuery(sqlString);
        if (values != null)
        {
            for (int i = 0; i < values.length; i++)
            {
                query.setParameter(i, values[i]);
            }
        }

        return query.list();
    }

    /**
     * <update>
     * @param t 实体
     * @see com.chat.common.dao.IHibernateBaseUtil#update(java.lang.Object)
     */
    @Override
    public void updateEntity(T t) {
        getSession().update(t);
        this.getSession().flush();  //刷新事务，执行之后将会提交事务，可以防止事务堆积在缓存里
    }

    /**
     * 根据id更新实体类
     * @param hql
     * @param id
     */
    @Override
    public void updateByHql(String hql,Object... values){
        Query query = this.getSession().createQuery(hql);
        if(values != null){
            for(int i=0;i<values.length;i++){
                query.setParameter(i, values[i]);
            }
        }
        query.executeUpdate();

    }

    /**
     * <根据HQL和参数得到记录数>
     * @param hql HQL语句
     * @param values 不定参数的Object数组
     * @return 记录总数
     * @see com.chat.common.dao.IHibernateBaseUtil#countByHql(java.lang.String, java.lang.Object[])
     */
    @Override
    public Long countByHql(String hql, Object... values) {
        Query query = getSession().createQuery(hql);
        if(values != null){
            for(int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        return (Long) query.uniqueResult();
    }

    /**
     * <指定HQL得到全部记录数>
     * @param hql HQL语句
     * @return 记录总数
     * @see com.chat.common.dao.IHibernateBaseUtil#countAll(java.lang.String, java.lang.Object[])
     */
    @Override
    public Long countAll(String hql) {
        Query query = getSession().createQuery(hql);
        return (Long) query.uniqueResult();
    }

    /**
     * <HQL分页查询>
     * @param hql HQL语句
     * @param countHql 查询记录条数的HQL语句
     * @param pageNo 下一页
     * @param pageSize 一页总条数
     * @param values 不定Object数组参数
     * @return PageResults的封装类，里面包含了页码的信息以及查询的数据List集合
     * @see com.chat.common.dao.IHibernateBaseUtil#findPageByFetchedHql(java.lang.String, java.lang.String, int, int, java.lang.Object[])
     */
    @SuppressWarnings("unchecked")
    @Override
    public PageResults<T> findPageByFetchedHql(String hql, String countHql,
                                               int pageNo, int pageSize, Object... values) {
        PageResults<T> retValue = new PageResults<T>();
        Query query = getSession().createQuery(hql);
        if(values != null){
            for(int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        int currentPage = pageNo > 1 ? pageNo : 1;
        retValue.setCurrentPage(currentPage);
        retValue.setPageSize(pageSize);
        if (countHql == null)
        {
            ScrollableResults results = query.scroll();
            results.last();
            retValue.setTotalCount(results.getRowNumber() + 1);// 设置总记录数
        }
        else
        {
            Long count = countByHql(countHql, values);
            retValue.setTotalCount(count.intValue());
        }
        retValue.resetPageNo();
        List<T> itemList = query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(pageSize).list();
        if (itemList == null)
        {
            itemList = new ArrayList<T>();
        }
        retValue.setResults(itemList);
        return retValue;
    }

}