package com.dz.module.charge;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.math.BigDecimal;

public class ChargePlanCompareCheck {
    private CheckChargeTable current;
    private CheckChargeTable compareTo;
    private BigDecimal contractPlanAmount;
    private BigDecimal baseChargeAmount;

    public ChargePlanCompareCheck() {
    }

    public CheckChargeTable getCurrent() {
        return current;
    }

    public void setCurrent(CheckChargeTable current) {
        this.current = current;
    }

    public CheckChargeTable getCompareTo() {
        return compareTo;
    }

    public void setCompareTo(CheckChargeTable compareTo) {
        this.compareTo = compareTo;
    }

    public BigDecimal getContractPlanAmount() {
        return contractPlanAmount;
    }

    public void setContractPlanAmount(BigDecimal contractPlanAmount) {
        this.contractPlanAmount = contractPlanAmount;
    }

    public BigDecimal getBaseChargeAmount() {
        return baseChargeAmount;
    }

    public void setBaseChargeAmount(BigDecimal baseChargeAmount) {
        this.baseChargeAmount = baseChargeAmount;
    }

}
