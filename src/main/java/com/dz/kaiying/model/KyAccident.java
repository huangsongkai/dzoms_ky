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
    @Column(name = "id") //主键
    private Integer id;

    @Column(name = "sgclbm")
    private String sgclbm; //事故处理部门

    @Column(name = "barq")
    private String barq; //报案日期 ====

    public String getBarq() {
        return barq;
    }

    public void setBarq(String barq) {
        this.barq = barq;
    }

    @Column(name = "basj")
    private String basj; //报案时间

    @Column(name = "jasj") //结案时间
    private String jasj;

    @Column(name = "tpbz")//通赔标志
    private String tpbz;

    @Column(name = "ywly") //业务来源
    private String ywly;

    @Column(name = "bdh")//保单号
    private String bdh;

    @Column(name = "bdgsjg")//保单归属机构
    private String bdgsjg;

    @Column(name = "qbrq")//启保日期
    private String qbrq;

    @Column(name = "zbrq")//终保日期
    private String zbrq;

    @Column(name = "cdrq") //初登日期
    private String cdrq;



    /**
     * 张言琦添加
     */
    @Column(name = "tk") //条款==
    private String tk;

    @Column(name = "bf") //保费==
    private String bf;

    @Column(name = "bah")//报案号==
    private String bah;


    @Column(name = "lah") //立案号
    private String lah;

    @Column(name = "ajxz") //案件性质
    private String ajxz;

    @Column(name = "cxrq") //出险日期
    private String cxrq;

    @Column(name = "sgclfs") //事故处理方式
    private String sgclfs;


    @Column(name = "larq") //立案日期==
    private String larq;


    @Column(name = "jarq") //结案日期==
    private String jarq;

    @Column(name = "gsje") //估损金额
    private String gsje;

    @Column(name = "gjpk") //估计赔偿
    private String gjpk;

    @Column(name = "pfje") //赔付金额
    private String pfje;

    @Column(name = "bar") //报案人
    private String bar;

    @Column(name = "bardh") //报案人电话
    private String bardh;

    @Column(name = "cky") //查勘员1
    private String cky;

    @Column(name = "cky2")//勘察员2==
    private String cky2;

    @Column(name = "clrdm")
    private String clrdm;   //处理人代码==

    @Column(name = "bdjbr") //保单经办人==
    private String bdjbr;

    @Column(name = "bdgsr") //保单归属人==
    private String bdgsr;


    @Column(name = "cxdz") //出险地址
    private String cxdz;

    @Column(name = "cxyy") //出险原因
    private String cxyy;

    @Column(name = "jsr") //驾驶人
    private String jsr;

    @Column(name = "jsz") //驾驶证
    private String jsz;

    @Column(name = "cpxh") //厂牌型号
    private String cpxh;

    @Column(name = "cph") //车牌号
    private String cph;

    @Column(name = "bbxr") //被保险人==
    private String bbxr;

    @Column(name = "cxjg") //出险经过
    private String cxjg;

    @Column(name = "create_date") //创建时间
    private Date createDate;

    public String getSgclbm() {
        return sgclbm;
    }

    public void setSgclbm(String sgclbm) {
        this.sgclbm = sgclbm;
    }

    public String getTpbz() {
        return tpbz;
    }

    public void setTpbz(String tpbz) {
        this.tpbz = tpbz;
    }

    public String getYwly() {
        return ywly;
    }

    public void setYwly(String ywly) {
        this.ywly = ywly;
    }

    public String getBdgsjg() {
        return bdgsjg;
    }

    public void setBdgsjg(String bdgsjg) {
        this.bdgsjg = bdgsjg;
    }

    public String getQbrq() {
        return qbrq;
    }

    public void setQbrq(String qbrq) {
        this.qbrq = qbrq;
    }

    public String getZbrq() {
        return zbrq;
    }

    public void setZbrq(String zbrq) {
        this.zbrq = zbrq;
    }

    public String getTk() {
        return tk;
    }

    public void setTk(String tk) {
        this.tk = tk;
    }

    public String getBf() {
        return bf;
    }

    public void setBf(String bf) {
        this.bf = bf;
    }

    public String getBah() {
        return bah;
    }

    public void setBah(String bah) {
        this.bah = bah;
    }

    public String getLarq() {
        return larq;
    }

    public void setLarq(String larq) {
        this.larq = larq;
    }

    public String getJarq() {
        return jarq;
    }

    public void setJarq(String jarq) {
        this.jarq = jarq;
    }

    public String getCky2() {
        return cky2;
    }

    public void setCky2(String cky2) {
        this.cky2 = cky2;
    }

    public String getClrdm() {
        return clrdm;
    }

    public void setClrdm(String clrdm) {
        this.clrdm = clrdm;
    }

    public String getBdjbr() {
        return bdjbr;
    }

    public void setBdjbr(String bdjbr) {
        this.bdjbr = bdjbr;
    }

    public String getBdgsr() {
        return bdgsr;
    }

    public void setBdgsr(String bdgsr) {
        this.bdgsr = bdgsr;
    }

    public String getBbxr() {
        return bbxr;
    }

    public void setBbxr(String bbxr) {
        this.bbxr = bbxr;
    }


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