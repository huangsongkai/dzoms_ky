package com.dz.module.driver.accident;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
@Entity
@Table(name="accident",catalog = "ky_dzomsdb")
public class Accident {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	//事故id
	private int accId;
	//司机id
	@Column
	private String driverId;
	@Column
	private String driverAttr;
	//车辆id（车架号）
	private String carId;
    //登记人
	private int register;
	//事故类别
	private String aClass;
	//事故类型
	private int aType;
	//optional
	//事故性质
	private String shiguxingzhi;
	private BigDecimal shigujine;
	private String shiguzeren;

	//条款
	private int  clause;
	//事故处理
	private String accDeal;
	//天气状况
	private String weather;
	//事故区域
	private String area;
	//事故时间
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="timet")
	private Date time;
	//登记时间
	@Temporal(TemporalType.TIMESTAMP)
	private Date addTime;
	//出险原因
	private String reason;
	//事故处理状态，0表示未审核，1表示未修改，2表示未
	@Column
	private int status = 0;
	//保险公司
	private String insuCompany;
	//路面情况
	private String roadCondition;
    //发生区域
	private String happenArea;
	//归属区域
	private String belongArea;
	//事故经过
	private String accReason;
	//事故地点
	private String location;
	//车辆损失
	private BigDecimal carLoss;
	//车辆赔付
	private BigDecimal carPaid;
	//人员损失
	private BigDecimal peopleLoss;
    //赔付金额
    private BigDecimal money;

	private int checker;
	private Date check_time;
	private String payer;
	private Date pay_time;

	
	public int getAccId() {
		return accId;
	}
	public void setAccId(int accId) {
		this.accId = accId;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDriverId() {
		return driverId;
	}
	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}
	public int getChecker() {
		return checker;
	}
	public void setChecker(int checker) {
		this.checker = checker;
	}
	public Date getCheck_time() {
		return check_time;
	}
	public void setCheck_time(Date check_time) {
		this.check_time = check_time;
	}
	public String getPayer() {
		return payer;
	}
	public void setPayer(String payer) {
		this.payer = payer;
	}
	public Date getPay_time() {
		return pay_time;
	}
	public void setPay_time(Date pay_time) {
		this.pay_time = pay_time;
	}
	public String getCarId() {
		return carId;
	}
	public void setCarId(String carId) {
		this.carId = carId;
	}
	public int getClause() {
		return clause;
	}
	public void setClause(int clause) {
		this.clause = clause;
	}
	public String getAccDeal() {
		return accDeal;
	}
	public void setAccDeal(String accDeal) {
		this.accDeal = accDeal;
	}
	public String getWeather() {
		return weather;
	}
	public void setWeather(String weather) {
		this.weather = weather;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getInsuCompany() {
		return insuCompany;
	}
	public void setInsuCompany(String insuCompany) {
		this.insuCompany = insuCompany;
	}
	public String getRoadCondition() {
		return roadCondition;
	}
	public void setRoadCondition(String roadCondition) {
		this.roadCondition = roadCondition;
	}
	public String getBelongArea() {
		return belongArea;
	}
	public void setBelongArea(String belongArea) {
		this.belongArea = belongArea;
	}
	public String getAccReason() {
		return accReason;
	}
	public void setAccReason(String accReason) {
		this.accReason = accReason;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public BigDecimal getPeopleLoss() {
		return peopleLoss;
	}
	public void setPeopleLoss(BigDecimal harmLoss) {
		this.peopleLoss = harmLoss;
	}
	public int getRegister() {
		return register;
	}
	public void setRegister(int register) {
		this.register = register;
	}
	public Date getAddTime() {
		return addTime;
	}
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	public String getHappenArea() {
		return happenArea;
	}

	public BigDecimal getCarLoss() {
		return carLoss;
	}

	public void setCarLoss(BigDecimal carLoss) {
		this.carLoss = carLoss;
	}

	public BigDecimal getCarPaid() {
		return carPaid;
	}

	public void setCarPaid(BigDecimal carPaid) {
		this.carPaid = carPaid;
	}

	public void setHappenArea(String happenArea) {

		this.happenArea = happenArea;
	}

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

	@Override
	public String toString() {
		return "Accident{" +
				"accId=" + accId +
				", driverId='" + driverId + '\'' +
				", carId='" + carId + '\'' +
				", register=" + register +
				", aClass='" + aClass + '\'' +
				", aType=" + aType +
				", clause=" + clause +
				", accDeal='" + accDeal + '\'' +
				", weather='" + weather + '\'' +
				", area='" + area + '\'' +
				", time=" + time +
				", addTime=" + addTime +
				", reason='" + reason + '\'' +
				", status=" + status +
				", insuCompany='" + insuCompany + '\'' +
				", roadCondition='" + roadCondition + '\'' +
				", happenArea='" + happenArea + '\'' +
				", belongArea='" + belongArea + '\'' +
				", accReason='" + accReason + '\'' +
				", location='" + location + '\'' +
				", carLoss=" + carLoss +
				", carPaid=" + carPaid +
				", peopleLoss=" + peopleLoss +
				", money=" + money +
				", checker=" + checker +
				", check_time=" + check_time +
				", payer='" + payer + '\'' +
				", pay_time=" + pay_time +
				'}';
	}

	public String getAClass() {
		return aClass;
	}

	public void setAClass(String aClass) {
		this.aClass = aClass;
	}

	public int getAType() {
		return aType;
	}

	public void setAType(int aType) {
		this.aType = aType;
	}

	public String getDriverAttr() {
		return driverAttr;
	}

	public void setDriverAttr(String driverAttr) {
		this.driverAttr = driverAttr;
	}

	public String getaClass() {
		return aClass;
	}

	public void setaClass(String aClass) {
		this.aClass = aClass;
	}

	public int getaType() {
		return aType;
	}

	public void setaType(int aType) {
		this.aType = aType;
	}

	public String getShiguxingzhi() {
		return shiguxingzhi;
	}

	public void setShiguxingzhi(String shiguxingzhi) {
		this.shiguxingzhi = shiguxingzhi;
	}

	public BigDecimal getShigujine() {
		return shigujine;
	}

	public void setShigujine(BigDecimal shigujine) {
		this.shigujine = shigujine;
	}

	public String getShiguzeren() {
		return shiguzeren;
	}

	public void setShiguzeren(String shiguzeren) {
		this.shiguzeren = shiguzeren;
	}
}
