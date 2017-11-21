package com.dz.module.charge.receipt;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
@Entity
@Table(name = "`roll`",catalog = "ky_dzomsdb")
public class Roll {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int id;
    private int startNum;
    private int endNum;
    private int year;
    //0表示买入，1表示卖出
    private int solded;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStartNum() {
        return startNum;
    }

    public void setStartNum(int startNum) {
        this.startNum = startNum;
    }

    public int getEndNum() {
        return endNum;
    }

    public void setEndNum(int endNum) {
        this.endNum = endNum;
    }

    public int getSolded() {
        return solded;
    }

    public void setSolded(int solded) {
        this.solded = solded;
    }

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}
}
