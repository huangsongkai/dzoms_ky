package com.dz.kaiying.DTO;


import java.util.List;

public class ListHistoryDTO implements java.io.Serializable {



	private Integer personId;
	private String personName;
	private List<ListHistory1DTO> detail;
	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public List<ListHistory1DTO> getDetail() {
		return detail;
	}

	public void setDetail(List<ListHistory1DTO> detail) {
		this.detail = detail;
	}
}
