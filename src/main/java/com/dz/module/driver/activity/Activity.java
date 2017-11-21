package com.dz.module.driver.activity;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Activity entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "activity", catalog = "ky_dzomsdb")
public class Activity implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -4512578487475410978L;
	private Integer id;
	private String activityName;
	private String activityClass;
	private Integer fileInfo;
	private String activityContext;
	private Integer driverList;
	private Date activityTime;
	private Float grade;
	private Integer registrant;
	private Date registTime;

	// Constructors

	/** default constructor */
	public Activity() {
	}

	/** full constructor */
	public Activity(String activityName, String activityClass,
			Integer fileInfo, String activityContext, Integer driverList,
			Date activityTime, Float grade, Integer registrant, Date registTime) {
		this.activityName = activityName;
		this.activityClass = activityClass;
		this.fileInfo = fileInfo;
		this.activityContext = activityContext;
		this.driverList = driverList;
		this.activityTime = activityTime;
		this.grade = grade;
		this.registrant = registrant;
		this.registTime = registTime;
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

	@Column(name = "activity_name")
	public String getActivityName() {
		return this.activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	@Column(name = "activity_class", length = 30)
	public String getActivityClass() {
		return this.activityClass;
	}

	public void setActivityClass(String activityClass) {
		this.activityClass = activityClass;
	}

	@Column(name = "file_info")
	public Integer getFileInfo() {
		return this.fileInfo;
	}

	public void setFileInfo(Integer fileInfo) {
		this.fileInfo = fileInfo;
	}

	@Column(name = "activity_context")
	public String getActivityContext() {
		return this.activityContext;
	}

	public void setActivityContext(String activityContext) {
		this.activityContext = activityContext;
	}

	@Column(name = "driver_list")
	public Integer getDriverList() {
		return this.driverList;
	}

	public void setDriverList(Integer driverList) {
		this.driverList = driverList;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "activity_time", length = 0)
	public Date getActivityTime() {
		return this.activityTime;
	}

	public void setActivityTime(Date activityTime) {
		this.activityTime = activityTime;
	}

	@Column(name = "grade", precision = 10, scale = 0)
	public Float getGrade() {
		return this.grade;
	}

	public void setGrade(Float grade) {
		this.grade = grade;
	}

	@Column(name = "registrant")
	public Integer getRegistrant() {
		return this.registrant;
	}

	public void setRegistrant(Integer registrant) {
		this.registrant = registrant;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "regist_time", length = 0)
	public Date getRegistTime() {
		return this.registTime;
	}

	public void setRegistTime(Date registTime) {
		this.registTime = registTime;
	}

}