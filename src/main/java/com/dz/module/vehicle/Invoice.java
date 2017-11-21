package com.dz.module.vehicle;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Invoice", catalog = "ky_dzomsdb")
public class Invoice implements java.io.Serializable {
	@Id
	@Column(unique = true, nullable = false, length = 30)
	private String carframeNum;
	@Temporal(TemporalType.DATE)
	private Date invoiceDate;
	@Column(length = 100)
	private String invoiceNumber;
	@Column(precision = 10, scale = 2)
	private Double invoiceMoney;
	@Column
	private String purseFrom;
	@Column(length = 11)
	private Integer invoiceRegister;
	@Temporal(TemporalType.DATE)
	private Date invoiceRegistTime;
	@Column(length = 11)
	private int state;
	
	
	public String getCarframeNum() {
		return carframeNum;
	}
	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}
	public Date getInvoiceDate() {
		return invoiceDate;
	}
	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}
	public String getInvoiceNumber() {
		return invoiceNumber;
	}
	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}
	public Double getInvoiceMoney() {
		return invoiceMoney;
	}
	public void setInvoiceMoney(Double invoiceMoney) {
		this.invoiceMoney = invoiceMoney;
	}
	public String getPurseFrom() {
		return purseFrom;
	}
	public void setPurseFrom(String purseFrom) {
		this.purseFrom = purseFrom;
	}
	public Integer getInvoiceRegister() {
		return invoiceRegister;
	}
	public void setInvoiceRegister(Integer invoiceRegister) {
		this.invoiceRegister = invoiceRegister;
	}
	public Date getInvoiceRegistTime() {
		return invoiceRegistTime;
	}
	public void setInvoiceRegistTime(Date invoiceRegistTime) {
		this.invoiceRegistTime = invoiceRegistTime;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}

}
