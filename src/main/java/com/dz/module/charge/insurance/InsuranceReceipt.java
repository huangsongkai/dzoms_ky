package com.dz.module.charge.insurance;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "insurance_receipt")
public class InsuranceReceipt implements Serializable {
//    @Id
//    @GeneratedValue(strategy=GenerationType.IDENTITY)
//    private int id;

    @Id
    @Column(name = "receipt_id",length = 30,nullable = false)
    private String receiptId;

    private String attachment;
    @Temporal(TemporalType.DATE)
    private Date timestamp;
    @Column(scale = 2)
    private BigDecimal amount;

    private int state;// 0 -- 未处理  正数 -- 对应的InsuranceBack.id   -1 -- 匹配失败及错误号

    public String getReceiptId() {
        return receiptId;
    }

    public void setReceiptId(String receiptId) {
        this.receiptId = receiptId;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "InsuranceReceipt{" +
                "receiptId='" + receiptId + '\'' +
                ", attachment='" + attachment + '\'' +
                ", timestamp=" + timestamp +
                ", amount=" + amount +
                ", state=" + state +
                '}';
    }
}
