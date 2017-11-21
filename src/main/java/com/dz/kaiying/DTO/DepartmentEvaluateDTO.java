package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class DepartmentEvaluateDTO implements java.io.Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	private Integer id;
	private String proName;
	private String childProName;
	private Integer childProValue;
	private String jobResponsibility;
	private String jobStandard;
	private String complete;
	private String scoreStandard;
	private String[] inputs;
	private Integer ziping;
	private String evaluateName;

	public String getEvaluateName() {
		return evaluateName;
	}

	public void setEvaluateName(String evaluateName) {
		this.evaluateName = evaluateName;
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

	public Integer getChildProValue() {
		return childProValue;
	}

	public void setChildProValue(Integer childProValue) {
		this.childProValue = childProValue;
	}

	public String getJobResponsibility() {
		return jobResponsibility;
	}

	public void setJobResponsibility(String jobResponsibility) {
		this.jobResponsibility = jobResponsibility;
	}

	public String getJobStandard() {
		return jobStandard;
	}

	public void setJobStandard(String jobStandard) {
		this.jobStandard = jobStandard;
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

	public String[] getInputs() {
		return inputs;
	}

	public void setInputs(String[] inputs) {
		this.inputs = inputs;
	}

	public Integer getZiping() {
		return ziping;
	}

	public void setZiping(Integer ziping) {
		this.ziping = ziping;
	}
}