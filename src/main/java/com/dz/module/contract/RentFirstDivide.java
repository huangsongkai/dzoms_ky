package com.dz.module.contract;
// default package

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * Rentfirstdivide entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="rentfirstdivide"
        ,catalog="ky_dzomsdb"
)
public class RentFirstDivide  implements java.io.Serializable {


    /**
     *
     */
    private static final long serialVersionUID = 6657966888789624684L;
    // Fields
    private Integer id;
    private String carframeNum;
    private Date month;
    private BigDecimal money;
    private Integer register;
    private Date regTime;


    // Constructors

    /** default constructor */
    public RentFirstDivide() {
    }

    /** minimal constructor */
    public RentFirstDivide(Integer id) {
        this.id = id;
    }

    /** full constructor */
    public RentFirstDivide(Integer id, String carframeNum, Date month, BigDecimal money, Integer register, Date regTime) {
        this.id = id;
        this.carframeNum = carframeNum;
        this.month = month;
        this.money = money;
        this.register = register;
        this.regTime = regTime;
    }


    // Property accessors
    @Id
    @Column(name="id", unique=true, nullable=false)
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(name="carframeNum", length=30)
    public String getCarframeNum() {
        return this.carframeNum;
    }

    public void setCarframeNum(String carframeNum) {
        this.carframeNum = carframeNum;
    }

    @Temporal(TemporalType.DATE)
    @Column(name="month", length=0)
    public Date getMonth() {
        return this.month;
    }

    public void setMonth(Date month) {
        this.month = month;
    }

    @Column(name="money", precision=10, scale=2)
    public BigDecimal getMoney() {
        return this.money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    @Column(name="register")
    public Integer getRegister() {
        return this.register;
    }

    public void setRegister(Integer register) {
        this.register = register;
    }

    @Column(name="regTime")
    @Temporal(TemporalType.DATE)
    public Date getRegTime() {
        return this.regTime;
    }

    public void setRegTime(Date regTime) {
        this.regTime = regTime;
    }

}