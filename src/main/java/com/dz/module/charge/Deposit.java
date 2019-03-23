package com.dz.module.charge;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author ghode
 * Created on 18-11-20.
 */
@Entity
//@Table(catalog = "ky_dzomsdb", name = "deposit")
public class Deposit implements Serializable {
    @Id
    @GeneratedValue
    @Column(name = "`id`")
    private int id;

    @Column(name = "carframe_num")
    private String carframeNum;
    @Column(name = "id_num")
    private String idNum;
    @Column(name = "in_money")
    private double inMoney;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "in_date")
    private Date inDate;
    @Column(name = "back_money")
    private double backMoney;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "back_date")
    private Date backDate;
    @Column(name = "deposit_id")
    private String depositId;
    @Column(name = "u_name_in")
    private String uNameIn;
    @Column(name = "u_name_back")
    private String uNameBack;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCarframeNum() {
        return carframeNum;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    public String getIdNum() {
        return idNum;
    }

    public void setIdNum(String idNum) {
        this.idNum = idNum;
    }

    public double getInMoney() {
        return inMoney;
    }

    public void setInMoney(double inMoney) {
        this.inMoney = inMoney;
    }

    public Date getInDate() {
        return inDate;
    }

    public void setInDate(Date inDate) {
        this.inDate = inDate;
    }

    public double getBackMoney() {
        return backMoney;
    }

    public void setBackMoney(double backMoney) {
        this.backMoney = backMoney;
    }

    public Date getBackDate() {
        return backDate;
    }

    public void setBackDate(Date backDate) {
        this.backDate = backDate;
    }

    public String getDepositId() {
        return depositId;
    }

    public String getuNameIn() {
        return uNameIn;
    }

    public void setuNameIn(String uNameIn) {
        this.uNameIn = uNameIn;
    }

    public String getuNameBack() {
        return uNameBack;
    }

    public void setuNameBack(String uNameBack) {
        this.uNameBack = uNameBack;
    }

    public void setDepositId(String depositId) {
        this.depositId = depositId;
    }


}
