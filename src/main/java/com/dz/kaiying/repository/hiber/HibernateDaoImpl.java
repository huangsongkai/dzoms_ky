package com.dz.kaiying.repository.hiber;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.criterion.*;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import static com.dz.common.factory.HibernateSessionFactory.getSessionFactory;

@Repository
/**
 * @Repository只能标注在DAO类上。因为该注解的作用不仅是将类识别为Bean，同时
 * 它还能降所标注的类中跑出的数据访问异常封装为Spring的数据访问异常类型，
 * @Component是一个泛华的概念，仅仅表示一个组件（Bean），可以用在任何层次。
 * 而@Service通常作用在业务层，但是目前该功能与 @Component 相同。
 * @Controller通常作用在控制层。但是目前该功能与 @Component 相同。
 * 通过以上的注解，Spring会自动创建相应的BeanDefinition对象，并注册到
 * ApplicationContext中，这些类就成了Spring的受管组件。
 * 原理：当一个Bean被自动检测到时，会根据那个扫描器的BeanNameGenerator策略
 * 生成Bean名称。默认情况下，对于上面四中注解，会把name取值昨晚Bean的名字。
 */
public class HibernateDaoImpl<T, PK extends Serializable>  implements HibernateDao<T, PK> {
    @Resource
    HibernateTemplate hibernateTemplate;
    // -------------------- 基本检索、增加、修改、删除操作 --------------------

    // 根据主键获取实体。如果没有相应的实体，返回 null。
    @Override
    public T get(Class<T> c, PK id) {
        return (T) hibernateTemplate.get(c, id);
    }

    @Override
    public T getWithLock(Class<T> c, PK id, LockMode lock) {
        T t = (T) hibernateTemplate.get(c, id, lock);
        if (t != null) {
            this.flush(); // 立即刷新，否则锁不会生效。
        }
        return t;
    }


    // 根据主键获取实体。如果没有相应的实体，抛出异常。
    @Override
    public T load(Class<T> c, PK id) {
        return (T) hibernateTemplate.load(c, id);
    }

    @Override
    public T loadWithLock(Class<T> c, PK id, LockMode lock) {
        T t = (T) hibernateTemplate.load(c, id, lock);
        if (t != null) {
            this.flush(); // 立即刷新，否则锁不会生效。
        }
        return t;
    }


    // 获取全部实体。
    @Override
    public List<T> loadAll(Class<T> c) {
        return (List<T>) hibernateTemplate.loadAll(c);
    }

    // loadAllWithLock() ?

    // 更新实体
    @Override
    public void update(T entity) {
        hibernateTemplate.update(entity);
    }

    // 更新实体并加锁
    @Override
    public void updateWithLock(T entity, LockMode lock) {
        hibernateTemplate.update(entity, lock);
        this.flush(); // 立即刷新，否则锁不会生效。
    }

    // 存储实体到数据库
    @Override
    public Integer save(T entity) {
        Serializable result = hibernateTemplate.save(entity);
        Integer id = (Integer)result;
        return id;
    }

    // saveWithLock()？

    // 增加或更新实体
    @Override
    public void saveOrUpdate(T entity) {
        hibernateTemplate.saveOrUpdate(entity);
    }

    // 增加或更新集合中的全部实体
    @Override
    public void saveOrUpdateAll(Collection<T> entities) {
        hibernateTemplate.saveOrUpdate(entities);
    }

    // 删除指定的实体
    @Override
    public void delete(T entity) {
        hibernateTemplate.delete(entity);
        this.flush();
    }

    // 加锁并删除指定的实体
    @Override
    public void deleteWithLock(T entity, LockMode lock) {
        hibernateTemplate.delete(entity, lock);
        this.flush(); // 立即刷新，否则锁不会生效。
    }

    // 根据主键删除指定实体
    @Override
    public void deleteByKey(Class<T> c, PK id) {
        this.delete(this.load(c,id));

    }

    // 根据主键加锁并删除指定的实体
    @Override
    public void deleteByKeyWithLock(Class<T> c, PK id, LockMode lock) {
        this.deleteWithLock(this.load(c, id), lock);
    }

    // 删除集合中的全部实体
    @Override
    public void deleteAll(Collection<T> entities) {
        hibernateTemplate.deleteAll(entities);
    }

    // -------------------- HSQL ----------------------------------------------

    // 使用HSQL语句直接增加、更新、删除实体
    @Override
    public int bulkUpdate(String queryString) {
        return hibernateTemplate.bulkUpdate(queryString);
    }

    // 使用带参数的HSQL语句增加、更新、删除实体
    @Override
    public int bulkUpdate(String queryString, Object[] values) {
        return hibernateTemplate.bulkUpdate(queryString, values);
    }

    // 使用HSQL语句检索数据
    @Override
    public List find(String queryString) {
        return hibernateTemplate.find(queryString);
    }

    // 使用带参数的HSQL语句检索数据
    @Override
    public List find(String queryString, Object[] values) {
        return hibernateTemplate.find(queryString, values);
    }

    // 使用带命名的参数的HSQL语句检索数据
    @Override
    public List findByNamedParam(String queryString, String[] paramNames,
                                 Object[] values) {
        return hibernateTemplate.findByNamedParam(queryString, paramNames,
                values);
    }

    // 使用命名的HSQL语句检索数据
    @Override
    public List findByNamedQuery(String queryName) {
        return hibernateTemplate.findByNamedQuery(queryName);
    }

    // 使用带参数的命名HSQL语句检索数据
    @Override
    public List findByNamedQuery(String queryName, Object[] values) {
        return hibernateTemplate.findByNamedQuery(queryName, values);
    }

    // 使用带命名参数的命名HSQL语句检索数据
    @Override
    public List findByNamedQueryAndNamedParam(String queryName,
                                              String[] paramNames, Object[] values) {
        return hibernateTemplate.findByNamedQueryAndNamedParam(queryName,
                paramNames, values);
    }

    // 使用HSQL语句检索数据，返回 Iterator
    @Override
    public Iterator iterate(String queryString) {
        return hibernateTemplate.iterate(queryString);
    }

    // 使用带参数HSQL语句检索数据，返回 Iterator
    @Override
    public Iterator iterate(String queryString, Object[] values) {
        return hibernateTemplate.iterate(queryString, values);
    }

    // 关闭检索返回的 Iterator
    @Override
    public void closeIterator(Iterator it) {
        hibernateTemplate.closeIterator(it);
    }

    // -------------------------------- Criteria ------------------------------

    // 创建与会话无关的检索标准
    @Override
    public DetachedCriteria createDetachedCriteria(Class c) {
        return DetachedCriteria.forClass(c);
    }

    // 创建与会话绑定的检索标准
    @Override
    public Criteria createCriteria(Class<T> c) {
        return this.createDetachedCriteria(c).getExecutableCriteria(
                this.hibernateTemplate.getSessionFactory().getCurrentSession());
    }

    // 检索满足标准的数据
    @Override
    public List findByCriteria(DetachedCriteria criteria) {
        return hibernateTemplate.findByCriteria(criteria);
    }

    // 检索满足标准的数据，返回指定范围的记录
    @Override
    public List findByCriteria(DetachedCriteria criteria, int firstResult,
                               int maxResults) {
        return hibernateTemplate.findByCriteria(criteria, firstResult,
                maxResults);
    }

    // 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
    @Override
    public List<T> findEqualByEntity(T entity, String[] propertyNames) {
        Criteria criteria = this.createCriteria((Class<T>) entity.getClass());
        Example exam = Example.create(entity);
        exam.excludeZeroes();
        String[] defPropertys = getSessionFactory().getClassMetadata(
                (Class<T>) entity.getClass()).getPropertyNames();
        for (String defProperty : defPropertys) {
            int ii = 0;
            for (ii = 0; ii < propertyNames.length; ++ii) {
                if (defProperty.equals(propertyNames[ii])) {
                    criteria.addOrder(Order.asc(defProperty));
                    break;
                }
            }
            if (ii == propertyNames.length) {
                exam.excludeProperty(defProperty);
            }
        }
        criteria.add(exam);
        return (List<T>) criteria.list();
    }

    // 使用指定的实体及属性检索（满足属性 like 串实体值）数据
    @Override
    public List<T> findLikeByEntity(T entity, String[] propertyNames) {
        Criteria criteria = this.createCriteria((Class<T>) entity.getClass());
        for (String property : propertyNames) {
            try {
                Object value = PropertyUtils.getProperty(entity, property);
                if (value instanceof String) {
                    criteria.add(Restrictions.like(property, (String) value,
                            MatchMode.ANYWHERE));
                    criteria.addOrder(Order.asc(property));
                } else {
                    criteria.add(Restrictions.eq(property, value));
                    criteria.addOrder(Order.asc(property));
                }
            } catch (Exception ex) {
                // 忽略无效的检索参考数据。
            }
        }
        return (List<T>) criteria.list();
    }

    // 使用指定的检索标准获取满足标准的记录数
    @Override
    public Integer getRowCount(DetachedCriteria criteria) {
        criteria.setProjection(Projections.rowCount());
        List list = this.findByCriteria(criteria, 0, 1);
        return (Integer) list.get(0);
    }

    // 使用指定的检索标准检索数据，返回指定统计值(max,min,avg,sum)
    @Override
    public Object getStatValue(DetachedCriteria criteria, String propertyName,
                               String StatName) {
        if (StatName.toLowerCase().equals("max"))
            criteria.setProjection(Projections.max(propertyName));
        else if (StatName.toLowerCase().equals("min"))
            criteria.setProjection(Projections.min(propertyName));
        else if (StatName.toLowerCase().equals("avg"))
            criteria.setProjection(Projections.avg(propertyName));
        else if (StatName.toLowerCase().equals("sum"))
            criteria.setProjection(Projections.sum(propertyName));
        else
            return null;
        List list = this.findByCriteria(criteria, 0, 1);
        return list.get(0);
    }

    // -------------------------------- Others --------------------------------

    // 加锁指定的实体
    @Override
    public void lock(T entity, LockMode lock) {
        hibernateTemplate.lock(entity, lock);
    }

    // 强制初始化指定的实体
    @Override
    public void initialize(Object proxy) {
        hibernateTemplate.initialize(proxy);
    }

    // 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
    @Override
    public void flush() {
        hibernateTemplate.flush();
    }
}