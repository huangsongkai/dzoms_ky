package com.dz.kaiying.model;

/**
 * Created by 杨东儒 on 2018/10/28.
 */
public class ElectricDTO implements java.io.Serializable{

    private Integer id;
    private String act;
    private Integer grade;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAct() {
        return act;
    }

    public void setAct(String act) {
        this.act = act;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }
}
