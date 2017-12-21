package com.dz.module.driver.meeting;
// default package

import java.util.Date;

import javax.persistence.*;
import static javax.persistence.GenerationType.IDENTITY;

import org.apache.commons.lang.BooleanUtils;

import com.dz.module.driver.Driver;

/**
 * MeetingCheck entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "meeting_check", catalog = "ky_dzomsdb")
public class MeetingCheck implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 8894239234645262691L;
	private Integer id;
	private Integer meetingId;
	private String idNum;
	private Date needCheckTime;
	private Boolean isChecked;
	private Date checkTime;
	private String checkMethod;
	private Date manmalCheckTime;
	private Integer manmalCheckPerson;
	private String checkClass;

	// Constructors

	/** default constructor */
	public MeetingCheck() {
	}

	/** full constructor */
	public MeetingCheck(Integer meetingId, String idNum,
			Date needCheckTime, Boolean isChecked, Date checkTime,
			String checkMethod) {
		this.meetingId = meetingId;
		this.idNum = idNum;
		this.needCheckTime = needCheckTime;
		this.isChecked = isChecked;
		this.checkTime = checkTime;
		this.checkMethod = checkMethod;
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

	@Column(name = "meeting_id")
	public Integer getMeetingId() {
		return this.meetingId;
	}

	public void setMeetingId(Integer meetingId) {
		this.meetingId = meetingId;
	}

	@Column(name = "id_num", length = 30)
	public String getIdNum() {
		return this.idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	@Column(name = "need_check_time")
	@Temporal(TemporalType.DATE)
	public Date getNeedCheckTime() {
		return this.needCheckTime;
	}

	public void setNeedCheckTime(Date needCheckTime) {
		this.needCheckTime = needCheckTime;
	}

	@Column(name = "is_checked")
	public Boolean getIsChecked() {
		return this.isChecked;
	}

	public void setIsChecked(Boolean isChecked) {
		this.isChecked = isChecked;
	}

	@Column(name = "check_time")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getCheckTime() {
		return this.checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	@Column(name = "check_method", length = 30)
	public String getCheckMethod() {
		return this.checkMethod;
	}

	public void setCheckMethod(String checkMethod) {
		this.checkMethod = checkMethod;
	}
	@Column(name = "manmal_check_time")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getManmalCheckTime() {
		return this.manmalCheckTime;
	}

	public void setManmalCheckTime(Date date) {
		this.manmalCheckTime = date;
	}

	@Column(name = "manmal_check_person")
	public Integer getManmalCheckPerson() {
		return this.manmalCheckPerson;
	}

	public void setManmalCheckPerson(Integer manmalCheckPerson) {
		this.manmalCheckPerson = manmalCheckPerson;
	}
	
	@SuppressWarnings("deprecation")
	@Transient 
	public boolean isBuhui(){
		Date today = new Date();
		Date nct = new Date(needCheckTime.getTime());
		nct.setHours(17);
		nct.setMinutes(30);
		
		if(BooleanUtils.isNotTrue(isChecked)){
			if(today.before(nct))
				return false;
		}else{
			try{
			Driver d = (Driver) com.dz.common.other.ObjectAccess.getObject("com.dz.module.driver.Driver",idNum);
			Meeting m = (Meeting) com.dz.common.other.ObjectAccess.getObject("com.dz.module.driver.meeting.Meeting",meetingId);
			String dept = d.getDept();
			Date buhuiDate = null;
			switch(dept){
			case "一部":
				buhuiDate = m.getMeetingTimeB1();
				break;
			case "二部":
				buhuiDate = m.getMeetingTimeB2();
				break;
			case "三部":
				buhuiDate = m.getMeetingTimeB3();
				break;
			}
//			buhuiDate.setHours(17);
//			buhuiDate.setMinutes(30);
			
			if(checkTime.after(buhuiDate)){
				return true;
			}
			}catch(Exception e){
				//e.printStackTrace();
				return false;
			}
		}
		
		return false;
	}

	@Transient
	public boolean isDangri(){
		Date nct = new Date(needCheckTime.getTime());
		nct.setHours(23);
		nct.setMinutes(30);
		Date nc_before = new Date(needCheckTime.getTime());
		nc_before.setHours(0);
		nc_before.setMinutes(30);

		if(BooleanUtils.isNotTrue(isChecked)){
			return false;
		}else if(checkTime.after(nc_before)&&checkTime.before(nct)){
			return true;
		}

		return false;
	}

	@SuppressWarnings("deprecation")
	public static boolean isChidao(Date checkTime){
		Date time_span = new Date(checkTime.getTime());
		time_span.setHours(13);
		time_span.setMinutes(5);

		Date time_span_end = new Date(checkTime.getTime());
		time_span_end.setHours(13);
		time_span_end.setMinutes(59);

		if(checkTime.after(time_span) && checkTime.before(time_span_end)){
			return true;
		}

		time_span.setHours(14);
		time_span.setMinutes(35);
		time_span_end.setHours(15);
		time_span_end.setMinutes(29);

		if(checkTime.after(time_span) && checkTime.before(time_span_end)){
			return true;
		}

		time_span.setHours(16);
		time_span.setMinutes(5);
		time_span_end.setHours(17);
		time_span_end.setMinutes(29);

		if(checkTime.after(time_span) && checkTime.before(time_span_end)){
			return true;
		}

		return false;
	}

	@Transient 
	public boolean isChidao(){
		return isChidao(checkTime);
	}
	
	@Column(name = "check_class", length = 30)
	public String getCheckClass() {
		return checkClass;
	}

	public void setCheckClass(String checkClass) {
		this.checkClass = checkClass;
	}

}