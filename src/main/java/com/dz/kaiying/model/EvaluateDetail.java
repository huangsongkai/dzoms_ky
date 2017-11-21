package com.dz.kaiying.model;


import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_evaluate_detail", catalog = "ky_dzomsdb")
public class EvaluateDetail implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id" )
    private Integer id;

    @Column(name = "job_duty_id" )
    private Integer jobDutyId;// 工作职责表id

    @Column(name = "person_id")//人的id
    private Integer personId;

    @Column(name = "evaluate_name" )
    private String evaluateName; //考评名称



    @Column(name = "pro_name")
    private String proName;

    @Column(name = "child_proName")
    private String childProName;

    @Column(name = "job_responsibility")
    private String jobResponsibility;

    @Column(name = "complete")
    private String complete;

    @Column(name = "score_standard")
    private String scoreStandard;

    @Column(name = "job_standard")
    private String jobStandard;

    @Column(name = "self_inputs" )
    private String selfInputs;

    @Column(name = "self_score")
    private int selfScore;

    @Column(name = "self_date")
    private Date selfDate;

    @Column(name = "self_total")
    private Double selfTotal;


    @Column(name = "manager_inputs" )
    private String managerInputs;

    @Column(name = "manager_score")
    private int managerScore;

    @Column(name = "manager_date")
    private Date managerDate;
    @Column(name = "manager_total")
    private Double managerTotal;



    @Column(name = "group_inputs" )
    private String groupInputs;

    @Column(name = "group_score")
    private int groupScore;

    @Column(name = "group_date")
    private Date groupDate;

    @Column(name = "group_total")
    private Double groupTotal;

    @Column(name = "group_remark")
    private String remark;



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getJobDutyId() {
        return jobDutyId;
    }

    public void setJobDutyId(Integer jobDutyId) {
        this.jobDutyId = jobDutyId;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public String getEvaluateName() {
        return evaluateName;
    }

    public void setEvaluateName(String evaluateName) {
        this.evaluateName = evaluateName;
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

    public String getJobStandard() {
        return jobStandard;
    }

    public void setJobStandard(String jobStandard) {
        this.jobStandard = jobStandard;
    }

    public String getSelfInputs() {
        return selfInputs;
    }

    public void setSelfInputs(String selfInputs) {
        this.selfInputs = selfInputs;
    }

    public int getSelfScore() {
        return selfScore;
    }

    public void setSelfScore(int selfScore) {
        this.selfScore = selfScore;
    }

    public Date getSelfDate() {
        return selfDate;
    }

    public void setSelfDate(Date selfDate) {
        this.selfDate = selfDate;
    }

    public String getManagerInputs() {
        return managerInputs;
    }

    public void setManagerInputs(String managerInputs) {
        this.managerInputs = managerInputs;
    }

    public int getManagerScore() {
        return managerScore;
    }

    public void setManagerScore(int managerScore) {
        this.managerScore = managerScore;
    }

    public Date getManagerDate() {
        return managerDate;
    }

    public void setManagerDate(Date managerDate) {
        this.managerDate = managerDate;
    }

    public String getGroupInputs() {
        return groupInputs;
    }

    public void setGroupInputs(String groupInputs) {
        this.groupInputs = groupInputs;
    }

    public int getGroupScore() {
        return groupScore;
    }

    public void setGroupScore(int groupScore) {
        this.groupScore = groupScore;
    }

    public Date getGroupDate() {
        return groupDate;
    }

    public void setGroupDate(Date groupDate) {
        this.groupDate = groupDate;
    }

    public Double getSelfTotal() {
        return selfTotal;
    }

    public void setSelfTotal(Double selfTotal) {
        this.selfTotal = selfTotal;
    }

    public Double getManagerTotal() {
        return managerTotal;
    }

    public void setManagerTotal(Double managerTotal) {
        this.managerTotal = managerTotal;
    }

    public Double getGroupTotal() {
        return groupTotal;
    }

    public void setGroupTotal(Double groupTotal) {
        this.groupTotal = groupTotal;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}