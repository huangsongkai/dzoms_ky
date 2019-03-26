package com.dz.module.charge;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity
public class BaseChargeItem implements java.io.Serializable {
    @Id
    private int contractId;
    private BigDecimal planBase;
    private String carNumber;
    private String dept;
    private String planList;

    public BaseChargeItem() {
    }

    public BaseChargeItem(int contractId, BigDecimal planBase, String carNumber, String dept, String planList) {
        this.contractId = contractId;
        this.planBase = planBase;
        this.carNumber = carNumber;
        this.dept = dept;
        this.planList = planList;
    }

    public BaseChargeItem(int contractId, double planBase, String carNumber, String dept, String planList) {
        this.contractId = contractId;
        this.planBase = BigDecimal.valueOf(planBase);
        this.carNumber = carNumber;
        this.dept = dept;
        this.planList = planList;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public BigDecimal getPlanBase() {
        return planBase;
    }

    public void setPlanBase(BigDecimal planBase) {
        this.planBase = planBase;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getPlanList() {
        return planList;
    }

    public void setPlanList(String planList) {
        this.planList = planList;
    }
}
