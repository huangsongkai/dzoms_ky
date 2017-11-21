package com.dz.module.driver;
import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Families entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "families", catalog = "ky_dzomsdb")
public class Families implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -1833808491418699728L;
	private Integer id;
	private String idNum;
	private String role;
	private String name;
	private String phoneNum;
	private String work;

	// Constructors

	/** default constructor */
	public Families() {
	}

	/** minimal constructor */
	public Families(String idNum, String role, String name) {
		this.idNum = idNum;
		this.role = role;
		this.name = name;
	}

	/** full constructor */
	public Families(String idNum, String role, String name, String phoneNum,
			String work) {
		this.idNum = idNum;
		this.role = role;
		this.name = name;
		this.phoneNum = phoneNum;
		this.work = work;
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

	@Column(name = "id_num", nullable = false, length = 18)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "role", nullable = false, length = 20)
	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Column(name = "name", nullable = false, length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "phone_num", length = 20)
	public String getPhoneNum() {
		return this.phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	@Column(name = "work", length = 50)
	public String getWork() {
		return this.work;
	}

	public void setWork(String work) {
		this.work = work;
	}

	@Override
	public String toString() {
		return role+":"+name+","+work+","+phoneNum;
	}
}