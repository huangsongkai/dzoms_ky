package com.dz.module.vehicle;

import com.dz.common.global.Page;

import org.apache.commons.lang.StringUtils;
import org.javatuples.Triplet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VehicleService {
	@Autowired
	VehicleDao vehicleDao;
	public boolean addVehicle(Vehicle vehicle){
		if(vehicle==null){
			return false;
		}
		return vehicleDao.addVehicle(vehicle);
	}
	public List<Vehicle> seleVehicle(Page page, Vehicle vehicle,Triplet<String,String,Object> ... conditions) {
		return vehicleDao.vehicleSearch(page, vehicle,conditions);
	}
	public int seleVehicleCount(Vehicle vehicle,Triplet<String,String,Object> ... conditions) {
		return vehicleDao.vehicleSearchCount(vehicle,conditions);
	}
	public boolean updateVehicle(Vehicle vehicle) {
		if(vehicle == null){
			return false;
		}
		return vehicleDao.vehicleUpdate(vehicle);
	}
	public Vehicle selectByLicenseNum(Vehicle vehicle){
		return vehicleDao.selectByLicense(vehicle);
	}
	public Vehicle selectById(Vehicle vehicle){
		if(vehicle!=null&&StringUtils.isNotBlank(vehicle.getCarframeNum())){
			return vehicleDao.selectByFrameId(vehicle.getCarframeNum());
		}
		return null;
	}
	public List<Vehicle> selectAll(){
		return vehicleDao.selectAll();
	}
	public List<Vehicle> selectAll(Vehicle vehicle){
		return vehicleDao.selectAll(vehicle);
	}

}
