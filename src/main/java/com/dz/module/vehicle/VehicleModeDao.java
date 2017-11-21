package com.dz.module.vehicle;

//import java.util.ArrayList;

import java.util.List;

import org.hibernate.HibernateException;

import com.dz.common.global.Page;

public interface VehicleModeDao {
	public boolean addVehicleMode(VehicleMode vehicleMode) throws HibernateException;//���ӳ�������
	public boolean vehicleModeUpdate(VehicleMode vehicleMode) throws HibernateException;//�޸ĳ�������
	public boolean delevehicleMode(VehicleMode vehicleMode) throws HibernateException;
	List<VehicleMode> selectAll();
	public int selectByConditionCount(VehicleMode vehicleMode);
	public List<Insurance> selectByCondition(Page page, VehicleMode vehicleMode);
	public boolean updateVehicleMode(VehicleMode vehicleMode);
}
