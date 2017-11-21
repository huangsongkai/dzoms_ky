package com.dz.module.driver.activity;

import com.dz.common.global.Page;
import org.hibernate.HibernateException;

import java.util.Date;
import java.util.List;

public interface ActivityDao {

	public abstract List<Activity> selectAllActivity(Page page, Date beginDate,
													 Date endDate) throws HibernateException;

	public abstract int selectAllActivityCount(Date beginDate, Date endDate)
			throws HibernateException;

	public abstract void addActivity(Activity activity)
			throws HibernateException;

	public abstract void updateActivity(Activity activity)
			throws HibernateException;

	public abstract void deleteActivity(Activity activity)
			throws HibernateException;

	void addActivityDriver(ActivityDriver activity) throws HibernateException;

}