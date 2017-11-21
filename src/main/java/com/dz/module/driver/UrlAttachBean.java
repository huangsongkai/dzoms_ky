package com.dz.module.driver;

import java.util.Date;

/**
 * @author doggy
 *         Created on 16-5-19.
 */
public class UrlAttachBean implements Comparable<UrlAttachBean> {
    private String idNum;
    private String name;
    private String url;
    private String carNum;
    private Date applyTime;

    public UrlAttachBean(String idNum, String name, String url,String carNum,Date applyTime) {
        this.idNum = idNum;
        this.name = name;
        this.url = url;
        this.carNum = carNum;
        this.applyTime = applyTime;
    }

    public String getIdNum() {
        return idNum;
    }

    public void setIdNum(String idNum) {
        this.idNum = idNum;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCarNum() {
        return carNum;
    }

    public void setCarNum(String carNum) {
        this.carNum = carNum;
    }

    @Override
    public int compareTo(UrlAttachBean o) {
        return applyTime.compareTo(o.applyTime);
    }


}
