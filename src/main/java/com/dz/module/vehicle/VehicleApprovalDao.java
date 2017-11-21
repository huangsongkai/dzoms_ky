package com.dz.module.vehicle;

import org.hibernate.HibernateException;

import java.util.List;

public interface VehicleApprovalDao {
	public boolean addVehicleApproval(VehicleApproval vehicleApproval) throws HibernateException;//���Ȩ��
	public List<VehicleApproval> queryVehicleApprovalByState(Short checkType, Integer state) throws HibernateException;//��״̬��ѯ������
	public VehicleApproval queryVehicleApprovalById(Integer approvalId) throws HibernateException;//��ID��ѯ������
	public boolean executeUpdate(VehicleApproval vehicleApproval)throws HibernateException;//����������
	VehicleApproval queryVehicleApprovalByContractId(Integer contractId)
			throws HibernateException;
}
