package com.dz.module.vehicle;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Trade", catalog = "ky_dzomsdb")
public class Trade {
	@Id
	@Column(unique = true, nullable = false, length = 30)
	private String carframeNum;
	@Column
	private Integer state;
	@Column
	private String businessLicenseComment;
	@Column(length=30)
	private String licenseNum;
	@Temporal(TemporalType.DATE)
	@Column
	private Date beginDate;
	@Temporal(TemporalType.DATE)
	@Column
	private Date endDate;
	@Column
	private Integer register;
	@Temporal(TemporalType.DATE)
	@Column
	private Date registDate;
	
	public String getCarframeNum() {
		return carframeNum;
	}
	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}

	public String getBusinessLicenseComment() {
		return businessLicenseComment;
	}
	public void setBusinessLicenseComment(String businessLicenseComment) {
		this.businessLicenseComment = businessLicenseComment;
	}
	public String getLicenseNum() {
		return licenseNum;
	}
	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Integer getRegister() {
		return register;
	}
	public void setRegister(Integer register) {
		this.register = register;
	}
	public Date getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Date registDate) {
		this.registDate = registDate;
	}
}
