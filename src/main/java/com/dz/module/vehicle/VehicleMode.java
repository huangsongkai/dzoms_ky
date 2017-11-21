package com.dz.module.vehicle;
// default package

import javax.persistence.*;
import java.util.Date;

/**
 * VehicleMode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "vehicle_mode", catalog = "ky_dzomsdb")
public class VehicleMode implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 5827979656773642023L;
	private String carMode;
	private Date licenseDate;
	private String company;
	private String color;
	private String brand;
	private String fuel;
	private String emission;
	private String tire;
	private Integer displacement;
	private Integer power;
	private String corneringAbility;
	private Integer tireNum;
	private Integer treadFront;
	private Integer treadBack;
	private Float fastest;
	private Float wholeWeight;
	private Integer sizeLong;
	private Integer sizeWide;
	private Integer sizeHigh;
	private Integer personNum;
	private Float norWeight;
	private Integer wheelBase;
	private String engineMode;
	private Float allWeight;
	private Integer baseNum;
	private String distinct;
	private Double invoiceAmount;
	private Double taxAmount;
	private Double averageYearDistance;
	private String useway;

	// Constructors

	/** default constructor */
	public VehicleMode() {
	}

	/** minimal constructor */
	public VehicleMode(String carMode, Date licenseDate, String company,
			String color, String brand, String fuel) {
		this.carMode = carMode;
		this.licenseDate = licenseDate;
		this.company = company;
		this.color = color;
		this.brand = brand;
		this.fuel = fuel;
	}

	/** full constructor */
	public VehicleMode(String carMode, Date licenseDate, String company,
			String color, String brand, String fuel, String emission,
			String tire, Integer displacement, Integer power,
			String corneringAbility, Integer tireNum, Integer treadFront,
			Integer treadBack, Float fastest, Float wholeWeight,
			Integer sizeLong, Integer sizeWide, Integer sizeHigh,
			Integer personNum, Float norWeight, Integer wheelBase,
			String engineMode, Float allWeight, Integer baseNum/*,
			String useway, String distance, String aera, BigDecimal money,
			BigDecimal tax*/) {
		this.carMode = carMode;
		this.licenseDate = licenseDate;
		this.company = company;
		this.color = color;
		this.brand = brand;
		this.fuel = fuel;
		this.emission = emission;
		this.tire = tire;
		this.displacement = displacement;
		this.power = power;
		this.corneringAbility = corneringAbility;
		this.tireNum = tireNum;
		this.treadFront = treadFront;
		this.treadBack = treadBack;
		this.fastest = fastest;
		this.wholeWeight = wholeWeight;
		this.sizeLong = sizeLong;
		this.sizeWide = sizeWide;
		this.sizeHigh = sizeHigh;
		this.personNum = personNum;
		this.norWeight = norWeight;
		this.wheelBase = wheelBase;
		this.engineMode = engineMode;
		this.allWeight = allWeight;
		this.baseNum = baseNum;
		/*this.useway = useway;
		this.distance = distance;
		this.aera = aera;
		this.money = money;
		this.tax = tax;*/
	}

	// Property accessors
	@Id
	@Column(name = "car_mode", unique = true, nullable = false, length = 30)
	public String getCarMode() {
		return this.carMode;
	}

	public void setCarMode(String carMode) {
		this.carMode = carMode;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "license_date", nullable = false, length = 0)
	public Date getLicenseDate() {
		return this.licenseDate;
	}

	public void setLicenseDate(Date licenseDate) {
		this.licenseDate = licenseDate;
	}

	@Column(name = "company", nullable = false, length = 30)
	public String getCompany() {
		return this.company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	@Column(name = "color", nullable = false, length = 30)
	public String getColor() {
		return this.color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@Column(name = "brand", nullable = false, length = 30)
	public String getBrand() {
		return this.brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	@Column(name = "fuel", nullable = false, length = 30)
	public String getFuel() {
		return this.fuel;
	}

	public void setFuel(String fuel) {
		this.fuel = fuel;
	}

	@Column(name = "emission", length = 30)
	public String getEmission() {
		return this.emission;
	}

	public void setEmission(String emission) {
		this.emission = emission;
	}

	@Column(name = "tire", length = 30)
	public String getTire() {
		return this.tire;
	}

	public void setTire(String tire) {
		this.tire = tire;
	}

	@Column(name = "displacement", length = 10)
	public Integer getDisplacement() {
		return this.displacement;
	}

	public void setDisplacement(Integer displacement) {
		this.displacement = displacement;
	}

	@Column(name = "power", length = 10)
	public Integer getPower() {
		return this.power;
	}

	public void setPower(Integer power) {
		this.power = power;
	}

	@Column(name = "cornering_ability", length = 30)
	public String getCorneringAbility() {
		return this.corneringAbility;
	}

	public void setCorneringAbility(String corneringAbility) {
		this.corneringAbility = corneringAbility;
	}

	@Column(name = "tire_num")
	public Integer getTireNum() {
		return this.tireNum;
	}

	public void setTireNum(Integer tireNum) {
		this.tireNum = tireNum;
	}

	@Column(name = "tread_front", length = 10)
	public Integer getTreadFront() {
		return this.treadFront;
	}

	public void setTreadFront(Integer treadFront) {
		this.treadFront = treadFront;
	}

	@Column(name = "tread_back", length = 10)
	public Integer getTreadBack() {
		return this.treadBack;
	}

	public void setTreadBack(Integer treadBack) {
		this.treadBack = treadBack;
	}

	@Column(name = "fastest")
	public Float getFastest() {
		return this.fastest;
	}

	public void setFastest(Float fastest) {
		this.fastest = fastest;
	}

	@Column(name = "whole_weight")
	public Float getWholeWeight() {
		return this.wholeWeight;
	}

	public void setWholeWeight(Float wholeWeight) {
		this.wholeWeight = wholeWeight;
	}

	@Column(name = "size_long", length = 10)
	public Integer getSizeLong() {
		return this.sizeLong;
	}

	public void setSizeLong(Integer sizeLong) {
		this.sizeLong = sizeLong;
	}

	@Column(name = "size_wide", length = 10)
	public Integer getSizeWide() {
		return this.sizeWide;
	}

	public void setSizeWide(Integer sizeWide) {
		this.sizeWide = sizeWide;
	}

	@Column(name = "size_high", length = 10)
	public Integer getSizeHigh() {
		return this.sizeHigh;
	}

	public void setSizeHigh(Integer sizeHigh) {
		this.sizeHigh = sizeHigh;
	}

	@Column(name = "person_num", length = 10)
	public Integer getPersonNum() {
		return this.personNum;
	}

	public void setPersonNum(Integer personNum) {
		this.personNum = personNum;
	}

	@Column(name = "nor_weight")
	public Float getNorWeight() {
		return this.norWeight;
	}

	public void setNorWeight(Float norWeight) {
		this.norWeight = norWeight;
	}

	@Column(name = "wheel_base", length = 10)
	public Integer getWheelBase() {
		return this.wheelBase;
	}

	public void setWheelBase(Integer wheelBase) {
		this.wheelBase = wheelBase;
	}

	@Column(name = "engine_mode", length = 20)
	public String getEngineMode() {
		return this.engineMode;
	}

	public void setEngineMode(String engineMode) {
		this.engineMode = engineMode;
	}

	@Column(name = "all_weight")
	public Float getAllWeight() {
		return this.allWeight;
	}

	public void setAllWeight(Float allWeight) {
		this.allWeight = allWeight;
	}

	@Column(name = "base_num")
	public Integer getBaseNum() {
		return this.baseNum;
	}

	public void setBaseNum(Integer baseNum) {
		this.baseNum = baseNum;
	}

	@Column(name = "useway", length = 30)
	public String getUseway() {
		return this.useway;
	}

	public void setUseway(String useway) {
		this.useway = useway;
	}

	@Column(name = "`distinct`", length = 30)
	public String getDistinct() {
		return this.distinct;
	}

	public void setDistinct(String distinct) {
		this.distinct = distinct;
	}

	@Column(name = "invoiceAmount", precision = 20)
	public Double getInvoiceAmount() {
		return this.invoiceAmount;
	}

	public void setInvoiceAmount(Double invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}

	@Column(name = "taxAmount", precision = 20)
	public Double getTaxAmount() {
		return this.taxAmount;
	}

	public void setTaxAmount(Double taxAmount) {
		this.taxAmount = taxAmount;
	}

	@Column(name = "averageYearDistance", precision = 20)
	public Double getAverageYearDistance() {
		return this.averageYearDistance;
	}

	public void setAverageYearDistance(Double averageYearDistance) {
		this.averageYearDistance = averageYearDistance;
	}

}