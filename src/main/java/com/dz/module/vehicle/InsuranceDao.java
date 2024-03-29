package com.dz.module.vehicle;

//import java.util.ArrayList;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
import org.hibernate.HibernateException;

import java.util.Date;
import java.util.List;

public interface InsuranceDao {
    boolean addInsurance(Insurance insurance, boolean override) throws HibernateException;

    public void addInsurance(Insurance insurance) throws HibernateException;//���ӳ�������
	public void updateInsurance(Insurance insurance) throws HibernateException;//�޸ĳ�������
	public void deleteInsurance(Insurance insurance) throws HibernateException;
	List<Insurance> selectAll();
	List<Insurance> selectByVehicle(Vehicle vehicle);
	List<Insurance> selectByDriver(Driver driver);
	public int selectByConditionCount(Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd);
	public List<Insurance> selectByCondition(Page page, Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd);
}
