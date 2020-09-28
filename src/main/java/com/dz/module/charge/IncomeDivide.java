package com.dz.module.charge;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="income_divide",catalog = "ky_dzomsdb")
public class IncomeDivide {//income_divide
    @Id
    @GeneratedValue
    private int id;

    @Column(name = "month_plan_id")
    private int monthPlanId;

    @Column(name = "income_id")
    private int incomeId;

    @Column(name="amount")
    private BigDecimal amount;

    @Column(name = "type")
    private int type;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMonthPlanId() {
        return monthPlanId;
    }

    public void setMonthPlanId(int monthPlanId) {
        this.monthPlanId = monthPlanId;
    }

    public int getIncomeId() {
        return incomeId;
    }

    public void setIncomeId(int incomeId) {
        this.incomeId = incomeId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
