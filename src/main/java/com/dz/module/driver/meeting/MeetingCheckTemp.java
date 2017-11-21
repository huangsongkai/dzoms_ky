package com.dz.module.driver.meeting;

public class MeetingCheckTemp {
	private String fingerNum;
	private String checkTime;
	private String name;
	private String vehicleNum;
	private String idNum;

	public String getFingerNum() {
		return fingerNum;
	}
	public void setFingerNum(String fingerNum) {
		this.fingerNum = fingerNum;
	}
	public String getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVehicleNum() {
		return vehicleNum;
	}
	public void setVehicleNum(String vehicleNum) {
		this.vehicleNum = vehicleNum;
	}
	public String getIdNum() {
		return idNum;
	}
	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Override
	public String toString() {
		return "MeetingCheckTemp [fingerNum=" + fingerNum + ", checkTime="
				+ checkTime + ", name=" + name + ", vehicleNum=" + vehicleNum
				+ ", idNum=" + idNum + "]";
	}


}
