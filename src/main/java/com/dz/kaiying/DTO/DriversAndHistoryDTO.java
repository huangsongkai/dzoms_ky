package com.dz.kaiying.DTO;
// default package

import java.util.List;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class DriversAndHistoryDTO implements java.io.Serializable {
	private List<DriversPurchase> drivers;
	private List<History1> history;

	public List<DriversPurchase> getDrivers() {
		return drivers;
	}

	public void setDrivers(List<DriversPurchase> drivers) {
		this.drivers = drivers;
	}

	public List<History1> getHistory() {
		return history;
	}

	public void setHistory(List<History1> history) {
		this.history = history;
	}
}