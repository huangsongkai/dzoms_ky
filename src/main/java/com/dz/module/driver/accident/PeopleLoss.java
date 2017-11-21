package com.dz.module.driver.accident;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name="peopleloss",catalog = "ky_dzomsdb")
public class PeopleLoss {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int  plId;
	//0表伤，1表亡
	private int hd;
	//伤亡人姓名
	@Column(nullable = false)
	private String name;
	//人员损失
	private BigDecimal loss = new BigDecimal(0);
	//0表示甲，1表示乙
	@Column(nullable = false)
	private int part;
	public int getPlId() {
		return plId;
	}
	public void setPlId(int plId) {
		this.plId = plId;
	}
	public int getHd() {
		return hd;
	}
	public void setHd(int hd) {
		this.hd = hd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getLoss() {
		return loss;
	}
	public void setLoss(BigDecimal loss) {
		this.loss = loss;
	}
	public int getPart() {
		return part;
	}
	public void setPart(int part) {
		this.part = part;
	}
}
