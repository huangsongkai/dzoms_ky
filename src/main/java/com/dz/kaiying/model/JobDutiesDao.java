package com.dz.kaiying.model;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
//import com.dz.module.search.Dv;
import com.dz.module.vehicle.Vehicle;
import org.hibernate.HibernateException;

import java.util.List;

public interface JobDutiesDao {
	List<jobDuties> selectAll();
	List<jobDuties> selectByVehicle(Vehicle vehicle);
	List<jobDuties> selectByDriver(Driver driver);
//	public int selectByConditionCount(Dv dv);
//	public List<jobDuties> selectByCondition(Page page, Dv dv);
	public abstract void addTest(jobDuties test)
			throws HibernateException;
}
