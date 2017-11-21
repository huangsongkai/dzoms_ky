package com.dz.module.driver.activity;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dz.common.global.Page;
import java.util.Date;
import java.util.List;

@Service
public class ActivityService {
	@Autowired
	private ActivityDao activityDao;
	
	public int selectAllActivityCount(Date beginDate, Date endDate) throws HibernateException {
		return activityDao.selectAllActivityCount(beginDate,endDate);
	}


	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}

	public void addActivity(Activity activity) throws HibernateException {
		activityDao.addActivity(activity);		
	}

	public void updateActivity(Activity activity) throws HibernateException {
		activityDao.updateActivity(activity);		
	}

	public void deleteActivity(Activity activity) throws HibernateException {
		activityDao.deleteActivity(activity);		
	}

	public List<Activity> selectAllActivity(Page page, Date beginDate,
			Date endDate) {
		return activityDao.selectAllActivity(page, beginDate, endDate);
	}
	
	void addActivityDriver(ActivityDriver activity) {
		activityDao.addActivityDriver(activity);
	}
}
