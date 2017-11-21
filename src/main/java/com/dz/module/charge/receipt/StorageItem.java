package com.dz.module.charge.receipt;

import com.dz.module.charge.receipt.util.CountPass;

import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 16-3-6.
 */
public class StorageItem {
    //数量以及开始结束编号
    private List<CountPass> countPasses;
    private String proveNum;
    private Date recordTime;
    private String recorder;

    public List<CountPass> getCountPasses() {
        return countPasses;
    }

    public void setCountPasses(List<CountPass> countPasses) {
        this.countPasses = countPasses;
    }

    public String getProveNum() {
        return proveNum;
    }

    public void setProveNum(String proveNum) {
        this.proveNum = proveNum;
    }

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    public String getRecorder() {
        return recorder;
    }

    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }
}
