package com.dz.module.driver.accident;

import javax.persistence.*;

@Entity
@Table(name="relation_accident_peopleLoss",catalog = "ky_dzomsdb")
public class Relation_Accident_PeopleLoss {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int rid;
	@Column(nullable = false)
	private int accId;
	@Column(nullable = false)
	private int plId;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getAccId() {
		return accId;
	}
	public void setAccId(int accId) {
		this.accId = accId;
	}
	public int getPlId() {
		return plId;
	}
	public void setPlId(int plId) {
		this.plId = plId;
	}
}
