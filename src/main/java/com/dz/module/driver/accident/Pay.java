package com.dz.module.driver.accident;

import java.math.BigDecimal;
import java.util.Date;

public class Pay {
	private Date time;
	private String payer;
	private BigDecimal money;
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getPayer() {
		return payer;
	}
	public void setPayer(String payer) {
		this.payer = payer;
	}
	public BigDecimal getMoney() {
		return money;
	}
	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	
}
