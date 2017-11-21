package com.dz.module.contract.invoice;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * InvoiceRecord entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "invoice_record", catalog = "ky_dzomsdb")
public class InvoiceRecord implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 8215776014460345615L;
	private Integer id;
	private String type;
	private String carNum;
	private String contractor;
	private String reciever;
	private Date time;
	private Integer user;
	private String receiptNum;
	private Integer amount;
	private Long unitPrice;
	private Integer buy;
	private Integer sell;
	private Long price;
	private String sectionBegin;
	private String sectionEnd;
	private Integer yearId;
	private Boolean isAbandoned;
	private Integer abandonedUser;
	private Date abandonedTime;
	private String abandonedRemark;

	// Constructors

	/** default constructor */
	public InvoiceRecord() {
	}

	/** minimal constructor */
	public InvoiceRecord(String type, Date time, Integer user,
			String receiptNum, Integer amount, Long unitPrice, Integer buy,
			Integer sell, Long price, String sectionBegin, String sectionEnd,
			Integer yearId, Boolean isAbandoned) {
		this.type = type;
		this.time = time;
		this.user = user;
		this.receiptNum = receiptNum;
		this.amount = amount;
		this.unitPrice = unitPrice;
		this.buy = buy;
		this.sell = sell;
		this.price = price;
		this.sectionBegin = sectionBegin;
		this.sectionEnd = sectionEnd;
		this.yearId = yearId;
		this.isAbandoned = isAbandoned;
	}

	/** full constructor */
	public InvoiceRecord(String type, String carNum, String contractor,
			String reciever, Date time, Integer user, String receiptNum,
			Integer amount, Long unitPrice, Integer buy, Integer sell,
			Long price, String sectionBegin, String sectionEnd, Integer yearId,
			Boolean isAbandoned, Integer abandonedUser, Date abandonedTime,
			String abandonedRemark) {
		this.type = type;
		this.carNum = carNum;
		this.contractor = contractor;
		this.reciever = reciever;
		this.time = time;
		this.user = user;
		this.receiptNum = receiptNum;
		this.amount = amount;
		this.unitPrice = unitPrice;
		this.buy = buy;
		this.sell = sell;
		this.price = price;
		this.sectionBegin = sectionBegin;
		this.sectionEnd = sectionEnd;
		this.yearId = yearId;
		this.isAbandoned = isAbandoned;
		this.abandonedUser = abandonedUser;
		this.abandonedTime = abandonedTime;
		this.abandonedRemark = abandonedRemark;
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

	@Column(name = "type", nullable = false, length = 30)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "car_num", length = 30)
	public String getCarNum() {
		return this.carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	@Column(name = "contractor", length = 18)
	public String getContractor() {
		return this.contractor;
	}

	public void setContractor(String contractor) {
		this.contractor = contractor;
	}

	@Column(name = "reciever", length = 30)
	public String getReciever() {
		return this.reciever;
	}

	public void setReciever(String reciever) {
		this.reciever = reciever;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "time", nullable = false, length = 0)
	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	@Column(name = "user", nullable = false)
	public Integer getUser() {
		return this.user;
	}

	public void setUser(Integer user) {
		this.user = user;
	}

	@Column(name = "receipt_num", nullable = false, length = 30)
	public String getReceiptNum() {
		return this.receiptNum;
	}

	public void setReceiptNum(String receiptNum) {
		this.receiptNum = receiptNum;
	}

	@Column(name = "amount", nullable = false)
	public Integer getAmount() {
		return this.amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	@Column(name = "unit_price", nullable = false, precision = 10, scale = 0)
	public Long getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(Long unitPrice) {
		this.unitPrice = unitPrice;
	}

	@Column(name = "buy", nullable = false)
	public Integer getBuy() {
		return this.buy;
	}

	public void setBuy(Integer buy) {
		this.buy = buy;
	}

	@Column(name = "sell", nullable = false)
	public Integer getSell() {
		return this.sell;
	}

	public void setSell(Integer sell) {
		this.sell = sell;
	}

	@Column(name = "price", nullable = false, precision = 10, scale = 0)
	public Long getPrice() {
		return this.price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	@Column(name = "section_begin", nullable = false, length = 30)
	public String getSectionBegin() {
		return this.sectionBegin;
	}

	public void setSectionBegin(String sectionBegin) {
		this.sectionBegin = sectionBegin;
	}

	@Column(name = "section_end", nullable = false, length = 30)
	public String getSectionEnd() {
		return this.sectionEnd;
	}

	public void setSectionEnd(String sectionEnd) {
		this.sectionEnd = sectionEnd;
	}

	@Column(name = "year_id", nullable = false)
	public Integer getYearId() {
		return this.yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	@Column(name = "is_abandoned", nullable = false)
	public Boolean getIsAbandoned() {
		return this.isAbandoned;
	}

	public void setIsAbandoned(Boolean isAbandoned) {
		this.isAbandoned = isAbandoned;
	}

	@Column(name = "abandoned_user")
	public Integer getAbandonedUser() {
		return this.abandonedUser;
	}

	public void setAbandonedUser(Integer abandonedUser) {
		this.abandonedUser = abandonedUser;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "abandoned_time", length = 0)
	public Date getAbandonedTime() {
		return this.abandonedTime;
	}

	public void setAbandonedTime(Date abandonedTime) {
		this.abandonedTime = abandonedTime;
	}

	@Column(name = "abandoned_remark", length = 100)
	public String getAbandonedRemark() {
		return this.abandonedRemark;
	}

	public void setAbandonedRemark(String abandonedRemark) {
		this.abandonedRemark = abandonedRemark;
	}

}