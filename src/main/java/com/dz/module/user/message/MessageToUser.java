package com.dz.module.user.message;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * MessageToUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "message_to_user", catalog = "ky_dzomsdb")
public class MessageToUser implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer uid;
	private Integer mid;
	private Boolean alreadyRead;

	// Constructors

	/** default constructor */
	public MessageToUser() {
	}

	/** full constructor */
	public MessageToUser(Integer uid, Integer mid, Boolean alreadyRead) {
		this.uid = uid;
		this.mid = mid;
		this.alreadyRead = alreadyRead;
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

	@Column(name = "uid")
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Column(name = "mid")
	public Integer getMid() {
		return this.mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	@Column(name = "alreadyRead")
	public Boolean getAlreadyRead() {
		return this.alreadyRead;
	}

	public void setAlreadyRead(Boolean alreadyRead) {
		this.alreadyRead = alreadyRead;
	}

}