package com.dz.module.charge.jiaotong;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "jiaotong_bankrecord", catalog = "ky_dzomsdb")
public class JiaoTongBankRecord {

    @Id
    @Column(name = "order_no", unique = true, nullable = false, length = 30)
    private String orderNo;
    @Column(name = "car_no", length = 30)
    private String carNo;

    @Column(name = "carframe_num", length = 30)
    public String carframeNum;

    private int month;
    private BigDecimal amount;

    private String comment;

    private String reason;

    private short state;

    @Column(name = "charge_id")
    private int chargeId;

    public JiaoTongBankRecord() {

    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getCarNo() {
        return carNo;
    }

    public void setCarNo(String carNo) {
        this.carNo = carNo;
    }

    public String getCarframeNum() {
        return carframeNum;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public short getState() {
        return state;
    }

    public void setState(short state) {
        this.state = state;
    }

    public int getChargeId() {
        return chargeId;
    }

    public void setChargeId(int chargeId) {
        this.chargeId = chargeId;
    }
}
