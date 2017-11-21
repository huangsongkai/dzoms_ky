package com.dz.module.vehicle.newcheck;

import javax.persistence.*;

/**
 * @author doggy
 *         Created on 16-3-25.
 */
@Entity
@Table(name = "unpassdetail",catalog = "ky_dzomsdb")
public class UnPassDetail {
    @Id
    @GeneratedValue
    private int id;
    @ManyToOne
    private CheckRecord checkRecord;

    private String unPassPicture;

    private String passPicture;

    private String unPassReason;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUnPassPicture() {
        return unPassPicture;
    }

    public void setUnPassPicture(String unPassPicture) {
        this.unPassPicture = unPassPicture;
    }

    public String getPassPicture() {
        return passPicture;
    }

    public void setPassPicture(String passPicture) {
        this.passPicture = passPicture;
    }

    public String getUnPassReason() {
        return unPassReason;
    }

    public void setUnPassReason(String unPassReason) {
        this.unPassReason = unPassReason;
    }

    public CheckRecord getCheckRecord() {
        return checkRecord;
    }

    public void setCheckRecord(CheckRecord checkRecord) {
        this.checkRecord = checkRecord;
    }

    @Override
    public String toString() {
        return "UnPassDetail{" +
                "id=" + id +
                ", checkRecord=" + checkRecord +
                ", unPassPicture='" + unPassPicture + '\'' +
                ", passPicture='" + passPicture + '\'' +
                ", unPassReason='" + unPassReason + '\'' +
                '}';
    }
}
