package com.dz.kaiying.DTO;

public class QueryEvaluateDTO implements java.io.Serializable {

	private Integer id;// 工作职责表id
	private String proName;
	private String childProName;
	private Double childProValue;
	private String jobResponsibility;
	private String jobStandard;
	private String scoreStandard;
	private String evaluateName;
	private String complete;
	private String reason;
	private String remarks;


	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	private String taskId;

	private SaveEvaluateDetailDTO personal;
	private SaveEvaluateDetailDTO bumen;
	private SaveEvaluateDetailDTO kpgroup;

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
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

	public Double getChildProValue() {
		return childProValue;
	}

	public void setChildProValue(Double childProValue) {
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

	public String getScoreStandard() {
		return scoreStandard;
	}

	public void setScoreStandard(String scoreStandard) {
		this.scoreStandard = scoreStandard;
	}

	public String getEvaluateName() {
		return evaluateName;
	}

	public void setEvaluateName(String evaluateName) {
		this.evaluateName = evaluateName;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public SaveEvaluateDetailDTO getPersonal() {
		return personal;
	}

	public void setPersonal(SaveEvaluateDetailDTO personal) {
		this.personal = personal;
	}

	public SaveEvaluateDetailDTO getBumen() {
		return bumen;
	}

	public void setBumen(SaveEvaluateDetailDTO bumen) {
		this.bumen = bumen;
	}

	public SaveEvaluateDetailDTO getKpgroup() {
		return kpgroup;
	}

	public void setKpgroup(SaveEvaluateDetailDTO kpgroup) {
		this.kpgroup = kpgroup;
	}
}