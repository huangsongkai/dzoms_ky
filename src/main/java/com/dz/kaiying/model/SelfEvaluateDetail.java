package com.dz.kaiying.model;


import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

//用户自评主表
@Entity
@Table(name = "ky_self_evaluate_detail", catalog = "ky_dzomsdb")
public class SelfEvaluateDetail implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id" )
    private Integer id;

    @Column(name = "job_duty_id" )
    private Integer jobDutyId;

    @Column(name = "self_evaluate_id" )
    private Integer selfEvaluateId;

    @Column(name = "inputs" )
    private String inputs;

    @Column(name = "score")
    private int Score;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSelfEvaluateId() {
        return selfEvaluateId;
    }

    public void setSelfEvaluateId(Integer selfEvaluateId) {
        this.selfEvaluateId = selfEvaluateId;
    }

    public String getInputs() {
        return inputs;
    }

    public void setInputs(String inputs) {
        this.inputs = inputs;
    }

    public int getScore() {
        return Score;
    }

    public void setScore(int score) {
        Score = score;
    }

    public Integer getJobDutyId() {
        return jobDutyId;
    }

    public void setJobDutyId(Integer jobDutyId) {
        this.jobDutyId = jobDutyId;
    }
}