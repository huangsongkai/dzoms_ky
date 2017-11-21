package com.dz.kaiying.DTO;


import java.util.Map;

public class SaveUserJobDutyDTO implements java.io.Serializable {
	private Map<Integer, String> jobList;

	private Integer personId;

	public Map<Integer, String> getJobList() {
		return jobList;
	}

	public void setJobList(Map<Integer, String> jobList) {
		this.jobList = jobList;
	}

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

}
