package com.dz.kaiying.model;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by 杨东儒 on 2018/10/28.
 */
@Entity
@Table(name = "electric_grade", catalog = "ky_dzomsdb")
public class Electric implements java.io.Serializable{

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column(name = "act")
    private String act;
    @Column(name = "grade")
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
