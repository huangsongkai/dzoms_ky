package com.dz.module.driver.praise;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
import org.hibernate.HibernateException;

import java.util.Date;
import java.util.List;


public interface PraiseDao {

	List<Praise> selectAll(Page page, Date beginDate, Date endDate) throws HibernateException;

	List<Praise> selectAllWaitForDeal(Page page, Date beginDate, Date endDate) throws HibernateException;

	List<Praise> selectByDriver(Driver driver, Page page) throws HibernateException;

	void addPraise(Praise praise) throws HibernateException;

	void updatePraise(Praise praise) throws HibernateException;

	Praise selectById(Praise praise);

	int selectByDriverCount(Driver driver, Page page) throws HibernateException;

	int selectAllWaitForDealCount(Date beginDate, Date endDate) throws HibernateException;

	int selectAllCount(Date beginDate, Date endDate) throws HibernateException;

	void addGroupPraise(GroupPraise praise) throws HibernateException;

	void updateGroupPraise(GroupPraise praise) throws HibernateException;

	void deleteGroupPraise(GroupPraise praise) throws HibernateException;

	int selectAllGroupPraiseCount(Date beginDate, Date endDate) throws HibernateException;
	
	List<GroupPraise> selectAllGroupPraise(Page page, Date beginDate, Date endDate) throws HibernateException;

	int selectAllHandledCount(Date beginDate, Date endDate);

	List<Praise> selectAllHandled(Page page, Date beginDate, Date endDate);

	void addGroupPraiseDriver(GroupPraiseDriver groupPraiseDriver);
}
