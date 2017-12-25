package com.dz.module.vehicle.electric;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ElectricFetch entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "electric_fetch", catalog = "ky_dzomsdb")
public class ElectricFetch implements java.io.Serializable {

	// Fields

	private Integer id;
	private Date fetchTime;
	private Integer fetchNum;

	// Constructors

	/** default constructor */
	public ElectricFetch() {
	}

	/** full constructor */
	public ElectricFetch(Date fetchTime, Integer fetchNum) {
		this.fetchTime = fetchTime;
		this.fetchNum = fetchNum;
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

	@Column(name = "fetch_time", length = 0)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getFetchTime() {
		return this.fetchTime;
	}

	public void setFetchTime(Date fetchTime) {
		this.fetchTime = fetchTime;
	}

	@Column(name = "fetch_num")
	public Integer getFetchNum() {
		return this.fetchNum;
	}

	public void setFetchNum(Integer fetchNum) {
		this.fetchNum = fetchNum;
	}

}