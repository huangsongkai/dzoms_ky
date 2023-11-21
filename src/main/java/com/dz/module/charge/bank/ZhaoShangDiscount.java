package com.dz.module.charge.bank;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Table(catalog = "ky_dzomsdb")
public class ZhaoShangDiscount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(length = 30)
    private String yurref;
    @Column(length = 30)
    private String bankSeq;
    @Column
    private int states;//0-处理中 1-成功 2-部分成功 3-全部失败
    @Column(columnDefinition = "decimal(10,2)")
    private BigDecimal totalMoney;

    @Column(columnDefinition = "decimal(10,2)")
    private BigDecimal realMoney;

    @Column
    private int totalCount;

    @Column
    private int realCount;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date chargeTime;

    @OneToMany(targetEntity = BankItem.class,mappedBy = "zhaoShangDiscount",fetch = FetchType.EAGER)
    private List<BankItem> items;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getYurref() {
        return yurref;
    }

    public void setYurref(String yurref) {
        this.yurref = yurref;
    }

    public String getBankSeq() {
        return bankSeq;
    }

    public void setBankSeq(String bankSeq) {
        this.bankSeq = bankSeq;
    }

    public int getStates() {
        return states;
    }

    public void setStates(int states) {
        this.states = states;
    }

    public BigDecimal getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(BigDecimal totalMoney) {
        this.totalMoney = totalMoney;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public Date getChargeTime() {
        return chargeTime;
    }

    public void setChargeTime(Date chargeTime) {
        this.chargeTime = chargeTime;
    }

    public List<BankItem> getItems() {
        return items;
    }

    public void setItems(List<BankItem> items) {
        this.items = items;
    }

    public BigDecimal getRealMoney() {
        return realMoney;
    }

    public void setRealMoney(BigDecimal realMoney) {
        this.realMoney = realMoney;
    }

    public int getRealCount() {
        return realCount;
    }

    public void setRealCount(int realCount) {
        this.realCount = realCount;
    }
}
