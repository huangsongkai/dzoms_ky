package com.dz.module.charge;

import com.dz.module.contract.Contract;
import com.dz.module.contract.ContractDao;
import com.dz.module.contract.ContractDaoImpl;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-11-8.
 */
@Entity
@Table(name="batchplan",catalog = "ky_dzomsdb")
public class BatchPlan {
    @Id
    @GeneratedValue
    private int id;
    //具体计划列表
    @OneToMany(mappedBy = "batchPlan",cascade = {CascadeType.ALL})
    private List<ChargePlan> chargePlanList = new ArrayList<ChargePlan>();
    //所涉及的合同列表
    @ElementCollection(fetch = FetchType.EAGER)
    @JoinTable(catalog = "ky_dzomsdb",name="batchplan_contractidlist")
    @OrderColumn
    private List<Integer> contractIdList = new ArrayList<Integer>();
    //批处理开始时间
    @Temporal(TemporalType.DATE)
    private Date startTime;
    //批处理结束时间
    @Temporal(TemporalType.DATE)
    private Date endTime;
    //收费或降费类型
    private String feeType;
    //每月费用
    private BigDecimal fee;
    //备注
    private String comment;
    private String title;
    //数据添加者
    private String register;
    //记录时间
    private Date inTime = new Date();
    
    private boolean isToEnd;
    
    public void generate(){
    	System.out.println("BatchPlan.generate()"+startTime+fee+contractIdList);
        if(startTime !=null && fee != null && contractIdList!=null){
            ContractDao contractDao = new ContractDaoImpl();
            for(int i:contractIdList){
                /*基本日期数据*/
                Calendar start = Calendar.getInstance();
                start.setTime(startTime);
                if(isToEnd){
                    Contract cccc = contractDao.selectById(i);
                    endTime = cccc.getContractEndDate();
                }
                if(endTime == null) break;
                Calendar end = Calendar.getInstance();
                end.setTime(endTime);
                Calendar current = Calendar.getInstance();
                current.setTime(startTime);
                int endYear = end.get(Calendar.YEAR);
                int endMonth = end.get(Calendar.MONTH);
                int endDay = end.get(Calendar.DAY_OF_MONTH);
                int currentYear = current.get(Calendar.YEAR);
                int currentMonth = current.get(Calendar.MONTH);
                int currentDay = current.get(Calendar.DAY_OF_MONTH);
                System.out.printf("Current year:%d End year:%d\n", currentYear, endYear);
                while(currentYear <= endYear){
                    if(currentYear == endYear && currentMonth > endMonth) break;
                    if(currentYear == endYear && currentMonth == endMonth && currentDay>endDay)break;
                    ChargePlan cp = new ChargePlan();
                    //设置当月的费用
                    if(currentDay >= 27){
                        if(currentYear==endYear && currentMonth == endMonth){
                            cp.setFee(new BigDecimal(fee.doubleValue()/30*(endDay-currentDay+1)));
                        }else if(currentYear == endYear && currentMonth == endMonth-1 && endDay <= 26){
                            cp.setFee(new BigDecimal(fee.doubleValue()/30*(30-(26-endDay))));
                        }else{
                            cp.setFee(new BigDecimal(fee.doubleValue()));
                        }
                        //移动至下一月
                        if(currentMonth != 11){
                            currentMonth++;
                        }else{
                            currentYear++;
                            currentMonth = 0;
                        }
                    }else if(currentDay < 27){
                        if(currentYear == endYear && currentMonth == endMonth){
                            if(endDay <= 26){
                                cp.setFee(new BigDecimal(fee.doubleValue()/30*(endDay-currentDay+1)));
                            }else{
                                cp.setFee(new BigDecimal(fee.doubleValue()/30*(26-currentDay+1)));
                            }
                        }else{
                            cp.setFee(new BigDecimal(fee.doubleValue()/30*(26-currentDay+1)));
                        }
                    }
                    currentDay = 27;
                    Calendar tmp = Calendar.getInstance();
                    tmp.set(Calendar.YEAR,currentYear);
                    tmp.set(Calendar.MONTH,currentMonth);
                    tmp.set(Calendar.DAY_OF_MONTH,26);
                    cp.setIsClear(false);
                    cp.setTime(tmp.getTime());
                    cp.setComment(this.comment);
                    cp.setContractId(i);
                    cp.setBatchPlan(this);
                    cp.setFeeType(this.feeType);
                    cp.setRegister(this.register);
                    cp.setInTime(this.inTime);
                    chargePlanList.add(cp);
                }
            }
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<ChargePlan> getChargePlanList() {
        return chargePlanList;
    }

    public void setChargePlanList(List<ChargePlan> chargePlanList) {
        this.chargePlanList = chargePlanList;
    }

    public List<Integer> getContractIdList() {
        return contractIdList;
    }

    public void setContractIdList(List<Integer> contractIdList) {
        this.contractIdList = contractIdList;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTiem) {
        this.startTime = startTiem;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRegister() {
        return register;
    }

    public void setRegister(String register) {
        this.register = register;
    }

    public Date getInTime() {
        return inTime;
    }

    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }

	public boolean isToEnd() {
		return isToEnd;
	}
	
	public boolean getIsToEnd() {
		return isToEnd;
	}

	public void setToEnd(boolean isToEnd) {
		this.isToEnd = isToEnd;
	}
	
	public void setIsToEnd(boolean isToEnd) {
		this.isToEnd = isToEnd;
	}
}
