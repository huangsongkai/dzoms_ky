package com.dz.module.charge.insurance;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

//保险回款
@Entity
@Table(name = "insurance_back")
public class InsuranceBack {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private int id;
    @Column(name = "carframe_num",length = 30)
    private String carframeNum;
    @Column(name = "car_num",length = 30)
    private String carNum;
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;
    private String attachment;
    @Column(scale = 2)
    private BigDecimal amount;
    @Column(name = "receipt_id",length = 30)
    private String receiptId;

    private int state;// 0 -- 未处理  正数 -- 对应的chargeId   -1 -- 匹配失败及错误号

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

    public String getCarNum() {
        return carNum;
    }

    public void setCarNum(String carNum) {
        this.carNum = carNum;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getReceiptId() {
        return receiptId;
    }

    public void setReceiptId(String receiptId) {
        this.receiptId = receiptId;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
