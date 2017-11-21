package com.dz.kaiying.DTO;
// default package

import java.util.Map;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveSelfEvaluateDTO implements java.io.Serializable {

	/**
	 *工作自评DTO
	 */
	//private List<SaveSelfEvaluateDetailDTO> selfEvaluate;

	private Map<Integer, SaveSelfEvaluateDetailDTO> selfEvaluate;
	private Integer total;
	private String evaluateName;
	public Map<Integer, SaveSelfEvaluateDetailDTO> getSelfEvaluate() {
		return selfEvaluate;
	}

	public void setSelfEvaluate(Map<Integer, SaveSelfEvaluateDetailDTO> selfEvaluate) {
		this.selfEvaluate = selfEvaluate;
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