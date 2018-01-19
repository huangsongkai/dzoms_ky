package com.dz.kaiying.model;


import javax.persistence.*;
import java.util.Date;

import static com.ibm.media.codec.audio.g723.G723Tables.s;
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
    @Column(name = "sort_id")
    private int sortId;




    @Column(name = "self_inputs" )
    private String selfInputs;

    @Column(name = "self_score")
    private Double selfScore;

    @Column(name = "self_date")
    private Date selfDate;

    @Column(name = "self_total")
    private Double selfTotal;


    @Column(name = "manager_inputs" )
    private String managerInputs;

    @Column(name = "manager_score")
    private Double managerScore;

    @Column(name = "manager_date")
    private Date managerDate;
    @Column(name = "manager_total")
    private Double managerTotal;



    @Column(name = "group_inputs" )
    private String groupInputs;

    @Column(name = "group_score")
    private Double groupScore;

    @Column(name = "group_date")
    private Date groupDate;

    @Column(name = "group_total")
    private Double groupTotal;

    @Column(name = "remarks")
    private String remarks;



    @Column(name = "regect_self")
    private String regect_self;

    @Column(name = "regect_manager")
    private String regect_manager;

    @Column(name = "regect_group")
    private String regect_group;


    public String getRegect_self() {
        return regect_self;
    }

    public void setRegect_self(String regect_self) {
        this.regect_self = regect_self;
    }

    public String getRegect_manager() {
        return regect_manager;
    }

    public void setRegect_manager(String regect_manager) {
        this.regect_manager = regect_manager;
    }

    public String getRegect_group() {
        return regect_group;
    }

    public void setRegect_group(String regect_group) {
        this.regect_group = regect_group;
    }

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

    public Double getSelfScore() {
        return selfScore;
    }

    public void setSelfScore(Double selfScore) {
        this.selfScore = selfScore;
    }

    public Date getSelfDate() {
        return selfDate;
    }

    public void setSelfDate(Date selfDate) {
        this.selfDate = selfDate;
    }

    public Double getSelfTotal() {
        return selfTotal;
    }

    public void setSelfTotal(Double selfTotal) {
        this.selfTotal = selfTotal;
    }

    public String getManagerInputs() {
        return managerInputs;
    }

    public void setManagerInputs(String managerInputs) {
        this.managerInputs = managerInputs;
    }

    public Double getManagerScore() {
        return managerScore;
    }

    public void setManagerScore(Double managerScore) {
        this.managerScore = managerScore;
    }

    public Date getManagerDate() {
        return managerDate;
    }

    public void setManagerDate(Date managerDate) {
        this.managerDate = managerDate;
    }

    public Double getManagerTotal() {
        return managerTotal;
    }

    public void setManagerTotal(Double managerTotal) {
        this.managerTotal = managerTotal;
    }

    public String getGroupInputs() {
        return groupInputs;
    }

    public void setGroupInputs(String groupInputs) {
        this.groupInputs = groupInputs;
    }

    public Double getGroupScore() {
        return groupScore;
    }

    public void setGroupScore(Double groupScore) {
        this.groupScore = groupScore;
    }

    public Date getGroupDate() {
        return groupDate;
    }

    public void setGroupDate(Date groupDate) {
        this.groupDate = groupDate;
    }

    public Double getGroupTotal() {
        return groupTotal;
    }

    public void setGroupTotal(Double groupTotal) {
        this.groupTotal = groupTotal;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public int getSortId() {
        return sortId;
    }

    public void setSortId(int sortId) {
        this.sortId = sortId;
    }

}