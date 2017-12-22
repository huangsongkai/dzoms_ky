package com.dz.module.driver;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table
public class QualificationMessageLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    /**
     * `id` int(11) NOT NULL AUTO_INCREMENT,
     `id_num` varchar(30) DEFAULT NULL COMMENT '身份证号',
     `phone_num` varchar(30) DEFAULT NULL,
     `send_time` datetime DEFAULT NULL,
     `context` varchar(255) DEFAULT NULL,
     `return_val` varchar(50) DEFAULT NULL,
     */
    @Column(length = 30)
    private String idNum;
    @Column(length = 30)
    private String phoneNum;
    @Temporal(TemporalType.TIMESTAMP)
    private Date sendTime;
    private String context;
    @Column(length = 50)
    private String returnVal;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIdNum() {
        return idNum;
    }

    public void setIdNum(String idNum) {
        this.idNum = idNum;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getReturnVal() {
        return returnVal;
    }

    public void setReturnVal(String returnVal) {
        this.returnVal = returnVal;
    }
}
