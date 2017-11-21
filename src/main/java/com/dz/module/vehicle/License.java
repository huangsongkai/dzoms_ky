package com.dz.module.vehicle;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "License", catalog = "ky_dzomsdb")
public class License {
	@Id
	@Column(unique = true, nullable = false, length = 30)
	private String carframeNum;
	@Column(length = 30)
	private String licenseNum;
	@Column(length = 30)
	private String licenseRegNum;
	@Temporal(TemporalType.DATE)
	private Date licenseNumRegDate;
	@Column
	private Boolean isNewLicense;
	@Column(length = 50)
	private String licensePurseNum;
	@Column(length = 11)
	private Integer licenseRegister;
	@Temporal(TemporalType.DATE)
	private Date licenseRegistTime;
	@Column(length = 11)
	private int state;
	public String getCarframeNum() {
		return carframeNum;
	}
	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}
	public String getLicenseRegNum() {
		return licenseRegNum;
	}
	public void setLicenseRegNum(String licenseRegNum) {
		this.licenseRegNum = licenseRegNum;
	}
	public Date getLicenseNumRegDate() {
		return licenseNumRegDate;
	}
	public void setLicenseNumRegDate(Date licenseNumRegDate) {
		this.licenseNumRegDate = licenseNumRegDate;
	}
	public Boolean getIsNewLicense() {
		return isNewLicense;
	}
	public void setIsNewLicense(Boolean isNewLicense) {
		this.isNewLicense = isNewLicense;
	}
	public String getLicensePurseNum() {
		return licensePurseNum;
	}
	public void setLicensePurseNum(String licensePurseNum) {
		this.licensePurseNum = licensePurseNum;
	}
	public Integer getLicenseRegister() {
		return licenseRegister;
	}
	public void setLicenseRegister(Integer licenseRegister) {
		this.licenseRegister = licenseRegister;
	}
	public Date getLicenseRegistTime() {
		return licenseRegistTime;
	}
	public void setLicenseRegistTime(Date licenseRegistTime) {
		this.licenseRegistTime = licenseRegistTime;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getLicenseNum() {
		return licenseNum;
	}
	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}
}
