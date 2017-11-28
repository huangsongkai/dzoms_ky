package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveManagerEvaluateDetailDTO implements java.io.Serializable {

	/**
	 *工作自评DTO
	 */
	private Integer score;
	private String remark;

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}