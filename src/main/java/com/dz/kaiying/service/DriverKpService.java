package com.dz.kaiying.service;

import com.dz.kaiying.DTO.DriverKpDTO;
import com.dz.kaiying.model.DriverKpParams;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.HibernateUtil;
import com.dz.kaiying.util.TimeUtil;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by song on 2017/7/5.
 */
@Service
public class DriverKpService {
    @Resource
    HibernateDao<DriverKpParams, Integer> driverKpParamsDao;
    @Autowired
    HibernateTemplate hibernateTemplate;
    @Autowired
    HibernateUtil hibernateUtil;
//    select count(1) from checkchargetable where contractId='308' and thisMonthTotalOwe > 0 and time >= '2017-01-01' and time <= '2017-12-01'
    public List<DriverKpDTO> getDtosByMonth(String ym){
        String month_first_day = TimeUtil.getFirstMonthDateByYM(ym);
        String month_last_day = TimeUtil.getLastMonthDateByYM(ym);
        return getDtosByTime(month_first_day, month_last_day);
    }


    public List<DriverKpDTO> getDtosByYear(String year){
        if(year.equals("")){
            Calendar date = Calendar.getInstance();
            year = String.valueOf(date.get(Calendar.YEAR));
        }
        String year_first_day = "'"+year + "-01-01"+"'";
        String year_last_day = "'"+year + "-12-31 23:59:59"+"'";
        return getDtosByTime(year_first_day, year_last_day);
    }

    public List<DriverKpDTO> getDtosByTime(String beg, String end){
//        String month_first_day = beg;
        String month_first_day = beg;
        String month_last_day = end;
        //添加时间限制
        String dtoListSql = "select v.dept fgs, d.name xm, v.license_num cph, v.carframe_num djh, d.driver_class zfj, sg, wz,ts,lh,hd, mt,praise, zj, (case when (v.driver_id = d.id_num) then 1 else 0 end) as 'isOwner',contract_begin_date,(case when (contract_begin_date > $month_first_day or  d.apply_time > $month_first_day) then 1 else 0 end) as 'isNew', cid, d.apply_time, a.sg_0, a.sg_1, a.sg_2,ts_score,hd_score, mt_score,praise_score from driver d  left join vehicle v on d.carframeNum = v.carframe_num  left join (select id as cid, carframe_num,contract_begin_date from contract a where not exists (select id from contract b where a.carframe_num = b.carframe_num and b.id > a.id)) as contract on contract.carframe_num = v.carframe_num  left Join (select count(1) lh, id_num from meeting_check WHERE is_checked is null and need_check_time >= $month_first_day and need_check_time <= $month_last_day group by id_num ) l on l.id_num=d.id_num   left Join (select sum(1) sg, sum(if(accident.shiguxingzhi='轻微',1,0)) sg_0, sum(if(accident.shiguxingzhi='一般',1,0)) sg_1, sum(if(accident.shiguxingzhi='重大',1,0)) sg_2, driverId from accident where accident.checker and timet >= $month_first_day and timet <= $month_last_day  and check_time is not null GROUP BY driverId ) as a on d.id_num   = a.driverId  left Join (select count(1) wz, carframeNum from electric_history where date >= $month_first_day and date <= $month_last_day GROUP BY carframeNum ) e on e.carframeNum = v.carframe_num  left Join (select count(1) ts, sum(grade) ts_score, deal_reault from complain where complain_time >= $month_first_day and complain_time <= $month_last_day GROUP BY deal_reault ) c on c.deal_reault = d.id_num  left Join (select count(1) hd, sum(grade) hd_score, id_num from activity_driver,activity where activity.id=activity_driver.activity_id and activity_time >= $month_first_day and activity_time <= $month_last_day GROUP BY id_num ) ac on ac.id_num = d.id_num  left Join (select count(1) mt, sum(grade) mt_score,id_num from group_praise_driver gpd,group_praise gp where gpd.group_praise_id = gp.id and praise_time >= $month_first_day and praise_time <= $month_last_day GROUP BY id_num ) g on g.id_num = d.id_num  left Join (select count(1) praise, sum(grade) praise_score, id_num from praise where praise_time >= $month_first_day and praise_time <= $month_last_day GROUP BY id_num ) p on p.id_num = d.id_num  left Join (select count(1) zj, contractId from checkchargetable where thisMonthTotalOwe > 0 and time >= $month_first_day and time <= $month_last_day group by contractId ) as ct on cid = ct.contractId  where is_in_car = 1 order by cph";
        dtoListSql = dtoListSql.replace("$month_first_day", month_first_day);
        dtoListSql = dtoListSql.replace("$month_last_day", month_last_day);
        System.out.println(dtoListSql);
        List<Object[]> driverObjectList = hibernateUtil.queryBySql(dtoListSql);

        List<DriverKpDTO> driverKpDTOList = new ArrayList<>();
        for(Object[] o :driverObjectList ){
            int score = 100;
            DriverKpDTO driverKpDTO = new DriverKpDTO();
            driverKpDTO.setFgs(o[0] == null ?"":((String) o[0]).trim());
            driverKpDTO.setXm(o[1] == null ?"":((String) o[1]).trim());
            driverKpDTO.setCph(o[2] == null ?"":((String) o[2]).trim());
            driverKpDTO.setDjh(o[3] == null ?"":((String) o[3]).trim());
            driverKpDTO.setZfj(o[4] == null ?"":((String) o[4]).trim());
            driverKpDTO.setSg(getSafeInt(o[5]));
            driverKpDTO.setWz(getSafeInt(o[6]));
            driverKpDTO.setTs(getSafeInt(o[7]));
            driverKpDTO.setLh(getSafeInt(o[8]));
            driverKpDTO.setHd(getSafeInt(o[9]));
            driverKpDTO.setMt(getSafeInt(o[10]));
            driverKpDTO.setPraise(getSafeInt(o[11]));
//            driverKpDTO.setZj((BigInteger) o[12] == null?0:((BigInteger) o[13]).intValue());
            driverKpDTO.setZj(getSafeInt(o[12]));
            driverKpDTO.setIsOwner(getSafeInt(o[13]));
            driverKpDTO.setIsNew(getSafeInt(o[15]));
            driverKpDTO.setSg_0(getSafeInt(o[18]));
            driverKpDTO.setSg_1(getSafeInt(o[19]));
            driverKpDTO.setSg_2(getSafeInt(o[20]));
            driverKpDTO.setTs_score(getSafeInt(o[21]));
            driverKpDTO.setHd_score(getSafeInt(o[22]));
            driverKpDTO.setMt_score(getSafeInt(o[23]));
            driverKpDTO.setPraise_score(getSafeInt(o[24]));
            driverKpDTO.setPay(0);
            driverKpDTO.setPay_score(0);

            CalcScore(driverKpDTO);
            /*score = score - driverKpDTO.getSg()-driverKpDTO.getWz()-driverKpDTO.getTs()-driverKpDTO.getLh()
                    +driverKpDTO.getHd()+driverKpDTO.getBy()+driverKpDTO.getMt();
            driverKpDTO.setScore(score);*/
            driverKpDTOList.add(driverKpDTO);
        }
        return driverKpDTOList;
    }

    int getSafeInt(Object obj){
        if(obj == null)
            return 0;
        if(obj instanceof BigInteger){
            return ((BigInteger) obj).intValue();
        }
        if(obj instanceof BigDecimal){
            return ((BigDecimal) obj).intValue();
        }
        if(obj instanceof Integer){
            return (Integer)obj;
        }
        if(obj instanceof Double){
            return ((Double) obj).intValue();
        }
        return 0;
    }

    void CalcScore(DriverKpDTO driverKpDTO){
        String[] properties = {"zj", "insurance", };
        DriverKpParams original = driverKpParamsDao.get(DriverKpParams.class, 1);

        if(original == null){
            return;
        }

        int score;

        int isOwner = driverKpDTO.getIsOwner();

        if(isOwner == 0)
            score = 0;
        else
            score = driverKpDTO.getZj() * original.getZj_0();
        driverKpDTO.setZj_score(getSmaller(score, original.getZj_total()));

        if(isOwner == 0)
            score = 0;
        else
            score = driverKpDTO.getInsurance() * original.getInsurance_0();
        driverKpDTO.setInsurance_score(getSmaller(score, original.getInsurance_total()));

        score = driverKpDTO.getLaw() * original.getLaw_0();
        driverKpDTO.setLaw_score(getSmaller(score, original.getLaw_total()));

        driverKpDTO.setTs_score(getSmaller(driverKpDTO.getTs_score(), original.getTs_total()));

        score = driverKpDTO.getSg_0()*original.getSg_0()+driverKpDTO.getSg_1()*original.getSg_1()+driverKpDTO.getSg_2()*original.getSg_2();
        driverKpDTO.setSg_score(getSmaller(score, original.getSg_total()));

        if(isOwner == 0)
            score = 0;
        else
            score = driverKpDTO.getWz() * original.getWz_0();
        driverKpDTO.setWz_score(getSmaller(score, original.getWz_total()));

        score = driverKpDTO.getLj() * original.getLj_0();
        driverKpDTO.setLj_score(getSmaller(score, original.getLj_total()));

        score = driverKpDTO.getLh() * original.getLh_0();
        driverKpDTO.setLh_score(getSmaller(score, original.getLh_total()));

        score = driverKpDTO.getZj_score()+driverKpDTO.getInsurance_score()+driverKpDTO.getLaw_score()+driverKpDTO.getTs_score()+
                driverKpDTO.getSg_score()+driverKpDTO.getWz_score()+driverKpDTO.getLj_score()+driverKpDTO.getLh_score();

        driverKpDTO.setScore(100 - score);

        driverKpDTO.setHd_score(getSmaller(driverKpDTO.getHd_score(), original.getHd_total()));

        driverKpDTO.setMt_score(getSmaller(driverKpDTO.getMt_score(), original.getMt_total()));

        driverKpDTO.setPraise_score(getSmaller(driverKpDTO.getPraise_score(),original.getMt_total()));

        score = driverKpDTO.getPay()*original.getPay_0();
        driverKpDTO.setPay_score(getSmaller(score, original.getPay_total()));

        score = driverKpDTO.getHd_score()+driverKpDTO.getMt_score()+driverKpDTO.getPraise_score()+driverKpDTO.getPay_score();
        driverKpDTO.setScore2(getSmaller(score, original.getScore2()));
    }

    int getSmaller(int a, int b){
        return a>b?b:a;
    }


    public boolean updateParams(DriverKpParams driverKpParams){
        DriverKpParams original = driverKpParamsDao.get(DriverKpParams.class, 1);
        try {
            if(original == null)
                original = new DriverKpParams();
            BeanUtils.copyProperties(original, driverKpParams);
            driverKpParamsDao.saveOrUpdate(original);
        } catch (Exception e) {
            return false;
        }
        return true;
    }


    public DriverKpParams getCalcParams() {
        return driverKpParamsDao.get(DriverKpParams.class, 1);
    }


}
