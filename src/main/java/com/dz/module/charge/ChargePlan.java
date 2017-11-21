package com.dz.module.charge;

import com.dz.common.other.ObjectAccess;
import com.dz.module.contract.BankCard;
import com.dz.module.contract.Contract;
import org.joda.time.DateTime;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author doggy
 * Created on 15-11-8.
 */
@Entity
@Table(name="charge_plan",catalog = "ky_dzomsdb")
public class ChargePlan {
    @Id
    @GeneratedValue
    private int id;
    @ManyToOne
    private BatchPlan batchPlan;
    @Column(name = "contract_id")
    private int contractId;
    @Temporal(TemporalType.DATE)
    @Column(name="`time`")
    private Date time;
    /**
     * add_bank:银行回款
     * add_bank2 : 招商银行回款
     * add_insurance:保险回款
     * add_cash:现金回款
     * add_oil:油补回款
     * add_other:其他回款
     * sub_oil:油补取款
     * sub_insurance:保险取款
     *
     * plan_base_contract:合同基本费用
     * plan_add_insurance:保险费用+
     * plan_sub_insurance:保险费用-
     * plan_add_contract:合同费用+
     * plan_sub_contract:合同费用-
     * plan_add_other:其他费用+
     * plan_sub_other:其他费用-
     *
     * last_month_left
     */
    @Column(name="fee_type")
    private String feeType;
    @Column(name="fee")
    private BigDecimal fee;
    @Column(name = "`comment`")
    private String comment;
    private boolean isClear;
    @Temporal(TemporalType.TIMESTAMP)
    private Date inTime = new Date();
    private String register;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BatchPlan getBatchPlan() {
        return batchPlan;
    }

    public void setBatchPlan(BatchPlan batchPlan) {
        this.batchPlan = batchPlan;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    public BigDecimal getFee() {
        return fee;
    }

    public void setFee(BigDecimal fee) {
        this.fee = fee;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public boolean getIsClear() {
        return isClear;
    }

    public Date getInTime() {
        return inTime;
    }

    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }

    public String getRegister() {
        return register;
    }

    public void setRegister(String register) {
        this.register = register;
    }

    public void setIsClear(boolean isClear) {

        this.isClear = isClear;
    }

    public boolean isClear(){
        Contract c = (Contract)ObjectAccess.getObject("com.dz.module.contract.Contract",this.getContractId());
        ClearTime clearTime = ObjectAccess.execute("from ClearTime where department='"+c.getBranchFirm()+"'");
        Date cd = clearTime.getCurrent();
        DateTime dt = new DateTime(cd);
        DateTime now = new DateTime(time);
        return now.getYear()>dt.getYear()||(now.getYear()==dt.getYear()&&now.getMonthOfYear()>=dt.getMonthOfYear());
    }

}
