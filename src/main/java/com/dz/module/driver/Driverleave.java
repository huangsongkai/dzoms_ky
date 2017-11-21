package com.dz.module.driver;
// default package

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Driverleave entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "driverleave", catalog = "ky_dzomsdb")
public class Driverleave implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 2318573766211366850L;
	private Integer id;
	private String carframeNum;
	private String idNumber;
	private Boolean isRepresented;
	private String representName;
	private String representIdnum;
	private String operation;
	private Date opeTime;
	private Integer operator;
	private Boolean finished;

	// Constructors

	/** default constructor */
	public Driverleave() {
	}

	/** full constructor */
	public Driverleave(String carframeNum, String idNumber,
			Boolean isRepresented, String representName, String representIdnum,
			String operation, Date opeTime, Integer operator) {
		this.carframeNum = carframeNum;
		this.idNumber = idNumber;
		this.isRepresented = isRepresented;
		this.representName = representName;
		this.representIdnum = representIdnum;
		this.operation = operation;
		this.opeTime = opeTime;
		this.operator = operator;
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

	@Column(name = "isRepresented")
	public Boolean getIsRepresented() {
		return this.isRepresented;
	}

	public void setIsRepresented(Boolean isRepresented) {
		this.isRepresented = isRepresented;
	}

	@Column(name = "representName", length = 30)
	public String getRepresentName() {
		return this.representName;
	}

	public void setRepresentName(String representName) {
		this.representName = representName;
	}

	@Column(name = "representIdnum", length = 30)
	public String getRepresentIdnum() {
		return this.representIdnum;
	}

	public void setRepresentIdnum(String representIdnum) {
		this.representIdnum = representIdnum;
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

	@Column(name = "operator")
	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	@Column(name="finished")
	public Boolean getFinished() {
		return finished;
	}

	public void setFinished(Boolean finished) {
		this.finished = finished;
	}

}