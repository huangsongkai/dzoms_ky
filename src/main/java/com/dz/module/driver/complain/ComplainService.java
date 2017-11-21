package com.dz.module.driver.complain;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ComplainService{
	@Autowired
	private ComplainDao complainDao;

	public void setComplainDao(ComplainDao complainDao) {
		this.complainDao = complainDao;
	}

	public void addComplain(Complain complain) throws HibernateException {
		complainDao.addComplain(complain);
	}

	public void deleteComplain(Complain complain) throws HibernateException {
		complainDao.deleteComplain(complain);		
	}

	public List<Complain> selectAll(Page page, Date beginDate, Date endDate) throws HibernateException {
		return complainDao.selectAll(page,beginDate,endDate);
	}

	public void updateComplain(Complain complain) throws HibernateException {
		complainDao.updateComplain(complain);		
	}

	public int selectAllCount(Date beginDate, Date endDate) throws HibernateException {
		return complainDao.selectAllCount(beginDate,endDate);
	}

	public List<Complain> selectByDriver(Driver driver, Page page)
			throws HibernateException {
		return complainDao.selectByDriver(driver, page);
	}

	public int selectByDriverCount(Driver driver) throws HibernateException {
		return complainDao.selectByDriverCount(driver);
	}

	public Complain selectById(Complain complain) {
		return complainDao.selectById(complain);
	}


	public int selectAllByStateCount(Date beginDate, Date endDate ,int state)
			throws HibernateException {
		return complainDao.selectAllByStateCount(beginDate, endDate, state);
	}

	public List<Complain> selectAllByState(Page page, Date beginDate, Date endDate,
			int state) throws HibernateException {
		return complainDao.selectAllByState(page, beginDate, endDate, state);
	}

	
	public int selectAllByStatesCount(Complain complain, Date beginDate, Date endDate,
			String dept, Short[] states) {
		return complainDao.selectAllByStatesCount( complain,beginDate, endDate,dept, states);
	}

	public List<Complain> selectByStates(Page page, Complain complain, Date beginDate,
			Date endDate, String dept, Short[] states, String order) {
		return complainDao.selectAllByStates(complain,page, beginDate, endDate,dept, states,order);
	}

}
