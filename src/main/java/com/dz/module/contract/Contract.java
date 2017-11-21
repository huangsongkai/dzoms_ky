package com.dz.module.contract;
// default package

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import static javax.persistence.GenerationType.*;
/**
 * Contract entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(catalog = "ky_dzomsdb")
public class Contract implements java.io.Serializable {

	// Fields
	/**
	 *
	 */
	private static final long serialVersionUID = -2381503502270852032L;
	private Integer id;
	private String contractId;
	private String carframeNum;
	private String carNum;
	private String businessForm;
	private Boolean ascription;
	private Integer contractFrom;
	private Double penalty;
	private Double rentFirst;
	private Double rent;
	private Double deposit;
	private Double feeAlter;
	private Date contractBeginDate;
	private Date contractEndDate;
	private Boolean isRenew;
	private String carNumOld;
	private String branchFirm;
	private String idNum;
	private String remark;
	private String identityGuarantor;
	private String guarantorName;
	private String phoneNumGuarantor;
	private String addressLicenseGuarantor;
	private String addressCurrentGuarantor;
	private String photoGuarantor;
	private Date abandonedTime;
	private Date abandonedFinalTime;
	@Temporal(TemporalType.DATE)
	@Column
	private Date abandonedChargeTime;
	private String abandonReason;
	private String abandonRequest;
	private String abandonedUser;
	private String abandonedTimeControl;
	private Integer inputer;
	private Date inputTime;
	private Short state;
	private BigDecimal account;
	private String contractType;
	private Boolean geneByImport;
	private Integer discountDays;
	private String driverRequest;
	private String planList;
	/**
	 * 约定是否建立，只对合同状态为0,1的有效
	 */
	@Column
	private boolean planMaked;

	// Constructors

	/** default constructor */
	public Contract() {
	}

	/** minimal constructor */
	public Contract(String contractId, String carframeNum, String carNum,
					String businessForm, Double penalty, Double rentFirst, Double rent,
					Double deposit, Date contractBeginDate, Date contractEndDate,
					String branchFirm, String idNum, String remark,
					String identityGuarantor, String guarantorName,
					String phoneNumGuarantor, String addressLicenseGuarantor,
					String addressCurrentGuarantor) {
		this.contractId = contractId;
		this.carframeNum = carframeNum;
		this.carNum = carNum;
		this.businessForm = businessForm;
		this.penalty = penalty;
		this.rentFirst = rentFirst;
		this.rent = rent;
		this.deposit = deposit;
		this.contractBeginDate = contractBeginDate;
		this.contractEndDate = contractEndDate;
		this.branchFirm = branchFirm;
		this.idNum = idNum;
		this.remark = remark;
		this.identityGuarantor = identityGuarantor;
		this.guarantorName = guarantorName;
		this.phoneNumGuarantor = phoneNumGuarantor;
		this.addressLicenseGuarantor = addressLicenseGuarantor;
		this.addressCurrentGuarantor = addressCurrentGuarantor;
	}

	/** full constructor */
	public Contract(String contractId, String carframeNum, String carNum,
					String businessForm, Boolean ascription, Integer contractFrom,
					Double penalty, Double rentFirst, Double rent, Double deposit,
					Double feeAlter, Date contractBeginDate, Date contractEndDate,
					Boolean isRenew, String carNumOld, String branchFirm, String idNum,
					String remark, String identityGuarantor, String guarantorName,
					String phoneNumGuarantor, String addressLicenseGuarantor,
					String addressCurrentGuarantor, String photoGuarantor,
					Date abandonedTime, String abandonReason, String abandonRequest,
					String abandonedUser, String abandonedTimeControl, Integer inputer,
					Date inputTime, Short state) {
		this.contractId = contractId;
		this.carframeNum = carframeNum;
		this.carNum = carNum;
		this.businessForm = businessForm;
		this.ascription = ascription;
		this.contractFrom = contractFrom;
		this.penalty = penalty;
		this.rentFirst = rentFirst;
		this.rent = rent;
		this.deposit = deposit;
		this.feeAlter = feeAlter;
		this.contractBeginDate = contractBeginDate;
		this.contractEndDate = contractEndDate;
		this.isRenew = isRenew;
		this.carNumOld = carNumOld;
		this.branchFirm = branchFirm;
		this.idNum = idNum;
		this.remark = remark;
		this.identityGuarantor = identityGuarantor;
		this.guarantorName = guarantorName;
		this.phoneNumGuarantor = phoneNumGuarantor;
		this.addressLicenseGuarantor = addressLicenseGuarantor;
		this.addressCurrentGuarantor = addressCurrentGuarantor;
		this.photoGuarantor = photoGuarantor;
		this.abandonedTime = abandonedTime;
		this.abandonReason = abandonReason;
		this.abandonRequest = abandonRequest;
		this.abandonedUser = abandonedUser;
		this.abandonedTimeControl = abandonedTimeControl;
		this.inputer = inputer;
		this.inputTime = inputTime;
		this.state = state;
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

	@Column(name = "contract_id",  length = 30)
	public String getContractId() {
		return this.contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	@Column(name = "carframe_num", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "car_num",  length = 30)
	public String getCarNum() {
		return this.carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	@Column(name = "business_form",  length = 30)
	public String getBusinessForm() {
		return this.businessForm;
	}

	public void setBusinessForm(String businessForm) {
		this.businessForm = businessForm;
	}

	@Column(name = "ascription")
	public Boolean getAscription() {
		return this.ascription;
	}

	public void setAscription(Boolean ascription) {
		this.ascription = ascription;
	}

	@Column(name = "contract_from")
	public Integer getContractFrom() {
		return this.contractFrom;
	}

	public void setContractFrom(Integer contractFrom) {
		this.contractFrom = contractFrom;
	}

	@Column(name = "penalty",  precision = 10, scale = 2)
	public Double getPenalty() {
		return this.penalty;
	}

	public void setPenalty(Double penalty) {
		this.penalty = penalty;
	}

	@Column(name = "rent_first", precision = 10, scale = 2)
	public Double getRentFirst() {
		return this.rentFirst;
	}

	public void setRentFirst(Double rentFirst) {
		this.rentFirst = rentFirst;
	}

	@Column(name = "rent",  precision = 10, scale = 2)
	public Double getRent() {
		return this.rent;
	}

	public void setRent(Double rent) {
		this.rent = rent;
	}

	@Column(name = "deposit",  precision = 10, scale = 2)
	public Double getDeposit() {
		return this.deposit;
	}

	public void setDeposit(Double deposit) {
		this.deposit = deposit;
	}

	@Column(name = "fee_alter", precision = 10, scale = 2)
	public Double getFeeAlter() {
		return this.feeAlter;
	}

	public void setFeeAlter(Double feeAlter) {
		this.feeAlter = feeAlter;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "contract_begin_date",  length = 0)
	public Date getContractBeginDate() {
		return this.contractBeginDate;
	}

	public void setContractBeginDate(Date contractBeginDate) {
		this.contractBeginDate = com.dz.common.other.TimeComm.convertDate(contractBeginDate);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "contract_end_date",  length = 0)
	public Date getContractEndDate() {
		return this.contractEndDate;
	}

	public void setContractEndDate(Date contractEndDate) {
		this.contractEndDate = com.dz.common.other.TimeComm.convertDate(contractEndDate);
	}

	@Column(name = "is_renew")
	public Boolean getIsRenew() {
		return this.isRenew;
	}

	public void setIsRenew(Boolean isRenew) {
		this.isRenew = isRenew;
	}

	@Column(name = "car_num_old", length = 30)
	public String getCarNumOld() {
		return this.carNumOld;
	}

	public void setCarNumOld(String carNumOld) {
		this.carNumOld = carNumOld;
	}

	@Column(name = "branch_firm", nullable = false, length = 30)
	public String getBranchFirm() {
		return this.branchFirm;
	}

	public void setBranchFirm(String branchFirm) {
		this.branchFirm = branchFirm;
	}

	@Column(name = "id_num", nullable = false, length = 18)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "remark", length = 100)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "identity_guarantor",  length = 30)
	public String getIdentityGuarantor() {
		return this.identityGuarantor;
	}

	public void setIdentityGuarantor(String identityGuarantor) {
		this.identityGuarantor = identityGuarantor;
	}

	@Column(name = "guarantor_name", length = 30)
	public String getGuarantorName() {
		return this.guarantorName;
	}

	public void setGuarantorName(String guarantorName) {
		this.guarantorName = guarantorName;
	}

	@Column(name = "phone_num_guarantor",  length = 30)
	public String getPhoneNumGuarantor() {
		return this.phoneNumGuarantor;
	}

	public void setPhoneNumGuarantor(String phoneNumGuarantor) {
		this.phoneNumGuarantor = phoneNumGuarantor;
	}

	@Column(name = "address_license_guarantor",  length = 50)
	public String getAddressLicenseGuarantor() {
		return this.addressLicenseGuarantor;
	}

	public void setAddressLicenseGuarantor(String addressLicenseGuarantor) {
		this.addressLicenseGuarantor = addressLicenseGuarantor;
	}

	@Column(name = "address_current_guarantor",  length = 50)
	public String getAddressCurrentGuarantor() {
		return this.addressCurrentGuarantor;
	}

	public void setAddressCurrentGuarantor(String addressCurrentGuarantor) {
		this.addressCurrentGuarantor = addressCurrentGuarantor;
	}

	@Column(name = "photo_guarantor", length = 100)
	public String getPhotoGuarantor() {
		return this.photoGuarantor;
	}

	public void setPhotoGuarantor(String photoGuarantor) {
		this.photoGuarantor = photoGuarantor;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "abandoned_time", length = 0)
	public Date getAbandonedTime() {
		return this.abandonedTime;
	}

	public void setAbandonedTime(Date abandonedTime) {
		this.abandonedTime = com.dz.common.other.TimeComm.convertDate(abandonedTime);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "abandoned_final_time", length = 0)
	public Date getAbandonedFinalTime() {
		return abandonedFinalTime;
	}

	public void setAbandonedFinalTime(Date abandonedFinalTime) {
		this.abandonedFinalTime = com.dz.common.other.TimeComm.convertDate(abandonedFinalTime);
	}

	@Column(name = "abandon_reason", length = 30)
	public String getAbandonReason() {
		return this.abandonReason;
	}

	public void setAbandonReason(String abandonReason) {
		this.abandonReason = abandonReason;
	}

	@Column(name = "abandon_request")
	public String getAbandonRequest() {
		return this.abandonRequest;
	}

	public void setAbandonRequest(String abandonRequest) {
		this.abandonRequest = abandonRequest;
	}

	@Column(name = "abandoned_user", length = 30)
	public String getAbandonedUser() {
		return this.abandonedUser;
	}

	public void setAbandonedUser(String abandonedUser) {
		this.abandonedUser = abandonedUser;
	}

	@Column(name = "abandoned_time_control", length = 30)
	public String getAbandonedTimeControl() {
		return this.abandonedTimeControl;
	}

	public void setAbandonedTimeControl(String abandonedTimeControl) {
		this.abandonedTimeControl = abandonedTimeControl;
	}

	@Column(name = "inputer")
	public Integer getInputer() {
		return this.inputer;
	}

	public void setInputer(Integer inputer) {
		this.inputer = inputer;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "input_time", length = 0)
	public Date getInputTime() {
		return this.inputTime;
	}

	public void setInputTime(Date inputTime) {
		this.inputTime = com.dz.common.other.TimeComm.convertDate(inputTime);
	}

	@Column(name = "state")
	public Short getState() {
		return this.state;
	}

	public void setState(Short state) {
		this.state = state;
	}

	public BigDecimal getAccount() {
		return account;
	}

	public void setAccount(BigDecimal account) {
		this.account = account;
	}
	@Column(name = "contractType", length = 30)
	public String getContractType() {
		return contractType;
	}

	public void setContractType(String contractType) {
		this.contractType = contractType;
	}

	@Column(name = "geneByImport")
	public Boolean getGeneByImport() {
		return geneByImport;
	}

	public void setGeneByImport(Boolean geneByImport) {
		this.geneByImport = geneByImport;
	}

	@Column(name = "discountDays")
	public Integer getDiscountDays() {
		return this.discountDays;
	}

	public void setDiscountDays(Integer discountDays) {
		this.discountDays = discountDays;
	}

	@Column(name="driver_request")
	public String getDriverRequest() {
		return driverRequest;
	}

	public void setDriverRequest(String driverRequest) {
		this.driverRequest = driverRequest;
	}

	@Column(name="planList")
	public String getPlanList() {
		return planList;
	}

	public void setPlanList(String planList) {
		this.planList = planList;
	}

	public Date getAbandonedChargeTime() {
		return abandonedChargeTime;
	}

	public void setAbandonedChargeTime(Date abandonedChargeTime) {
		this.abandonedChargeTime = abandonedChargeTime;
	}

	public boolean isPlanMaked() {
		return planMaked;
	}

	public void setPlanMaked(boolean planMaked) {
		this.planMaked = planMaked;
	}
}