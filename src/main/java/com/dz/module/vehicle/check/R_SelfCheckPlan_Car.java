package com.dz.module.vehicle.check;

import javax.persistence.*;

/**
 * @author doggy
 *         Created on 15-10-14.
 */
@Entity
@Table(name="R_SelfCheckPlan_Car",catalog = "ky_dzomsdb")
public class R_SelfCheckPlan_Car {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int rid;
    private String carId;
    private int planId;
    private boolean isPass = true;
    private String reason;

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public int getPlanId() {
        return planId;
    }

    public void setPlanId(int planId) {
        this.planId = planId;
    }

    public boolean isPass() {
        return isPass;
    }

    public void setIsPass(boolean isPass) {
        this.isPass = isPass;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
