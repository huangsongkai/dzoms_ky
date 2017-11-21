package com.dz.kaiying.model;


import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_zuo_tao", catalog = "ky_dzomsdb")
public class ZuoTao implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")//车牌号
	private Integer id;

	@Column(name = "che_pai")//车牌号
	private String cph;

	@Column(name = "xiao_zuo_po_sun")//小坐破损
	private String xzps;

	@Column(name = "xiao_zuo_wo_zi")//小坐污渍
	private String xzwz;

	@Column(name = "da_zuo_po_sun")//大坐破损
	private String dzps;

	@Column(name = "da_zuo_wu_zi")//大坐污渍
	private String dzwz;

	@Column(name = "yuan_gong_gong_hao")
	private String employeeId;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCph() {
		return cph;
	}

	public void setCph(String cph) {
		this.cph = cph;
	}

	public String getXzps() {
		return xzps;
	}

	public void setXzps(String xzps) {
		this.xzps = xzps;
	}

	public String getXzwz() {
		return xzwz;
	}

	public void setXzwz(String xzwz) {
		this.xzwz = xzwz;
	}

	public String getDzps() {
		return dzps;
	}

	public void setDzps(String dzps) {
		this.dzps = dzps;
	}

	public String getDzwz() {
		return dzwz;
	}

	public void setDzwz(String dzwz) {
		this.dzwz = dzwz;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
}


