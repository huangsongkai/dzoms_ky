package com.dz.kaiying.model;


import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_storage", catalog = "ky_dzomsdb")
public class Storage implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "item_id")//物品表Id
	private Integer itemId;

	@Column(name = "item_total_num")//总数量
	private Integer itemTotalNum;

	@Column(name = "item_purchasing_price")//采购价格
	private Double itemPurchasingPrice;

	@Column(name = "item_remarks")//备注
	private String itemRemarks;

	@Column(name = "state")//状态 1为运营部商品 2 为办公室商品
	private String state;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}


