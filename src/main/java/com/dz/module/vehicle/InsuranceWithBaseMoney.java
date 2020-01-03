package com.dz.module.vehicle;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import java.util.Date;

@Entity
@DiscriminatorValue("base_money")
public class InsuranceWithBaseMoney extends Insurance{
    private double baseMoney;

    public InsuranceWithBaseMoney() {
    }

    public InsuranceWithBaseMoney(Integer id, String insuranceClass, String carframeNum, String insuranceNum, String insuranceCompany,
                                  Double insuranceMoney, Date beginDate, Date endDate, Date signDate, String driverId, Integer register, Date registTime,
                                  String phone, String address, int state, double baseMoney) {
        super(id, insuranceClass, carframeNum, insuranceNum, insuranceCompany, insuranceMoney, beginDate, endDate, signDate, driverId, register, registTime, phone, address, state);
        this.baseMoney = baseMoney;
    }

    public InsuranceWithBaseMoney(Insurance insurance,Double baseMoney){
        super(insurance);
        this.baseMoney = baseMoney==null?0.0:baseMoney;
    }

    public double getBaseMoney() {
        return baseMoney;
    }

    public void setBaseMoney(double baseMoney) {
        this.baseMoney = baseMoney;
    }

    @Override
    public String toString() {
        return "InsuranceWithBaseMoney{" +
                "baseMoney=" + baseMoney +
                "} " + super.toString();
    }
}
