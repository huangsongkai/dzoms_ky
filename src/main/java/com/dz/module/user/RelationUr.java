package com.dz.module.user;

// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * RelationUr entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "relation_ur", catalog = "ky_dzomsdb")
public class RelationUr implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 5424384790121230426L;
	private Integer id;
	private Integer uid;
	private Integer rid;

	// Constructors

	/** default constructor */
	public RelationUr() {
	}

	/** full constructor */
	public RelationUr(Integer uid, Integer rid) {
		this.uid = uid;
		this.rid = rid;
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

	@Column(name = "uid", nullable = false)
	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	@Column(name = "rid", nullable = false)
	public Integer getRid() {
		return this.rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

}