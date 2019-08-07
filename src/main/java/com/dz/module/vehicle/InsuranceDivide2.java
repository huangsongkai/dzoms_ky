package com.dz.module.vehicle;

import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * Created by Wang on 2018/11/27.
 */
@Entity
@Table(name = "insurance_divide",catalog = "ky_dzomsdb")
public class InsuranceDivide2 {
    @EmbeddedId
    private InsuranceDivideID id;
    private String carframeNum;
    private Double money;

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

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public InsuranceDivideID getId() {
        return id;
    }

    public void setId(InsuranceDivideID id) {
        this.id = id;
    }

    public InsuranceDivide2(){}

    public InsuranceDivide2(int monthRank, int insuranceId, Double money) {
        this.id = new InsuranceDivideID();
        this.id.setMonthRank(monthRank);
        this.id.setInsuranceId(insuranceId);
        this.money = money;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    public String getCarframeNum() {
        return carframeNum;
    }
}


