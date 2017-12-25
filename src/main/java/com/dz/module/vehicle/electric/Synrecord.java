package com.dz.module.vehicle.electric;
// default package

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
 * Synrecord entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "synrecord", catalog = "ky_dzomsdb")
public class Synrecord implements java.io.Serializable {

	// Fields

	private Integer id;
	private String type;
	private Integer synCount;
	private Date synTime;
	private String synDetail;

	// Constructors

	/** default constructor */
	public Synrecord() {
	}

	/** full constructor */
	public Synrecord(String type, Integer synCount, Date synTime,
			String synDetail) {
		this.type = type;
		this.synCount = synCount;
		this.synTime = synTime;
		this.synDetail = synDetail;
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

	@Column(name = "synCount")
	public Integer getSynCount() {
		return this.synCount;
	}

	public void setSynCount(Integer synCount) {
		this.synCount = synCount;
	}

	@Column(name = "synTime", length = 19)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getSynTime() {
		return this.synTime;
	}

	public void setSynTime(Date synTime) {
		this.synTime = synTime;
	}

	@Column(name = "synDetail")
	public String getSynDetail() {
		return this.synDetail;
	}

	public void setSynDetail(String synDetail) {
		this.synDetail = synDetail;
	}

}