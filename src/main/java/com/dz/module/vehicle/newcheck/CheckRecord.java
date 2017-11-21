package com.dz.module.vehicle.newcheck;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Entity
@Table(name = "checkrecord",catalog = "ky_dzomsdb")
public class CheckRecord {
    @Id
    @GeneratedValue
    private int id;
    @ManyToOne
    private Group group;
    private String licenseNum;
    private String dept;
    private String driver;
    private boolean isPassed;
    private String unPassReason;
    private String recorder;

    @Transient
    private String renter;

    @Temporal(TemporalType.DATE)
    //检车时间
    private Date recordTime;
    private int vote = 0;
    @OneToMany(fetch = FetchType.EAGER,mappedBy = "checkRecord",cascade = CascadeType.ALL)
    private List<UnPassDetail> unPassDetail;
    private String passPicture;
    private String repassReason;
    private boolean isRepass;
    private String carFrameNum;
    private String contractNum;
    private String inCarDriver;
    private String inCarDriverId;
    private boolean isTogether;
    private String _recorder;
    //录入时间
    private String _recordTime;
    //录入人
    private String fullDegree;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public boolean getIsPassed() {
        return isPassed;
    }

    public void setIsPassed(boolean isPassed) {
        this.isPassed = isPassed;
    }

    public String getUnPassReason() {
        return unPassReason;
    }

    public void setUnPassReason(String unPassReason) {
        this.unPassReason = unPassReason;
    }

    public int getVote() {
        return vote;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }

    public String getRecorder() {
        return recorder;
    }

    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public boolean getPassed() {
        return isPassed;
    }

    public void setPassed(boolean passed) {
        isPassed = passed;
    }

    public List<UnPassDetail> getUnPassDetail() {
        return unPassDetail;
    }

    public void setUnPassDetail(List<UnPassDetail> unPassDetail) {
        this.unPassDetail = unPassDetail;
    }

    public String getPassPicture() {
        return passPicture;
    }

    public void setPassPicture(String passPicture) {
        this.passPicture = passPicture;
    }

    public boolean getRepass() {
        return isRepass;
    }

    public void setRepass(boolean repass) {
        isRepass = repass;
    }

    public String getCarFrameNum() {
        return carFrameNum;
    }

    public void setCarFrameNum(String carFrameNum) {
        this.carFrameNum = carFrameNum;
    }

    public String getContractNum() {
        return contractNum;
    }

    public void setContractNum(String contractNum) {
        this.contractNum = contractNum;
    }

    public String getInCarDriver() {
        return inCarDriver;
    }

    public void setInCarDriver(String inCarDriver) {
        this.inCarDriver = inCarDriver;
    }

    public String getInCarDriverId() {
        return inCarDriverId;
    }

    public void setInCarDriverId(String inCarDriverId) {
        this.inCarDriverId = inCarDriverId;
    }

    public boolean getTogether() {
        return isTogether;
    }

    public void setTogether(boolean together) {
        isTogether = together;
    }

    public String get_recorder() {
        return _recorder;
    }

    public void set_recorder(String _recorder) {
        this._recorder = _recorder;
    }

    public String get_recordTime() {
        return _recordTime;
    }

    public void set_recordTime(String _recordTime) {
        this._recordTime = _recordTime;
    }

    public String getFullDegree() {
        return fullDegree;
    }

    public void setFullDegree(String fullDegree) {
        this.fullDegree = fullDegree;
    }

    public String getRepassReason() {
        return repassReason;
    }

    public void setRepassReason(String repassReason) {
        this.repassReason = repassReason;
    }

    public String getRenter() {
        return renter;
    }

    public void setRenter(String renter) {
        this.renter = renter;
    }
}
