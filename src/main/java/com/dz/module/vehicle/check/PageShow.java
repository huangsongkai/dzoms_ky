package com.dz.module.vehicle.check;

/**
 * @author doggy
 *         Created on 15-10-20.
 */
public class PageShow {
    //车架号
    private String carId;
    //车牌号
    private String license_num;
    //合同编号
    private String contractId;
    //承包人
    private String renter;
    //承包形式
    private String rentStyle;
    //承包人身份证
    private String renterId;
    private String unPassReason;

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getLicense_num() {
        return license_num;
    }

    public void setLicense_num(String license_num) {
        this.license_num = license_num;
    }

    public String getContractId() {
        return contractId;
    }

    public void setContractId(String contractId) {
        this.contractId = contractId;
    }

    public String getRenter() {
        return renter;
    }

    public void setRenter(String renter) {
        this.renter = renter;
    }

    public String getRentStyle() {
        return rentStyle;
    }

    public void setRentStyle(String rentStyle) {
        this.rentStyle = rentStyle;
    }

    public String getRenterId() {
        return renterId;
    }

    public void setRenterId(String renterId) {
        this.renterId = renterId;
    }

    public String getUnPassReason() {
        return unPassReason;
    }

    public void setUnPassReason(String unPassReason) {
        this.unPassReason = unPassReason;
    }
}
