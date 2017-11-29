package com.dz.module.driver.meeting;
// default package

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Meeting entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "meeting", catalog = "ky_dzomsdb")
public class Meeting implements java.io.Serializable {

	// Fields

	/**
	 *
	 */
	private static final long serialVersionUID = 7940691657796301187L;
	private Integer id;
	private String meetingName;
	private Integer meetingClass;
	private Integer fileInfo;
	private String meetingContext;
	private Integer driverList;
	private Date meetingTime;
	private Float grade;
	private Integer registrant;
	private Date registTime;
	private Boolean alreadyChecked;
	private Integer checkedNum;
	private Integer uncheckedNum;
	private Date meetingTimeL1;
	private Date meetingTimeB1;
	private Date meetingTimeL2;
	private Date meetingTimeB2;
	private Date meetingTimeL3;
	private Date meetingTimeB3;

	// Constructors

	/** default constructor */
	public Meeting() {
	}

	/** full constructor */
	public Meeting(String meetingName, Integer meetingClass, Integer fileInfo,
				   String meetingContext, Integer driverList, Date meetingTime,
				   Float grade, Integer registrant, Date registTime) {
		this.meetingName = meetingName;
		this.meetingClass = meetingClass;
		this.fileInfo = fileInfo;
		this.meetingContext = meetingContext;
		this.driverList = driverList;
		this.meetingTime = meetingTime;
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

	@Column(name = "meeting_name", length = 30)
	public String getMeetingName() {
		return this.meetingName;
	}

	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}

	@Column(name = "meeting_class")
	public Integer getMeetingClass() {
		return this.meetingClass;
	}

	public void setMeetingClass(Integer meetingClass) {
		this.meetingClass = meetingClass;
	}

	@Column(name = "file_info")
	public Integer getFileInfo() {
		return this.fileInfo;
	}

	public void setFileInfo(Integer fileInfo) {
		this.fileInfo = fileInfo;
	}

	@Column(name = "meeting_context")
	public String getMeetingContext() {
		return this.meetingContext;
	}

	public void setMeetingContext(String meetingContext) {
		this.meetingContext = meetingContext;
	}

	@Column(name = "driver_list")
	public Integer getDriverList() {
		return this.driverList;
	}

	public void setDriverList(Integer driverList) {
		this.driverList = driverList;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time", length = 0)
	public Date getMeetingTime() {
		return this.meetingTime;
	}

	public void setMeetingTime(Date meetingTime) {
		this.meetingTime = meetingTime;
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

	@Column(name = "alreadyChecked")
	public Boolean getAlreadyChecked() {
		return this.alreadyChecked;
	}

	public void setAlreadyChecked(Boolean alreadyChecked) {
		this.alreadyChecked = alreadyChecked;
	}

	@Column(name = "checkedNum")
	public Integer getCheckedNum() {
		return this.checkedNum;
	}

	public void setCheckedNum(Integer checkedNum) {
		this.checkedNum = checkedNum;
	}

	@Column(name = "uncheckedNum")
	public Integer getUncheckedNum() {
		return this.uncheckedNum;
	}

	public void setUncheckedNum(Integer uncheckedNum) {
		this.uncheckedNum = uncheckedNum;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time_l1", length = 0)
	public Date getMeetingTimeL1() {
		return this.meetingTimeL1;
	}

	public void setMeetingTimeL1(Date meetingTimeL1) {
		this.meetingTimeL1 = meetingTimeL1;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time_b1", length = 0)
	public Date getMeetingTimeB1() {
		return this.meetingTimeB1;
	}

	public void setMeetingTimeB1(Date meetingTimeB1) {
		this.meetingTimeB1 = meetingTimeB1;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time_l2", length = 0)
	public Date getMeetingTimeL2() {
		return this.meetingTimeL2;
	}

	public void setMeetingTimeL2(Date meetingTimeL2) {
		this.meetingTimeL2 = meetingTimeL2;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time_b2", length = 0)
	public Date getMeetingTimeB2() {
		return this.meetingTimeB2;
	}

	public void setMeetingTimeB2(Date meetingTimeB2) {
		this.meetingTimeB2 = meetingTimeB2;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time_l3", length = 0)
	public Date getMeetingTimeL3() {
		return this.meetingTimeL3;
	}

	public void setMeetingTimeL3(Date meetingTimeL3) {
		this.meetingTimeL3 = meetingTimeL3;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "meeting_time_b3", length = 0)
	public Date getMeetingTimeB3() {
		return this.meetingTimeB3;
	}

	public void setMeetingTimeB3(Date meetingTimeB3) {
		this.meetingTimeB3 = meetingTimeB3;
	}
}