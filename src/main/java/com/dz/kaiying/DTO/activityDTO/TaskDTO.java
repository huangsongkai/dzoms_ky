package com.dz.kaiying.DTO.activityDTO;
// default package

import java.util.Date;
import java.util.List;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class TaskDTO implements java.io.Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	private Integer id;
	private String name;
	private String assignee;
	private Date time;
	private List<LocalVariableDetailDTO> localVariables;
	private List<FormPropertieDetailDTO> formProperties;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAssignee() {
		return assignee;
	}

	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public List<LocalVariableDetailDTO> getLocalVariables() {
		return localVariables;
	}

	public void setLocalVariables(List<LocalVariableDetailDTO> localVariables) {
		this.localVariables = localVariables;
	}

	public List<FormPropertieDetailDTO> getFormProperties() {
		return formProperties;
	}

	public void setFormProperties(List<FormPropertieDetailDTO> formProperties) {
		this.formProperties = formProperties;
	}
}