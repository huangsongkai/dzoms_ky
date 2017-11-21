package com.dz.kaiying.DTO;


public class SaveZuoTaoDTO implements java.io.Serializable {
	private String cph;
	private String employeeId;
	private SaveZuoTaoDetailDTO issueType;

	public String getCph() {
		return cph;
	}

	public void setCph(String cph) {
		this.cph = cph;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public SaveZuoTaoDetailDTO getIssueType() {
		return issueType;
	}

	public void setIssueType(SaveZuoTaoDetailDTO issueType) {
		this.issueType = issueType;
	}
}
