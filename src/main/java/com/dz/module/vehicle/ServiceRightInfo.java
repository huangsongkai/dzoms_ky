package com.dz.module.vehicle;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ServiceRightInfo", catalog = "ky_dzomsdb")
public class ServiceRightInfo {
	@Id
	@Column(unique = true, nullable = false, length = 30)
	private String carframeNum;
	@Column(name = "operate_card", length = 30)
	private String operateCard;
	@Temporal(TemporalType.DATE)
	@Column
	private Date operateCardTime;
	@Column
	private Integer serviceRightRegister;
	@Temporal(TemporalType.DATE)
	@Column
	private Date serviceRightRegistDate;
	public String getCarframeNum() {
		return carframeNum;
	}
	public void setCarframeNum(String carframeNum) {
		this.carframeNum = carframeNum;
	}
	public String getOperateCard() {
		return operateCard;
	}
	public void setOperateCard(String operateCard) {
		this.operateCard = operateCard;
	}
	public Date getOperateCardTime() {
		return operateCardTime;
	}
	public void setOperateCardTime(Date operateCardTime) {
		this.operateCardTime = operateCardTime;
	}
	public Integer getServiceRightRegister() {
		return serviceRightRegister;
	}
	public void setServiceRightRegister(Integer serviceRightRegister) {
		this.serviceRightRegister = serviceRightRegister;
	}
	public Date getServiceRightRegistDate() {
		return serviceRightRegistDate;
	}
	public void setServiceRightRegistDate(Date serviceRightRegistDate) {
		this.serviceRightRegistDate = serviceRightRegistDate;
	}
	@Column
	private Integer state;

	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
}
