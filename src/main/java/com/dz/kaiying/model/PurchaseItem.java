package com.dz.kaiying.model;


import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_purchase_item", catalog = "ky_dzomsdb")
public class PurchaseItem implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "item_id")//物品id
	private String itemId;

	@Column(name = "purchase_Num")//采购数量
	private String itemNum;

	@Column(name = "purchase_estimated_price")//预计价格
	private String purchasEstimatedPrice;

	@Column(name = "purchase_state")//采购状态
	private String purchaseState;

	@Column(name = "item_department")//采购部门
	private String itemDepartment;

	@Column(name = "purchase_remarks")//备注
	private String purchaseRemarks;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
}


