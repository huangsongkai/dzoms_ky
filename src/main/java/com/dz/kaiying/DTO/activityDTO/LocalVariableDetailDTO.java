package com.dz.kaiying.DTO.activityDTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class LocalVariableDetailDTO implements java.io.Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	private String name;
	private Integer value;
	private String scope;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}
}