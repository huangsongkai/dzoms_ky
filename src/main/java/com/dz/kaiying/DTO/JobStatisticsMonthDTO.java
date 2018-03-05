package com.dz.kaiying.DTO;

public class JobStatisticsMonthDTO {
    String name;
    String department;
    KpScore kpScore;
    String remarks;

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
}
