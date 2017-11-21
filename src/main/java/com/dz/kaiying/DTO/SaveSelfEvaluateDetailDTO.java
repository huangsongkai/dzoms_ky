package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveSelfEvaluateDetailDTO implements java.io.Serializable {

	/**
	 *工作自评DTO
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	//private Integer id;
	private String[]inputs;
	private Integer score;


	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String[] getInputs() {
		return inputs;
	}

	public void setInputs(String[] inputs) {
		this.inputs = inputs;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

}