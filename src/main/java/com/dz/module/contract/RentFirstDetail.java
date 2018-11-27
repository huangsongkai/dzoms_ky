package com.dz.module.contract;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.math.BigDecimal;

/**
 * Created by Wang on 2018/11/23.
 */
@Entity
public class RentFirstDetail {
    @Id
    private int contractId;

    private String begin_month;//由contractId获取
    private String end_month;//由contractId获取
    private String carNum;//由contractId获取
    private String dept;//由contractId获取
    private BigDecimal total_money;
    private long total_months;

    public RentFirstDetail(){

    }

    public RentFirstDetail(int contractId, String begin_month, String end_month, String carNum, String dept, Double total_money, long total_months) {
        this.contractId = contractId;
        this.begin_month = begin_month;
        this.end_month = end_month;
        this.carNum = carNum;
        this.dept = dept;
        this.total_money = BigDecimal.valueOf(total_money);
        this.total_months = total_months;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public String getBegin_month() {
        return begin_month;
    }

    public void setBegin_month(String begin_month) {
        this.begin_month = begin_month;
    }

    public String getEnd_month() {
        return end_month;
    }

    public void setEnd_month(String end_month) {
        this.end_month = end_month;
    }

    public String getCarNum() {
        return carNum;
    }

    public void setCarNum(String carNum) {
        this.carNum = carNum;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public BigDecimal getTotal_money() {
        return total_money;
    }

    public void setTotal_money(BigDecimal total_money) {
        this.total_money = total_money;
    }

    public long getTotal_months() {
        return total_months;
    }

    public void setTotal_months(long total_months) {
        this.total_months = total_months;
    }

    @Override
    public String toString() {
        return "RentFirstDetail{" +
                "contractId=" + contractId +
                ", begin_month='" + begin_month + '\'' +
                ", end_month='" + end_month + '\'' +
                ", carNum='" + carNum + '\'' +
                ", dept='" + dept + '\'' +
                ", total_money=" + total_money +
                ", total_months=" + total_months +
                '}';
    }
}
