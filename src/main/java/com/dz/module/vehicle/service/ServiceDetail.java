package com.dz.module.vehicle.service;
// default package


import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Servicedetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "servicedetail", catalog = "ky_dzomsdb")
public class ServiceDetail implements java.io.Serializable {

	// Fields

	private Integer id;
	private String carframeNum;
	private Date serviceBegin;
	private Date serviceEnd;
	private BigDecimal money;
	private BigDecimal allDistance;
	private BigDecimal effectiveDistance;
	private BigDecimal uselessDistance;
	private Integer times;
	private String dept;
	private String billType;

	// Constructors

	/** default constructor */
	public ServiceDetail() {
	}

	/** full constructor */
	public ServiceDetail(String carframeNum, Date serviceBegin,
			Date serviceEnd, BigDecimal money, BigDecimal allDistance,
			BigDecimal effectiveDistance, BigDecimal uselessDistance, Integer times,
			String dept) {
		this.carframeNum = carframeNum;
		this.serviceBegin = serviceBegin;
		this.serviceEnd = serviceEnd;
		this.money = money;
		this.allDistance = allDistance;
		this.effectiveDistance = effectiveDistance;
		this.uselessDistance = uselessDistance;
		this.times = times;
		this.dept = dept;
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

	@Column(name = "carframeNum", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "serviceBegin", length = 0)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getServiceBegin() {
		return this.serviceBegin;
	}

	public void setServiceBegin(Date serviceBegin) {
		this.serviceBegin = serviceBegin;
	}

	@Column(name = "serviceEnd", length = 0)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getServiceEnd() {
		return this.serviceEnd;
	}

	public void setServiceEnd(Date serviceEnd) {
		this.serviceEnd = serviceEnd;
	}

	@Column(name = "money", precision = 20)
	public BigDecimal getMoney() {
		return this.money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	@Column(name = "allDistance", precision = 20)
	public BigDecimal getAllDistance() {
		return this.allDistance;
	}

	public void setAllDistance(BigDecimal allDistance) {
		this.allDistance = allDistance;
	}

	@Column(name = "effectiveDistance", precision = 20)
	public BigDecimal getEffectiveDistance() {
		return this.effectiveDistance;
	}

	public void setEffectiveDistance(BigDecimal effectiveDistance) {
		this.effectiveDistance = effectiveDistance;
	}

	@Column(name = "uselessDistance", precision = 20)
	public BigDecimal getUselessDistance() {
		return this.uselessDistance;
	}

	public void setUselessDistance(BigDecimal uselessDistance) {
		this.uselessDistance = uselessDistance;
	}

	@Column(name = "times")
	public Integer getTimes() {
		return this.times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	@Column(name = "dept", length = 20)
	public String getDept() {
		return this.dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getBillType() {
		return billType;
	}

	public void setBillType(String billType) {
		this.billType = billType;
	}

}