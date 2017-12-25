package com.dz.module.vehicle.electric;
// default package

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * ElectricAnaylse entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "electric_anaylse", catalog = "ky_dzomsdb")
public class ElectricAnaylse implements java.io.Serializable {

	// Fields

	private Integer id;
	private Date beginDate;
	private Date endDate;
	private Integer allTimes;
	private Long allMoney;
	private Integer time1;
	private Long money1;
	private Integer time2;
	private Long money2;
	private Integer time3;
	private Long money3;
	private String filePath;

	// Constructors

	/** default constructor */
	public ElectricAnaylse() {
	}

	/** full constructor */
	public ElectricAnaylse(Date beginDate, Date endDate, Integer allTimes,
			Long allMoney, Integer time1, Long money1, Integer time2,
			Long money2, Integer time3, Long money3, String filePath) {
		this.beginDate = beginDate;
		this.endDate = endDate;
		this.allTimes = allTimes;
		this.allMoney = allMoney;
		this.time1 = time1;
		this.money1 = money1;
		this.time2 = time2;
		this.money2 = money2;
		this.time3 = time3;
		this.money3 = money3;
		this.filePath = filePath;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "beginDate", length = 10)
	public Date getBeginDate() {
		return this.beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "endDate", length = 10)
	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Column(name = "allTimes")
	public Integer getAllTimes() {
		return this.allTimes;
	}

	public void setAllTimes(Integer allTimes) {
		this.allTimes = allTimes;
	}

	@Column(name = "allMoney", precision = 10, scale = 0)
	public Long getAllMoney() {
		return this.allMoney;
	}

	public void setAllMoney(Long allMoney) {
		this.allMoney = allMoney;
	}

	@Column(name = "time1")
	public Integer getTime1() {
		return this.time1;
	}

	public void setTime1(Integer time1) {
		this.time1 = time1;
	}

	@Column(name = "money1", precision = 10, scale = 0)
	public Long getMoney1() {
		return this.money1;
	}

	public void setMoney1(Long money1) {
		this.money1 = money1;
	}

	@Column(name = "time2")
	public Integer getTime2() {
		return this.time2;
	}

	public void setTime2(Integer time2) {
		this.time2 = time2;
	}

	@Column(name = "money2", precision = 10, scale = 0)
	public Long getMoney2() {
		return this.money2;
	}

	public void setMoney2(Long money2) {
		this.money2 = money2;
	}

	@Column(name = "time3")
	public Integer getTime3() {
		return this.time3;
	}

	public void setTime3(Integer time3) {
		this.time3 = time3;
	}

	@Column(name = "money3", precision = 10, scale = 0)
	public Long getMoney3() {
		return this.money3;
	}

	public void setMoney3(Long money3) {
		this.money3 = money3;
	}

	@Column(name = "filePath")
	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	@Override
	public String toString() {
		return "ElectricAnaylse [id=" + id + ", beginDate=" + beginDate
				+ ", endDate=" + endDate + ", allTimes=" + allTimes
				+ ", allMoney=" + allMoney + ", time1=" + time1 + ", money1="
				+ money1 + ", time2=" + time2 + ", money2=" + money2
				+ ", time3=" + time3 + ", money3=" + money3 + ", filePath="
				+ filePath + "]";
	}
	
	

}