package com.dz.kaiying.DTO;
// default package

import java.util.Map;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveManagerEvaluateDTO implements java.io.Serializable {

	/**
	 *工作自评DTO
	 */
	private Map<Integer, SaveManagerEvaluateDetailDTO> managerEvaluate;
	private Integer total;
	private String evaluateName;

	public String getEvaluateName() {
		return evaluateName;
	}

	public void setEvaluateName(String evaluateName) {
		this.evaluateName = evaluateName;
	}

	public Integer getTotal() {

		return total;
	}

	public Map<Integer, SaveManagerEvaluateDetailDTO> getManagerEvaluate() {
		return managerEvaluate;
	}

	public void setManagerEvaluate(Map<Integer, SaveManagerEvaluateDetailDTO> managerEvaluate) {
		this.managerEvaluate = managerEvaluate;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}
	//	{
//			"total":100
//			"selfEvaluate": [
//		{
//			"id": 1,
//				"inputs": [
//			"1",
//					"2"
//			],
//			"score": 1
//		}
//		]
//	}





}