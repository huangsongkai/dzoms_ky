package com.dz.kaiying.DTO;
// default package

import java.util.Map;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveDepartmentEvaluateDTO implements java.io.Serializable {

	/**
	 *部门评价DTO
	 */
	private Map<Integer, Integer> departmentEvaluate;
	private Integer total;
	private String evaluateName;

	public String getEvaluateName() {
		return evaluateName;
	}

	public void setEvaluateName(String evaluateName) {
		this.evaluateName = evaluateName;
	}

	public Map<Integer, Integer> getDepartmentEvaluate() {
		return departmentEvaluate;
	}

	public void setDepartmentEvaluate(Map<Integer, Integer> departmentEvaluate) {
		this.departmentEvaluate = departmentEvaluate;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}
	//	{
//			"personId":123
//			"total":100
//			"departmentEvaluate": [
//		{
//			"id": 1,
//			"score": 10
//		}
//		]
//	}





}