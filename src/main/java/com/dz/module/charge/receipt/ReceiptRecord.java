package com.dz.module.charge.receipt;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
@Entity
@Table(name = "`receiptrecord`",catalog = "ky_dzomsdb")
public class ReceiptRecord implements Comparable<ReceiptRecord>{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int id;
    //开始编号
    private int startNum;
    //结束编号
    private int endNum;
    //类型（进货还是出货）
    private String style;
    //车牌号
    private String carId;
    //承包人
    private String renter;
    //领购人
    private String taker;
    //时间
    @Temporal(TemporalType.DATE)
    private Date happenTime;
    //收据编号
    private String proveNum;
    //张数
    private int paperNum;
    //单价
    private BigDecimal price;
    //进货数量
    private int inNum;
    //销售数量
    private int soldNum;
    //总金额
    private double allPrice;
    //存储量
    private long storage;
    //备注
    private String comment;

    private String recorder;
    @Temporal(TemporalType.TIMESTAMP)
    private Date recordTime;
    
    private int year;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStartNum() {
        return startNum;
    }

    public void setStartNum(int startNum) {
        this.startNum = startNum;
    }

    public int getEndNum() {
        return endNum;
    }

    public void setEndNum(int endNum) {
        this.endNum = endNum;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getRenter() {
        return renter;
    }

    public void setRenter(String renter) {
        this.renter = renter;
    }

    public String getTaker() {
        return taker;
    }

    public void setTaker(String taker) {
        this.taker = taker;
    }

    public Date getHappenTime() {
        return happenTime;
    }

    public void setHappenTime(Date happenTime) {
        this.happenTime = happenTime;
    }

    public String getProveNum() {
        return proveNum;
    }

    public void setProveNum(String proveNum) {
        this.proveNum = proveNum;
    }

    public int getPaperNum() {
        return paperNum;
    }

    public void setPaperNum(int paperNum) {
        this.paperNum = paperNum;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getInNum() {
        return inNum;
    }

    public void setInNum(int inNum) {
        this.inNum = inNum;
    }

    public int getSoldNum() {
        return soldNum;
    }

    public void setSoldNum(int soldNum) {
        this.soldNum = soldNum;
    }

    public double getAllPrice() {
        return allPrice;
    }

    public void setAllPrice(double allPrice) {
        this.allPrice = allPrice;
    }


    public void setStorage(int storage) {
        this.storage = storage;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getRecorder() {
        return recorder;
    }

    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;

    }

    public long getStorage() {
        return storage;
    }

    public void setStorage(long storage) {
        this.storage = storage;
    }

    @Override
    public int compareTo(ReceiptRecord o) {
        if(this.getRecordTime().getTime() > o.getRecordTime().getTime())
            return 1;
        else if(this.getRecordTime().getTime() == o.getRecordTime().getTime())
            return 0;
        else
            return -1;

    }

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}
}
