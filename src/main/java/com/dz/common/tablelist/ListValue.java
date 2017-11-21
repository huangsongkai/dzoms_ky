package com.dz.common.tablelist;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * ListValue entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "list_value", catalog = "ky_dzomsdb")
public class ListValue implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -5915440808382769189L;
	private Integer id;
	private String value;
	private Integer fid;
	private Boolean visible;

	// Constructors

	/** default constructor */
	public ListValue() {
	}

	/** full constructor */
	public ListValue(String value, Integer fid, Boolean visible) {
		this.value = value;
		this.fid = fid;
		this.visible = visible;
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

	@Column(name = "value")
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(name = "fid")
	public Integer getFid() {
		return this.fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	@Column(name = "visible")
	public Boolean getVisible() {
		return this.visible;
	}

	public void setVisible(Boolean visible) {
		this.visible = visible;
	}

}