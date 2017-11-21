package com.dz.module.driver.praise;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Praise entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "praise", catalog = "ky_dzomsdb")
public class Praise implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 8011369403002231759L;
	private Integer id;
	private String praiseClass;
	private String praiseFromOut;
	private String praiseFromIn;
	private String praiseFromOther;
	private Integer fileInfo;
	private String praiseContext;
	private String idNum;
	private String ticketNumber;
	private Date praiseTime;
	private Float grade;
	private Integer registrant;
	private Date registTime;
	private Boolean alreadyDeal;
	private Integer dealPerson;
	private Date dealTime;
	
	private String praisePersonName;
	private String praisePersonPhone;

	// Constructors

	/** default constructor */
	public Praise() {
	}

	/** full constructor */
	public Praise(String praiseClass, String praiseFrom, String praiseFromIn,
			Integer fileInfo, String praiseContext, String idNum,
			String ticketNumber, Date praiseTime, Float grade,
			Integer registrant, Date registTime, Boolean alreadyDeal,
			Integer dealPerson, Date dealTime) {
		this.praiseClass = praiseClass;
		this.praiseFromOut = praiseFrom;
		this.praiseFromIn = praiseFromIn;
		this.fileInfo = fileInfo;
		this.praiseContext = praiseContext;
		this.idNum = idNum;
		this.ticketNumber = ticketNumber;
		this.praiseTime = praiseTime;
		this.grade = grade;
		this.registrant = registrant;
		this.registTime = registTime;
		this.alreadyDeal = alreadyDeal;
		this.dealPerson = dealPerson;
		this.dealTime = dealTime;
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

	@Column(name = "praise_class", length = 30)
	public String getPraiseClass() {
		return this.praiseClass;
	}

	public void setPraiseClass(String praiseClass) {
		this.praiseClass = praiseClass;
	}

	@Column(name = "praise_from_out")
	public String getPraiseFromOut() {
		return this.praiseFromOut;
	}

	public void setPraiseFromOut(String praiseFrom) {
		this.praiseFromOut = praiseFrom;
	}

	@Column(name = "praise_from_in")
	public String getPraiseFromIn() {
		return this.praiseFromIn;
	}

	public void setPraiseFromIn(String praiseFromIn) {
		this.praiseFromIn = praiseFromIn;
	}

	@Column(name = "file_info")
	public Integer getFileInfo() {
		return this.fileInfo;
	}

	public void setFileInfo(Integer fileInfo) {
		this.fileInfo = fileInfo;
	}

	@Column(name = "praise_context")
	public String getPraiseContext() {
		return this.praiseContext;
	}

	public void setPraiseContext(String praiseContext) {
		this.praiseContext = praiseContext;
	}

	@Column(name = "id_num", length = 18)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "ticket_number", length = 50)
	public String getTicketNumber() {
		return this.ticketNumber;
	}

	public void setTicketNumber(String ticketNumber) {
		this.ticketNumber = ticketNumber;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "praise_time", length = 0)
	public Date getPraiseTime() {
		return this.praiseTime;
	}

	public void setPraiseTime(Date praiseTime) {
		this.praiseTime = praiseTime;
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

	@Column(name = "already_deal")
	public Boolean getAlreadyDeal() {
		return this.alreadyDeal;
	}

	public void setAlreadyDeal(Boolean alreadyDeal) {
		this.alreadyDeal = alreadyDeal;
	}

	@Column(name = "deal_person")
	public Integer getDealPerson() {
		return this.dealPerson;
	}

	public void setDealPerson(Integer dealPerson) {
		this.dealPerson = dealPerson;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "deal_time", length = 0)
	public Date getDealTime() {
		return this.dealTime;
	}

	public void setDealTime(Date dealTime) {
		this.dealTime = dealTime;
	}

	@Column(name="praiseFromOther")
	public String getPraiseFromOther() {
		return praiseFromOther;
	}

	public void setPraiseFromOther(String praiseFromOther) {
		this.praiseFromOther = praiseFromOther;
	}

	@Column(name="praisePersonName")
	public String getPraisePersonName() {
		return praisePersonName;
	}

	public void setPraisePersonName(String praisePersonName) {
		this.praisePersonName = praisePersonName;
	}

	@Column(name="praisePersonPhone")
	public String getPraisePersonPhone() {
		return praisePersonPhone;
	}

	public void setPraisePersonPhone(String praisePersonPhone) {
		this.praisePersonPhone = praisePersonPhone;
	}

}