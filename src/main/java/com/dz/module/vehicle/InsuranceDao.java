package com.dz.module.vehicle;

//import java.util.ArrayList;

import java.util.List;

import org.hibernate.HibernateException;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;

public interface InsuranceDao {
	public void addInsurance(Insurance insurance) throws HibernateException;//���ӳ�������
	public void updateInsurance(Insurance insurance) throws HibernateException;//�޸ĳ�������
	public void deleteInsurance(Insurance insurance) throws HibernateException;
	List<Insurance> selectAll();
	List<Insurance> selectByVehicle(Vehicle vehicle);
	List<Insurance> selectByDriver(Driver driver);
	public int selectByConditionCount(Insurance insurance, Vehicle vehicle);
	public List<Insurance> selectByCondition(Page page, Insurance insurance, Vehicle vehicle);
}
