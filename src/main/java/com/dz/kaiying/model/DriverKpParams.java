package com.dz.kaiying.model;


import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


@Entity
@Table(name = "ky_driverKpParams", catalog = "ky_dzomsdb")
public class DriverKpParams implements java.io.Serializable {

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Integer id;

	private Integer zj_total;
	private Integer zj_0;
	private Integer insurance_total;
	private Integer insurance_0;
	private Integer law_total;
	private Integer law_0;
	private Integer ts_total;
	private Integer sg_total;
	private Integer sg_2;
	private Integer sg_1;
	private Integer sg_0;
	private Integer wz_total;
	private Integer wz_0;
	private Integer lj_total;
	private Integer lj_0;
	private Integer lh_total;
	private Integer lh_0;
	private Integer score2;
	private Integer hd_total;
	private Integer mt_total;
	private Integer praise_total;
	private Integer pay_0;
	private Integer pay_total;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getZj_total() {
		return zj_total;
	}

	public void setZj_total(Integer zj_total) {
		this.zj_total = zj_total;
	}

	public Integer getZj_0() {
		return zj_0;
	}

	public void setZj_0(Integer zj_0) {
		this.zj_0 = zj_0;
	}

	public Integer getInsurance_total() {
		return insurance_total;
	}

	public void setInsurance_total(Integer insurance_total) {
		this.insurance_total = insurance_total;
	}

	public Integer getInsurance_0() {
		return insurance_0;
	}

	public void setInsurance_0(Integer insurance_0) {
		this.insurance_0 = insurance_0;
	}

	public Integer getLaw_total() {
		return law_total;
	}

	public void setLaw_total(Integer law_total) {
		this.law_total = law_total;
	}

	public Integer getLaw_0() {
		return law_0;
	}

	public void setLaw_0(Integer law_0) {
		this.law_0 = law_0;
	}

	public Integer getTs_total() {
		return ts_total;
	}

	public void setTs_total(Integer ts_total) {
		this.ts_total = ts_total;
	}

	public Integer getSg_total() {
		return sg_total;
	}

	public void setSg_total(Integer sg_total) {
		this.sg_total = sg_total;
	}

	public Integer getSg_2() {
		return sg_2;
	}

	public void setSg_2(Integer sg_2) {
		this.sg_2 = sg_2;
	}

	public Integer getSg_1() {
		return sg_1;
	}

	public void setSg_1(Integer sg_1) {
		this.sg_1 = sg_1;
	}

	public Integer getSg_0() {
		return sg_0;
	}

	public void setSg_0(Integer sg_0) {
		this.sg_0 = sg_0;
	}

	public Integer getWz_total() {
		return wz_total;
	}

	public void setWz_total(Integer wz_total) {
		this.wz_total = wz_total;
	}

	public Integer getWz_0() {
		return wz_0;
	}

	public void setWz_0(Integer wz_0) {
		this.wz_0 = wz_0;
	}

	public Integer getLj_total() {
		return lj_total;
	}

	public void setLj_total(Integer lj_total) {
		this.lj_total = lj_total;
	}

	public Integer getLj_0() {
		return lj_0;
	}

	public void setLj_0(Integer lj_0) {
		this.lj_0 = lj_0;
	}

	public Integer getLh_total() {
		return lh_total;
	}

	public void setLh_total(Integer lh_total) {
		this.lh_total = lh_total;
	}

	public Integer getLh_0() {
		return lh_0;
	}

	public void setLh_0(Integer lh_0) {
		this.lh_0 = lh_0;
	}

	public Integer getScore2() {
		return score2;
	}

	public void setScore2(Integer score2) {
		this.score2 = score2;
	}

	public Integer getHd_total() {
		return hd_total;
	}

	public void setHd_total(Integer hd_total) {
		this.hd_total = hd_total;
	}

	public Integer getMt_total() {
		return mt_total;
	}

	public void setMt_total(Integer mt_total) {
		this.mt_total = mt_total;
	}

	public Integer getPraise_total() {
		return praise_total;
	}

	public void setPraise_total(Integer praise_total) {
		this.praise_total = praise_total;
	}

	public Integer getPay_0() {
		return pay_0;
	}

	public void setPay_0(Integer pay_0) {
		this.pay_0 = pay_0;
	}

	public Integer getPay_total() {
		return pay_total;
	}

	public void setPay_total(Integer pay_total) {
		this.pay_total = pay_total;
	}
}

