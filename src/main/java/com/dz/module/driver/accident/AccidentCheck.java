package com.dz.module.driver.accident;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="accidentcheck",catalog = "ky_dzomsdb")
public class AccidentCheck {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int acId;
	private int aId;
	private Date acTime;
	private int checker;
	private String reason;
	private boolean isPassed = false;
	
	public int getAcId() {
		return acId;
	}
	public void setAcId(int acId) {
		this.acId = acId;
	}
	public int getaId() {
		return aId;
	}
	public void setaId(int aId) {
		this.aId = aId;
	}
	public int getChecker() {
		return checker;
	}
	public void setChecker(int checker) {
		this.checker = checker;
	}
	public boolean isPassed() {
		return isPassed;
	}
	public void setPassed(boolean isPassed) {
		this.isPassed = isPassed;
	}

	public void setIsPassed(boolean isPassed) {
		this.isPassed = isPassed;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

    public Date getAcTime() {
        return acTime;
    }

    public void setAcTime(Date acTime) {
        this.acTime = acTime;
    }
}
