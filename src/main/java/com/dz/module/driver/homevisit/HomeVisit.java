package com.dz.module.driver.homevisit;
// default package

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * HomeVisit entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "home_visit", catalog = "ky_dzomsdb")
public class HomeVisit implements java.io.Serializable {

	// Fields

	private Integer id;
	private String carframeNum;
	private String idNum;
	private String record;
	private String comment;
	private Integer register;
	private Date time;

	// Constructors

	/** default constructor */
	public HomeVisit() {
	}

	/** full constructor */
	public HomeVisit(String carframeNum, String idNum,
			String record, String comment, Integer register, Date time) {
		this.carframeNum = carframeNum;
		this.idNum = idNum;
		this.record = record;
		this.comment = comment;
		this.register = register;
		this.time = time;
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

	@Column(name = "carframeNum", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "idNum", length = 30)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "record")
	public String getRecord() {
		return this.record;
	}

	public void setRecord(String record) {
		this.record = record;
	}

	@Column(name = "comment")
	public String getComment() {
		return this.comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Column(name = "register")
	public Integer getRegister() {
		return this.register;
	}

	public void setRegister(Integer register) {
		this.register = register;
	}

	@Column(name = "time", length = 0)
	@Temporal(TemporalType.DATE)
	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

}