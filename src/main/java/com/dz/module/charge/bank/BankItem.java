package com.dz.module.charge.bank;

import com.dz.module.contract.Contract;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(catalog = "ky_dzomsdb")
public class BankItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne(cascade=CascadeType.ALL)
    private ZhaoShangDiscount zhaoShangDiscount;
    @ManyToOne(cascade=CascadeType.ALL)
    private Contract contract;

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date applyTime;

    @Column
    private BigDecimal planFee;

    @Temporal(TemporalType.TIMESTAMP)
    @Column
    private Date realTime;

    @Column
    private BigDecimal realFee;

    @Temporal(TemporalType.DATE)
    private Date forTime;

    @Column(length = 30)
    private String register;

    /**
     *  0 A：待处理
     *  1 C： 取消（ 代发） 撤销 （代扣）
     *  2 E：失败
     *  3 I: 待复核
     *  4 S: 成功
     */
    private int state;

    @Column(length = 30)
    private String cardNumber;

    @Column(length = 100)
    private String comment;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ZhaoShangDiscount getZhaoShangDiscount() {
        return zhaoShangDiscount;
    }

    public void setZhaoShangDiscount(ZhaoShangDiscount zhaoShangDiscount) {
        this.zhaoShangDiscount = zhaoShangDiscount;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public Date getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(Date applyTime) {
        this.applyTime = applyTime;
    }

    public BigDecimal getPlanFee() {
        return planFee;
    }

    public void setPlanFee(BigDecimal planFee) {
        this.planFee = planFee;
    }

    public Date getRealTime() {
        return realTime;
    }

    public void setRealTime(Date realTime) {
        this.realTime = realTime;
    }

    public BigDecimal getRealFee() {
        return realFee;
    }

    public void setRealFee(BigDecimal realFee) {
        this.realFee = realFee;
    }

    public Date getForTime() {
        return forTime;
    }

    public void setForTime(Date forTime) {
        this.forTime = forTime;
    }

    public String getRegister() {
        return register;
    }

    public void setRegister(String register) {
        this.register = register;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
