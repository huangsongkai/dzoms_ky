package com.dz.module.driver.complain;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;
/**
 * Complain entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "complain", catalog = "ky_dzomsdb")
public class Complain implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7071720328827320374L;
	private Integer id;
	private String vehicleId;
	private String complainClass;
	private String complainType;
	private String complainObject;
	private String complainFromOut;
	private String complainFromIn;
	private Integer complainFile;
	private String complainPersonName;
	private String complainPersonSex;
	private String complainPersonPhone;
	private String complainContext;
	private Date complainTime;
	private String ticketNumber;
	private Integer registrant;
	private Date registTime;
	private String dealReault;
	private Float grade;
	private Date confirmTime;
	private Integer confirmPerson;
	private Date dealTime;
	private Integer dealPerson;
	private String visitBackResult;
	private Date visitBackTime;
	private Integer visitBackPerson;
	private Date finishTime;
	private Integer finishPerson;
	private Short state;
	private String attachDetail;
	private Date attachTime;
	private Integer attachPerson;
	private String dealContext;
	
//	@Transient
	private String carNum;

	// Constructors

	/** default constructor */
	public Complain() {
	}

	/** full constructor */
	public Complain(String vehicleId, String complainClass,
			String complainType, String complainObject,
			String complainFromOut, String complainFromIn,
			Integer complainFile, String complainPersonName,
			String complainPersonSex, String complainPersonPhone,
			String complainContext, Date complainTime, String ticketNumber,
			Integer registrant, Date registTime, String dealReault,
			Float grade, Date confirmTime, Integer confirmPerson,
			Date dealTime, Integer dealPerson, String visitBackResult,
			Date visitBackTime, Integer visitBackPerson, Date finishTime,
			Integer finishPerson, Short state) {
		this.vehicleId = vehicleId;
		this.complainClass = complainClass;
		this.complainType = complainType;
		this.complainObject = complainObject;
		this.complainFromOut = complainFromOut;
		this.complainFromIn = complainFromIn;
		this.complainFile = complainFile;
		this.complainPersonName = complainPersonName;
		this.complainPersonSex = complainPersonSex;
		this.complainPersonPhone = complainPersonPhone;
		this.complainContext = complainContext;
		this.complainTime = complainTime;
		this.ticketNumber = ticketNumber;
		this.registrant = registrant;
		this.registTime = registTime;
		this.dealReault = dealReault;
		this.grade = grade;
		this.confirmTime = confirmTime;
		this.confirmPerson = confirmPerson;
		this.dealTime = dealTime;
		this.dealPerson = dealPerson;
		this.visitBackResult = visitBackResult;
		this.visitBackTime = visitBackTime;
		this.visitBackPerson = visitBackPerson;
		this.finishTime = finishTime;
		this.finishPerson = finishPerson;
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

	@Column(name = "vehicle_id", length = 30)
	public String getVehicleId() {
		return this.vehicleId;
	}

	public void setVehicleId(String vehicleId) {
		this.vehicleId = vehicleId;
	}

	@Column(name = "complain_class", length = 10)
	public String getComplainClass() {
		return this.complainClass;
	}

	public void setComplainClass(String complainClass) {
		this.complainClass = complainClass;
	}

	@Column(name = "complain_type", length = 10)
	public String getComplainType() {
		return this.complainType;
	}

	public void setComplainType(String complainType) {
		this.complainType = complainType;
	}

	@Column(name = "complain_object")
	public String getComplainObject() {
		return this.complainObject;
	}

	public void setComplainObject(String complainObject) {
		this.complainObject = complainObject;
	}

	@Column(name = "complain_from_out")
	public String getComplainFromOut() {
		return this.complainFromOut;
	}

	public void setComplainFromOut(String complainFromOut) {
		this.complainFromOut = complainFromOut;
	}

	@Column(name = "complain_from_in")
	public String getComplainFromIn() {
		return this.complainFromIn;
	}

	public void setComplainFromIn(String complainFromIn) {
		this.complainFromIn = complainFromIn;
	}

	@Column(name = "complain_file")
	public Integer getComplainFile() {
		return this.complainFile;
	}

	public void setComplainFile(Integer complainFile) {
		this.complainFile = complainFile;
	}

	@Column(name = "complain_person_name", length = 20)
	public String getComplainPersonName() {
		return this.complainPersonName;
	}

	public void setComplainPersonName(String complainPersonName) {
		this.complainPersonName = complainPersonName;
	}

	@Column(name = "complain_person_sex", length = 10)
	public String getComplainPersonSex() {
		return this.complainPersonSex;
	}

	public void setComplainPersonSex(String complainPersonSex) {
		this.complainPersonSex = complainPersonSex;
	}

	@Column(name = "complain_person_phone", length = 30)
	public String getComplainPersonPhone() {
		return this.complainPersonPhone;
	}

	public void setComplainPersonPhone(String complainPersonPhone) {
		this.complainPersonPhone = complainPersonPhone;
	}

	@Column(name = "complain_context")
	public String getComplainContext() {
		return this.complainContext;
	}

	public void setComplainContext(String complainContext) {
		this.complainContext = complainContext;
	}

	@Column(name = "dealContext")
	public String getDealContext() {
		return dealContext;
	}

	public void setDealContext(String dealContext) {
		this.dealContext = dealContext;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "complain_time", length = 0)
	public Date getComplainTime() {
		return this.complainTime;
	}

	public void setComplainTime(Date complainTime) {
		this.complainTime = com.dz.common.other.TimeComm.convertDate(complainTime);
	}

	@Column(name = "ticket_number", length = 50)
	public String getTicketNumber() {
		return this.ticketNumber;
	}

	public void setTicketNumber(String ticketNumber) {
		this.ticketNumber = ticketNumber;
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
		this.registTime = com.dz.common.other.TimeComm.convertDate(registTime);
	}

	@Column(name = "deal_reault")
	public String getDealReault() {
		return this.dealReault;
	}

	public void setDealReault(String dealReault) {
		this.dealReault = dealReault;
	}

	@Column(name = "grade", precision = 10, scale = 0)
	public Float getGrade() {
		return this.grade;
	}

	public void setGrade(Float grade) {
		this.grade = grade;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "confirm_time", length = 0)
	public Date getConfirmTime() {
		return this.confirmTime;
	}

	public void setConfirmTime(Date confirmTime) {
		this.confirmTime = com.dz.common.other.TimeComm.convertDate(confirmTime);
	}

	@Column(name = "confirm_person")
	public Integer getConfirmPerson() {
		return this.confirmPerson;
	}

	public void setConfirmPerson(Integer confirmPerson) {
		this.confirmPerson = confirmPerson;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "deal_time", length = 0)
	public Date getDealTime() {
		return this.dealTime;
	}

	public void setDealTime(Date dealTime) {
		this.dealTime = com.dz.common.other.TimeComm.convertDate(dealTime);
	}

	@Column(name = "deal_person")
	public Integer getDealPerson() {
		return this.dealPerson;
	}

	public void setDealPerson(Integer dealPerson) {
		this.dealPerson = dealPerson;
	}

	@Column(name = "visit_back_result")
	public String getVisitBackResult() {
		return this.visitBackResult;
	}

	public void setVisitBackResult(String visitBackResult) {
		this.visitBackResult = visitBackResult;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "visit_back_time", length = 0)
	public Date getVisitBackTime() {
		return this.visitBackTime;
	}

	public void setVisitBackTime(Date visitBackTime) {
		this.visitBackTime = com.dz.common.other.TimeComm.convertDate(visitBackTime);
	}

	@Column(name = "visit_back_person")
	public Integer getVisitBackPerson() {
		return this.visitBackPerson;
	}

	public void setVisitBackPerson(Integer visitBackPerson) {
		this.visitBackPerson = visitBackPerson;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "finish_time", length = 0)
	public Date getFinishTime() {
		return this.finishTime;
	}

	public void setFinishTime(Date finishTime) {
		this.finishTime = com.dz.common.other.TimeComm.convertDate(finishTime);
	}

	@Column(name = "finish_person")
	public Integer getFinishPerson() {
		return this.finishPerson;
	}

	public void setFinishPerson(Integer finishPerson) {
		this.finishPerson = finishPerson;
	}

	@Column(name = "state")
	public Short getState() {
		return this.state;
	}

	public void setState(Short state) {
		this.state = state;
	}

	public void setState(Integer i) {
		if(i==null) this.state=null;
		this.state = (short)(int)i;
	}

	@Column(name="attachDetail")
	public String getAttachDetail() {
		return attachDetail;
	}

	public void setAttachDetail(String attachDetail) {
		this.attachDetail = attachDetail;
	}

	@Transient
	public String getCarNum() {
		return carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	@Override
	public String toString() {
		return "Complain [id=" + id + ", vehicleId=" + vehicleId
				+ ", complainClass=" + complainClass + ", complainType="
				+ complainType + ", complainObject=" + complainObject
				+ ", complainFromOut=" + complainFromOut + ", complainFromIn="
				+ complainFromIn + ", complainFile=" + complainFile
				+ ", complainPersonName=" + complainPersonName
				+ ", complainPersonSex=" + complainPersonSex
				+ ", complainPersonPhone=" + complainPersonPhone
				+ ", complainContext=" + complainContext + ", complainTime="
				+ complainTime + ", ticketNumber=" + ticketNumber
				+ ", registrant=" + registrant + ", registTime=" + registTime
				+ ", dealReault=" + dealReault + ", grade=" + grade
				+ ", confirmTime=" + confirmTime + ", confirmPerson="
				+ confirmPerson + ", dealTime=" + dealTime + ", dealPerson="
				+ dealPerson + ", visitBackResult=" + visitBackResult
				+ ", visitBackTime=" + visitBackTime + ", visitBackPerson="
				+ visitBackPerson + ", finishTime=" + finishTime
				+ ", finishPerson=" + finishPerson + ", state=" + state
				+ ", attachDetail=" + attachDetail + "]";
	}

	@Column
	@Temporal(TemporalType.DATE)
	public Date getAttachTime() {
		return attachTime;
	}

	public void setAttachTime(Date attachTime) {
		this.attachTime = attachTime;
	}

	@Column
	public Integer getAttachPerson() {
		return attachPerson;
	}

	public void setAttachPerson(Integer attachPerson) {
		this.attachPerson = attachPerson;
	}
}