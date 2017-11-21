package com.dz.module.vehicle;
// default package

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * VehicleReject entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "vehicle_reject", catalog = "ky_dzomsdb")
public class VehicleReject implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8325949976192948263L;
	private Integer id;
	private String type;
	private String carframeNum;
	private String licenseNum;
	private Date stopDate;
	private String reason;

	// Constructors

	/** default constructor */
	public VehicleReject() {
	}

	/** full constructor */
	public VehicleReject(String type, String carframeNum, String licenseNum,
			Date stopDate, String reason) {
		this.type = type;
		this.carframeNum = carframeNum;
		this.licenseNum = licenseNum;
		this.stopDate = stopDate;
		this.reason = reason;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "type", length = 30)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "carframe_num", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "license_num", length = 30)
	public String getLicenseNum() {
		return this.licenseNum;
	}

	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "stop_date", length = 0)
	public Date getStopDate() {
		return this.stopDate;
	}

	public void setStopDate(Date stopDate) {
		this.stopDate = stopDate;
	}

	@Column(name = "reason")
	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

}