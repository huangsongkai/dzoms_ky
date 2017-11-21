package com.dz.module.charge;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author doggy
 *         Created on 15-11-15.
 */
@Entity
@Table(name="CheckChargeTable",catalog = "ky_dzomsdb")
public class CheckChargeTable implements java.io.Serializable {
	@Id
	@GeneratedValue
	private int id;
	
    private int contractId;
    @Temporal(TemporalType.DATE)
    private Date time;
    private String driverName;//由contractId获取
    private String carNumber;//由contractId获取
    private String driverId;//由contractId获取
    private String dept;//由contractId获取
    
    private BigDecimal planAll;

    private BigDecimal cash;
    private BigDecimal other;
    private BigDecimal bank;
    private BigDecimal bank1;
    private BigDecimal bank2;
    private BigDecimal oilAdd;
    private BigDecimal insurance;
    private BigDecimal total;//调用generated时生成

    //本月欠款(计划总额-收入合计)
    private BigDecimal thisMonthOwe;//调用generated时生成
    //上月累欠(上月存款)
    private BigDecimal lastMonthOwe;//调用generated时传入
    //本月存款(本月剩余)
    private BigDecimal thisMonthLeft;//调用generated时生成
    //本月累欠
    private BigDecimal thisMonthTotalOwe;//调用generated时生成

    public BigDecimal getPlanAll() {
        return planAll;
    }

    public void setPlanAll(BigDecimal planAll) {
        this.planAll = planAll;
    }

    public BigDecimal getCash() {
        return cash;
    }

    public void setCash(BigDecimal cash) {
        this.cash = cash;
    }

    public BigDecimal getBank() {
        return bank;
    }

    public void setBank(BigDecimal bank) {
        this.bank = bank;
    }

    public BigDecimal getOilAdd() {
        return oilAdd;
    }

    public void setOilAdd(BigDecimal oilAdd) {
        this.oilAdd = oilAdd;
    }

    public BigDecimal getInsurance() {
        return insurance;
    }

    public void setInsurance(BigDecimal insurance) {
        this.insurance = insurance;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public BigDecimal getThisMonthOwe() {
        return thisMonthOwe;
    }

    public void setThisMonthOwe(BigDecimal thisMonthOwe) {
        this.thisMonthOwe = thisMonthOwe;
    }

    public BigDecimal getLastMonthOwe() {
        return lastMonthOwe;
    }

    public void setLastMonthOwe(BigDecimal lastMonthOwe) {
        this.lastMonthOwe = lastMonthOwe;
    }

    public BigDecimal getThisMonthLeft() {
        return thisMonthLeft;
    }

    public void setThisMonthLeft(BigDecimal thisMonthLeft) {
        this.thisMonthLeft = thisMonthLeft;
    }

    public BigDecimal getThisMonthTotalOwe() {
        return thisMonthTotalOwe;
    }

    public void setThisMonthTotalOwe(BigDecimal thisMonthTotalOwe) {
        this.thisMonthTotalOwe = thisMonthTotalOwe;

    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    public BigDecimal getOther() {
        return other;
    }

    public void setOther(BigDecimal other) {
        this.other = other;
    }
    //需要提前设置各项收入，与总计划
    public void generated(BigDecimal lastMonthOwe){
    	//现在的 planAll = cash+bank+oilAdd+insurance+other+plan_*
    	
    	//total = cash+bank+oilAdd+insurance+other
        this.total = new BigDecimal(0);
        if(cash == null) cash = new BigDecimal(0.00);
        if(bank == null) bank = new BigDecimal(0.00);
        if(oilAdd == null) oilAdd = new BigDecimal(0.00);
        if(insurance == null) insurance = new BigDecimal(0.00);
        if(other == null) other = new BigDecimal(0.00);
        
//        this.total = this.total.add(cash).add(bank).add(oilAdd).add(insurance).add(other).setScale(0, BigDecimal.ROUND_HALF_EVEN);
//        BigDecimal owe = this.total.subtract(this.planAll).add(lastMonthOwe).setScale(0, BigDecimal.ROUND_HALF_EVEN);
//        //上月累欠
//        this.lastMonthOwe = lastMonthOwe.setScale(0, BigDecimal.ROUND_HALF_EVEN);
//        //本月欠款
//        this.thisMonthOwe = owe.doubleValue() > 0?new BigDecimal(0.00):owe;
//        //本月存款
//        this.thisMonthLeft = owe.doubleValue() > 0?owe:new BigDecimal(0.00);
//        //本月累欠
//        this.thisMonthTotalOwe = owe.setScale(0, BigDecimal.ROUND_HALF_EVEN);
//        
//        this.planAll = this.planAll.setScale(0, BigDecimal.ROUND_HALF_EVEN);
        
        this.total = this.total.add(cash).add(bank).add(oilAdd).add(insurance).add(other);
        BigDecimal owe = this.total.subtract(this.planAll).add(lastMonthOwe);
        //上月累欠
        this.lastMonthOwe = lastMonthOwe;
        //本月欠款
        this.thisMonthOwe = owe.doubleValue() > 0?new BigDecimal(0.00):owe;
        //本月存款
        this.thisMonthLeft = owe.doubleValue() > 0?owe:new BigDecimal(0.00);
        //本月累欠
        this.thisMonthTotalOwe = owe;

//        BigDecimal lastleft;
        
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

	public CheckChargeTable() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CheckChargeTable(Integer contractId, Date time,
			Double bank,
			Double cash,
			Double insurance,
			Double oilAdd, 
			Double other ,
			Double planAll,
			String carNumber,String dept,String driverName,Double lastMonthOwe) {
		super();
		
		if(contractId!=null)
			this.contractId = contractId;
		
		this.time = time;
		
		this.planAll = planAll!=null?BigDecimal.valueOf(planAll):BigDecimal.valueOf(0);
		this.cash = cash!=null?BigDecimal.valueOf(cash):BigDecimal.valueOf(0);
		this.other = other!=null?BigDecimal.valueOf(other):BigDecimal.valueOf(0);
		this.bank = bank!=null?BigDecimal.valueOf(bank):BigDecimal.valueOf(0);
		this.oilAdd =oilAdd!=null?BigDecimal.valueOf(oilAdd):BigDecimal.valueOf(0);
		this.insurance =insurance!=null?BigDecimal.valueOf(insurance):BigDecimal.valueOf(0);
		
		this.carNumber = carNumber;
		this.dept  = dept;
		this.driverName = driverName;
		
		this.lastMonthOwe = lastMonthOwe!=null?BigDecimal.valueOf(lastMonthOwe):BigDecimal.valueOf(0);
		
		this.generated(this.lastMonthOwe);
	}

    public CheckChargeTable(Integer contractId, Date time,
                            Double bank1,
                            Double bank2,
                            Double cash,
                            Double insurance,
                            Double oilAdd,
                            Double other ,
                            Double planAll,
                            String carNumber,String dept,String driverName,Double lastMonthOwe) {
        super();

        if(contractId!=null)
            this.contractId = contractId;

        this.time = time;

        this.planAll = planAll!=null?BigDecimal.valueOf(planAll):BigDecimal.valueOf(0);
        this.cash = cash!=null?BigDecimal.valueOf(cash):BigDecimal.valueOf(0);
        this.other = other!=null?BigDecimal.valueOf(other):BigDecimal.valueOf(0);
        this.bank1 = bank1!=null?BigDecimal.valueOf(bank1):BigDecimal.valueOf(0);
        this.bank2 = bank2!=null?BigDecimal.valueOf(bank2):BigDecimal.valueOf(0);
        this.bank = this.bank1.add(this.bank2);
        this.oilAdd =oilAdd!=null?BigDecimal.valueOf(oilAdd):BigDecimal.valueOf(0);
        this.insurance =insurance!=null?BigDecimal.valueOf(insurance):BigDecimal.valueOf(0);

        this.carNumber = carNumber;
        this.dept  = dept;
        this.driverName = driverName;

        this.lastMonthOwe = lastMonthOwe!=null?BigDecimal.valueOf(lastMonthOwe):BigDecimal.valueOf(0);

        this.generated(this.lastMonthOwe);
    }

    public BigDecimal getBank1() {
        return bank1;
    }

    public void setBank1(BigDecimal bank1) {
        this.bank1 = bank1;
    }

    public BigDecimal getBank2() {
        return bank2;
    }

    public void setBank2(BigDecimal bank2) {
        this.bank2 = bank2;
    }
}
