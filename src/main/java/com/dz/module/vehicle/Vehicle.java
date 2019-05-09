package com.dz.module.vehicle;

import com.dz.module.contract.BankCardOfVehicle;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

/**
 * Vehicle entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "vehicle", catalog = "ky_dzomsdb")
public class Vehicle implements java.io.Serializable {

	@OneToMany(targetEntity = BankCardOfVehicle.class,mappedBy = "vehicle",fetch = FetchType.LAZY)
	public List<BankCardOfVehicle> getBovList() {
		return bovList;
	}

	public void setBovList(List<BankCardOfVehicle> bovList) {
		this.bovList = bovList;
	}

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3041935820882021112L;
	private String carframeNum;
	private String engineNum;
	private String carMode;
	private Date inDate;
	private String certifyNum;
	private String dept;
	private Date pd;
	private String driverId;
	private String licenseNum;
	private Integer picture;
	private String firstDriver;
	private String secondDriver;
	private String thirdDriver;
	private String forthDriver;
	private String tempDriver;
	private Date tempLastDate;
	private String team;
	private Integer state;
	private Date invoiceDate;
	private String invoiceNumber;
	private Double invoiceMoney;
	private String purseFrom;
	private Integer invoiceRegister;
	private Date invoiceRegistTime;
	private String taxNumber;
	private Date taxDate;
	private Double taxMoney;
	private String taxFrom;
	private Date taxRegistTime;
	private Integer taxRegister;
	private String licenseRegNum;
	private Date licenseNumRegDate;
	private Boolean isNewLicense;
	private String licensePurseNum;
	private Integer licenseRegister;
	private Date licenseRegistTime;
	private String operateCard;
	private Date operateCardTime;
	private Date twiceSupplyDate;
	private Date nextSupplyDate;
	private String moneyCountor;
	private Date moneyCountorTime;
	private Date moneyCountorNextDate;
	private Integer operateCardRegister;
	private Date operateCardRegistDate;
	private Integer serviceRightRegister;
	private Date serviceRightRegistDate;
	private String businessLicenseId;
	private String businessLicenseComment;
	private Integer seqVal;
	private Date electricLastTime;
	private Date getCarDate;

	private List<BankCardOfVehicle> bovList;

	@Column
	private Boolean reused;

	private BigDecimal insuranceBase;

	// Constructors

	/** default constructor */
	public Vehicle() {
	}

	/** minimal constructor */
	public Vehicle(String carframeNum, String engineNum, String carMode,
			Date inDate, String certifyNum, Date pd) {
		this.carframeNum = carframeNum;
		this.engineNum = engineNum;
		this.carMode = carMode;
		this.inDate = inDate;
		this.certifyNum = certifyNum;
		this.pd = pd;
	}

	/** full constructor */
	public Vehicle(String carframeNum, String engineNum, String carMode,
			Date inDate, String certifyNum, String dept, Date pd,
			String driverId, String licenseNum, Integer picture,
			String firstDriver, String secondDriver, String thirdDriver,
			String forthDriver, String tempDriver, Date tempLastDate,
			String team) {
		this.carframeNum = carframeNum;
		this.engineNum = engineNum;
		this.carMode = carMode;
		this.inDate = inDate;
		this.certifyNum = certifyNum;
		this.dept = dept;
		this.pd = pd;
		this.driverId = driverId;
		this.licenseNum = licenseNum;
		this.picture = picture;
		this.firstDriver = firstDriver;
		this.secondDriver = secondDriver;
		this.thirdDriver = thirdDriver;
		this.forthDriver = forthDriver;
		this.tempDriver = tempDriver;
		this.tempLastDate = tempLastDate;
		this.team = team;
	}

	public Vehicle(String carframeNum, String engineNum, String carMode,
			Date inDate, String certifyNum, String dept, Date pd,
			String driverId, String licenseNum, Integer picture,
			String firstDriver, String secondDriver, String thirdDriver,
			String forthDriver, String tempDriver, Date tempLastDate,
			String team, Integer state, Date invoiceDate, String invoiceNumber,
			Double invoiceMoney, String purseFrom, Integer invoiceRegister,
			Date invoiceRegistTime, String taxNumber, Date taxDate,
			Double taxMoney, String taxFrom, Date taxRegistTime,
			Integer taxRegister, String licenseRegNum, Date licenseNumRegDate,
			String licensePurseNum, Integer licenseRegister,
			Date licenseRegistTime, String operateCard, Date operateCardTime,
			Date twiceSupplyDate, Date nextSupplyDate, String moneyCountor,
			Date moneyCountorTime, Date moneyCountorNextDate,
			Integer operateCardRegister, Date operateCardRegistDate,
			String businessLicenseId, String businessLicenseComment) {
		this.carframeNum = carframeNum;
		this.engineNum = engineNum;
		this.carMode = carMode;
		this.inDate = inDate;
		this.certifyNum = certifyNum;
		this.dept = dept;
		this.pd = pd;
		this.driverId = driverId;
		this.licenseNum = licenseNum;
		this.picture = picture;
		this.firstDriver = firstDriver;
		this.secondDriver = secondDriver;
		this.thirdDriver = thirdDriver;
		this.forthDriver = forthDriver;
		this.tempDriver = tempDriver;
		this.tempLastDate = tempLastDate;
		this.team = team;
		this.state = state;
		this.invoiceDate = invoiceDate;
		this.invoiceNumber = invoiceNumber;
		this.invoiceMoney = invoiceMoney;
		this.purseFrom = purseFrom;
		this.invoiceRegister = invoiceRegister;
		this.invoiceRegistTime = invoiceRegistTime;
		this.taxNumber = taxNumber;
		this.taxDate = taxDate;
		this.taxMoney = taxMoney;
		this.taxFrom = taxFrom;
		this.taxRegistTime = taxRegistTime;
		this.taxRegister = taxRegister;
		this.licenseRegNum = licenseRegNum;
		this.licenseNumRegDate = licenseNumRegDate;
		this.licensePurseNum = licensePurseNum;
		this.licenseRegister = licenseRegister;
		this.licenseRegistTime = licenseRegistTime;
		this.operateCard = operateCard;
		this.operateCardTime = operateCardTime;
		this.twiceSupplyDate = twiceSupplyDate;
		this.nextSupplyDate = nextSupplyDate;
		this.moneyCountor = moneyCountor;
		this.moneyCountorTime = moneyCountorTime;
		this.moneyCountorNextDate = moneyCountorNextDate;
		this.operateCardRegister = operateCardRegister;
		this.operateCardRegistDate = operateCardRegistDate;
		this.businessLicenseId = businessLicenseId;
		this.businessLicenseComment = businessLicenseComment;
	}

	public Vehicle(String carframeNum, String licenseNum) {
		super();
		this.carframeNum = carframeNum;
		this.licenseNum = licenseNum;
	}

	// Property accessors
	@Id
	@Column(name = "carframe_num", unique = true, nullable = false, length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "engine_num", nullable = false, length = 30)
	public String getEngineNum() {
		return this.engineNum;
	}

	public void setEngineNum(String engineNum) {
		this.engineNum = engineNum;
	}

	@Column(name = "car_mode", nullable = false, length = 30)
	public String getCarMode() {
		return this.carMode;
	}

	public void setCarMode(String carMode) {
		this.carMode = carMode;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "in_date", nullable = false, length = 0)
	public Date getInDate() {
		return this.inDate;
	}
	
	private static Date convertDate(Date date){
		if(date!=null)
			return new Date(date.getTime());
		return null;
	}

	public void setInDate(Date inDate) {
		this.inDate = convertDate(inDate);
	}

	@Column(name = "certify_num", nullable = false, length = 30)
	public String getCertifyNum() {
		return this.certifyNum;
	}

	public void setCertifyNum(String certifyNum) {
		this.certifyNum = certifyNum;
	}

	@Column(name = "dept", length = 30)
	public String getDept() {
		return this.dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "pd", nullable = false, length = 0)
	public Date getPd() {
		return this.pd;
	}

	public void setPd(Date pd) {
		this.pd = convertDate(pd);
	}

	@Column(name = "driver_id", length = 18)
	public String getDriverId() {
		return this.driverId;
	}

	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}

	@Column(name = "license_num", length = 30)
	public String getLicenseNum() {
		return this.licenseNum;
	}

	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}

	@Column(name = "picture")
	public Integer getPicture() {
		return this.picture;
	}

	public void setPicture(Integer picture) {
		this.picture = picture;
	}

	@Column(name = "first_driver", length = 18)
	public String getFirstDriver() {
		return this.firstDriver;
	}

	public void setFirstDriver(String firstDriver) {
		this.firstDriver = firstDriver;
	}

	@Column(name = "second_driver", length = 18)
	public String getSecondDriver() {
		return this.secondDriver;
	}

	public void setSecondDriver(String secondDriver) {
		this.secondDriver = secondDriver;
	}

	@Column(name = "third_driver", length = 18)
	public String getThirdDriver() {
		return this.thirdDriver;
	}

	public void setThirdDriver(String thirdDriver) {
		this.thirdDriver = thirdDriver;
	}

	@Column(name = "forth_driver", length = 18)
	public String getForthDriver() {
		return this.forthDriver;
	}

	public void setForthDriver(String forthDriver) {
		this.forthDriver = forthDriver;
	}

	@Column(name = "temp_driver", length = 18)
	public String getTempDriver() {
		return this.tempDriver;
	}

	public void setTempDriver(String tempDriver) {
		this.tempDriver = tempDriver;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "temp_last_date", length = 0)
	public Date getTempLastDate() {
		return this.tempLastDate;
	}

	public void setTempLastDate(Date tempLastDate) {
		this.tempLastDate = convertDate(tempLastDate);
	}

	@Column(name = "team", length = 100)
	public String getTeam() {
		return this.team;
	}

	public void setTeam(String team) {
		this.team = team;
	}
	
	@Column(name = "state")
	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}


	@Temporal(TemporalType.DATE)
	@Column(name = "invoice_date", length = 0)
	public Date getInvoiceDate() {
		return this.invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = convertDate(invoiceDate);
	}

	@Column(name = "invoice_number", length = 100)
	public String getInvoiceNumber() {
		return this.invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}

	@Column(name = "invoice_money", precision = 10, scale = 2)
	public Double getInvoiceMoney() {
		return this.invoiceMoney;
	}

	public void setInvoiceMoney(Double invoiceMoney) {
		this.invoiceMoney = invoiceMoney;
	}

	@Column(name = "purseFrom")
	public String getPurseFrom() {
		return this.purseFrom;
	}

	public void setPurseFrom(String purseFrom) {
		this.purseFrom = purseFrom;
	}

	@Column(name = "invoice_register")
	public Integer getInvoiceRegister() {
		return this.invoiceRegister;
	}

	public void setInvoiceRegister(Integer invoiceRegister) {
		this.invoiceRegister = invoiceRegister;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "invoice_regist_time", length = 0)
	public Date getInvoiceRegistTime() {
		return this.invoiceRegistTime;
	}

	public void setInvoiceRegistTime(Date invoiceRegistTime) {
		this.invoiceRegistTime = convertDate(invoiceRegistTime);
	}

	@Column(name = "tax_number", length = 100)
	public String getTaxNumber() {
		return this.taxNumber;
	}

	public void setTaxNumber(String taxNumber) {
		this.taxNumber = taxNumber;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "tax_date", length = 0)
	public Date getTaxDate() {
		return this.taxDate;
	}

	public void setTaxDate(Date taxDate) {
		this.taxDate = convertDate(taxDate);
	}

	@Column(name = "tax_money", precision = 10, scale = 2)
	public Double getTaxMoney() {
		return this.taxMoney;
	}

	public void setTaxMoney(Double taxMoney) {
		this.taxMoney = taxMoney;
	}

	@Column(name = "taxFrom")
	public String getTaxFrom() {
		return this.taxFrom;
	}

	public void setTaxFrom(String taxFrom) {
		this.taxFrom = taxFrom;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "tax_regist_time", length = 0)
	public Date getTaxRegistTime() {
		return this.taxRegistTime;
	}

	public void setTaxRegistTime(Date taxRegistTime) {
		this.taxRegistTime = convertDate(taxRegistTime);
	}

	@Column(name = "tax_register")
	public Integer getTaxRegister() {
		return this.taxRegister;
	}

	public void setTaxRegister(Integer taxRegister) {
		this.taxRegister = taxRegister;
	}

	@Column(name = "license_reg_num", length = 30)
	public String getLicenseRegNum() {
		return this.licenseRegNum;
	}

	public void setLicenseRegNum(String licenseRegNum) {
		this.licenseRegNum = licenseRegNum;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "license_num_reg_date", length = 0)
	public Date getLicenseNumRegDate() {
		return this.licenseNumRegDate;
	}

	public void setLicenseNumRegDate(Date licenseNumRegDate) {
		this.licenseNumRegDate = convertDate(licenseNumRegDate);
	}

	@Column(name = "license_purse_num", length = 50)
	public String getLicensePurseNum() {
		return this.licensePurseNum;
	}

	public void setLicensePurseNum(String licensePurseNum) {
		this.licensePurseNum = licensePurseNum;
	}

	@Column(name = "license_register")
	public Integer getLicenseRegister() {
		return this.licenseRegister;
	}

	public void setLicenseRegister(Integer licenseRegister) {
		this.licenseRegister = licenseRegister;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "license_regist_time", length = 0)
	public Date getLicenseRegistTime() {
		return this.licenseRegistTime;
	}

	public void setLicenseRegistTime(Date licenseRegistTime) {
		this.licenseRegistTime = convertDate(licenseRegistTime);
	}

	@Column(name = "operate_card", length = 30)
	public String getOperateCard() {
		return this.operateCard;
	}

	public void setOperateCard(String operateCard) {
		this.operateCard = operateCard;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "operate_card_time", length = 0)
	public Date getOperateCardTime() {
		return this.operateCardTime;
	}

	public void setOperateCardTime(Date operateCardTime) {
		this.operateCardTime = convertDate(operateCardTime);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "twice_supply_date", length = 0)
	public Date getTwiceSupplyDate() {
		return this.twiceSupplyDate;
	}

	public void setTwiceSupplyDate(Date twiceSupplyDate) {
		this.twiceSupplyDate = convertDate(twiceSupplyDate);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "next_supply_date", length = 0)
	public Date getNextSupplyDate() {
		return this.nextSupplyDate;
	}

	public void setNextSupplyDate(Date nextSupplyDate) {
		this.nextSupplyDate = convertDate(nextSupplyDate);
	}

	@Column(name = "money_countor", length = 50)
	public String getMoneyCountor() {
		return this.moneyCountor;
	}

	public void setMoneyCountor(String moneyCountor) {
		this.moneyCountor = moneyCountor;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "money_countor_time", length = 0)
	public Date getMoneyCountorTime() {
		return this.moneyCountorTime;
	}

	public void setMoneyCountorTime(Date moneyCountorTime) {
		this.moneyCountorTime = convertDate(moneyCountorTime);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "money_countor_next_date", length = 0)
	public Date getMoneyCountorNextDate() {
		return this.moneyCountorNextDate;
	}

	public void setMoneyCountorNextDate(Date moneyCountorNextDate) {
		this.moneyCountorNextDate = convertDate(moneyCountorNextDate);
	}

	@Column(name = "operate_card_register")
	public Integer getOperateCardRegister() {
		return this.operateCardRegister;
	}

	public void setOperateCardRegister(Integer operateCardRegister) {
		this.operateCardRegister = operateCardRegister;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "operate_card_regist_date", length = 0)
	public Date getOperateCardRegistDate() {
		return this.operateCardRegistDate;
	}

	public void setOperateCardRegistDate(Date operateCardRegistDate) {
		this.operateCardRegistDate = convertDate(operateCardRegistDate);
	}

	@Column(name = "business_license_id",length = 30)
	public String getBusinessLicenseId() {
		return this.businessLicenseId;
	}

	public void setBusinessLicenseId(String businessLicenseId) {
		this.businessLicenseId = businessLicenseId;
	}

	@Column(name = "business_license_comment")
	public String getBusinessLicenseComment() {
		return this.businessLicenseComment;
	}

	public void setBusinessLicenseComment(String businessLicenseComment) {
		this.businessLicenseComment = businessLicenseComment;
	}
	
	@Column(name = "is_new_license")
	public Boolean getIsNewLicense() {
		return this.isNewLicense;
	}

	public void setIsNewLicense(Boolean isNewLicense) {
		this.isNewLicense = isNewLicense;
	}

	@Column(name = "seq_val")
	public Integer getSeqVal() {
		return seqVal;
	}

	public void setSeqVal(Integer seqVal) {
		this.seqVal = seqVal;
	}

	@Column(name="electric_last_time")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getElectricLastTime() {
		return convertDate(electricLastTime);
	}

	public void setElectricLastTime(Date electricLastTime) {
		this.electricLastTime = electricLastTime;
	}

	@Column(name="getCarDate")
	public Date getGetCarDate() {
		return convertDate(getCarDate);
	}

	public void setGetCarDate(Date getCarDate) {
		this.getCarDate = getCarDate;
	}

	@Column(name="serviceRightRegister")
	public Integer getServiceRightRegister() {
		return serviceRightRegister;
	}

	public void setServiceRightRegister(Integer serviceRightRegister) {
		this.serviceRightRegister = serviceRightRegister;
	}

	@Column(name="serviceRightRegistDate")
	@Temporal(TemporalType.DATE)
	public Date getServiceRightRegistDate() {
		return convertDate(serviceRightRegistDate);
	}

	public void setServiceRightRegistDate(Date serviceRightRegistDate) {
		this.serviceRightRegistDate = serviceRightRegistDate;
	}

	public Boolean getReused() {
		return reused;
	}

	public void setReused(Boolean reused) {
		this.reused = reused;
	}

	@Column(name = "insurance_base",precision = 2)
	public BigDecimal getInsuranceBase() {
		return insuranceBase;
	}

	public void setInsuranceBase(BigDecimal insuranceBase) {
		this.insuranceBase = insuranceBase;
	}
}