package com.dz.module.charge;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="month_plan",catalog = "ky_dzomsdb")
public class MonthPlan {
    @Id
    @GeneratedValue
    private int id;
    @Column(name = "carframe_num")
    private String carframeNum;
//    @Column(name = "contract_id")
//    private int contractId;
    @Temporal(TemporalType.DATE)
    @Column(name="`time`")
    private Date time;

    @Column(name="plan_all")
    private BigDecimal planAll;

    @Column(name="arrear")
    private BigDecimal arrear;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

//    public int getContractId() {
//        return contractId;
//    }
//
//    public void setContractId(int contractId) {
//        this.contractId = contractId;
//    }


    public String getCarframeNum() {
        return carframeNum;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public BigDecimal getPlanAll() {
        return planAll;
    }

    public void setPlanAll(BigDecimal planAll) {
        this.planAll = planAll;
    }

    public BigDecimal getArrear() {
        return arrear;
    }

    public void setArrear(BigDecimal arrear) {
        this.arrear = arrear;
    }
}
