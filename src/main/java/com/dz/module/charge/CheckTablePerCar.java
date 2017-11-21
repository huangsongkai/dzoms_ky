package com.dz.module.charge;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-11-15.
 */
public class CheckTablePerCar {
    private int contractId;
    private Date time;
    private String driverName;
    private String carNumber;
    private String driverId;
    private String dept;
    //计划总额
    private BigDecimal planAll;
    //
    private BigDecimal oil = new BigDecimal(0.00);
    private BigDecimal cash = new BigDecimal(0.00);
    private BigDecimal bank = new BigDecimal(0.00);
    private BigDecimal insurance = new BigDecimal(0.00);
    private BigDecimal other = new BigDecimal(0.00);
    //实际的收入（不算上月余额）
    private BigDecimal realAll = new BigDecimal(0.00);
    //上月累欠
    private BigDecimal left = new BigDecimal(0.00);
    //本月累欠
    private BigDecimal thisMonthLeft = new BigDecimal(0.00);
    
    //本月计划
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

    public BigDecimal getPlanAll() {
        return planAll;
    }

    public void setPlanAll(BigDecimal planAll) {
        this.planAll = planAll;
    }

    public BigDecimal getRealAll() {
        return realAll;
    }

    public void setRealAll(BigDecimal realAll) {
        this.realAll = realAll;
    }

    public BigDecimal getLeft() {
        return left;
    }

    public void setLeft(BigDecimal left) {
        this.left = left;
    }

    public BigDecimal getThisMonthLeft() {
        return thisMonthLeft;
    }

    public void setThisMonthLeft(BigDecimal thisMonthLeft) {
        this.thisMonthLeft = thisMonthLeft;
    }

    public BigDecimal getOil() {
        return oil;
    }

    public void setOil(BigDecimal oil) {
        this.oil = oil;
    }

    public BigDecimal getCash() {
        return cash;
    }

    public void setCash(BigDecimal cash) {
        this.cash = cash;
    }

    public BigDecimal getBank() {
        return bank;
    }

    public void setBank(BigDecimal bank) {
        this.bank = bank;
    }

    public BigDecimal getInsurance() {
        return insurance;
    }

    public void setInsurance(BigDecimal insurance) {
        this.insurance = insurance;
    }

    public BigDecimal getOther() {
        return other;
    }

    public void setOther(BigDecimal other) {
        this.other = other;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

	public List<ChargePlan> getPlans() {
		return plans;
	}

	public void setPlans(List<ChargePlan> plans) {
		this.plans = plans;
	}
}
