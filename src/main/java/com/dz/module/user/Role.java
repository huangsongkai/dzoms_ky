package com.dz.module.user;

// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Role entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "role", catalog = "ky_dzomsdb", uniqueConstraints = @UniqueConstraint(columnNames = "rname"))
public class Role implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -2098895194546600725L;
	private Integer rid;
	private String rname;
	private String department;

	// Constructors

	/** default constructor */
	public Role() {
	}

	/** minimal constructor */
	public Role(String rname) {
		this.rname = rname;
	}

	/** full constructor */
	public Role(String rname, String department) {
		this.rname = rname;
		this.department = department;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "rid", unique = true, nullable = false)
	public Integer getRid() {
		return this.rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	@Column(name = "rname", unique = true, nullable = false, length = 30)
	public String getRname() {
		return this.rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}

	@Column(name = "department", length = 30)
	public String getDepartment() {
		return this.department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

}