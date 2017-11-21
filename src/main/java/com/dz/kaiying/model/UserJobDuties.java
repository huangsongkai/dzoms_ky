package com.dz.kaiying.model;


import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_user_duties", catalog = "ky_dzomsdb")
public class UserJobDuties implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id" )
	private Integer id;

	@Column(name = "job_duties_id")
	private Integer jobDutiesId;

	@Column(name = "score")
	private Integer score;

	@Column(name = "person_id")
	private Integer personId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getJobDutiesId() {
		return jobDutiesId;
	}

	public void setJobDutiesId(Integer jobDutiesId) {
		this.jobDutiesId = jobDutiesId;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}
}