package com.dz.module.vehicle.electric;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ElectricAnaylseVehicle entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "electric_anaylse_vehicle", catalog = "ky_dzomsdb")
public class ElectricAnaylseVehicle implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer anaylseId;
	private String carframeNum;
	private String licenseNum;
	private Integer times;
	private Long moneys;

	// Constructors

	/** default constructor */
	public ElectricAnaylseVehicle() {
	}

	/** full constructor */
	public ElectricAnaylseVehicle(Integer anaylseId, String carframeNum,
			String licenseNum, Integer times,Long moneys) {
		this.anaylseId = anaylseId;
		this.carframeNum = carframeNum;
		this.licenseNum = licenseNum;
		this.times = times;
		this.moneys = moneys;
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

	@Column(name = "anaylse_id")
	public Integer getAnaylseId() {
		return this.anaylseId;
	}

	public void setAnaylseId(Integer anaylseId) {
		this.anaylseId = anaylseId;
	}

	@Column(name = "carframeNum", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "licenseNum", length = 30)
	public String getLicenseNum() {
		return this.licenseNum;
	}

	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}

	@Column(name = "times")
	public Integer getTimes() {
		return this.times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	@Column(name = "moneys")
	public Long getMoneys() {
		return moneys;
	}

	public void setMoneys(Long moneys) {
		this.moneys = moneys;
	}

}