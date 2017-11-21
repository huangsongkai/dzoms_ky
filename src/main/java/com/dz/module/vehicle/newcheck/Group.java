package com.dz.module.vehicle.newcheck;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Entity
@Table(name = "group",catalog = "ky_dzomsdb")
public class Group {
    @Id
    @GeneratedValue
    private int id;
    @ElementCollection(fetch = FetchType.LAZY)
    @JoinTable(name = "group_checkerIds",catalog = "ky_dzomsdb")
    private Set<Integer> checkerIds;
    @ManyToOne
    private Plan plan;
    @OneToMany(mappedBy = "group")
    private Set<CheckRecord> checkRecords;
    private int minNum;
    private String location;
    private Date startTime;
    private Date endTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getMinNum() {
        return minNum;
    }

    public void setMinNum(int minNum) {
        this.minNum = minNum;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public Set<Integer> getCheckerIds() {
        return checkerIds;
    }

    public void setCheckerIds(Set<Integer> checkerIds) {
        this.checkerIds = checkerIds;
    }

    public Set<CheckRecord> getCheckRecords() {
        return checkRecords;
    }

    public void setCheckRecords(Set<CheckRecord> checkRecords) {
        this.checkRecords = checkRecords;
    }
}
