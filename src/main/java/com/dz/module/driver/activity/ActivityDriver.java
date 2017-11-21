package com.dz.module.driver.activity;
// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * ActivityDriver entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "activity_driver", catalog = "ky_dzomsdb")
public class ActivityDriver implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1187415953373508101L;
	private Integer id;
	private Integer activityId;
	private String idNum;

	// Constructors

	/** default constructor */
	public ActivityDriver() {
	}

	/** full constructor */
	public ActivityDriver(Integer activityId, String idNum) {
		this.activityId = activityId;
		this.idNum = idNum;
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

	@Column(name = "activity_id")
	public Integer getActivityId() {
		return this.activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	@Column(name = "id_num", length = 30)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

}