package com.dz.module.driver.accident;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="carloss",catalog = "ky_dzomsdb")
public class CarLoss {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int clId;
	@Column(nullable = false)
    //车牌号
	private String carId;
    //车辆损失
	private BigDecimal carLoss;
    //车辆类型
	@Column(nullable = false)
	private String carType;
	//0表示甲方，1表示乙方
	private int part;
	
	public int getClId() {
		return clId;
	}
	public void setClId(int clId) {
		this.clId = clId;
	}
	public String getCarId() {
		return carId;
	}
	public void setCarId(String carId) {
		this.carId = carId;
	}
	public BigDecimal getCarLoss() {
		return carLoss;
	}
	public void setCarLoss(BigDecimal carLoss) {
		this.carLoss = carLoss;
	}
	public String getCarType() {
		return carType;
	}
	public void setCarType(String carType) {
		this.carType = carType;
	}
	public int getPart() {
		return part;
	}
	public void setPart(int part) {
		this.part = part;
	}
}
