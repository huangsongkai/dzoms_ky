package com.dz.kaiying.model;



import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_job_duty", catalog = "ky_dzomsdb")
public class JobDuty implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id" )
    private Integer id;

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

    @Column(name = "job_department")
    private String department;


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

    public String getJobStandard() {
        return jobStandard;
    }

    public void setJobStandard(String jobStandard) {
        this.jobStandard = jobStandard;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
}