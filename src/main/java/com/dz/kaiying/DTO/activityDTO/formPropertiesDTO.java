package com.dz.kaiying.DTO.activityDTO;
// default package

import java.util.List;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class formPropertiesDTO implements java.io.Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	private Integer id;
	private String name;
	private String assignee;
	private String time;
	private List<LocalVariableDetailDTO> localVariables;
	private List<FormPropertieDetailDTO> formProperties;


}