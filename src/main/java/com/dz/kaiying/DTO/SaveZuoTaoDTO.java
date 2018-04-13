package com.dz.kaiying.DTO;


import java.util.Date;

public class SaveZuoTaoDTO implements java.io.Serializable {
	private String cph;
	private String employeeId;
	private SaveZuoTaoDetailDTO issueType;
	private String createDate;

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

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
