package com.dz.module.vehicle.service;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * ServiceMonthly entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "service_monthly", catalog = "ky_dzomsdb")
public class ServiceMonthly implements java.io.Serializable {

	// Fields
	private Integer id;
	private Integer number;
	private Date date;
	private BigDecimal money;
	private BigDecimal allDistance;
	private BigDecimal effectiveDistance;
	private BigDecimal times;

	// Constructors

	/** default constructor */
	public ServiceMonthly() {
	}

	/** full constructor */
	public ServiceMonthly(Date date, BigDecimal money, BigDecimal allDistance,
			BigDecimal effectiveDistance, BigDecimal times) {
		this.date = date;
		this.money = money;
		this.allDistance = allDistance;
		this.effectiveDistance = effectiveDistance;
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

	@Column(name = "times", precision = 20)
	public BigDecimal getTimes() {
		return this.times;
	}

	public void setTimes(BigDecimal times) {
		this.times = times;
	}

	@Column(name = "number")
	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

}