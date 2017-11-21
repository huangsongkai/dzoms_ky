package com.dz.module.vehicle;

import com.dz.module.contract.BankCardOfVehicle;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Vehicle entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "duanxin", catalog = "ky_dzomsdb")
public class DuanXin implements java.io.Serializable {
	/**
	 *
	 */
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer id;
	@Column(name = "phone")
	private String phone;
	@Column(name = "body")
	private String body;
	@Column(name = "status")
	private String status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}