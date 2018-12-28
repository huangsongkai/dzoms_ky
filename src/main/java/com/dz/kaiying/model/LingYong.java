package com.dz.kaiying.model;


import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_ling_yong", catalog = "ky_dzomsdb")
public class LingYong implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "person_name")//
	private String personName;

	@Column(name = "id_Number")//
	private String idNumber;


	@Column(name = "car_id")//
	private String carId;


	@Column(name = "count")//
	private Integer count;


	@Column(name = "item_id")//
	private Integer itemId;

	@Column(name = "state0")//领用状态  0是未领用 1 是已经领用
	private Integer state0;

	@Column(name = "state")//领用状态  0是未领用 1 是已经领用
	private Integer state;

	@Column(name = "applyTime")//领用时间
	private Date applyTime;

	@Column(name = "date")//
	private Date date;

	@Column(name = "remarks")//
	private String remarks;

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getState0() {
		return state0;
	}

	public void setState0(Integer state0) {
		this.state0 = state0;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getIdNumber() {
		return idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getCarId() {
		return carId;
	}

	public void setCarId(String carId) {
		this.carId = carId;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}
}


