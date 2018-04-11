package com.dz.kaiying.model;


import javax.persistence.*;

import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_purcher_record", catalog = "ky_dzomsdb")
public class ItemPurchaseRecord implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "item_id")//物品id
	private Integer itemId;

	@Column(name = "item_remarks")//备注
	private String itemRemarks;

	@Column(name = "item_num")//数量
	private Integer itemNum;

	@Column(name = "item_state")//状态 1为运营部商品 2 为办公室商品
	private String itemState;

	@Column(name = "Name")//状态 1为运营部商品 2 为办公室商品
	private String name;

	@Column(name = "item_date")//时间
	private Date date;

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getItemRemarks() {
		return itemRemarks;
	}

	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;
	}

	public String getItemState() {
		return itemState;
	}

	public void setItemState(String itemState) {
		this.itemState = itemState;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getItemNum() {
		return itemNum;
	}

	public void setItemNum(Integer itemNum) {
		this.itemNum = itemNum;
	}
}


