package com.dz.module.vehicle;

import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dz.common.global.Page;
import com.dz.module.driver.Driver;

@Service
public class InsuranceService {
	@Autowired
	private InsuranceDao insuranceDao;
	
	
	public void addInsurance(Insurance insurance) throws HibernateException {
		insuranceDao.addInsurance(insurance);
	}

	
	public void updateInsurance(Insurance insurance) throws HibernateException {
		insuranceDao.updateInsurance(insurance);
	}

	
	public void deleteInsurance(Insurance insurance) throws HibernateException {
		insuranceDao.deleteInsurance(insurance);
	}

	
	public List<Insurance> selectAll() {
		return insuranceDao.selectAll();
	}

	
	public List<Insurance> selectByVehicle(Vehicle vehicle) {
		return insuranceDao.selectByVehicle(vehicle);
	}

	
	public List<Insurance> selectByDriver(Driver driver) {
		return insuranceDao.selectByDriver(driver);
	}

	

	public void setInsuranceDao(InsuranceDao insuranceDao) {
		this.insuranceDao = insuranceDao;
	}


	public int selectByConditionCount(Insurance insurance, Vehicle vehicle) {
		return insuranceDao.selectByConditionCount(insurance,vehicle);
	}


	public List<Insurance> selectByCondition(Page page, Insurance insurance, Vehicle vehicle) {
		return insuranceDao.selectByCondition(page,insurance,vehicle);
	}

}
