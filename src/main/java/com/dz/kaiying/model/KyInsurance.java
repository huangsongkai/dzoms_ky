package com.dz.kaiying.model;


import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

//保险表
@Entity
@Table(name = "ky_insurance", catalog = "ky_dzomsdb")
public class KyInsurance implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id" )
    private Integer id;

    @Column(name = "bdh" )
    private String bdh; //保单号

    @Column(name = "cph" ) //车牌号
    private String cph;

    @Column(name = "bbxr")//被保险人
    private String bbxr;

    @Column(name = "bxqq" ) //保险启期
    private String bxqq;

    @Column(name = "bxzq" ) //保险止期
    private String bxzq;

    @Column(name = "zbe" ) //总保额
    private String zbe;

    @Column(name = "zbf" ) //总保费
    private String zbf;

    @Column(name = "lrsj" ) //录入时间
    private String lrsj;

    @Column(name = "create_date" ) //创建时间
    private Date createDate;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBdh() {
        return bdh;
    }

    public void setBdh(String bdh) {
        this.bdh = bdh;
    }

    public String getCph() {
        return cph;
    }

    public void setCph(String cph) {
        this.cph = cph;
    }

    public String getBbxr() {
        return bbxr;
    }

    public void setBbxr(String bbxr) {
        this.bbxr = bbxr;
    }

    public String getBxqq() {
        return bxqq;
    }

    public void setBxqq(String bxqq) {
        this.bxqq = bxqq;
    }

    public String getBxzq() {
        return bxzq;
    }

    public void setBxzq(String bxzq) {
        this.bxzq = bxzq;
    }

    public String getZbe() {
        return zbe;
    }

    public void setZbe(String zbe) {
        this.zbe = zbe;
    }

    public String getZbf() {
        return zbf;
    }

    public void setZbf(String zbf) {
        this.zbf = zbf;
    }

    public String getLrsj() {
        return lrsj;
    }

    public void setLrsj(String lrsj) {
        this.lrsj = lrsj;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}