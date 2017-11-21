package com.dz.module.charge;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author doggy
 *         Created on 15-11-24.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "bankrecordtmp")
public class BankRecordTmp {
    @Id
    @GeneratedValue
    private int id;
    private int fid;
    private String licenseNum;
    private String driverName;
    private BigDecimal money;
    @Temporal(TemporalType.DATE)
    private Date inTime;
    private String error;
    private String recorder;
    private Date recodeTime;
    /**
     * 0表示正常进入数据库，未进行任何处理
     * 1表示已经写入ChargePlan数据库
     * 2表示失败数据
     */
    private int status;
    private String bankCardNum;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    public Date getInTime() {
        return inTime;
    }

    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getRecorder() {
        return recorder;
    }

    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    public Date getRecodeTime() {
        return recodeTime;
    }

    public void setRecodeTime(Date recodeTime) {
        this.recodeTime = recodeTime;
    }

    public String getBankCardNum() {
        return bankCardNum;
    }

    public void setBankCardNum(String bankCardNum) {
        this.bankCardNum = bankCardNum;
    }

	public int getFid() {
		return fid;
	}

	public void setFid(int fid) {
		this.fid = fid;
	}
}
