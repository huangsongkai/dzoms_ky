package com.dz.module.charge;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
public class ChargePlanSum {
	private int contractId;
	private String carNumber;
	private String dept;
	
	private BigDecimal planSum;
	private Long planTimes;
	private BigDecimal receiveSum;
	private Long receiveTimes;

	public ChargePlanSum() {
	}

	public int getContractId() {
		return contractId;
	}
	public void setContractId(int contractId) {
		this.contractId = contractId;
	}
	public String getCarNumber() {
		return carNumber;
	}
	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public BigDecimal getPlanSum() {
		return planSum;
	}
	public void setPlanSum(BigDecimal planSum) {
		this.planSum = planSum;
	}
	public BigDecimal getReceiveSum() {
		return receiveSum;
	}
	public void setReceiveSum(BigDecimal receiveSum) {
		this.receiveSum = receiveSum;
	}
	public Long getPlanTimes() {
		return planTimes;
	}
	public void setPlanTimes(Long planTimes) {
		this.planTimes = planTimes;
	}
	public Long getReceiveTimes() {
		return receiveTimes;
	}
	public void setReceiveTimes(Long receiveTimes) {
		this.receiveTimes = receiveTimes;
	}
	public ChargePlanSum(int contractId, String carNumber, String dept,
			Double planSum, Long planTimes, Double receiveSum,
			Long receiveTimes) {
		super();
		this.contractId = contractId;
		this.carNumber = carNumber;
		this.dept = dept;
		this.planSum = planSum!=null?BigDecimal.valueOf(planSum):BigDecimal.valueOf(0);
		this.planTimes = planTimes;
		this.receiveSum = receiveSum!=null?BigDecimal.valueOf(receiveSum):BigDecimal.valueOf(0);
		this.receiveTimes = receiveTimes;
	}


	private String id;

	@Id
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
