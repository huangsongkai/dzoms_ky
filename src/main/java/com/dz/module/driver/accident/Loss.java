package com.dz.module.driver.accident;

import java.math.BigDecimal;

/**
 * @author doggy
 *         Created on 15-10-23.
 */
public class Loss {
    //车辆损失
    private BigDecimal carLoss;
    //车辆赔付
    private BigDecimal carPaid;
    //人员损失
    private BigDecimal peopleLoss;

    public BigDecimal getCarLoss() {
        return carLoss;
    }

    public void setCarLoss(BigDecimal carLoss) {
        this.carLoss = carLoss;
    }

    public BigDecimal getCarPaid() {
        return carPaid;
    }

    public void setCarPaid(BigDecimal carPaid) {
        this.carPaid = carPaid;
    }

    public BigDecimal getPeopleLoss() {
        return peopleLoss;
    }

    public void setPeopleLoss(BigDecimal peopleLoss) {
        this.peopleLoss = peopleLoss;
    }
}
