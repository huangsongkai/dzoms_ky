package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class ItemPurchaseUpadteDTO implements java.io.Serializable {

	private Integer itemId;
	private Integer num;
	private String remark;

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}