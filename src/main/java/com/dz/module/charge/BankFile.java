package com.dz.module.charge;

import java.util.Date;

import javax.persistence.*;

/**
 * @author doggy
 *         Created on 15-11-20.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "bankfile")
public class BankFile {
    @Id
    @GeneratedValue
    @Column(name = "`id`")
    private int id;
    @Column(name="`md5`")
    private String md5;
    
    @Column(name="`insertTime`")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insertTime;
    
    @Column(name="`insertMonth`")
    @Temporal(TemporalType.DATE)
    private Date insertMonth;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMd5() {
        return md5;
    }

    public void setMd5(String md5) {
        this.md5 = md5;
    }

	public Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}

	public Date getInsertMonth() {
		return insertMonth;
	}

	public void setInsertMonth(Date insertMonth) {
		this.insertMonth = insertMonth;
	}
    
    
}
