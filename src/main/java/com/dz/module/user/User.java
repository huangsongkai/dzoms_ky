package com.dz.module.user;

// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * User entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "user", catalog = "ky_dzomsdb")
public class User implements java.io.Serializable {

	// Fields
	/**
	 * 
	 */
	private static final long serialVersionUID = 7584486269495002832L;
	private Integer uid;
	private String uname;
	private String passwordHash;
	private String passwordSalt;
//	@Transient
	private String upwd;
	private String department;
	private String position;
	private String phone;
	// Constructors

	/** default constructor */
	public User() {
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "uid", unique = true, nullable = false)
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Column(name = "uname", nullable = false, length = 30)
	public String getUname() {
		return this.uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	@Column(name = "pwdSalt", nullable = false)
	public String getPasswordSalt() {
		return passwordSalt;
	}

	public void setPasswordSalt(String passwordSalt) {
		this.passwordSalt = passwordSalt;
	}

	@Column(name = "pwdHash", nullable = false)
	public String getPasswordHash() {
		return this.passwordHash;
	}

	public void setPasswordHash(String upwd) {
		this.passwordHash = upwd;
	}

	@Column(name = "department")
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	@Column(name = "position")
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	@Column(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Transient
	public String getUpwd() {
		return upwd;
	}

	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	@Override
	public String toString() {
		return "User{" +
				"uid=" + uid +
				", uname='" + uname + '\'' +
				", passwordHash='" + passwordHash + '\'' +
				", passwordSalt='" + passwordSalt + '\'' +
				", department='" + department + '\'' +
				", position='" + position + '\'' +
				", phone='" + phone + '\'' +
				'}';
	}
}