package com.dz.module.vehicle.service;

public class ServiceImport {
	private String licenseNum;
	@Deprecated
	private String serviceTimeSpace;
	private String serviceTimeBegin;
	private String serviceTimeEnd;
	private String money;
	private String allDistance;
	private String effectiveDistance;
	private String uselessDistance;
	private String times;
	private String billType;
	
	public String getLicenseNum() {
		return licenseNum;
	}
	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}
	@Deprecated
	public String getServiceTimeSpace() {
		return serviceTimeSpace;
	}
	@Deprecated
	public void setServiceTimeSpace(String serviceTimeSpace) {
		this.serviceTimeSpace = serviceTimeSpace;
	}
	
	public String getServiceTimeBegin() {
		return serviceTimeBegin;
	}
	public void setServiceTimeBegin(String serviceTimeBegin) {
		this.serviceTimeBegin = serviceTimeBegin;
	}
	public String getServiceTimeEnd() {
		return serviceTimeEnd;
	}
	public void setServiceTimeEnd(String serviceTimeEnd) {
		this.serviceTimeEnd = serviceTimeEnd;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getAllDistance() {
		return allDistance;
	}
	public void setAllDistance(String allDistance) {
		this.allDistance = allDistance;
	}
	public String getEffectiveDistance() {
		return effectiveDistance;
	}
	public void setEffectiveDistance(String effectiveDistance) {
		this.effectiveDistance = effectiveDistance;
	}
	public String getUselessDistance() {
		return uselessDistance;
	}
	public void setUselessDistance(String uselessDistance) {
		this.uselessDistance = uselessDistance;
	}
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getBillType() {
		return billType;
	}
	public void setBillType(String billType) {
		this.billType = billType;
	}
	
	
}
