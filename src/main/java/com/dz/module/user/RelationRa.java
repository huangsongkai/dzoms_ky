package com.dz.module.user;

// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * RelationRa entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "relation_ra", catalog = "ky_dzomsdb")
public class RelationRa implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8269344060150391713L;
	private Integer id;
	private Integer rid;
	private Integer aid;

	// Constructors

	/** default constructor */
	public RelationRa() {
	}

	/** full constructor */
	public RelationRa(Integer rid, Integer aid) {
		this.rid = rid;
		this.aid = aid;
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

	@Column(name = "rid", nullable = false)
	public Integer getRid() {
		return this.rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	@Column(name = "aid", nullable = false)
	public Integer getAid() {
		return this.aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

}