package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SelfEvaluateDTO implements java.io.Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	private Integer id;
	private Integer key;
	private String proName;
	private String childProName;
	private Integer childProValue;
	private String jobResponsibility;
	private String complete;
	private String scoreStandard;
	private String jobStandard;
	private String evaluateName;

	public String getEvaluateName() {
		return evaluateName;
	}

	public void setEvaluateName(String evaluateName) {
		this.evaluateName = evaluateName;
	}

	public Integer getChildProValue() {
		return childProValue;
	}

	public void setChildProValue(Integer childProValue) {
		this.childProValue = childProValue;
	}

	public String getJobStandard() {
		return jobStandard;
	}

	public void setJobStandard(String jobStandard) {
		this.jobStandard = jobStandard;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getKey() {
		return key;
	}

	public void setKey(Integer key) {
		this.key = key;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getChildProName() {
		return childProName;
	}

	public void setChildProName(String childProName) {
		this.childProName = childProName;
	}

	public String getJobResponsibility() {
		return jobResponsibility;
	}

	public void setJobResponsibility(String jobResponsibility) {
		this.jobResponsibility = jobResponsibility;
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public String getScoreStandard() {
		return scoreStandard;
	}

	public void setScoreStandard(String scoreStandard) {
		this.scoreStandard = scoreStandard;
	}


}