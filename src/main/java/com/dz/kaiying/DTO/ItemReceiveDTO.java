package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class ItemReceiveDTO implements java.io.Serializable {

	private Integer itemId;
	private String itemName;
	private String itemUnit;
	private String itemType;
	private Integer itemTotalNum;
	private Double itemPurchasingPrice;
	private String itemRemarks;

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemUnit() {
		return itemUnit;
	}

	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public Integer getItemTotalNum() {
		return itemTotalNum;
	}

	public void setItemTotalNum(Integer itemTotalNum) {
		this.itemTotalNum = itemTotalNum;
	}

	public Double getItemPurchasingPrice() {
		return itemPurchasingPrice;
	}

	public void setItemPurchasingPrice(Double itemPurchasingPrice) {
		this.itemPurchasingPrice = itemPurchasingPrice;
	}

	public String getItemRemarks() {
		return itemRemarks;
	}

	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;
	}
}