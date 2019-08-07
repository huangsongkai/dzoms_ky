package com.dz.module.vehicle;
// default package

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Insurance entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "insurance", catalog = "ky_dzomsdb")
public class Insurance implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8616607322450231978L;
	private Integer id;
	private String insuranceClass;
	private String carframeNum;
	private String insuranceNum;
	private String insuranceCompany;
	private Double insuranceMoney;
	private Date beginDate;
	private Date endDate;
	private Date signDate;
	private String driverId;
	private Integer register;
	private Date registTime;
	private String phone;
	private String enterpriseID;
	private String address;
	@Column(length = 11)
	private int state;

	// Constructors

	/** default constructor */
	public Insurance() {
	}

	/** full constructor */
	public Insurance(String insuranceClass, String carframeNum,
			String insuranceNum, String insuranceCompany, Double insuranceMoney,
			Date beginDate, Date endDate, Date signDate, String driverId,
			Integer register, Date registTime) {
		this.insuranceClass = insuranceClass;
		this.carframeNum = carframeNum;
		this.insuranceNum = insuranceNum;
		this.insuranceCompany = insuranceCompany;
		this.insuranceMoney = insuranceMoney;
		this.beginDate = beginDate;
		this.endDate = endDate;
		this.signDate = signDate;
		this.driverId = driverId;
		this.register = register;
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

	@Column(name = "insurance_class", length = 30)
	public String getInsuranceClass() {
		return this.insuranceClass;
	}

	public void setInsuranceClass(String insuranceClass) {
		this.insuranceClass = insuranceClass;
	}

	@Column(name = "carframe_num")
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "insurance_num",unique = true, length = 30)
	public String getInsuranceNum() {
		return this.insuranceNum;
	}

	public void setInsuranceNum(String insuranceNum) {
		this.insuranceNum = insuranceNum;
	}

	@Column(name = "insurance_company", length = 50)
	public String getInsuranceCompany() {
		return this.insuranceCompany;
	}

	public void setInsuranceCompany(String insuranceCompany) {
		this.insuranceCompany = insuranceCompany;
	}

	@Column(name = "insurance_money", precision = 10, scale = 0)
	public Double getInsuranceMoney() {
		return this.insuranceMoney;
	}

	public void setInsuranceMoney(Double insuranceMoney) {
		this.insuranceMoney = insuranceMoney;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "begin_date")
	public Date getBeginDate() {
		return this.beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "end_date")
	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "sign_date")
	public Date getSignDate() {
		return this.signDate;
	}

	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}

	@Column(name = "driver_id", length = 30)
	public String getDriverId() {
		return this.driverId;
	}

	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}

	@Column(name = "register")
	public Integer getRegister() {
		return this.register;
	}

	public void setRegister(Integer register) {
		this.register = register;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "regist_time", length = 0)
	public Date getRegistTime() {
		return this.registTime;
	}

	public void setRegistTime(Date registTime) {
		this.registTime = registTime;
	}

	@Column(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "enterpriseID")
	public String getEnterpriseID() {
		return enterpriseID;
	}

	public void setEnterpriseID(String enterpriseID) {
		this.enterpriseID = enterpriseID;
	}

	@Column(name = "address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Insurance{" +
				"id=" + id +
				", insuranceClass='" + insuranceClass + '\'' +
				", carframeNum='" + carframeNum + '\'' +
				", insuranceNum='" + insuranceNum + '\'' +
				", insuranceMoney=" + insuranceMoney +
				", beginDate=" + beginDate +
				", endDate=" + endDate +
				", state=" + state +
				'}';
	}
}