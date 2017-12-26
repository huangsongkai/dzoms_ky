package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.module.contract.BankCardOfVehicle;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.persistence.*;
import javax.servlet.ServletContext;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-11-17.
 */
@Entity
public class BankRecord {
	private String licenseNum,carframeNum;
	private String driverName,idNum;
	@Transient
	private List<BankCardOfVehicle> bankCards;
	private BigDecimal money;
	private Double derserve,left;
	private Date inTime;

	private int contractId;

	public BankRecord() {
		super();
	}

//    private static BankCardDao bankCardDao;
//    private static ChargeService chargeService;

	private static void initStatic(){
		ServletContext sc = ServletActionContext.getServletContext();
		ApplicationContext appc = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
//    	bankCardDao = appc.getBean(BankCardDao.class);
//    	chargeService = appc.getBean(ChargeService.class);
	}

	public BankRecord(String idNum,String driverName,String carframeNum,String licenseNum,Double derserve,Double left) {
		this.idNum = idNum;
		this.driverName = driverName;
		this.carframeNum = carframeNum;
		this.licenseNum = licenseNum;
		this.derserve = derserve==null?0:derserve;
		this.left = left==null?0:left;

//		System.out.println(derserve+"|"+left);

		init();
	}

	public BankRecord(String idNum,String driverName,String carframeNum,String licenseNum,Double derserve,Double left,int contractId) {
		this.idNum = idNum;
		this.driverName = driverName;
		this.carframeNum = carframeNum;
		this.licenseNum = licenseNum;
		this.derserve = derserve==null?0:derserve;
		this.left = left==null?0:left;
		this.contractId = contractId;
//		System.out.println(derserve+"|"+left);

		init();
	}

	public void init(){
//    	if(bankCardDao==null){
//    		initStatic();
//    	}

		money = BigDecimal.valueOf(derserve).add(BigDecimal.valueOf(left));
		if(money.compareTo(BigDecimal.ZERO)>0){
			money = BigDecimal.ZERO;
		}else{
			money = money.abs();
		}

		Session s = HibernateSessionFactory.getSession();
//		Query query = s.createQuery("from BankCardOfVehicle where bankCard.idNumber=:idNum and vehicle.carframeNum=:carno");
//		query.setString("idNum",idNum);
		//2017-09-21 放宽条件 允许非车主的银行卡
		Query query = s.createQuery("from BankCardOfVehicle where vehicle.carframeNum=:carno order by bankCard.id desc ");
		query.setString("carno",carframeNum);
		bankCards = query.list();
	}


	public String getLicenseNum() {
		return licenseNum;
	}

	public void setLicenseNum(String licenseNum) {
		this.licenseNum = licenseNum;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public List<BankCardOfVehicle> getBankCards() {
		return bankCards;
	}

	@Override
	public String toString() {
		return "BankRecord{" +
				"licenseNum='" + licenseNum + '\'' +
				", driverName='" + driverName + '\'' +
				", bankCards=" + bankCards +
				", money=" + money +
				'}';
	}

	public void setBankCards(List<BankCardOfVehicle> bankCards) {
		this.bankCards = bankCards;
	}

	public Date getInTime() {
		return inTime;
	}

	public void setInTime(Date inTime) {
		this.inTime = inTime;
	}


	public Double getDerserve() {
		return derserve;
	}


	public void setDerserve(Double derserve) {
		this.derserve = derserve;
	}


	public Double getLeft() {
		return left;
	}


	public void setLeft(Double left) {
		this.left = left;
	}


	public String getCarframeNum() {
		return carframeNum;
	}


	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}


	public String getIdNum() {
		return idNum;
	}


	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	public int getContractId() {
		return contractId;
	}

	public void setContractId(int contractId) {
		this.contractId = contractId;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
