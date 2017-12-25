package com.dz.module.vehicle.electric;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ElectricAnaylseActArea entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "electric_anaylse_act_area", catalog = "ky_dzomsdb")
public class ElectricAnaylseActArea implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer anaylseActId;
	private String area;
	private Integer times;

	// Constructors

	/** default constructor */
	public ElectricAnaylseActArea() {
	}

	/** full constructor */
	public ElectricAnaylseActArea(Integer anaylseActId, String area,
			Integer times) {
		this.anaylseActId = anaylseActId;
		this.area = area;
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

	@Column(name = "anaylse_act_id")
	public Integer getAnaylseActId() {
		return this.anaylseActId;
	}

	public void setAnaylseActId(Integer anaylseActId) {
		this.anaylseActId = anaylseActId;
	}

	@Column(name = "area")
	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "times")
	public Integer getTimes() {
		return this.times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

}