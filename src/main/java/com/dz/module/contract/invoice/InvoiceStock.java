package com.dz.module.contract.invoice;

// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * InvoiceStock entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "invoice_stock", catalog = "ky_dzomsdb")
public class InvoiceStock implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1599113365685297759L;
	private Integer id;
	private Long unitPrice;
	private Integer stock;

	// Constructors

	/** default constructor */
	public InvoiceStock() {
	}

	/** full constructor */
	public InvoiceStock(Integer id, Long unitPrice, Integer stock) {
		this.id = id;
		this.unitPrice = unitPrice;
		this.stock = stock;
	}

	// Property accessors
	@Id
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "unit_price", nullable = false, precision = 10, scale = 0)
	public Long getUnitPrice() {
		return this.unitPrice;
	}

	public void setUnitPrice(Long unitPrice) {
		this.unitPrice = unitPrice;
	}

	@Column(name = "stock", nullable = false)
	public Integer getStock() {
		return this.stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

}