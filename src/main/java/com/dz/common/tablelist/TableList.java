package com.dz.common.tablelist;

// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * TableList entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "table_list", catalog = "ky_dzomsdb")
public class TableList implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6597646117761883205L;
	private Integer id;
	private String name;
	private Integer root;

	// Constructors

	/** default constructor */
	public TableList() {
	}

	/** full constructor */
	public TableList(String name, Integer root) {
		this.name = name;
		this.root = root;
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

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "root")
	public Integer getRoot() {
		return this.root;
	}

	public void setRoot(Integer root) {
		this.root = root;
	}

}