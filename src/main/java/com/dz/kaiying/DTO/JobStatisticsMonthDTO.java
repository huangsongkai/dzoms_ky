package com.dz.kaiying.DTO;

public class JobStatisticsMonthDTO {
    String name;//名字
    String department;//部门
    KpScore kpScore;//考评分数
    String remarks;//备注

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public KpScore getKpScore() {
        return kpScore;
    }

    public void setKpScore(KpScore kpScore) {
        this.kpScore = kpScore;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Override
    public String toString() {
        return "JobStatisticsMonthDTO{" +
                "name='" + name + '\'' +
                ", department='" + department + '\'' +
                ", kpScore=" + kpScore +
                ", remarks='" + remarks + '\'' +
                '}';
    }
}
