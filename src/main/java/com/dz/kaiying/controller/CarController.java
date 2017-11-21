package com.dz.kaiying.controller;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.HibernateUtil;
import com.dz.kaiying.util.Result;
import com.dz.module.vehicle.Vehicle;
import com.fasterxml.jackson.annotation.JsonInclude;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by song on 2017/7/27.
 */
@Controller
@RequestMapping(value = "/car")
public class CarController extends BaseController{
    @Resource
    HibernateDao<Vehicle, Integer> vehicleHiberDao;
    @Autowired
    HibernateUtil hibernateUtil;


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Result list(){
        List<Object[]> vehicleList = hibernateUtil.queryBySql("select v.carframe_num,v.dept,license_num, contract_end_date,v.state,d.name,d.phone_num1 from vehicle v inner join contract c on v.carframe_num = c.carframe_num left join driver d on driver_id = d.id_num where v.state=1 and c.state=0 order by contract_end_date \n");
        List<CarDTO> carDTOList = new ArrayList<>();
        for(Object[]v : vehicleList){
            CarDTO carDTO = new CarDTO();
            carDTO.setDept((String) v[1]);
            carDTO.setLicenseNum((String) v[2]);
            carDTO.setContractEndDate((Date) v[3]);
            carDTO.setState("正常");
            carDTO.setName(((String)v[5]).trim());
            carDTO.setPhone((String)v[6]);
            carDTOList.add(carDTO);
        }
        return success("success", carDTOList);
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(){
        return "car/index";
    }





    @JsonInclude(JsonInclude.Include.NON_NULL)
    public class CarDTO {
        private String dept;
        private String licenseNum;
        private String carframeNum;
        private Date contractEndDate;
        private String state;
        private String name;
        private String phone;

        public String getDept() {
            return dept;
        }

        public void setDept(String dept) {
            this.dept = dept;
        }

        public String getLicenseNum() {
            return licenseNum;
        }

        public void setLicenseNum(String licenseNum) {
            this.licenseNum = licenseNum;
        }

        public String getCarframeNum() {
            return carframeNum;
        }

        public void setCarframeNum(String carframeNum) {
            this.carframeNum = carframeNum;
        }

        public Date getContractEndDate() {
            return contractEndDate;
        }

        public void setContractEndDate(Date contractEndDate) {
            this.contractEndDate = contractEndDate;
        }

        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }
    }
}
