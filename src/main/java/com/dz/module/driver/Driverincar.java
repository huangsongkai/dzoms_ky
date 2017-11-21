package com.dz.module.driver;
// default package

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Driverincar entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "driverincar", catalog = "ky_dzomsdb")
public class Driverincar implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6887934052334985785L;
	private Integer id;
	private String carframeNum;
	private String idNumber;
	private String operation;
	private String driverClass;
	private Boolean finished;
	private Date opeTime;

	// Constructors

	/** default constructor */
	public Driverincar() {
	}

	/** full constructor */
	public Driverincar(String carframeNum, String idNumber, String operation,
			Date opeTime) {
		this.carframeNum = carframeNum;
		this.idNumber = idNumber;
		this.operation = operation;
		this.opeTime = opeTime;
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

	@Column(name = "carframe_num", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "id_number", length = 30)
	public String getIdNumber() {
		return this.idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	@Column(name = "operation", length = 30)
	public String getOperation() {
		return this.operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "ope_time", length = 0)
	public Date getOpeTime() {
		return this.opeTime;
	}

	public void setOpeTime(Date opeTime) {
		this.opeTime = opeTime;
	}

	@Column(name = "driverClass")
	public String getDriverClass() {
		return driverClass;
	}

	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}

	@Column(name = "finished")
	public Boolean getFinished() {
		return finished;
	}

	public void setFinished(Boolean finished) {
		this.finished = finished;
	}

}