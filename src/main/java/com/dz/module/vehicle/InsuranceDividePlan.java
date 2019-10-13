package com.dz.module.vehicle;

import javax.persistence.*;

import java.math.BigDecimal;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "insurance_divide_plan", catalog = "ky_dzomsdb")
public class InsuranceDividePlan {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(unique = true, nullable = false)
    private int id;

    private int monthRank;
    private int type;
    @Column(precision = 10,scale = 2)
    private BigDecimal money;
    private int carCount;

    private String dept;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMonthRank() {
        return monthRank;
    }

    public void setMonthRank(int monthRank) {
        this.monthRank = monthRank;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    public int getCarCount() {
        return carCount;
    }

    public void setCarCount(int carCount) {
        this.carCount = carCount;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getDept() {
        return dept;
    }
}
