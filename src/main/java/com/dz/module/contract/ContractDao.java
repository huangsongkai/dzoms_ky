package com.dz.module.contract;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
import com.dz.module.vehicle.Vehicle;

import org.hibernate.HibernateException;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public interface ContractDao {
	public boolean contractWrite(Contract contract) 
			throws HibernateException;
	public int contractSearchTotal() throws HibernateException;
	public List<Contract> contractSearch(Page page) throws HibernateException;
	public int contractSearchAvilableTotal() throws HibernateException;
	public List<Contract> contractSearchAvilable(Page page) throws HibernateException;
	public List<Contract> contractSearchAllAvilable() throws HibernateException;
	public List<Contract> contractSearchAllAvilable(Date time);
	public List<Contract> contractSearchAllAvilable(Date time, String dept, Page page);
	public List<Contract> contractSearchAllAvilable(Date time, String dept, String licenseNum, Page page);
	public long contractSearchAllAvaliableCount(Date time, String dept);
	public Contract contractShow(String id) throws HibernateException;
	public boolean contractRevise(Contract c) throws HibernateException;
	public Contract contractShowAb(String id) throws HibernateException;
	public boolean contractAbandon(Contract c) throws HibernateException;
	public int contractSearchAbandonedTotal() throws HibernateException;
	public List<Contract> contractSearchAbandoned(Page page) throws HibernateException;
	public Contract contractSearchRentAvaliable(String carfarameNum);
	
	Contract selectByCarId(String id);
public Contract selectByCarId(String carframeNum, Date d);
	//	List<String> selectDriverByCar(Vehicle vehicle);
	int contractSearchConditionTotal(Integer contractid, String contractor,
									 Long rent, Boolean isabandoned, String sort, String desc)
			throws HibernateException;
	List<Contract> contractSearchCondition(Page page, Integer contractid,
										   String contractor, Long rent, Boolean isabandoned, String sort,
										   String desc) throws HibernateException;
	Contract selectById(int id);
	BigDecimal getAccount(int contractId);
	boolean updateAccount(int contractId, BigDecimal account);
	public void changeState(Integer contractId, int state);
	List<Contract> contractSearchByState(Short state) throws HibernateException;
	
	public int selectAllByStatesCount(Contract contract, Vehicle vehicle, Driver driver, Date beginDate, Date endDate, Short[] states);
	public List<Contract> selectAllByStates(Page page, Contract contract, Vehicle vehicle, Driver driver, Date beginDate, Date endDate, Short[] states);
	boolean addRentFirstDivide(RentFirstDivide rentFirstDivide);
	public int contractSearchAllAvaliableCount(Date time, String department,
											   String licenseNum);
}
