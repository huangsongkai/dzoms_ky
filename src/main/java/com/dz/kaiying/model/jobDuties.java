package com.dz.kaiying.model;
// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "jobDuties", catalog = "dzomsdb")
public class jobDuties implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false, columnDefinition = "主键")
	private Integer id;

	@Column(name = "proName", unique = true, nullable = false, columnDefinition = "项目名")
	private String proName;

	@Column(name = "childProName", unique = true, nullable = false, columnDefinition = "子项目")
	private String childProName;

	@Column(name = "jobResponsibility", unique = true, nullable = false, columnDefinition = "工作职责")
	private String jobResponsibility;

	@Column(name = "complete", unique = true, nullable = false, columnDefinition = "完成情况")
	private String complete;

	@Column(name = "scoreStandard", unique = true, nullable = false, columnDefinition = "评分标准")
	private String scoreStandard;


	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getChildProName() {
		return childProName;
	}

	public void setChildProName(String childProName) {
		this.childProName = childProName;
	}

	public String getJobResponsibility() {
		return jobResponsibility;
	}

	public void setJobResponsibility(String jobResponsibility) {
		this.jobResponsibility = jobResponsibility;
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public String getScoreStandard() {
		return scoreStandard;
	}

	public void setScoreStandard(String scoreStandard) {
		this.scoreStandard = scoreStandard;
	}
}