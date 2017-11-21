package com.dz.module.vehicle;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Tax", catalog = "ky_dzomsdb")
public class Tax implements java.io.Serializable {
	@Id
	@Column(unique = true, nullable = false, length = 30)
	private String carframeNum;
	@Column(length = 100)
	private String taxNumber;
	@Temporal(TemporalType.DATE)
	private Date taxDate;
	@Column(precision = 10, scale = 2)
	private Double taxMoney;
	@Column
	private String taxFrom;
	@Temporal(TemporalType.DATE)
	private Date taxRegistTime;
	@Column(length = 11)
	private Integer taxRegister;
	@Column(length = 11)
	private int state;
	
	public String getCarframeNum() {
		return carframeNum;
	}
	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}
	
	public String getTaxNumber() {
		return taxNumber;
	}
	public void setTaxNumber(String taxNumber) {
		this.taxNumber = taxNumber;
	}
	public Date getTaxDate() {
		return taxDate;
	}
	public void setTaxDate(Date taxDate) {
		this.taxDate = taxDate;
	}
	public Double getTaxMoney() {
		return taxMoney;
	}
	public void setTaxMoney(Double taxMoney) {
		this.taxMoney = taxMoney;
	}
	public String getTaxFrom() {
		return taxFrom;
	}
	public void setTaxFrom(String taxFrom) {
		this.taxFrom = taxFrom;
	}
	public Date getTaxRegistTime() {
		return taxRegistTime;
	}
	public void setTaxRegistTime(Date taxRegistTime) {
		this.taxRegistTime = taxRegistTime;
	}
	public Integer getTaxRegister() {
		return taxRegister;
	}
	public void setTaxRegister(Integer taxRegister) {
		this.taxRegister = taxRegister;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}

}

