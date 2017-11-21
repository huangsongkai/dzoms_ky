package com.dz.module.driver.praise;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * GroupPraise entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "group_praise", catalog = "ky_dzomsdb")
public class GroupPraise implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7948289864104920342L;
	private Integer id;
	private String praiseClass;
	private Integer msgFrom;
	private Integer fileInfo;
	private String praiseReason;
	private Integer driverList;
	private Date praiseTime;
	private Float grade;
	private String registrant;

	// Constructors

	/** default constructor */
	public GroupPraise() {
	}

	/** full constructor */
	public GroupPraise(String praiseClass, Integer msgFrom, Integer fileInfo,
			String praiseReason, Integer driverList, Date praiseTime,
			Float grade, String registrant) {
		this.praiseClass = praiseClass;
		this.msgFrom = msgFrom;
		this.fileInfo = fileInfo;
		this.praiseReason = praiseReason;
		this.driverList = driverList;
		this.praiseTime = praiseTime;
		this.grade = grade;
		this.registrant = registrant;
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

	@Column(name = "praise_class")
	public String getPraiseClass() {
		return this.praiseClass;
	}

	public void setPraiseClass(String praiseClass) {
		this.praiseClass = praiseClass;
	}

	@Column(name = "msg_from")
	public Integer getMsgFrom() {
		return this.msgFrom;
	}

	public void setMsgFrom(Integer msgFrom) {
		this.msgFrom = msgFrom;
	}

	@Column(name = "file_info")
	public Integer getFileInfo() {
		return this.fileInfo;
	}

	public void setFileInfo(Integer fileInfo) {
		this.fileInfo = fileInfo;
	}

	@Column(name = "praise_reason")
	public String getPraiseReason() {
		return this.praiseReason;
	}

	public void setPraiseReason(String praiseReason) {
		this.praiseReason = praiseReason;
	}

	@Column(name = "driver_list")
	public Integer getDriverList() {
		return this.driverList;
	}

	public void setDriverList(Integer driverList) {
		this.driverList = driverList;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "praise_time", length = 0)
	public Date getPraiseTime() {
		return this.praiseTime;
	}

	public void setPraiseTime(Date praiseTime) {
		this.praiseTime = praiseTime;
	}

	@Column(name = "grade", precision = 10, scale = 0)
	public Float getGrade() {
		return this.grade;
	}

	public void setGrade(Float grade) {
		this.grade = grade;
	}

	@Column(name = "registrant", length = 30)
	public String getRegistrant() {
		return this.registrant;
	}

	public void setRegistrant(String registrant) {
		this.registrant = registrant;
	}

}