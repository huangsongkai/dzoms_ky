package com.dz.module.vehicle.service;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * ServiceDaily entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "service_daily", catalog = "ky_dzomsdb")
public class ServiceDaily implements java.io.Serializable {

	// Fields

	private Integer id;
	private Date date;
	private String dept;
	private Integer number;
	private BigDecimal money;
	private BigDecimal allDistance;
	private BigDecimal effectiveDistance;
	private BigDecimal uselessDistance;
	private BigDecimal times;

	// Constructors

	/** default constructor */
	public ServiceDaily() {
	}

	/** full constructor */
	public ServiceDaily(Date date, String dept, Integer number, BigDecimal money,
			BigDecimal allDistance, BigDecimal effectiveDistance,
			BigDecimal uselessDistance, BigDecimal times) {
		this.date = date;
		this.dept = dept;
		this.number = number;
		this.money = money;
		this.allDistance = allDistance;
		this.effectiveDistance = effectiveDistance;
		this.uselessDistance = uselessDistance;
		this.times = times;
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

	@Temporal(TemporalType.DATE)
	@Column(name = "date", length = 0)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Column(name = "dept", length = 30)
	public String getDept() {
		return this.dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	@Column(name = "number")
	public Integer getNumber() {
		return this.number;
	}

	public void setNumber(Integer number) {
		this.number = number;
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

	@Column(name = "times", precision = 20)
	public BigDecimal getTimes() {
		return this.times;
	}

	public void setTimes(BigDecimal times) {
		this.times = times;
	}

}