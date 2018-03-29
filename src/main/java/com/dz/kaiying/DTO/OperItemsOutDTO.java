package com.dz.kaiying.DTO;

import java.util.Date;

/**
 * Created by 24244 on 2018/3/29.
 */
public class OperItemsOutDTO {

        private int id;
        private String personName;
        private String itemName;
        private String idNumber;
        private String carId;
        private Integer count;
        private Date time;

        public void setId(int id) {
            this.id = id;
        }
        public int getId() {
            return id;
        }

        public void setPersonName(String personName) {
            this.personName = personName;
        }
        public String getPersonName() {
            return personName;
        }

        public void setItemName(String itemName) {
            this.itemName = itemName;
        }
        public String getItemName() {
            return itemName;
        }

        public void setIdNumber(String idNumber) {
            this.idNumber = idNumber;
        }
        public String getIdNumber() {
            return idNumber;
        }

        public void setCarId(String carId) {
            this.carId = carId;
        }
        public String getCarId() {
            return carId;
        }

        public void setCount(Integer count) {
            this.count = count;
        }
        public Integer getCount() {
            return count;
        }

        public void setTime(Date time) {
            this.time = time;
        }
        public Date getTime() {
            return time;
        }

    }

