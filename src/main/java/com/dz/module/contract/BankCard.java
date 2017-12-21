package com.dz.module.contract;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.Date;
import java.util.List;
import javax.persistence.*;

import static com.dz.common.other.TimeComm.convertDate;
import static javax.persistence.GenerationType.IDENTITY;

/**
 * BankCard entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "bank_card", catalog = "ky_dzomsdb", uniqueConstraints = {
		@UniqueConstraint(columnNames = "cardNumber") })
public class BankCard implements java.io.Serializable {
	// Fields
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(unique = true, nullable = false)
	private Integer id;
	@Column(length = 30)
	private String idNumber;
	@Transient
	private String carNum;
	@Column(length = 20)
	private String cardClass;
	@Column(unique = true, length = 20)
	private String cardNumber;
	@Transient
	private Boolean isDefaultRecive;
	@Column
	private Integer operator;
	@Temporal(TemporalType.DATE)
	@Column
	private Date opeTime;

	@OneToMany(mappedBy = "bankCard",targetEntity = BankCardOfVehicle.class,fetch = FetchType.EAGER)
	private List<BankCardOfVehicle> bOfVList;

	// Constructors

	/** default constructor */
	public BankCard() {
	}

	/** full constructor */
	public BankCard(String idNumber, String cardClass, String cardNumber, Integer operator,
			Date opeTime) {
		this.idNumber = idNumber;
		this.cardClass = cardClass;
		this.cardNumber = cardNumber;
		this.operator = operator;
		this.opeTime = convertDate(opeTime);
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getIdNumber() {
		return this.idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	public String getCardClass() {
		return this.cardClass;
	}

	public void setCardClass(String cardClass) {
		this.cardClass = cardClass;
	}

	public String getCardNumber() {
		return this.cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public Boolean getIsDefaultRecive() {
		return this.isDefaultRecive;
	}

	public void setIsDefaultRecive(Boolean isDefaultRecive) {
		this.isDefaultRecive = isDefaultRecive;
	}

	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	public Date getOpeTime() {
		return this.opeTime;
	}

	public void setOpeTime(Date opeTime) {
		this.opeTime = convertDate(opeTime);
	}

	public String getCarNum() {
		return carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	public List<BankCardOfVehicle> getbOfVList() {
		return bOfVList;
	}

	public void setbOfVList(List<BankCardOfVehicle> bOfVList) {
		this.bOfVList = bOfVList;
	}

	@Transient
	public List<BankCardOfVehicle> fetchBofVList(){
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from BankCardOfVehicle where bankCard.id = :id");
		query.setInteger("id",id);
		return query.list();
	}

}