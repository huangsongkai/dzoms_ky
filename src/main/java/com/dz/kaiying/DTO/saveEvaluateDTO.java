package com.dz.kaiying.DTO;
// default package

import java.util.Map;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveEvaluateDTO implements java.io.Serializable {

	/**
	 *保存绩效考核DTO
	 */
	private Map<Integer, SaveEvaluateDetailDTO> selfEvaluate;
	private Map<Integer, SaveEvaluateDetailDTO> departmentEvaluate;
	private Map<Integer, SaveEvaluateDetailDTO> managerEvaluate;
	private Integer total;
	private String evaluateName;

	public Map<Integer, SaveEvaluateDetailDTO> getSelfEvaluate() {
		return selfEvaluate;
	}

	public void setSelfEvaluate(Map<Integer, SaveEvaluateDetailDTO> selfEvaluate) {
		this.selfEvaluate = selfEvaluate;
	}

	public Map<Integer, SaveEvaluateDetailDTO> getDepartmentEvaluate() {
		return departmentEvaluate;
	}

	public void setDepartmentEvaluate(Map<Integer, SaveEvaluateDetailDTO> departmentEvaluate) {
		this.departmentEvaluate = departmentEvaluate;
	}

	public Map<Integer, SaveEvaluateDetailDTO> getManagerEvaluate() {
		return managerEvaluate;
	}

	public void setManagerEvaluate(Map<Integer, SaveEvaluateDetailDTO> managerEvaluate) {
		this.managerEvaluate = managerEvaluate;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public String getEvaluateName() {
		return evaluateName;
	}

	public void setEvaluateName(String evaluateName) {
		this.evaluateName = evaluateName;
	}
}