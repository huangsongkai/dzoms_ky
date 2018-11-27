package com.dz.module.contract;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.math.BigDecimal;

/**
 * Created by Wang on 2018/11/23.
 */
@Entity
public class RentFirstAnaylse extends RentFirstDetail {
    public RentFirstAnaylse(){

    }

    public RentFirstAnaylse(int contractId, String begin_month, String end_month, String carNum, String dept, Double total_money, long total_months, long finsh_months, BigDecimal current_account, BigDecimal finsh_account) {
        super(contractId, begin_month, end_month, carNum, dept, total_money, total_months);
        this.finsh_months = finsh_months;
        this.current_account = current_account;
        this.finsh_account = finsh_account;
    }

    private long finsh_months;//已摊销月数
    private BigDecimal current_account;//本期摊销额
    private BigDecimal finsh_account;//累计摊销额

    public long getFinsh_months() {
        return finsh_months;
    }

    public void setFinsh_months(long finsh_months) {
        this.finsh_months = finsh_months;
    }

    public BigDecimal getCurrent_account() {
        return current_account;
    }

    public void setCurrent_account(BigDecimal current_account) {
        this.current_account = current_account;
    }

    public BigDecimal getFinsh_account() {
        return finsh_account;
    }

    public void setFinsh_account(BigDecimal finsh_account) {
        this.finsh_account = finsh_account;
    }

    @Override
    public String toString() {
        return "RentFirstAnaylse{" +
                super.toString()+
                "finsh_months=" + finsh_months +
                ", current_account=" + current_account +
                ", finsh_account=" + finsh_account +
                '}';
    }
}
