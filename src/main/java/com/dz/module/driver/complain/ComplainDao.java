package com.dz.module.driver.complain;


import com.dz.common.global.Page;
import com.dz.module.driver.Driver;

import org.hibernate.HibernateException;

import java.util.Date;
import java.util.List;

public interface ComplainDao{

	public abstract void addComplain(Complain complain)
			throws HibernateException;

	public abstract void deleteComplain(Complain complain)
			throws HibernateException;

	public abstract List<Complain> selectAll(Page page, Date beginDate, Date endDate) throws HibernateException;

	/**
	 * 所有待处理的投诉
	 * @param endDate 
	 * @param beginDate 
	 * @return
	 * @throws HibernateException
	 */
	public abstract List<Complain> selectAllWaitForDeal(Page page, Date beginDate, Date endDate)
			throws HibernateException;

	/**
	 * 所有待回访的投诉
	 * @param endDate 
	 * @param beginDate 
	 * @return
	 * @throws HibernateException
	 */
	public abstract List<Complain> selectAllWaitForVisitBack(Page page, Date beginDate, Date endDate)
			throws HibernateException;

	public abstract void updateComplain(Complain complain)
			throws HibernateException;

	int selectAllCount(Date beginDate, Date endDate) throws HibernateException;

	int selectAllWaitForDealCount(Date beginDate, Date endDate) throws HibernateException;

	int selectAllWaitForVisitBackCount(Date beginDate, Date endDate) throws HibernateException;

	List<Complain> selectByDriver(Driver driver, Page page) throws HibernateException;

	int selectByDriverCount(Driver driver) throws HibernateException;

	Complain selectById(Complain complain);

	List<Complain> selectAllHandled(Page page, Date beginDate, Date endDate) throws HibernateException;

	int selectAllHandledCount(Date beginDate, Date endDate) throws HibernateException;

	int selectAllByStateCount(Date beginDate, Date endDate, int state)
			throws HibernateException;

	List<Complain> selectAllByState(Page page, Date beginDate, Date endDate,
                                    int state) throws HibernateException;

	List<Complain> selectAllWaitForConfirm(Page page, Date beginDate,
                                           Date endDate) throws HibernateException;

	int selectAllWaitForConfirmCount(Date beginDate, Date endDate)
			throws HibernateException;

	List<Complain> selectAllWaitForHandled(Page page, Date beginDate,
                                           Date endDate) throws HibernateException;

	int selectAllWaitForHandledCount(Date beginDate, Date endDate)
			throws HibernateException;

	List<Complain> selectAllNotTrue(Page page, Date beginDate, Date endDate)
			throws HibernateException;

	int selectAllNotTrueCount(Date beginDate, Date endDate)
			throws HibernateException;

	public abstract int selectAllByStatesCount(Complain complain, Date beginDate, Date endDate,
                                               String dept, Short[] states);

	public abstract List<Complain> selectAllByStates(Complain complain, Page page,
                                                     Date beginDate, Date endDate, String dept, Short[] states, String order);

}