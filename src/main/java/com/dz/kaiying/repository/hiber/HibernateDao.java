package com.dz.kaiying.repository.hiber;

import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.criterion.DetachedCriteria;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

/**
 * Created by huang on 2017/4/24.
 */
public interface HibernateDao<T, PK extends Serializable> {
    // 根据主键获取实体。如果没有相应的实体，返回 null。
    T get(Class<T> c, PK id);

    T getWithLock(Class<T> c, PK id, LockMode lock);

    // 根据主键获取实体。如果没有相应的实体，抛出异常。
    T load(Class<T> c, PK id);

    T loadWithLock(Class<T> c, PK id, LockMode lock);

    // 获取全部实体。
    List<T> loadAll(Class<T> c);

    // 更新实体
    void update(T entity);

    // 更新实体并加锁
    void updateWithLock(T entity, LockMode lock);

    // 存储实体到数据库
    Integer save(T entity);

    // 增加或更新实体
    void saveOrUpdate(T entity);

    // 增加或更新集合中的全部实体
    void saveOrUpdateAll(Collection<T> entities);

    // 删除指定的实体
    void delete(T entity);

    // 加锁并删除指定的实体
    void deleteWithLock(T entity, LockMode lock);

    // 根据主键删除指定实体
    void deleteByKey(Class<T> c, PK id);

    // 根据主键加锁并删除指定的实体
    void deleteByKeyWithLock(Class<T> c, PK id, LockMode lock);

    // 删除集合中的全部实体
    void deleteAll(Collection<T> entities);

    // 使用HSQL语句直接增加、更新、删除实体
    int bulkUpdate(String queryString);

    // 使用带参数的HSQL语句增加、更新、删除实体
    int bulkUpdate(String queryString, Object[] values);

    // 使用HSQL语句检索数据
    List find(String queryString);

    // 使用带参数的HSQL语句检索数据
    List find(String queryString, Object[] values);

    // 使用带命名的参数的HSQL语句检索数据
    List findByNamedParam(String queryString, String[] paramNames,
                          Object[] values);

    // 使用命名的HSQL语句检索数据
    List findByNamedQuery(String queryName);

    // 使用带参数的命名HSQL语句检索数据
    List findByNamedQuery(String queryName, Object[] values);

    // 使用带命名参数的命名HSQL语句检索数据
    List findByNamedQueryAndNamedParam(String queryName,
                                       String[] paramNames, Object[] values);

    // 使用HSQL语句检索数据，返回 Iterator
    Iterator iterate(String queryString);

    // 使用带参数HSQL语句检索数据，返回 Iterator
    Iterator iterate(String queryString, Object[] values);

    // 关闭检索返回的 Iterator
    void closeIterator(Iterator it);

    // 创建与会话无关的检索标准
    DetachedCriteria createDetachedCriteria(Class c);

    // 创建与会话绑定的检索标准
    Criteria createCriteria(Class<T> c);

    // 检索满足标准的数据
    List findByCriteria(DetachedCriteria criteria);

    // 检索满足标准的数据，返回指定范围的记录
    List findByCriteria(DetachedCriteria criteria, int firstResult,
                        int maxResults);

    // 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
    List<T> findEqualByEntity(T entity, String[] propertyNames);

    // 使用指定的实体及属性检索（满足属性 like 串实体值）数据
    List<T> findLikeByEntity(T entity, String[] propertyNames);

    // 使用指定的检索标准获取满足标准的记录数
    Integer getRowCount(DetachedCriteria criteria);

    // 使用指定的检索标准检索数据，返回指定统计值(max,min,avg,sum)
    Object getStatValue(DetachedCriteria criteria, String propertyName,
                        String StatName);

    // 加锁指定的实体
    void lock(T entity, LockMode lock);

    // 强制初始化指定的实体
    void initialize(Object proxy);

    // 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
    void flush();
}
