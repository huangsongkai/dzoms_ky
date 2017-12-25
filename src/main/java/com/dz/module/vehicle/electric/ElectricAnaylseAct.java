package com.dz.module.vehicle.electric;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ElectricAnaylseAct entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "electric_anaylse_act", catalog = "ky_dzomsdb")
public class ElectricAnaylseAct implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer anaylseId;
	private String act;
	private Integer times;
	private Long moneys;

	// Constructors

	/** default constructor */
	public ElectricAnaylseAct() {
	}

	/** full constructor */
	public ElectricAnaylseAct(Integer anaylseId, String act, Integer times) {
		this.anaylseId = anaylseId;
		this.act = act;
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

	@Column(name = "anaylse_id")
	public Integer getAnaylseId() {
		return this.anaylseId;
	}

	public void setAnaylseId(Integer anaylseId) {
		this.anaylseId = anaylseId;
	}

	@Column(name = "act")
	public String getAct() {
		return this.act;
	}

	public void setAct(String act) {
		this.act = act;
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