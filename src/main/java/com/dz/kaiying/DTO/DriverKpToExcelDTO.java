package com.dz.kaiying.DTO;

/**
 * Created by song on 2017/7/5.
 */
public class DriverKpToExcelDTO {
    String fgs;//分公司
    String cph;//车牌号
    int zj, zj_score;//租金迟交
    int law, law_score;//法律诉讼
    int insurance, insurance_score;//保险迟交
    int ts, ts_score;//投诉
    int sg, sg_2,  sg_1, sg_0, sg_score;//事故
    int wz, wz_score;//违章
    int lj, lj_score;//路检
    int lh, lh_score;//例会缺席
    int score;//减分总评
    int hd, hd_score;//活动
    int mt, mt_score;//媒体
    int praise, praise_score;//乘客表扬
    int pay, pay_score;//二维码支付
    int score2;//加分总评


    public String getFgs() {
        return fgs;
    }

    public void setFgs(String fgs) {
        this.fgs = fgs;
    }


    public String getCph() {
        return cph;
    }

    public void setCph(String cph) {
        this.cph = cph;
    }

    public int getZj() {
        return zj;
    }

    public void setZj(int zj) {
        this.zj = zj;
    }

    public int getZj_score() {
        return zj_score;
    }

    public void setZj_score(int zj_score) {
        this.zj_score = zj_score;
    }

    public int getLaw() {
        return law;
    }

    public void setLaw(int law) {
        this.law = law;
    }

    public int getLaw_score() {
        return law_score;
    }

    public void setLaw_score(int law_score) {
        this.law_score = law_score;
    }

    public int getInsurance() {
        return insurance;
    }

    public void setInsurance(int insurance) {
        this.insurance = insurance;
    }

    public int getInsurance_score() {
        return insurance_score;
    }

    public void setInsurance_score(int insurance_score) {
        this.insurance_score = insurance_score;
    }

    public int getTs() {
        return ts;
    }

    public void setTs(int ts) {
        this.ts = ts;
    }

    public int getTs_score() {
        return ts_score;
    }

    public void setTs_score(int ts_score) {
        this.ts_score = ts_score;
    }

    public int getSg() {
        return sg;
    }

    public void setSg(int sg) {
        this.sg = sg;
    }

    public int getSg_2() {
        return sg_2;
    }

    public void setSg_2(int sg_2) {
        this.sg_2 = sg_2;
    }

    public int getSg_1() {
        return sg_1;
    }

    public void setSg_1(int sg_1) {
        this.sg_1 = sg_1;
    }

    public int getSg_0() {
        return sg_0;
    }

    public void setSg_0(int sg_0) {
        this.sg_0 = sg_0;
    }

    public int getSg_score() {
        return sg_score;
    }

    public void setSg_score(int sg_score) {
        this.sg_score = sg_score;
    }

    public int getWz() {
        return wz;
    }

    public void setWz(int wz) {
        this.wz = wz;
    }

    public int getWz_score() {
        return wz_score;
    }

    public void setWz_score(int wz_score) {
        this.wz_score = wz_score;
    }

    public int getLj() {
        return lj;
    }

    public void setLj(int lj) {
        this.lj = lj;
    }

    public int getLj_score() {
        return lj_score;
    }

    public void setLj_score(int lj_score) {
        this.lj_score = lj_score;
    }

    public int getLh() {
        return lh;
    }

    public void setLh(int lh) {
        this.lh = lh;
    }

    public int getLh_score() {
        return lh_score;
    }

    public void setLh_score(int lh_score) {
        this.lh_score = lh_score;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getHd() {
        return hd;
    }

    public void setHd(int hd) {
        this.hd = hd;
    }

    public int getHd_score() {
        return hd_score;
    }

    public void setHd_score(int hd_score) {
        this.hd_score = hd_score;
    }

    public int getMt() {
        return mt;
    }

    public void setMt(int mt) {
        this.mt = mt;
    }

    public int getMt_score() {
        return mt_score;
    }

    public void setMt_score(int mt_score) {
        this.mt_score = mt_score;
    }

    public int getPraise() {
        return praise;
    }

    public void setPraise(int praise) {
        this.praise = praise;
    }

    public int getPraise_score() {
        return praise_score;
    }

    public void setPraise_score(int praise_score) {
        this.praise_score = praise_score;
    }

    public int getPay() {
        return pay;
    }

    public void setPay(int pay) {
        this.pay = pay;
    }

    public int getPay_score() {
        return pay_score;
    }

    public void setPay_score(int pay_score) {
        this.pay_score = pay_score;
    }

    public int getScore2() {
        return score2;
    }

    public void setScore2(int score2) {
        this.score2 = score2;
    }

    @Override
    public String toString() {
        return "DriverKpToExcelDTO{" +
                ", fgs='" + fgs + '\'' +
                ", cph='" + cph + '\'' +
                ", zj=" + zj +
                ", zj_score=" + zj_score +
                ", law=" + law +
                ", law_score=" + law_score +
                ", insurance=" + insurance +
                ", insurance_score=" + insurance_score +
                ", ts=" + ts +
                ", ts_score=" + ts_score +
                ", sg=" + sg +
                ", sg_2=" + sg_2 +
                ", sg_1=" + sg_1 +
                ", sg_0=" + sg_0 +
                ", sg_score=" + sg_score +
                ", wz=" + wz +
                ", wz_score=" + wz_score +
                ", lj=" + lj +
                ", lj_score=" + lj_score +
                ", lh=" + lh +
                ", lh_score=" + lh_score +
                ", score=" + score +
                ", hd=" + hd +
                ", hd_score=" + hd_score +
                ", mt=" + mt +
                ", mt_score=" + mt_score +
                ", praise=" + praise +
                ", praise_score=" + praise_score +
                ", pay=" + pay +
                ", pay_score=" + pay_score +
                ", score2=" + score2 +
                '\n';
    }
}
