package com.dz.kaiying.service;

import com.dz.kaiying.DTO.DriverKpDTO;
import com.dz.kaiying.model.DriverKpParams;
import com.dz.kaiying.model.DriverKpParamsDTO;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.HibernateUtil;
import com.dz.kaiying.util.TimeUtil;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
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
        String year_first_day = "'"+year + "-01-01 00:00:00"+"'";
        String year_last_day = "'"+year + "-12-31 23:59:59"+"'";
        return getDtosByTime(year_first_day, year_last_day);
    }

    public List<DriverKpDTO> getDtosByTime(String beg, String end)  {
//        String month_first_day = beg;
        String month_first_day = beg;
        String month_last_day = end;
        //添加时间限制
        String dtoListSql = "select v.dept fgs, v.license_num cph, v.carframe_num djh, sg, wz,ts,lh,hd, mt,praise, zj,aa.sg_0, aa.sg_1, aa.sg_2,ts_score,hd_score, mt_score,praise_score from vehicle v left Join (select count(1) lh, m.id_num id1, d.id_num id2,d.carframeNum car from meeting_check m LEFT JOIN driver d on m.id_num = d.id_num where m.is_checked is null and need_check_time>$month_first_day and need_check_time<$month_last_day and d.is_in_car =1 GROUP BY car)llLEFT  on v.carframe_num = llLEFT.car left Join (select count(1) sg,sum(sg_0) sg_0,sum(sg_1) sg_1,sum(sg_2) sg_2,cph from (select bah,sum(pfje) pfje,cph,if(sum(pfje)<5000,1,0) sg_0,if (sum(pfje)>=5000 and sum(pfje)<10000,1,0) sg_1,if (sum(pfje)>=10000,1,0) sg_2 ,jarq from ky_accident ky,vehicle veh where jarq >= $month_first_day and jarq <= $month_last_day and  ky.cph = veh.license_num or ky.cph = veh.engine_num group by bah)a LEFT JOIN vehicle v ON a.cph=v.license_num or a.cph = v.engine_num GROUP BY a.cph) as aa on aa.cph = v.license_num or aa.cph = v.engine_num left Join (select count(1) wz, carframeNum from electric_history where date >= $month_first_day and date <= $month_last_day GROUP BY carframeNum ) e on e.carframeNum = v.carframe_num  left Join (select count(1) ts, sum(grade) ts_score, deal_reault,vehicle_id vcj from complain where complain_time >= $month_first_day and complain_time <= $month_last_day GROUP BY vcj ) c on c.vcj = v.carframe_num  left Join (select sum(1) hd, sum(grade) hd_score, a.id_num ,v.driver_id from activity_driver a LEFT JOIN activity b on a.activity_id = b.id LEFT JOIN vehicle v on a.id_num=v.driver_id where v.carframe_num is not NULL and  activity_time >= $month_first_day and activity_time <= $month_last_day GROUP BY v.carframe_num) ac on ac.id_num = v.driver_id left Join (select count(1) mt, sum(grade) mt_score,gpd.id_num,v.carframe_num from group_praise_driver gpd LEFT JOIN group_praise gp on gpd.group_praise_id = gp.id LEFT JOIN vehicle v on v.driver_id = gpd.id_num where  praise_time >= $month_first_day and praise_time <= $month_last_day and v.carframe_num is not null GROUP BY v.carframe_num) g on g.carframe_num = v.carframe_num left Join (select count(1) praise, sum(grade) praise_score, p.id_num ,d.carframeNum from praise p LEFT JOIN driver d  ON p.id_num = d.id_num where praise_time >= $month_first_day and praise_time <= $month_last_day GROUP BY d.carframeNum) p on p.id_num = v.driver_id left Join (select count(1) zj, che.contractId, v.license_num from checkchargetable che LEFT JOIN vehicle v ON che.carNumber = v.license_num where thisMonthTotalOwe > 0 and time >= $month_first_day and time <= $month_last_day group by v.carframe_num) as ct on v.license_num = ct.license_num where v.state != 2 GROUP BY v.carframe_num order by v.carframe_num";
        dtoListSql = dtoListSql.replace("$month_first_day", month_first_day);
        dtoListSql = dtoListSql.replace("$month_last_day", month_last_day);
        System.out.println(dtoListSql);
        List<Object[]> driverObjectList = hibernateUtil.queryBySql(dtoListSql);

        List<DriverKpDTO> driverKpDTOList = new ArrayList<>();
        for(Object[] o :driverObjectList ){
            int score = 100;
            DriverKpDTO driverKpDTO = new DriverKpDTO();
            driverKpDTO.setFgs(o[0] == null ?"":((String) o[0]).trim());
//            driverKpDTO.setXm(o[1] == null ?"":((String) o[1]).trim());
            driverKpDTO.setCph(o[1] == null ?"":((String) o[1]).trim());
            driverKpDTO.setDjh(o[2] == null ?"":((String) o[2]).trim());
//            driverKpDTO.setZfj(o[4] == null ?"":((String) o[4]).trim());
            driverKpDTO.setSg(getSafeInt(o[3]));
            driverKpDTO.setWz(getSafeInt(o[4]));
            driverKpDTO.setTs(getSafeInt(o[5]));
            driverKpDTO.setLh(getSafeInt(o[6]));
            driverKpDTO.setHd(getSafeInt(o[7]));
            driverKpDTO.setMt(getSafeInt(o[8]));
            driverKpDTO.setPraise(getSafeInt(o[9]));
//            driverKpDTO.setZj((BigInteger) o[12] == null?0:((BigInteger) o[13]).intValue());
            driverKpDTO.setZj(getSafeInt(o[10]));
//            driverKpDTO.setIsOwner(getSafeInt(o[13]));
//            driverKpDTO.setIsNew(getSafeInt(o[15]));
            driverKpDTO.setSg_0(getSafeInt(o[11]));
            driverKpDTO.setSg_1(getSafeInt(o[12]));
            driverKpDTO.setSg_2(getSafeInt(o[13]));
            driverKpDTO.setTs_score(getSafeInt(o[14]));
            driverKpDTO.setHd_score(getSafeInt(o[15]));
            driverKpDTO.setMt_score(getSafeInt(o[16]));
            driverKpDTO.setPraise_score(getSafeInt(o[17]));
            driverKpDTO.setPay(0);
            driverKpDTO.setPay_score(0);
            calcScore(driverKpDTO);
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

    void calcScore(DriverKpDTO driverKpDTO){
        String[] properties = {"zj", "insurance", };
        List<DriverKpParams> originalList = driverKpParamsDao.loadAll(DriverKpParams.class);
        DriverKpParams original;
        if(originalList.size() == 0)
            return;
        else{
            original = originalList.get(0);
        }

        int score;

//        int isOwner = driverKpDTO.getIsOwner();
//
//        if(isOwner == 0)
//            score = 0;
//        else
        score = driverKpDTO.getZj() * original.getZj_0();
        driverKpDTO.setZj_score(getSmaller(score, original.getZj_total()));

//        if(isOwner == 0)
//            score = 0;
//        else
        score = driverKpDTO.getInsurance() * original.getInsurance_0();
        driverKpDTO.setInsurance_score(getSmaller(score, original.getInsurance_total()));

        score = driverKpDTO.getLaw() * original.getLaw_0();
        driverKpDTO.setLaw_score(getSmaller(score, original.getLaw_total()));

        driverKpDTO.setTs_score(getSmaller(driverKpDTO.getTs_score(), original.getTs_total()));

        score = driverKpDTO.getSg_0()*original.getSg_0()+driverKpDTO.getSg_1()*original.getSg_1()+driverKpDTO.getSg_2()*original.getSg_2();
        driverKpDTO.setSg_score(getSmaller(score, original.getSg_total()));

//        if(isOwner == 0)
//            score = 0;
//        else
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


    public boolean updateParams(DriverKpParamsDTO driverKpParams){
        List<DriverKpParams> originalList = driverKpParamsDao.loadAll(DriverKpParams.class);
        DriverKpParams original;
        try {
            if(originalList.size() == 0)
                original = new DriverKpParams();
            else{
                original = originalList.get(0);
            }
            BeanUtils.copyProperties(original, driverKpParams);
            driverKpParamsDao.saveOrUpdate(original);
        } catch (Exception e) {
            return false;
        }
        return true;
    }


    public DriverKpParams getCalcParams() {
        List<DriverKpParams> originalList = driverKpParamsDao.loadAll(DriverKpParams.class);
        if(originalList.size() == 0)
            return null;
        else{
            return originalList.get(0);
        }
    }


}
