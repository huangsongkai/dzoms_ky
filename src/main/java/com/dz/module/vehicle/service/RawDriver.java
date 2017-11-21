package com.dz.module.vehicle.service;

public class RawDriver {
	
	private String licenseNum;
	private String ownerName;
	private String driverName;
	private String driverClass;
	private String restTime;
	private String idNum;
	private String phoneNum1;
	private String businessApplyTime;
	private String businessCancelTime;
	private String dept;
	private String isInCar;
	private String shiftTime;
	private String operatingStation;
	private String employeeNum;
	
	public String getLicenseNum() {
		return licenseNum;
	}
	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public String getDriverClass() {
		return driverClass;
	}
	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}
	public String getShiftTime() {
		return shiftTime;
	}
	public void setShiftTime(String shiftTime) {
		this.shiftTime = shiftTime;
	}
	public String getIdNum() {
		return idNum;
	}
	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}
	public String getPhoneNum1() {
		return phoneNum1;
	}
	public void setPhoneNum1(String phoneNum1) {
		this.phoneNum1 = phoneNum1;
	}
	public String getBusinessApplyTime() {
		return businessApplyTime;
	}
	public void setBusinessApplyTime(String businessApplyTime) {
		this.businessApplyTime = businessApplyTime;
	}
	public String getBusinessCancelTime() {
		return businessCancelTime;
	}
	public void setBusinessCancelTime(String businessCancelTime) {
		this.businessCancelTime = businessCancelTime;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getIsInCar() {
		return isInCar;
	}
	public void setIsInCar(String isInCar) {
		this.isInCar = isInCar;
	}
	public String getRestTime() {
		return restTime;
	}
	public void setRestTime(String restTime) {
		this.restTime = restTime;
	}
	public String getOperatingStation() {
		return operatingStation;
	}
	public void setOperatingStation(String operatingStation) {
		this.operatingStation = operatingStation;
	}
	public String getEmployeeNum() {
		return employeeNum;
	}
	public void setEmployeeNum(String employeeNum) {
		this.employeeNum = employeeNum;
	}
	@Override
	public String toString() {
		return "RawDriver [licenseNum=" + licenseNum + ", ownerName="
				+ ownerName + ", driverName=" + driverName + ", driverClass="
				+ driverClass + ", shiftTime=" + shiftTime + ", idNum=" + idNum
				+ ", phoneNum1=" + phoneNum1 + ", businessApplyTime="
				+ businessApplyTime + ", businessCancelTime="
				+ businessCancelTime + ", dept=" + dept + ", isInCar="
				+ isInCar + ", restTime=" + restTime + ", operatingStation="
				+ operatingStation + ", employeeNum=" + employeeNum + "]";
	}
	
	
}
