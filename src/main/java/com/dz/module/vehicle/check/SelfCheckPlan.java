package com.dz.module.vehicle.check;

import javax.persistence.*;
import java.util.Date;

/**
 * @author doggy
 *         Created on 15-10-14.
 *         车辆自检计划
 */
@Entity
@Table(name = "selfcheckplan",catalog = "ky_dzomsdb")
public class SelfCheckPlan {
    /**
     * 自检计划id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    /**
     * 计划开始时间
     */
    private Date startTime;
    /**
     * 计划结束时间
     */
    private Date endTime;
    /**
     * 录入时间
     */
    private Date recordTime;
    /**
     * 记录人员的id，即登录者id
     */
    private int recorder;
    /**
     * 计划名称,以年月开头
     */
    private String plan_name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    public int getRecorder() {
        return recorder;
    }

    public void setRecorder(int recorder) {
        this.recorder = recorder;
    }

    public String getPlan_name() {
        return plan_name;
    }

    public void setPlan_name(String plan_name) {
        this.plan_name = plan_name;
    }

    @Override
    public String toString() {
        return "SelfCheckPlan{" +
                "id=" + id +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", recordTime=" + recordTime +
                ", recorder=" + recorder +
                ", plan_name='" + plan_name + '\'' +
                '}';
    }
}
