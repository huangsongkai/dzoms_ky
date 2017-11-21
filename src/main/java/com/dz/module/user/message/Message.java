package com.dz.module.user.message;

import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Message entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "message", catalog = "ky_dzomsdb")
public class Message implements java.io.Serializable {

	// Fields

	private Integer id;
	private String type;
	private String idNum;
	private String carframeNum;
	private Integer fromUser;
	private Date time;
	private String msg;

	// Constructors

	/** default constructor */
	public Message() {
	}

	/** full constructor */
	public Message(String type, String idNum, String carframeNum,
			Integer fromUser, Date time, String msg) {
		this.type = type;
		this.idNum = idNum;
		this.carframeNum = carframeNum;
		this.fromUser = fromUser;
		this.time = time;
		this.msg = msg;
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

	@Column(name = "type", length = 100)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "idNum", length = 20)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "carframeNum", length = 30)
	public String getCarframeNum() {
		return this.carframeNum;
	}

	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}

	@Column(name = "fromUser")
	public Integer getFromUser() {
		return this.fromUser;
	}

	public void setFromUser(Integer fromUser) {
		this.fromUser = fromUser;
	}

	@Column(name = "time", length = 0)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	@Column(name = "msg")
	public String getMsg() {
		return this.msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}