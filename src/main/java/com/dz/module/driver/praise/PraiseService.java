package com.dz.module.driver.praise;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PraiseService{
	@Autowired
	private PraiseDao praiseDao;

	public List<Praise> selectAll(Page page, Date beginDate, Date endDate) throws HibernateException {
		return praiseDao.selectAll(page,beginDate,endDate);
	}

	public List<Praise> selectAllWaitForDeal(Page page,Date beginDate, Date endDate)
			throws HibernateException {
		return praiseDao.selectAllWaitForDeal(page,beginDate,endDate);
	}

	public List<Praise> selectByDriver(Driver driver, Page page)
			throws HibernateException {
		return praiseDao.selectByDriver(driver, page);
	}

	

	public void addPraise(Praise praise) throws HibernateException {
		praise.setAlreadyDeal(false);
		praiseDao.addPraise(praise);		
	}

	public void updatePraise(Praise praise) throws HibernateException {
		praiseDao.updatePraise(praise);		
	}
	
	public void dealPraise(Praise praise) throws HibernateException {
		praise.setAlreadyDeal(true);
		praiseDao.updatePraise(praise);		
	}

	public Praise selectById(Praise praise) {
		return praiseDao.selectById(praise);
	}

	public int selectByDriverCount(Driver driver, Page page)
			throws HibernateException {
		return praiseDao.selectByDriverCount(driver, page);
	}

	public int selectAllWaitForDealCount(Date beginDate, Date endDate) throws HibernateException {
		return praiseDao.selectAllWaitForDealCount(beginDate,endDate);
	}
	
	public List<GroupPraise> selectAllGroupPraise(Page page,Date beginDate, Date endDate)
			throws HibernateException {
		return praiseDao.selectAllGroupPraise(page,beginDate,endDate);
	}

	public int selectAllGroupPraiseCount(Date beginDate, Date endDate) throws HibernateException {
		return praiseDao.selectAllGroupPraiseCount(beginDate,endDate);
	}

	public int selectAllCount(Date beginDate, Date endDate) throws HibernateException {
		return praiseDao.selectAllCount(beginDate,endDate);
	}

	public void setPraiseDao(PraiseDao praiseDao) {
		this.praiseDao = praiseDao;
	}

	public void addGroupPraise(GroupPraise praise) throws HibernateException {
		praiseDao.addGroupPraise(praise);		
	}

	public void updateGroupPraise(GroupPraise praise) throws HibernateException {
		praiseDao.updateGroupPraise(praise);		
	}

	public void deleteGroupPraise(GroupPraise praise) throws HibernateException {
		praiseDao.deleteGroupPraise(praise);		
	}

	public int selectAllHandledCount(Date beginDate, Date endDate) {
		return praiseDao.selectAllHandledCount(beginDate,endDate);
	}

	public List<Praise> selectAllHandled(Page page, Date beginDate, Date endDate) {
		return praiseDao.selectAllHandled(page,beginDate,endDate);
	}

	public void addGroupPraiseDriver(GroupPraiseDriver groupPraiseDriver) {
		praiseDao.addGroupPraiseDriver(groupPraiseDriver);
	}

}
