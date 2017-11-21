package com.dz.module.driver;

import com.dz.common.global.Page;
import com.dz.module.vehicle.Vehicle;

import org.hibernate.HibernateException;
import org.javatuples.Triplet;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface DriverDao {
	public boolean driverAdd(Driver driver, List<Families> families)
			throws HibernateException;
	@Deprecated
	public int driverSearchTotal() throws HibernateException;
	@Deprecated
	public List<Driver> driverSearch(Page page) throws HibernateException;
	@Deprecated
	public int driverSearchConditionTotal(String idNum, Date beginDate,
										  Date endDate, Boolean isInCar, Triplet<String, String, Object>... conditions) throws HibernateException;
	@Deprecated
	public List<Driver> driverSearchCondition(Page page, String idNum,
											  Date beginDate, Date endDate, Boolean isInCar, Triplet<String, String, Object>... conditions)
			throws HibernateException;
	@Deprecated
	public int driverSearchConditionTotal(Date beginDate,
										  Date endDate, Driver driver) throws HibernateException;
	@Deprecated
	public List<Driver> driverSearchCondition(Page page,
											  Date beginDate, Date endDate, Driver driver)
			throws HibernateException;

	public boolean addBadRecord(Driver driver, String reason);
	public boolean deleteBadRecord(Driver driver);
	@Deprecated
	public List<Driver> searchAllBadDriver();
	
	boolean driverUpdate(Driver driver, List<Families> families)
			throws HibernateException;
	/**
	 * use driver.star to update sql.star
	 * @param driver:must contain star attr and id attr
	 * @return true if success else false
	 */
	boolean updateStar(Driver driver);
	@Deprecated
	public List<Vehicle> driverCarSearch(Page page, String idName,
										 String idNum, String linence_num);
	@Deprecated
	public int driverCarSearchTotal(String idName, String idNum,
									String linence_num);
	
	public Driver selectByName(String name);
	
	List<Families> selectFamily(Driver driver);
	
	public void addDriverInCarRecord(Driverincar record);
	@Deprecated
	public int selectDriverInCarByConditionCount(Date beginDate, Date endDate, Vehicle vehicle, Driver driver, String operation, Boolean finished);
	@Deprecated
	public List<Driverincar> selectDriverInCarByCondition(Page page, Date beginDate, Date endDate, Vehicle vehicle, Driver driver, String operation, Boolean finished);

	void addLeaveRecord(Driverleave record);

	int selectDriverLeaveByConditionCount(Date beginDate, Date endDate,
										  Vehicle vehicle, Driver driver, Boolean finished, String operation);

	List<Driverleave> selectDriverLeaveByCondition(Page page, Date beginDate,
												   Date endDate, Vehicle vehicle, Driver driver, Boolean finished, String operation);

	Driver selectById(String idNum) throws HibernateException;

	int searchCount(Triplet<String, String, Object>... conditions);

	List<Driver> search(Page page, Triplet<String, String, Object>... conditions);
	boolean appendScore(String idNum, String bangonshifuzeren, float score, String bangonshifuzerenyijian);
	boolean appendCaiWu(String idNum, String caiwufuzeren, BigDecimal fuwubaozhengjin, String caiwufuzerenyijian);
}
