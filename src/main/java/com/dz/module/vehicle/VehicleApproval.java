package com.dz.module.vehicle;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * VehicleApproval entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "vehicle_approval", catalog = "ky_dzomsdb")
public class VehicleApproval implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -519612536096925736L;
	private Integer id;
	private Short checkType;
	private Boolean ascription;
	private Boolean cartype;
	private String fueltype;
	private Integer contractId;
	private Date terminationDate;
	private Date procedureEndDate;
	private Integer terminationDays;
	private Integer terminationChief;
	private Date getCarDate;
	private Date licenseRegisterDate;
	private Integer getCarDays;
	private Integer getCarChief;
	private Date operateApplyDate;
	private Date operateCardDate;
	private Integer operateDays;
	private Integer operateChief;
	private Boolean creditCard;
	private Double damageInsurance;
	private Long onetimeAfterpay;
	private Date payBeginDate;
	private Date payEndDate;
	private Date approvalBranchDate;
	private Boolean isapprovalOffice;
	private Integer officeName;
	private String officeRemark;
	private Date approvalOfficeDate;
	private Integer cashierName;
	private String cashierRemark;
	private Date cashierApprovalDate;
	private Boolean isapprovalFinance;
	private Integer financeName;
	private String financeRemark;
	private Date approvalFinanceDate;
	private Boolean isapprovalFinanceManager;
	private Integer financeManagerName;
	private String financeManagerRemark;
	private Date financeManagerApprovalDate;
	private Boolean isapprovalBranchManager;
	private Integer branchManagerName;
	private String branchManagerRemark;
	private Date branchManagerApprovalDate;
	private Boolean isapprovalAssurer;
	private Integer assurerName;
	private String assurerRemark;
	private Date assurerApprovalDate;
	private Boolean isapprovalManager;
	private Integer managerName;
	private String managerRemark;
	private Date managerApprovalDate;
	private Boolean isapprovalDirector;
	private Integer directorName;
	private String directorRemark;
	private Date approvalDirectorDate;
	private Integer state;
	private Integer discountDays;
	private Boolean isFinished;
	private Boolean handleMatter;
	
	private Date interruptTime;
	private Integer interruptPerson;
	private String interruptReason;
	

	// Constructors

	/** default constructor */
	public VehicleApproval() {
	}

	/** minimal constructor */
	public VehicleApproval(Short checkType) {
		this.checkType = checkType;
	}

	/** full constructor */
	public VehicleApproval(Short checkType, Boolean ascription,
			Boolean cartype, String fueltype, Integer contractId,
			Date terminationDate, Date procedureEndDate,
			Integer terminationDays, Integer terminationChief, Date getCarDate,
			Date licenseRegisterDate, Integer getCarDays, Integer getCarChief,
			Date operateApplyDate, Date operateCardDate, Integer operateDays,
			Integer operateChief, Boolean creditCard, Double damageInsurance,
			Long onetimeAfterpay, Date approvalBranchDate,
			Boolean isapprovalOffice, Integer officeName, String officeRemark,
			Date approvalOfficeDate, Integer cashierName, String cashierRemark,
			Date cashierApprovalDate, Boolean isapprovalFinance,
			Integer financeName, String financeRemark,
			Date approvalFinanceDate, Boolean isapprovalFinanceManager,
			Integer financeManagerName, String financeManagerRemark,
			Date financeManagerApprovalDate, Boolean isapprovalBranchManager,
			Integer branchManagerName, String branchManagerRemark,
			Date branchManagerApprovalDate, Boolean isapprovalAssurer,
			Integer assurerName, String assurerRemark,
			Date assurerApprovalDate, Boolean isapprovalManager,
			Integer managerName, String managerRemark,
			Date managerApprovalDate, Boolean isapprovalDirector,
			Integer directorName, String directorRemark,
			Date approvalDirectorDate, Integer state) {
		this.checkType = checkType;
		this.ascription = ascription;
		this.cartype = cartype;
		this.fueltype = fueltype;
		this.contractId = contractId;
		this.terminationDate = terminationDate;
		this.procedureEndDate = procedureEndDate;
		this.terminationDays = terminationDays;
		this.terminationChief = terminationChief;
		this.getCarDate = getCarDate;
		this.licenseRegisterDate = licenseRegisterDate;
		this.getCarDays = getCarDays;
		this.getCarChief = getCarChief;
		this.operateApplyDate = operateApplyDate;
		this.operateCardDate = operateCardDate;
		this.operateDays = operateDays;
		this.operateChief = operateChief;
		this.creditCard = creditCard;
		this.damageInsurance = damageInsurance;
		this.onetimeAfterpay = onetimeAfterpay;
		this.approvalBranchDate = approvalBranchDate;
		this.isapprovalOffice = isapprovalOffice;
		this.officeName = officeName;
		this.officeRemark = officeRemark;
		this.approvalOfficeDate = approvalOfficeDate;
		this.cashierName = cashierName;
		this.cashierRemark = cashierRemark;
		this.cashierApprovalDate = cashierApprovalDate;
		this.isapprovalFinance = isapprovalFinance;
		this.financeName = financeName;
		this.financeRemark = financeRemark;
		this.approvalFinanceDate = approvalFinanceDate;
		this.isapprovalFinanceManager = isapprovalFinanceManager;
		this.financeManagerName = financeManagerName;
		this.financeManagerRemark = financeManagerRemark;
		this.financeManagerApprovalDate = financeManagerApprovalDate;
		this.isapprovalBranchManager = isapprovalBranchManager;
		this.branchManagerName = branchManagerName;
		this.branchManagerRemark = branchManagerRemark;
		this.branchManagerApprovalDate = branchManagerApprovalDate;
		this.isapprovalAssurer = isapprovalAssurer;
		this.assurerName = assurerName;
		this.assurerRemark = assurerRemark;
		this.assurerApprovalDate = assurerApprovalDate;
		this.isapprovalManager = isapprovalManager;
		this.managerName = managerName;
		this.managerRemark = managerRemark;
		this.managerApprovalDate = managerApprovalDate;
		this.isapprovalDirector = isapprovalDirector;
		this.directorName = directorName;
		this.directorRemark = directorRemark;
		this.approvalDirectorDate = approvalDirectorDate;
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

	@Column(name = "check_type", nullable = false)
	public Short getCheckType() {
		return this.checkType;
	}

	public void setCheckType(Short checkType) {
		this.checkType = checkType;
	}

	@Column(name = "ascription")
	public Boolean getAscription() {
		return this.ascription;
	}

	public void setAscription(Boolean ascription) {
		this.ascription = ascription;
	}

	@Column(name = "cartype")
	public Boolean getCartype() {
		return this.cartype;
	}

	public void setCartype(Boolean cartype) {
		this.cartype = cartype;
	}

	@Column(name = "fueltype", length = 30)
	public String getFueltype() {
		return this.fueltype;
	}

	public void setFueltype(String fueltype) {
		this.fueltype = fueltype;
	}

	@Column(name = "contract_id")
	public Integer getContractId() {
		return this.contractId;
	}

	public void setContractId(Integer contractId) {
		this.contractId = contractId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "termination_date", length = 0)
	public Date getTerminationDate() {
		return this.terminationDate;
	}

	public void setTerminationDate(Date terminationDate) {
		this.terminationDate = com.dz.common.other.TimeComm.convertDate(terminationDate);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "procedure_end_date", length = 0)
	public Date getProcedureEndDate() {
		return this.procedureEndDate;
	}

	public void setProcedureEndDate(Date procedureEndDate) {
		this.procedureEndDate = com.dz.common.other.TimeComm.convertDate(procedureEndDate);
	}

	@Column(name = "termination_days")
	public Integer getTerminationDays() {
		return this.terminationDays;
	}

	public void setTerminationDays(Integer terminationDays) {
		this.terminationDays = terminationDays;
	}

	@Column(name = "termination_chief")
	public Integer getTerminationChief() {
		return this.terminationChief;
	}

	public void setTerminationChief(Integer terminationChief) {
		this.terminationChief = terminationChief;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "get_car_date", length = 0)
	public Date getGetCarDate() {
		return this.getCarDate;
	}

	public void setGetCarDate(Date getCarDate) {
		this.getCarDate = com.dz.common.other.TimeComm.convertDate(getCarDate);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "license_register_date", length = 0)
	public Date getLicenseRegisterDate() {
		return this.licenseRegisterDate;
	}

	public void setLicenseRegisterDate(Date licenseRegisterDate) {
		this.licenseRegisterDate = com.dz.common.other.TimeComm.convertDate(licenseRegisterDate);
	}

	@Column(name = "get_car_days")
	public Integer getGetCarDays() {
		return this.getCarDays;
	}

	public void setGetCarDays(Integer getCarDays) {
		this.getCarDays = getCarDays;
	}

	@Column(name = "get_car_chief")
	public Integer getGetCarChief() {
		return this.getCarChief;
	}

	public void setGetCarChief(Integer getCarChief) {
		this.getCarChief = getCarChief;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "operate_apply_date", length = 0)
	public Date getOperateApplyDate() {
		return this.operateApplyDate;
	}

	public void setOperateApplyDate(Date operateApplyDate) {
		this.operateApplyDate = com.dz.common.other.TimeComm.convertDate(operateApplyDate);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "operate_card_date", length = 0)
	public Date getOperateCardDate() {
		return this.operateCardDate;
	}

	public void setOperateCardDate(Date operateCardDate) {
		this.operateCardDate = com.dz.common.other.TimeComm.convertDate(operateCardDate);
	}

	@Column(name = "operate_days")
	public Integer getOperateDays() {
		return this.operateDays;
	}

	public void setOperateDays(Integer operateDays) {
		this.operateDays = operateDays;
	}

	@Column(name = "operate_chief")
	public Integer getOperateChief() {
		return this.operateChief;
	}

	public void setOperateChief(Integer operateChief) {
		this.operateChief = operateChief;
	}

	@Column(name = "credit_card")
	public Boolean getCreditCard() {
		return this.creditCard;
	}

	public void setCreditCard(Boolean creditCard) {
		this.creditCard = creditCard;
	}

	@Column(name = "damage_insurance", precision = 22, scale = 0)
	public Double getDamageInsurance() {
		return this.damageInsurance;
	}

	public void setDamageInsurance(Double damageInsurance) {
		this.damageInsurance = damageInsurance;
	}

	@Column(name = "onetime_afterpay", precision = 10, scale = 0)
	public Long getOnetimeAfterpay() {
		return this.onetimeAfterpay;
	}

	public void setOnetimeAfterpay(Long onetimeAfterpay) {
		this.onetimeAfterpay = onetimeAfterpay;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "approval_branch_date", length = 0)
	public Date getApprovalBranchDate() {
		return this.approvalBranchDate;
	}

	public void setApprovalBranchDate(Date approvalBranchDate) {
		this.approvalBranchDate = com.dz.common.other.TimeComm.convertDate(approvalBranchDate);
	}

	@Column(name = "isapproval_office")
	public Boolean getIsapprovalOffice() {
		return this.isapprovalOffice;
	}

	public void setIsapprovalOffice(Boolean isapprovalOffice) {
		this.isapprovalOffice = isapprovalOffice;
	}

	@Column(name = "office_name")
	public Integer getOfficeName() {
		return this.officeName;
	}

	public void setOfficeName(Integer officeName) {
		this.officeName = officeName;
	}

	@Column(name = "office_remark", length = 100)
	public String getOfficeRemark() {
		return this.officeRemark;
	}

	public void setOfficeRemark(String officeRemark) {
		this.officeRemark = officeRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "approval_office_date", length = 0)
	public Date getApprovalOfficeDate() {
		return this.approvalOfficeDate;
	}

	public void setApprovalOfficeDate(Date approvalOfficeDate) {
		this.approvalOfficeDate = com.dz.common.other.TimeComm.convertDate(approvalOfficeDate);
	}

	@Column(name = "cashier_name")
	public Integer getCashierName() {
		return this.cashierName;
	}

	public void setCashierName(Integer cashierName) {
		this.cashierName = cashierName;
	}

	@Column(name = "cashier_remark", length = 100)
	public String getCashierRemark() {
		return this.cashierRemark;
	}

	public void setCashierRemark(String cashierRemark) {
		this.cashierRemark = cashierRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "cashier_approval_date", length = 0)
	public Date getCashierApprovalDate() {
		return this.cashierApprovalDate;
	}

	public void setCashierApprovalDate(Date cashierApprovalDate) {
		this.cashierApprovalDate = com.dz.common.other.TimeComm.convertDate(cashierApprovalDate);
	}

	@Column(name = "isapproval_finance")
	public Boolean getIsapprovalFinance() {
		return this.isapprovalFinance;
	}

	public void setIsapprovalFinance(Boolean isapprovalFinance) {
		this.isapprovalFinance = isapprovalFinance;
	}

	@Column(name = "finance_name")
	public Integer getFinanceName() {
		return this.financeName;
	}

	public void setFinanceName(Integer financeName) {
		this.financeName = financeName;
	}

	@Column(name = "finance_remark", length = 100)
	public String getFinanceRemark() {
		return this.financeRemark;
	}

	public void setFinanceRemark(String financeRemark) {
		this.financeRemark = financeRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "approval_finance_date", length = 0)
	public Date getApprovalFinanceDate() {
		return this.approvalFinanceDate;
	}

	public void setApprovalFinanceDate(Date approvalFinanceDate) {
		this.approvalFinanceDate = com.dz.common.other.TimeComm.convertDate(approvalFinanceDate);
	}

	@Column(name = "isapproval_finance_manager")
	public Boolean getIsapprovalFinanceManager() {
		return this.isapprovalFinanceManager;
	}

	public void setIsapprovalFinanceManager(Boolean isapprovalFinanceManager) {
		this.isapprovalFinanceManager = isapprovalFinanceManager;
	}

	@Column(name = "finance_manager_name")
	public Integer getFinanceManagerName() {
		return this.financeManagerName;
	}

	public void setFinanceManagerName(Integer financeManagerName) {
		this.financeManagerName = financeManagerName;
	}

	@Column(name = "finance_manager_remark", length = 100)
	public String getFinanceManagerRemark() {
		return this.financeManagerRemark;
	}

	public void setFinanceManagerRemark(String financeManagerRemark) {
		this.financeManagerRemark = financeManagerRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "finance_manager_approval_date", length = 0)
	public Date getFinanceManagerApprovalDate() {
		return this.financeManagerApprovalDate;
	}

	public void setFinanceManagerApprovalDate(Date financeManagerApprovalDate) {
		this.financeManagerApprovalDate = com.dz.common.other.TimeComm.convertDate(financeManagerApprovalDate);
	}

	@Column(name = "isapproval_branch_manager")
	public Boolean getIsapprovalBranchManager() {
		return this.isapprovalBranchManager;
	}

	public void setIsapprovalBranchManager(Boolean isapprovalBranchManager) {
		this.isapprovalBranchManager = isapprovalBranchManager;
	}

	@Column(name = "branch_manager_name")
	public Integer getBranchManagerName() {
		return this.branchManagerName;
	}

	public void setBranchManagerName(Integer branchManagerName) {
		this.branchManagerName = branchManagerName;
	}

	@Column(name = "branch_manager_remark", length = 100)
	public String getBranchManagerRemark() {
		return this.branchManagerRemark;
	}

	public void setBranchManagerRemark(String branchManagerRemark) {
		this.branchManagerRemark = branchManagerRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "branch_manager_approval_date", length = 0)
	public Date getBranchManagerApprovalDate() {
		return this.branchManagerApprovalDate;
	}

	public void setBranchManagerApprovalDate(Date branchManagerApprovalDate) {
		this.branchManagerApprovalDate = com.dz.common.other.TimeComm.convertDate(branchManagerApprovalDate);
	}

	@Column(name = "isapproval_assurer")
	public Boolean getIsapprovalAssurer() {
		return this.isapprovalAssurer;
	}

	public void setIsapprovalAssurer(Boolean isapprovalAssurer) {
		this.isapprovalAssurer = isapprovalAssurer;
	}

	@Column(name = "assurer_name")
	public Integer getAssurerName() {
		return this.assurerName;
	}

	public void setAssurerName(Integer assurerName) {
		this.assurerName = assurerName;
	}

	@Column(name = "assurer_remark", length = 100)
	public String getAssurerRemark() {
		return this.assurerRemark;
	}

	public void setAssurerRemark(String assurerRemark) {
		this.assurerRemark = assurerRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "assurer_approval_date", length = 0)
	public Date getAssurerApprovalDate() {
		return this.assurerApprovalDate;
	}

	public void setAssurerApprovalDate(Date assurerApprovalDate) {
		this.assurerApprovalDate = com.dz.common.other.TimeComm.convertDate(assurerApprovalDate);
	}

	@Column(name = "isapproval_manager")
	public Boolean getIsapprovalManager() {
		return this.isapprovalManager;
	}

	public void setIsapprovalManager(Boolean isapprovalManager) {
		this.isapprovalManager = isapprovalManager;
	}

	@Column(name = "manager_name")
	public Integer getManagerName() {
		return this.managerName;
	}

	public void setManagerName(Integer managerName) {
		this.managerName = managerName;
	}

	@Column(name = "manager_remark", length = 100)
	public String getManagerRemark() {
		return this.managerRemark;
	}

	public void setManagerRemark(String managerRemark) {
		this.managerRemark = managerRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "manager_approval_date", length = 0)
	public Date getManagerApprovalDate() {
		return this.managerApprovalDate;
	}

	public void setManagerApprovalDate(Date managerApprovalDate) {
		this.managerApprovalDate = com.dz.common.other.TimeComm.convertDate(managerApprovalDate);
	}

	@Column(name = "isapproval_director")
	public Boolean getIsapprovalDirector() {
		return this.isapprovalDirector;
	}

	public void setIsapprovalDirector(Boolean isapprovalDirector) {
		this.isapprovalDirector = isapprovalDirector;
	}

	@Column(name = "director_name")
	public Integer getDirectorName() {
		return this.directorName;
	}

	public void setDirectorName(Integer directorName) {
		this.directorName = directorName;
	}

	@Column(name = "director_remark", length = 100)
	public String getDirectorRemark() {
		return this.directorRemark;
	}

	public void setDirectorRemark(String directorRemark) {
		this.directorRemark = directorRemark;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "approval_director_date", length = 0)
	public Date getApprovalDirectorDate() {
		return this.approvalDirectorDate;
	}

	public void setApprovalDirectorDate(Date approvalDirectorDate) {
		this.approvalDirectorDate = com.dz.common.other.TimeComm.convertDate(approvalDirectorDate);
	}

	@Column(name = "state")
	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	
	@Column(name = "discountDays")
	public Integer getDiscountDays() {
		return this.discountDays;
	}

	public void setDiscountDays(Integer discountDays) {
		this.discountDays = discountDays;
	}

	@Column(name="approval_state")
	public Boolean getIsFinished() {
		return isFinished;
	}

	public void setIsFinished(Boolean isFinished) {
		this.isFinished = isFinished;
	}

	@Column(name="handleMatter")
	public Boolean getHandleMatter() {
		return handleMatter;
	}

	public void setHandleMatter(Boolean handleMatter) {
		this.handleMatter = handleMatter;
	}

	@Column(name="interruptTime")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getInterruptTime() {
		return interruptTime;
	}

	public void setInterruptTime(Date interruptTime) {
		this.interruptTime = interruptTime;
	}

	@Column(name="interruptPerson")
	public Integer getInterruptPerson() {
		return interruptPerson;
	}

	public void setInterruptPerson(Integer interruptPerson) {
		this.interruptPerson = interruptPerson;
	}

	@Column(name="interruptReason")
	public String getInterruptReason() {
		return interruptReason;
	}

	public void setInterruptReason(String interruptReason) {
		this.interruptReason = interruptReason;
	}

	@Column(name="payBeginDate")
	@Temporal(TemporalType.DATE)
	public Date getPayBeginDate() {
		return payBeginDate;
	}

	public void setPayBeginDate(Date payBeginDate) {
		this.payBeginDate = payBeginDate;
	}

	@Column(name="payEndDate")
	@Temporal(TemporalType.DATE)
	public Date getPayEndDate() {
		return payEndDate;
	}

	public void setPayEndDate(Date payEndDate) {
		this.payEndDate = payEndDate;
	}

}