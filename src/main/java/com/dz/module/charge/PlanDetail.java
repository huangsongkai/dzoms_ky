package com.dz.module.charge;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 16-5-22.
 */
public class PlanDetail {
    private int contractId;
    private Date time;
    private String driverName;
    private String carNumber;
    private String driverId;
    private String dept;
    private BigDecimal baoxian;
    private BigDecimal heton;
    private BigDecimal other;
    private BigDecimal total;
    
    private List<ChargePlan> plans;

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public BigDecimal getBaoxian() {
        return baoxian;
    }

    public void setBaoxian(BigDecimal baoxian) {
        this.baoxian = baoxian;
    }

    public BigDecimal getHeton() {
        return heton;
    }

    public void setHeton(BigDecimal heton) {
        this.heton = heton;
    }

    public BigDecimal getOther() {
        return other;
    }

    public void setOther(BigDecimal other) {
        this.other = other;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

	public List<ChargePlan> getPlans() {
		return plans;
	}

	public void setPlans(List<ChargePlan> plans) {
		this.plans = plans;
	}
}
