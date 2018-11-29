package com.dz.module.vehicle;

import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;

import java.io.Serializable;

/**
 * Created by Wang on 2018/11/27.
 */
@Entity
public class InsuranceDivide {
    @EmbeddedId
    private InsuranceDivideID id;

    private String month;
    private String insuranceClass;
    private String carframeNum;
    private String insuranceNum;
    private Double money;
    private Double divideMoney;

    @Embeddable
    public static class InsuranceDivideID implements Serializable {
        private int monthRank;
        private int insuranceId;

        public int getMonthRank() {
            return monthRank;
        }

        public void setMonthRank(int monthRank) {
            this.monthRank = monthRank;
        }

        public int getInsuranceId() {
            return insuranceId;
        }

        public void setInsuranceId(int insuranceId) {
            this.insuranceId = insuranceId;
        }
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getInsuranceClass() {
        return insuranceClass;
    }

    public void setInsuranceClass(String insuranceClass) {
        this.insuranceClass = insuranceClass;
    }

    public String getCarframeNum() {
        return carframeNum;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    public String getInsuranceNum() {
        return insuranceNum;
    }

    public void setInsuranceNum(String insuranceNum) {
        this.insuranceNum = insuranceNum;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Double getDivideMoney() {
        return divideMoney;
    }

    public void setDivideMoney(Double divideMoney) {
        this.divideMoney = divideMoney;
    }

    public InsuranceDivideID getId() {
        return id;
    }

    public void setId(InsuranceDivideID id) {
        this.id = id;
    }

    public InsuranceDivide(){}

    public InsuranceDivide(int monthRank,int insuranceId, String month, String insuranceClass, String carframeNum, String insuranceNum, Double money, Double divideMoney) {
        this.id = new InsuranceDivideID();
        this.id.setMonthRank(monthRank);
        this.id.setInsuranceId(insuranceId);
        this.month = month;
        this.insuranceClass = insuranceClass;
        this.carframeNum = carframeNum;
        this.insuranceNum = insuranceNum;
        this.money = money;
        this.divideMoney = divideMoney;
    }
}


