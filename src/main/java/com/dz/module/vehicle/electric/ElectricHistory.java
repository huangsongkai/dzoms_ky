package com.dz.module.vehicle.electric;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ElectricHistory entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "electric_history", catalog = "ky_dzomsdb")
public class ElectricHistory implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer fecthId;
	private String carframeNum;
	private String licenseNum;
	private Date date;
	private String act;
	private String area;
	private String code;
	private String fen;
	private String money;
	private String handled;
	private String payState;
	private String government;

	// Constructors

	/** default constructor */
	public ElectricHistory() {
	}

	/** full constructor */
	public ElectricHistory(Integer fecthId, String carframeNum,
			String licenseNum, Date date, String area, String code,
			String fen, String money, String handled) {
		this.fecthId = fecthId;
		this.carframeNum = carframeNum;
		this.licenseNum = licenseNum;
		this.date = date;
		this.area = area;
		this.code = code;
		this.fen = fen;
		this.money = money;
		this.handled = handled;
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

	@Column(name = "fecthId")
	public Integer getFecthId() {
		return this.fecthId;
	}

	public void setFecthId(Integer fecthId) {
		this.fecthId = fecthId;
	}

	@Column(name = "carframeNum", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "licenseNum", length = 30)
	public String getLicenseNum() {
		return this.licenseNum;
	}

	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}

	@Column(name = "date")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	@Column(name = "area")
	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "code", length = 30)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "fen", length = 30)
	public String getFen() {
		return this.fen;
	}

	public void setFen(String fen) {
		this.fen = fen;
	}

	@Column(name = "money", length = 30)
	public String getMoney() {
		return this.money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	@Column(name = "handled", length = 30)
	public String getHandled() {
		return this.handled;
	}

	public void setHandled(String handled) {
		this.handled = handled;
	}

	@Column(name = "act")
	public String getAct() {
		return act;
	}

	public void setAct(String act) {
		this.act = act;
	}

	@Column(name = "payState", length = 30)
	public String getPayState() {
		return payState;
	}

	public void setPayState(String payState) {
		this.payState = payState;
	}

	@Column(name = "government")
	public String getGovernment() {
		return government;
	}

	public void setGovernment(String government) {
		this.government = government;
	}

	@Override
	public String toString() {
		return "ElectricHistory [id=" + id + ", fecthId=" + fecthId
				+ ", carframeNum=" + carframeNum + ", licenseNum=" + licenseNum
				+ ", date=" + date + ", act=" + act + ", area=" + area
				+ ", code=" + code + ", fen=" + fen + ", money=" + money
				+ ", handled=" + handled + ", payState=" + payState
				+ ", government=" + government + "]";
	}
	
}