package com.dz.module.vehicle;

import com.dz.common.global.Page;

import org.hibernate.HibernateException;
import org.javatuples.Triplet;

import java.util.List;


public interface VehicleDao {
	public boolean addVehicle(Vehicle vehicle) throws HibernateException;//���ӳ�������
	public boolean vehicleUpdate(Vehicle vehicle) throws HibernateException;//�޸ĳ�������
	public boolean delevehicle(Vehicle vehicle) throws HibernateException;//ɾ������
	/**
	 * 
	 * @param page
	 * @param vehicle
	 * @param conditions 查询的剩余条件   Triplet<String,String,Object> <字段,条件,值> 如：<"money",">=",10>
	 * @return
	 * @throws HibernateException
	 */
	public List<Vehicle> vehicleSearch(Page page, Vehicle vehicle, Triplet<String, String, Object>... conditions) throws HibernateException;
	public int vehicleSearchCount(Vehicle vehicle, Triplet<String, String, Object>... conditions) throws HibernateException;
	Vehicle selectByLicense(Vehicle vehicle);
	Vehicle selectByFrameId(String id);
	List<Vehicle> selectAll();
	List<Vehicle> selectAll(Vehicle vehicle);
}

