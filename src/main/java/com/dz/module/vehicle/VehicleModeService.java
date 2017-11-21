package com.dz.module.vehicle;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dz.common.global.Page;

//import com.dz.oms.entity.Page;

@Service
public class VehicleModeService {
	@Autowired
	private VehicleModeDao vehicleModeDao;

	public void setVehicleModeDao(VehicleModeDao vehicleModeDao) {
		this.vehicleModeDao = vehicleModeDao;
	}

	//添加车辆型号
	public boolean addVehicleMode(VehicleMode vehicleMode){
		if(vehicleMode==null){
			return false;
		}
		return vehicleModeDao.addVehicleMode(vehicleMode);
	}
	
	public List<VehicleMode> selectAll(){
		return vehicleModeDao.selectAll();
	}



	public int selectByConditionCount(VehicleMode vehicleMode) {
		// TODO 自动生成的方法存根
		return vehicleModeDao.selectByConditionCount(vehicleMode);
	}

	public List<Insurance> selectByCondition(Page page, VehicleMode vehicleMode) {
		// TODO 自动生成的方法存根
		return vehicleModeDao.selectByCondition(page,vehicleMode);
	}

	public boolean updateVehicleMode(VehicleMode vehicleMode) {
		// TODO Auto-generated method stub
		return vehicleModeDao.updateVehicleMode(vehicleMode);
	}
	
	
}
