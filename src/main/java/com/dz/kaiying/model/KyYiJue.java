package com.dz.kaiying.model;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * @author zhangyanqi
 * @since 1.0 2017/11/22
 * <p>
 * 对应Excel的已决
 */

@Entity
@Table(name = "ky_yijue", catalog = "ky_dzomsdb")
public class KyYiJue implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id") //主键
    private Integer id;

    @Column(name = "pdh")
    private String pdh; //赔偿单号

    @Column(name = "xzdm")
    private String xzdm; //险种代码

    @Column(name = "bdgsjg")
    private String bdgsjg; //保单归属机构

    @Column(name = "tkdm")
    private String tkdm;//条款代码

    @Column(name = "jssh")
    private String jssh; //计算书号

    @Column(name = "lah")
    private String lah; //立案号

    @Column(name = "bah")
    private String bah; //报案号

    @Column(name = "barq")
    private String barq; //报案日期

    @Column(name = "bdh")
    private String bdh; //保单号

    @Column(name = "qbrq")
    private String qbrq; //起保日期

    @Column(name = "zbrq")
    private String zbrq; //终保日期

    @Column(name = "be")
    private String be; //保额

    @Column(name = "bf")
    private String bf; //保费

    @Column(name = "xcgzj")
    private String xcgzj; //新车购置价

    @Column(name = "palb")
    private String palb;//赔案类别

    @Column(name = "pclb")
    private String pclb;//赔偿类别

    @Column(name = "cxyy")
    private String cxyy;//出险原因

    @Column(name = "sglx")
    private String sglx;//事故类型

    @Column(name = "hprq")
    private String hprq;//核赔日期

    @Column(name = "hpr")
    private String hpr;//核赔人

    @Column(name = "lsrdm")
    private String lsrdm; //理算人代码

    @Column(name = "lsr")
    private String lsr; //理算人

    @Column(name = "cxrq")
    private String cxrq; //出险日期

    @Column(name = "larq")
    private String larq; //立案日期

    @Column(name = "jarq")
    private String jarq; //结案日期

    @Column(name = "pfje")
    private String pfje; //赔付金额

    @Column(name = "cwfkje")
    private String cwfkje;  //财务付款金额

    @Column(name = "bbxr")
    private String bbxr;  //被保险人

    @Column(name = "lkrlx")
    private String lkrlx;  //领款人类型

    @Column(name = "lkr")
    private String lkr;  //领款人

    @Column(name = "lkrdh")
    private String lkrdh;  //领款人电话

    @Column(name = "zjlx")
    private String zjlx;  //证件类型

    @Column(name = "zjhm")
    private String zjhm;  //证件号码

    @Column(name = "khh")
    private String khh;  //开户行

    @Column(name = "yhdm")
    private String yhdm;  //银行代码

    @Column(name = "yhzh")
    private String yhzh;  //银行账号

    @Column(name = "qydm")
    private String qydm;  //区域代码

    @Column(name = "gsbz")
    private String gsbz;  //共私标志

    @Column(name = "bar")
    private String bar;  //报案人

    @Column(name = "bardh")
    private String bardh;  //报案人电话

    @Column(name = "bdjbr")
    private String bdjbr;  //保单经办人

    @Column(name = "cxdd")
    private String cxdd;  //出险地点

    @Column(name = "cph")
    private String cph;  //车牌号

    @Column(name = "cx")
    private String cx;  //车型

    @Column(name = "ywly")
    private String ywly; //业务来源

    @Column(name = "tpbz")
    private String tpbz;  //通赔标志

    @Column(name = "ckydm1")
    private String ckydm1;  //查勘员代码

    @Column(name = "cky1")
    private String cky1;  //查勘员

    @Column(name = "ckydm2")
    private String ckydm2;  //查勘员代码

    @Column(name = "cky2")
    private String cky2;  //查勘员

    @Column(name = "hsydm")
    private String hsydm;  //核损员代码

    @Column(name = "hsy")
    private String hys;  //核损员
    private String dept;

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPdh() {
        return pdh;
    }

    public void setPdh(String pdh) {
        this.pdh = pdh;
    }

    public String getXzdm() {
        return xzdm;
    }

    public void setXzdm(String xzdm) {
        this.xzdm = xzdm;
    }

    public String getBdgsjg() {
        return bdgsjg;
    }

    public void setBdgsjg(String bdgsjg) {
        this.bdgsjg = bdgsjg;
    }

    public String getTkdm() {
        return tkdm;
    }

    public void setTkdm(String tkdm) {
        this.tkdm = tkdm;
    }

    public String getJssh() {
        return jssh;
    }

    public void setJssh(String jssh) {
        this.jssh = jssh;
    }

    public String getLah() {
        return lah;
    }

    public void setLah(String lah) {
        this.lah = lah;
    }

    public String getBah() {
        return bah;
    }

    public void setBah(String bah) {
        this.bah = bah;
    }

    public String getBarq() {
        return barq;
    }

    public void setBarq(String barq) {
        this.barq = barq;
    }

    public String getBdh() {
        return bdh;
    }

    public void setBdh(String bdh) {
        this.bdh = bdh;
    }

    public String getQbrq() {
        return qbrq;
    }

    public void setQbrq(String qbrq) {
        this.qbrq = qbrq;
    }

    public String getBe() {
        return be;
    }

    public void setBe(String be) {
        this.be = be;
    }

    public String getBf() {
        return bf;
    }

    public void setBf(String bf) {
        this.bf = bf;
    }

    public String getXcgzj() {
        return xcgzj;
    }

    public void setXcgzj(String xcgzj) {
        this.xcgzj = xcgzj;
    }

    public String getPalb() {
        return palb;
    }

    public void setPalb(String palb) {
        this.palb = palb;
    }

    public String getPclb() {
        return pclb;
    }

    public void setPclb(String pclb) {
        this.pclb = pclb;
    }

    public String getCxyy() {
        return cxyy;
    }

    public void setCxyy(String cxyy) {
        this.cxyy = cxyy;
    }

    public String getSglx() {
        return sglx;
    }

    public void setSglx(String sglx) {
        this.sglx = sglx;
    }

    public String getHprq() {
        return hprq;
    }

    public void setHprq(String hprq) {
        this.hprq = hprq;
    }

    public String getHpr() {
        return hpr;
    }

    public void setHpr(String hpr) {
        this.hpr = hpr;
    }

    public String getLsrdm() {
        return lsrdm;
    }

    public void setLsrdm(String lsrdm) {
        this.lsrdm = lsrdm;
    }

    public String getLsr() {
        return lsr;
    }

    public void setLsr(String lsr) {
        this.lsr = lsr;
    }

    public String getCxrq() {
        return cxrq;
    }

    public void setCxrq(String cxrq) {
        this.cxrq = cxrq;
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

    public String getPfje() {
        return pfje;
    }

    public void setPfje(String pfje) {
        this.pfje = pfje;
    }

    public String getCwfkje() {
        return cwfkje;
    }

    public void setCwfkje(String cwfkje) {
        this.cwfkje = cwfkje;
    }

    public String getBbxr() {
        return bbxr;
    }

    public void setBbxr(String bbxr) {
        this.bbxr = bbxr;
    }

    public String getLkrlx() {
        return lkrlx;
    }

    public void setLkrlx(String lkrlx) {
        this.lkrlx = lkrlx;
    }

    public String getLkr() {
        return lkr;
    }

    public void setLkr(String lkr) {
        this.lkr = lkr;
    }

    public String getLkrdh() {
        return lkrdh;
    }

    public void setLkrdh(String lkrdh) {
        this.lkrdh = lkrdh;
    }

    public String getZjlx() {
        return zjlx;
    }

    public void setZjlx(String zjlx) {
        this.zjlx = zjlx;
    }

    public String getZjhm() {
        return zjhm;
    }

    public void setZjhm(String zjhm) {
        this.zjhm = zjhm;
    }

    public String getKhh() {
        return khh;
    }

    public void setKhh(String khh) {
        this.khh = khh;
    }

    public String getYhdm() {
        return yhdm;
    }

    public void setYhdm(String yhdm) {
        this.yhdm = yhdm;
    }

    public String getYhzh() {
        return yhzh;
    }

    public void setYhzh(String yhzh) {
        this.yhzh = yhzh;
    }

    public String getQydm() {
        return qydm;
    }

    public void setQydm(String qydm) {
        this.qydm = qydm;
    }

    public String getGsbz() {
        return gsbz;
    }

    public void setGsbz(String gsbz) {
        this.gsbz = gsbz;
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

    public String getBdjbr() {
        return bdjbr;
    }

    public void setBdjbr(String bdjbr) {
        this.bdjbr = bdjbr;
    }

    public String getCxdd() {
        return cxdd;
    }

    public void setCxdd(String cxdd) {
        this.cxdd = cxdd;
    }

    public String getCph() {
        return cph;
    }

    public void setCph(String cph) {
        this.cph = cph;
    }

    public String getCx() {
        return cx;
    }

    public void setCx(String cx) {
        this.cx = cx;
    }

    public String getYwly() {
        return ywly;
    }

    public void setYwly(String ywly) {
        this.ywly = ywly;
    }

    public String getTpbz() {
        return tpbz;
    }

    public void setTpbz(String tpbz) {
        this.tpbz = tpbz;
    }

    public String getCkydm1() {
        return ckydm1;
    }

    public void setCkydm1(String ckydm1) {
        this.ckydm1 = ckydm1;
    }

    public String getCky1() {
        return cky1;
    }

    public void setCky1(String cky1) {
        this.cky1 = cky1;
    }

    public String getCkydm2() {
        return ckydm2;
    }

    public void setCkydm2(String ckydm2) {
        this.ckydm2 = ckydm2;
    }

    public String getCky2() {
        return cky2;
    }

    public void setCky2(String cky2) {
        this.cky2 = cky2;
    }

    public String getHsydm() {
        return hsydm;
    }

    public void setHsydm(String hsydm) {
        this.hsydm = hsydm;
    }

    public String getHys() {
        return hys;
    }

    public void setHys(String hys) {
        this.hys = hys;
    }


    public String getZbrq() {
        return zbrq;
    }

    public void setZbrq(String zbrq) {
        this.zbrq = zbrq;
    }

}
