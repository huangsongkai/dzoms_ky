package com.dz.kaiying.model;


import javax.persistence.*;
import java.util.Date;

import static javax.persistence.GenerationType.IDENTITY;

//事故信息表
@Entity
@Table(name = "ky_accident", catalog = "ky_dzomsdb")
public class KyAccident implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id" ) //主键
    private Integer id;
    @Column(name = "sgclbm" )
    private String sgclbm; //事故处理部门

    @Column(name = "basj" )
    private String basj; //报案时间

    @Column(name = "jasj" ) //结案时间
    private String jasj;

    @Column(name = "tpbz" )//通赔标志
    private String tpbz;

    @Column(name = "ywly" ) //业务来源
    private String ywly;

    @Column(name = "bdh")//保单号
    private String bdh;

    @Column(name = "bdgsjg")//保单归属机构
    private String bdgsjg;

    @Column(name = "qbrq")//启保日期
    private String qbrq;

    @Column(name = "zbrq")//终保日期
    private String zbrq;

    @Column(name = "cdrq" ) //初登日期
    private String cdrq;

    @Column(name = "lah" ) //立案号
    private String lah;

    @Column(name = "ajxz" ) //案件性质
    private String ajxz;

    @Column(name = "cxrq" ) //出险日期
    private String cxrq;

    @Column(name = "sgclfs" ) //事故处理方式
    private String sgclfs;

    @Column(name = "gsje" ) //估损金额
    private String gsje;

    @Column(name = "gjpk" ) //估计赔偿
    private String gjpk;

    @Column(name = "pfje" ) //赔付金额
    private String pfje;

    @Column(name = "bar" ) //报案人
    private String bar;

    @Column(name = "bardh" ) //报案人电话
    private String bardh;

    @Column(name = "cky" ) //查勘员
    private String cky;

    @Column(name = "cxdz" ) //出险地址
    private String cxdz;

    @Column(name = "cxyy" ) //出险原因
    private String cxyy;

    @Column(name = "jsr" ) //驾驶人
    private String jsr;

    @Column(name = "jsz" ) //驾驶证
    private String jsz;

    @Column(name = "cpxh" ) //厂牌型号
    private String cpxh;

    @Column(name = "cph" ) //车牌号
    private String cph;

    @Column(name = "cxjg" ) //出险经过
    private String cxjg;

    @Column(name = "create_date" ) //创建时间
    private Date createDate;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBasj() {
        return basj;
    }

    public void setBasj(String basj) {
        this.basj = basj;
    }

    public String getJasj() {
        return jasj;
    }

    public void setJasj(String jasj) {
        this.jasj = jasj;
    }

    public String getBdh() {
        return bdh;
    }

    public void setBdh(String bdh) {
        this.bdh = bdh;
    }

    public String getCdrq() {
        return cdrq;
    }

    public void setCdrq(String cdrq) {
        this.cdrq = cdrq;
    }

    public String getLah() {
        return lah;
    }

    public void setLah(String lah) {
        this.lah = lah;
    }

    public String getAjxz() {
        return ajxz;
    }

    public void setAjxz(String ajxz) {
        this.ajxz = ajxz;
    }

    public String getCxrq() {
        return cxrq;
    }

    public void setCxrq(String cxrq) {
        this.cxrq = cxrq;
    }

    public String getSgclfs() {
        return sgclfs;
    }

    public void setSgclfs(String sgclfs) {
        this.sgclfs = sgclfs;
    }

    public String getGsje() {
        return gsje;
    }

    public void setGsje(String gsje) {
        this.gsje = gsje;
    }

    public String getGjpk() {
        return gjpk;
    }

    public void setGjpk(String gjpk) {
        this.gjpk = gjpk;
    }

    public String getPfje() {
        return pfje;
    }

    public void setPfje(String pfje) {
        this.pfje = pfje;
    }

    public String getBar() {
        return bar;
    }

    public void setBar(String bar) {
        this.bar = bar;
    }

    public String getBardh() {
        return bardh;
    }

    public void setBardh(String bardh) {
        this.bardh = bardh;
    }

    public String getCky() {
        return cky;
    }

    public void setCky(String cky) {
        this.cky = cky;
    }

    public String getCxdz() {
        return cxdz;
    }

    public void setCxdz(String cxdz) {
        this.cxdz = cxdz;
    }

    public String getCxyy() {
        return cxyy;
    }

    public void setCxyy(String cxyy) {
        this.cxyy = cxyy;
    }

    public String getJsr() {
        return jsr;
    }

    public void setJsr(String jsr) {
        this.jsr = jsr;
    }

    public String getJsz() {
        return jsz;
    }

    public void setJsz(String jsz) {
        this.jsz = jsz;
    }

    public String getCpxh() {
        return cpxh;
    }

    public void setCpxh(String cpxh) {
        this.cpxh = cpxh;
    }

    public String getCph() {
        return cph;
    }

    public void setCph(String cph) {
        this.cph = cph;
    }

    public String getCxjg() {
        return cxjg;
    }

    public void setCxjg(String cxjg) {
        this.cxjg = cxjg;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}