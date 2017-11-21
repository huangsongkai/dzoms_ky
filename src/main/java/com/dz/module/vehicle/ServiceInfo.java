package com.dz.module.vehicle;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ServiceInfo", catalog = "ky_dzomsdb")
public class ServiceInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2022926523375333197L;
	@Id
	@Column(unique = true, nullable = false, length = 30)
	private String carframeNum;
	@Temporal(TemporalType.DATE)
	@Column
	private Date twiceSupplyDate;
	@Temporal(TemporalType.DATE)
	@Column
	private Date nextSupplyDate;
	@Column(name = "money_countor", length = 50)
	private String moneyCountor;
	@Temporal(TemporalType.DATE)
	@Column
	private Date moneyCountorTime;
	@Temporal(TemporalType.DATE)
	@Column
	private Date moneyCountorNextDate;
	@Column
	private Integer operateCardRegister;
	@Temporal(TemporalType.DATE)
	@Column
	private Date operateCardRegistDate;
	
	public String getCarframeNum() {
		return carframeNum;
	}
	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}
	public Date getTwiceSupplyDate() {
		return twiceSupplyDate;
	}
	public void setTwiceSupplyDate(Date twiceSupplyDate) {
		this.twiceSupplyDate = twiceSupplyDate;
	}
	public Date getNextSupplyDate() {
		return nextSupplyDate;
	}
	public void setNextSupplyDate(Date nextSupplyDate) {
		this.nextSupplyDate = nextSupplyDate;
	}
	public String getMoneyCountor() {
		return moneyCountor;
	}
	public void setMoneyCountor(String moneyCountor) {
		this.moneyCountor = moneyCountor;
	}
	public Date getMoneyCountorTime() {
		return moneyCountorTime;
	}
	public void setMoneyCountorTime(Date moneyCountorTime) {
		this.moneyCountorTime = moneyCountorTime;
	}
	public Date getMoneyCountorNextDate() {
		return moneyCountorNextDate;
	}
	public void setMoneyCountorNextDate(Date moneyCountorNextDate) {
		this.moneyCountorNextDate = moneyCountorNextDate;
	}
	public Integer getOperateCardRegister() {
		return operateCardRegister;
	}
	public void setOperateCardRegister(Integer operateCardRegister) {
		this.operateCardRegister = operateCardRegister;
	}
	public Date getOperateCardRegistDate() {
		return operateCardRegistDate;
	}
	public void setOperateCardRegistDate(Date operateCardRegistDate) {
		this.operateCardRegistDate = operateCardRegistDate;
	}
	
	@Column
	private Integer state;

	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	
	
}
