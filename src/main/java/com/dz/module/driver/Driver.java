package com.dz.module.driver;
// default package

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.dz.common.other.TimeComm;

/**
 * Driver entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "driver", catalog = "ky_dzomsdb")
public class Driver implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -1093714225153937348L;
	private float score;
	//0为申请完成,1为录入完成,2为成绩完成,3为财务完成,4已下车
	private int status;

	private String shenqingren;
	private String lururen;
	private String bangonshifuzeren;
	private String caiwufuzeren;
	private String bangonshifuzerenyijian;
	private String caiwufuzerenyijian;
	private BigDecimal fuwubaozhengjin;


	private String idNum;
	private String applyMatter;
	private String driverClass;
	private String carframeNum;
	private Date applyTime;
	private String name;
	private Boolean sex;
	private Short age;
	private Boolean maritalStatus;
	private String nation;
	private String accountLocation;
	private String phoneNum1;
	private String phoneNum2;
	private String address;
	private String drivingLicenseNum;
	private Date drivingLicenseDate;
	private String drivingLicenseType;
	//2017-10-18 新增 资格证号
	private String qualificationNo;
	private String qualificationNum;
	private Date qualificationDate;
	private Date qualificationValidDate;
	private String shiftLocation;
	private Date shiftTime;
	private String fuelLocation;
	private String operatingStation;
	private Boolean taxiExperience;
	private Integer taxiExperienceYears;
	private String oldLicenseNum;
	private String oldCompany;
	private Integer height;
	private String politicalStatus;
	private Boolean scar;
	private String specialty;
	private String qq;
	private String employeeNum;
	private Integer fingerprintNum;
	private Integer star;
	private String resume;
	private String hobby;
	private String educationDegree;
	private String languageAbility;
	private String health;
	private String cityFamiliarty;
	private Boolean badRecord;
	private Integer registrant;
	private Boolean isInCar;
	private Boolean isLeave;
	private String badRecordReason;
	private String restTime;
	private Date businessApplyTime;
	private Integer businessApplyRegistrant;
	private Date businessApplyRegistTime;
	private Date businessReciveTime;
	private Integer businessReciveRegistrant;
	private Date businessReciveRegistTime;
	private Date businessApplyCancelTime;
	private Integer businessApplyCancelRegistrant;
	private Date businessApplyCancelRegistTime;
	private Date businessReciveCancelTime;
	private Integer businessReciveCancelRegistrant;
	private Date businessReciveCancelRegistTime;
	private Integer businessApplyState;
	private Integer businessApplyCancelState;
	
	private String dept;
	private String team;
	private Boolean hasBadRecord;
	private String breakRecord;
	private String accidentRecord;
	private Date insertTime;
	private Boolean isQualified;
	private Boolean isContractorPassed;
	
	private String applyLicenseNum;

	// Constructors

	/** default constructor */
	public Driver() {
	}

	/** minimal constructor */
	public Driver(String idNum, String applyMatter, Date applyTime,
			String name, Boolean sex, String phoneNum1, String address,
			Integer registrant, Boolean isInCar) {
		this.idNum = idNum;
		this.applyMatter = applyMatter;
		this.applyTime = applyTime;
		this.name = name;
		this.sex = sex;
		this.phoneNum1 = phoneNum1;
		this.address = address;
		this.registrant = registrant;
		this.isInCar = isInCar;
	}

	public String getBangonshifuzerenyijian() {
		return bangonshifuzerenyijian;
	}

	public void setBangonshifuzerenyijian(String bangonshifuzerenyijian) {
		this.bangonshifuzerenyijian = bangonshifuzerenyijian;
	}

	public String getCaiwufuzerenyijian() {
		return caiwufuzerenyijian;
	}

	public void setCaiwufuzerenyijian(String caiwufuzerenyijian) {
		this.caiwufuzerenyijian = caiwufuzerenyijian;
	}

	public String getShenqingren() {
		return shenqingren;
	}

	public void setShenqingren(String shenqingren) {
		this.shenqingren = shenqingren;
	}

	public String getLururen() {
		return lururen;
	}

	public void setLururen(String lururen) {
		this.lururen = lururen;
	}

	public String getBangonshifuzeren() {
		return bangonshifuzeren;
	}

	public void setBangonshifuzeren(String bangonshifuzeren) {
		this.bangonshifuzeren = bangonshifuzeren;
	}

	public String getCaiwufuzeren() {
		return caiwufuzeren;
	}

	public void setCaiwufuzeren(String caiwufuzeren) {
		this.caiwufuzeren = caiwufuzeren;
	}

	/** full constructor */
	public Driver(String idNum, String applyMatter, Date applyTime,
			String name, Boolean sex, Short age, Boolean maritalStatus,
			String nation, String accountLocation, String phoneNum1,
			String phoneNum2, String address, String drivingLicenseNum,
			Date drivingLicenseDate, String drivingLicenseType,
			String qualificationNum, Date qualificationDate,
			Date qualificationValidDate, String shiftLocation, Date shiftTime,
			String fuelLocation, String operatingStation,
			Boolean taxiExperience, Integer taxiExperienceYears,
			String oldLicenseNum, String oldCompany, Integer height,
			String politicalStatus, Boolean scar, String specialty, String qq,
			String employeeNum, Integer fingerprintNum, Integer star,
			String resume, String hobby, String educationDegree,
			String languageAbility, String health, String cityFamiliarty,
			Boolean badRecord, Integer registrant, Boolean isInCar,
			String badRecordReason, String restTime) {
		this.idNum = idNum;
		this.applyMatter = applyMatter;
		this.applyTime = applyTime;
		this.name = name;
		this.sex = sex;
		this.age = age;
		this.maritalStatus = maritalStatus;
		this.nation = nation;
		this.accountLocation = accountLocation;
		this.phoneNum1 = phoneNum1;
		this.phoneNum2 = phoneNum2;
		this.address = address;
		this.drivingLicenseNum = drivingLicenseNum;
		this.drivingLicenseDate = drivingLicenseDate;
		this.drivingLicenseType = drivingLicenseType;
		this.qualificationNum = qualificationNum;
		this.qualificationDate = qualificationDate;
		this.qualificationValidDate = qualificationValidDate;
		this.shiftLocation = shiftLocation;
		this.shiftTime = shiftTime;
		this.fuelLocation = fuelLocation;
		this.operatingStation = operatingStation;
		this.taxiExperience = taxiExperience;
		this.taxiExperienceYears = taxiExperienceYears;
		this.oldLicenseNum = oldLicenseNum;
		this.oldCompany = oldCompany;
		this.height = height;
		this.politicalStatus = politicalStatus;
		this.scar = scar;
		this.specialty = specialty;
		this.qq = qq;
		this.employeeNum = employeeNum;
		this.fingerprintNum = fingerprintNum;
		this.star = star;
		this.resume = resume;
		this.hobby = hobby;
		this.educationDegree = educationDegree;
		this.languageAbility = languageAbility;
		this.health = health;
		this.cityFamiliarty = cityFamiliarty;
		this.badRecord = badRecord;
		this.registrant = registrant;
		this.isInCar = isInCar;
		this.badRecordReason = badRecordReason;
		this.restTime = restTime;
	}

	public Driver(String idNum) {
		this.idNum = idNum;
	}

	public float getScore() {
		return score;
	}

	public void setScore(float score) {
		this.score = score;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	// Property accessors
	@Id
	@Column(name = "id_num", unique = true , length = 18)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "apply_matter" , length = 30)
	public String getApplyMatter() {
		return this.applyMatter;
	}

	public void setApplyMatter(String applyMatter) {
		this.applyMatter = applyMatter;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "apply_time" , length = 0)
	public Date getApplyTime() {
		return this.applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = new Date(applyTime==null?0l:applyTime.getTime());
	}

	@Column(name = "name" , length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "sex" )
	public Boolean getSex() {
		return this.sex;
	}

	public void setSex(Boolean sex) {
		this.sex = sex;
	}

	@Column(name = "age")
	public Short getAge() {
		return this.age;
	}

	public void setAge(Short age) {
		this.age = age;
	}

	@Column(name = "marital_status")
	public Boolean getMaritalStatus() {
		return this.maritalStatus;
	}

	public void setMaritalStatus(Boolean maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	@Column(name = "nation", length = 10)
	public String getNation() {
		return this.nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	@Column(name = "account_location", length = 50)
	public String getAccountLocation() {
		return this.accountLocation;
	}

	public void setAccountLocation(String accountLocation) {
		this.accountLocation = accountLocation;
	}

	@Column(name = "phone_num1" , length = 20)
	public String getPhoneNum1() {
		return this.phoneNum1;
	}

	public void setPhoneNum1(String phoneNum1) {
		this.phoneNum1 = phoneNum1;
	}

	@Column(name = "phone_num2", length = 20)
	public String getPhoneNum2() {
		return this.phoneNum2;
	}

	public void setPhoneNum2(String phoneNum2) {
		this.phoneNum2 = phoneNum2;
	}

	@Column(name = "address" , length = 50)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "driving_license_num", length = 20)
	public String getDrivingLicenseNum() {
		return this.drivingLicenseNum;
	}

	public void setDrivingLicenseNum(String drivingLicenseNum) {
		this.drivingLicenseNum = drivingLicenseNum;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "driving_license_date", length = 0)
	public Date getDrivingLicenseDate() {
		return this.drivingLicenseDate;
	}

	public void setDrivingLicenseDate(Date drivingLicenseDate) {
		this.drivingLicenseDate = new Date(drivingLicenseDate!=null?drivingLicenseDate.getTime():0l);
	}

	@Column(name = "driving_license_type", length = 30)
	public String getDrivingLicenseType() {
		return this.drivingLicenseType;
	}

	public void setDrivingLicenseType(String drivingLicenseType) {
		this.drivingLicenseType = drivingLicenseType;
	}

	@Column(name = "qualification_num", length = 30)
	public String getQualificationNum() {
		return this.qualificationNum;
	}

	public void setQualificationNum(String qualificationNum) {
		this.qualificationNum = qualificationNum;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "qualification_date", length = 0)
	public Date getQualificationDate() {
		return this.qualificationDate;
	}

	public void setQualificationDate(Date qualificationDate) {
		this.qualificationDate = new Date(qualificationDate!=null?qualificationDate.getTime():0l);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "qualification_valid_date", length = 0)
	public Date getQualificationValidDate() {
		return this.qualificationValidDate;
	}

	public void setQualificationValidDate(Date qualificationValidDate) {
		this.qualificationValidDate = new Date(qualificationValidDate==null?0l:qualificationValidDate.getTime());
	}

	@Column(name = "shift_location", length = 30)
	public String getShiftLocation() {
		return this.shiftLocation;
	}

	public void setShiftLocation(String shiftLocation) {
		this.shiftLocation = shiftLocation;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "shift_time", length = 0)
	public Date getShiftTime() {
		return this.shiftTime;
	}

	public void setShiftTime(Date shiftTime) {
		this.shiftTime = new Date( shiftTime==null?0l:shiftTime.getTime());
	}

	@Column(name = "fuel_location", length = 30)
	public String getFuelLocation() {
		return this.fuelLocation;
	}

	public void setFuelLocation(String fuelLocation) {
		this.fuelLocation = fuelLocation;
	}

	@Column(name = "operating_station", length = 30)
	public String getOperatingStation() {
		return this.operatingStation;
	}

	public void setOperatingStation(String operatingStation) {
		this.operatingStation = operatingStation;
	}

	@Column(name = "taxi_experience")
	public Boolean getTaxiExperience() {
		return this.taxiExperience;
	}

	public void setTaxiExperience(Boolean taxiExperience) {
		this.taxiExperience = taxiExperience;
	}

	@Column(name = "taxi_experience_years")
	public Integer getTaxiExperienceYears() {
		return this.taxiExperienceYears;
	}

	public void setTaxiExperienceYears(Integer taxiExperienceYears) {
		this.taxiExperienceYears = taxiExperienceYears;
	}

	@Column(name = "old_license_num", length = 30)
	public String getOldLicenseNum() {
		return this.oldLicenseNum;
	}

	public void setOldLicenseNum(String oldLicenseNum) {
		this.oldLicenseNum = oldLicenseNum;
	}

	@Column(name = "old_company", length = 30)
	public String getOldCompany() {
		return this.oldCompany;
	}

	public void setOldCompany(String oldCompany) {
		this.oldCompany = oldCompany;
	}

	@Column(name = "height")
	public Integer getHeight() {
		return this.height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	@Column(name = "political_status", length = 10)
	public String getPoliticalStatus() {
		return this.politicalStatus;
	}

	public void setPoliticalStatus(String politicalStatus) {
		this.politicalStatus = politicalStatus;
	}

	@Column(name = "scar")
	public Boolean getScar() {
		return this.scar;
	}

	public void setScar(Boolean scar) {
		this.scar = scar;
	}

	@Column(name = "specialty", length = 30)
	public String getSpecialty() {
		return this.specialty;
	}

	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}

	@Column(name = "qq", length = 20)
	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	@Column(name = "employee_num", length = 30)
	public String getEmployeeNum() {
		return this.employeeNum;
	}

	public void setEmployeeNum(String employeeNum) {
		this.employeeNum = employeeNum;
	}

	@Column(name = "fingerprint_num")
	public Integer getFingerprintNum() {
		return this.fingerprintNum;
	}

	public void setFingerprintNum(Integer fingerprintNum) {
		this.fingerprintNum = fingerprintNum;
	}

	@Column(name = "star")
	public Integer getStar() {
		return this.star;
	}

	public void setStar(Integer star) {
		this.star = star;
	}

	@Column(name = "resume")
	public String getResume() {
		return this.resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	@Column(name = "hobby", length = 50)
	public String getHobby() {
		return this.hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	@Column(name = "education_degree", length = 20)
	public String getEducationDegree() {
		return this.educationDegree;
	}

	public void setEducationDegree(String educationDegree) {
		this.educationDegree = educationDegree;
	}

	@Column(name = "language_ability", length = 20)
	public String getLanguageAbility() {
		return this.languageAbility;
	}

	public void setLanguageAbility(String languageAbility) {
		this.languageAbility = languageAbility;
	}

	@Column(name = "health", length = 30)
	public String getHealth() {
		return this.health;
	}

	public void setHealth(String health) {
		this.health = health;
	}

	@Column(name = "city_familiarty", length = 20)
	public String getCityFamiliarty() {
		return this.cityFamiliarty;
	}

	public void setCityFamiliarty(String cityFamiliarty) {
		this.cityFamiliarty = cityFamiliarty;
	}

	@Column(name = "bad_record")
	public Boolean getBadRecord() {
		return this.badRecord;
	}

	public void setBadRecord(Boolean badRecord) {
		this.badRecord = badRecord;
	}

	@Column(name = "registrant" )
	public Integer getRegistrant() {
		return this.registrant;
	}

	public void setRegistrant(Integer registrant) {
		this.registrant = registrant;
	}

	@Column(name = "is_in_car" )
	public Boolean getIsInCar() {
		return this.isInCar;
	}

	public void setIsInCar(Boolean isInCar) {
		this.isInCar = isInCar;
	}

	@Column(name = "bad_record_reason")
	public String getBadRecordReason() {
		return this.badRecordReason;
	}

	public void setBadRecordReason(String badRecordReason) {
		this.badRecordReason = badRecordReason;
	}

	@Column(name = "rest_time", length = 100)
	public String getRestTime() {
		return this.restTime;
	}

	public void setRestTime(String restTime) {
		this.restTime = restTime;
	}


	@Column(name = "driver_class", length = 30)
	public String getDriverClass() {
		return this.driverClass;
	}

	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}

	@Column(name = "carframeNum", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}


	@Column(name = "team", length = 30)
	public String getTeam() {
		return this.team;
	}

	public void setTeam(String team) {
		this.team = team;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name = "business_apply_time", length = 0)
	public Date getBusinessApplyTime() {
		return this.businessApplyTime;
	}

	public void setBusinessApplyTime(Date businessApplyTime) {
		this.businessApplyTime = TimeComm.convertDate(businessApplyTime);
	}

	@Column(name = "business_apply_registrant")
	public Integer getBusinessApplyRegistrant() {
		return this.businessApplyRegistrant;
	}

	public void setBusinessApplyRegistrant(Integer businessApplyRegistrant) {
		this.businessApplyRegistrant = businessApplyRegistrant;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_apply_regist_time", length = 0)
	public Date getBusinessApplyRegistTime() {
		return this.businessApplyRegistTime;
	}

	public void setBusinessApplyRegistTime(Date businessApplyRegistTime) {
		this.businessApplyRegistTime = TimeComm.convertDate(businessApplyRegistTime);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_recive_time", length = 0)
	public Date getBusinessReciveTime() {
		return this.businessReciveTime;
	}

	public void setBusinessReciveTime(Date businessReciveTime) {
		this.businessReciveTime = TimeComm.convertDate(businessReciveTime);
	}

	@Column(name = "business_recive_registrant")
	public Integer getBusinessReciveRegistrant() {
		return this.businessReciveRegistrant;
	}

	public void setBusinessReciveRegistrant(Integer businessReciveRegistrant) {
		this.businessReciveRegistrant = businessReciveRegistrant;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_recive_regist_time", length = 0)
	public Date getBusinessReciveRegistTime() {
		return this.businessReciveRegistTime;
	}

	public void setBusinessReciveRegistTime(Date businessReciveRegistTime) {
		this.businessReciveRegistTime = TimeComm.convertDate(businessReciveRegistTime);
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_apply_cancel_time", length = 0)
	public Date getBusinessApplyCancelTime() {
		return this.businessApplyCancelTime;
	}

	public void setBusinessApplyCancelTime(Date businessApplyCancelTime) {
		this.businessApplyCancelTime = TimeComm.convertDate(businessApplyCancelTime);
	}

	@Column(name = "business_apply_cancel_registrant")
	public Integer getBusinessApplyCancelRegistrant() {
		return this.businessApplyCancelRegistrant;
	}

	public void setBusinessApplyCancelRegistrant(
			Integer businessApplyCancelRegistrant) {
		this.businessApplyCancelRegistrant = businessApplyCancelRegistrant;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_apply_cancel_regist_time", length = 0)
	public Date getBusinessApplyCancelRegistTime() {
		return this.businessApplyCancelRegistTime;
	}

	public void setBusinessApplyCancelRegistTime(
			Date businessApplyCancelRegistTime) {
		this.businessApplyCancelRegistTime =TimeComm.convertDate(businessApplyCancelRegistTime) ;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_recive_cancel_time", length = 0)
	public Date getBusinessReciveCancelTime() {
		return this.businessReciveCancelTime;
	}

	public void setBusinessReciveCancelTime(Date businessReciveCancelTime) {
		this.businessReciveCancelTime = TimeComm.convertDate(businessReciveCancelTime);
	}

	@Column(name = "business_recive_cancel_registrant")
	public Integer getBusinessReciveCancelRegistrant() {
		return this.businessReciveCancelRegistrant;
	}

	public void setBusinessReciveCancelRegistrant(
			Integer businessReciveCancelRegistrant) {
		this.businessReciveCancelRegistrant = businessReciveCancelRegistrant;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "business_recive_cancel_regist_time", length = 0)
	public Date getBusinessReciveCancelRegistTime() {
		return this.businessReciveCancelRegistTime;
	}

	public void setBusinessReciveCancelRegistTime(
			Date businessReciveCancelRegistTime) {
		this.businessReciveCancelRegistTime = TimeComm.convertDate(businessReciveCancelRegistTime);
	}

	@Column(name = "dept", length = 30)
	public String getDept() {
		return this.dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	@Column(name = "hasBadRecord")
	public Boolean getHasBadRecord() {
		return this.hasBadRecord;
	}

	public void setHasBadRecord(Boolean hasBadRecord) {
		this.hasBadRecord = hasBadRecord;
	}

	@Column(name = "breakRecord", length = 50)
	public String getBreakRecord() {
		return this.breakRecord;
	}

	public void setBreakRecord(String breakRecord) {
		this.breakRecord = breakRecord;
	}

	@Column(name = "accidentRecord", length = 50)
	public String getAccidentRecord() {
		return this.accidentRecord;
	}

	public void setAccidentRecord(String accidentRecord) {
		this.accidentRecord = accidentRecord;
	}
	
	@Column(name = "isLeave")
	public Boolean getIsLeave() {
		return this.isLeave;
	}

	public void setIsLeave(Boolean isLeave) {
		this.isLeave = isLeave;
	}

	@Column(name = "insertTime")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = TimeComm.convertDate(insertTime);
	}

	@Column(name = "isQualified")
	public Boolean getIsQualified() {
		return isQualified;
	}

	public void setIsQualified(Boolean isQualified) {
		this.isQualified = isQualified;
	}

	@Column(name = "isContractorPassed")
	public Boolean getIsContractorPassed() {
		return isContractorPassed;
	}

	public void setIsContractorPassed(Boolean isContractorPassed) {
		this.isContractorPassed = isContractorPassed;
	}

	public BigDecimal getFuwubaozhengjin() {
		return fuwubaozhengjin;
	}

	public void setFuwubaozhengjin(BigDecimal fuwubaozhengjin) {
		this.fuwubaozhengjin = fuwubaozhengjin;
	}

	@Column(name = "business_apply_state")
	public Integer getBusinessApplyState() {
		return businessApplyState;
	}

	public void setBusinessApplyState(Integer businessApplyState) {
		this.businessApplyState = businessApplyState;
	}

	@Column(name = "business_apply_cancel_state")
	public Integer getBusinessApplyCancelState() {
		return businessApplyCancelState;
	}

	public void setBusinessApplyCancelState(Integer businessApplyCancelState) {
		this.businessApplyCancelState = businessApplyCancelState;
	}
	
	private String businessApplyDriverClass;
	private String businessApplyCarframeNum;
	
	@Column(name = "business_apply_driver_class")
	public String getBusinessApplyDriverClass() {
		return businessApplyDriverClass;
	}

	public void setBusinessApplyDriverClass(String businessApplyDriverClass) {
		this.businessApplyDriverClass = businessApplyDriverClass;
	}

	@Column(name = "business_apply_carframe_num")
	public String getBusinessApplyCarframeNum() {
		return businessApplyCarframeNum;
	}

	public void setBusinessApplyCarframeNum(String businessApplyCarframeNum) {
		this.businessApplyCarframeNum = businessApplyCarframeNum;
	}

	@Column(name="apply_license_num")
	public String getApplyLicenseNum() {
		return applyLicenseNum;
	}

	public void setApplyLicenseNum(String applyLicenseNum) {
		this.applyLicenseNum = applyLicenseNum;
	}

	@Column(name="qualification_no")
	public String getQualificationNo() {
		return qualificationNo;
	}

	public void setQualificationNo(String qualificationNo) {
		this.qualificationNo = qualificationNo;
	}
}