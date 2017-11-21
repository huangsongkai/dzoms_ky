package com.dz.module.charge;

import javax.persistence.*;
import java.util.Date;

/**
 * @author doggy
 *         Created on 15-11-17.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "cleartime")
public class ClearTime {
    @Id
    @GeneratedValue
    @Column(name = "`key`")
    private int key;
    @Temporal(TemporalType.DATE)
    @Column(name = "`current`")
    private Date current;
    @Column(name = "`department`")
    private String department;

    public Date getCurrent() {
        return current;
    }

    public void setCurrent(Date current) {
        this.current = current;
    }

    public String getDepartment() {
        return department;
    }

    public ClearTime setDepartment(String department) {
        this.department = department;
        return this;
    }

    public int getKey() {
        return key;
    }

    public ClearTime setKey(int key) {
        this.key = key;
        return this;
    }

    @Override
    public String toString() {
        return "ClearTime{" +
                "key=" + key +
                ", current=" + current +
                ", department='" + department + '\'' +
                '}';
    }
}
