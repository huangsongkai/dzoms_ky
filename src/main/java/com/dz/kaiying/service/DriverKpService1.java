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
public class DriverKpService1 {
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


    public List<DriverKpDTO> getDtosByYear(String year,String month){
        if(year.equals("")){
            Calendar date = Calendar.getInstance();
            year = String.valueOf(date.get(Calendar.YEAR));
        }
        if(month.equals("")||month==null){
            String year_first_day = "'"+year + "-01-01 00:00:00"+"'";
            String year_last_day = "'"+year + "-12-31 23:59:59"+"'";
            System.out.println(year_first_day+"-----"+year_last_day);
            return getDtosByTime(year_first_day, year_last_day);
        }else{
            int day=0;
            int years = Integer.parseInt(year);
            switch (Integer.parseInt(month)) {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    day = 31;
                    break;
                case 4:
                case 6:
                case 9:
                case 11:
                    day = 30;
                    break;
                case 2:
                    if ( ((years % 4 == 0) && !(years % 100 == 0)) || (years % 400 == 0))
                        day = 29;
                    else
                        day = 28;
                    break;
                default:
                    break;
            }
            String year_first_day = "'"+year + "-"+month+"-01 00:00:00"+"'";
            String year_last_day = "'"+year + "-"+month+"-"+day+" 23:59:59"+"'";
            System.out.println(year_first_day+"-----"+year_last_day);
            return getDtosByTime(year_first_day, year_last_day);
        }
    }

    public List<DriverKpDTO> getDtosByTime(String beg, String end){

//        String month_first_day = beg;
        String month_first_day = beg;
        String month_last_day = end;
        //添加时间限制
        String dtoListSql = "select v.dept fgs, d.name xm, v.license_num cph, v.carframe_num djh, d.driver_class zfj, sg, wz,ts,lh,hd, mt,praise, zj, (case when (v.driver_id = d.id_num) then 1 else 0 end) as 'isOwner',contract_begin_date,(case when (contract_begin_date > $month_first_day or  d.apply_time > $month_first_day) then 1 else 0 end) as 'isNew', cid, d.apply_time, sg_0, sg_1, sg_2,ts_score,hd_score, mt_score,praise_score from driver d  left join vehicle v on d.carframeNum = v.carframe_num  left join (select id as cid, carframe_num,contract_begin_date from contract a where not exists (select id from contract b where a.carframe_num = b.carframe_num and b.id > a.id)) as contract on contract.carframe_num = v.carframe_num  left Join (select count(1) lh, id_num from meeting_check WHERE is_checked is null and need_check_time >= $month_first_day and need_check_time <= $month_last_day group by id_num ) l on l.id_num=d.id_num  LEFT JOIN (select  count(1) sg,sum(sg_0) sg_0,sum(sg_1) sg_1,sum(sg_2) sg_2 ,a.cph from(select bah,sum(pfje) pfje,cph,if(sum(pfje)<5000,1,0) sg_0,if (sum(pfje)>=5000 and sum(pfje)<10000,1,0) sg_1,if (sum(pfje)>=10000,1,0) sg_2 ,jarq from ky_yijue ky,vehicle veh where jarq >= $month_first_day and jarq <= $month_last_day and  (ky.cph = veh.license_num or ky.cph = veh.engine_num) group by bah)a LEFT JOIN vehicle v ON a.cph=v.license_num or a.cph = v.engine_num GROUP BY cph)as aa on aa.cph = v.license_num left Join (select count(1) wz, carframeNum from electric_history where date >= $month_first_day and date <= $month_last_day GROUP BY carframeNum ) e on e.carframeNum = v.carframe_num  left Join (select count(1) ts, sum(grade) ts_score, deal_reault from complain where complain_time >= $month_first_day and complain_time <= $month_last_day GROUP BY deal_reault ) c on c.deal_reault = d.id_num  left Join (select count(1) hd, sum(grade) hd_score, id_num from activity_driver,activity where activity.id=activity_driver.activity_id and activity_time >= $month_first_day and activity_time <= $month_last_day GROUP BY id_num ) ac on ac.id_num = d.id_num  left Join (select count(1) mt, sum(grade) mt_score,id_num from group_praise_driver gpd,group_praise gp where gpd.group_praise_id = gp.id and praise_time >= $month_first_day and praise_time <= $month_last_day GROUP BY id_num ) g on g.id_num = d.id_num  left Join (select count(1) praise, sum(grade) praise_score, id_num from praise where praise_time >= $month_first_day and praise_time <= $month_last_day GROUP BY id_num ) p on p.id_num = d.id_num  left Join (select count(1) zj, contractId from checkchargetable where thisMonthTotalOwe > 0 and time >= $month_first_day and time <= $month_last_day group by contractId ) as ct on cid = ct.contractId  where is_in_car = 1 order by cph";
        dtoListSql = dtoListSql.replace("$month_first_day", month_first_day);
        dtoListSql = dtoListSql.replace("$month_last_day", month_last_day);
//        System.out.println(dtoListSql);
        List<Object[]> driverObjectList1 = hibernateUtil.queryBySql(dtoListSql);

        List<DriverKpDTO> DriverKpDTOList = new ArrayList<>();
        for(Object[] o :driverObjectList1 ){
            int score = 100;
            DriverKpDTO DriverKpDTO = new DriverKpDTO();
            DriverKpDTO.setFgs(o[0] == null ?"":((String) o[0]).trim());
            DriverKpDTO.setXm(o[1] == null ?"":((String) o[1]).trim());
            DriverKpDTO.setCph(o[2] == null ?"":((String) o[2]).trim());
            DriverKpDTO.setDjh(o[3] == null ?"":((String) o[3]).trim());
            DriverKpDTO.setZfj(o[4] == null ?"":((String) o[4]).trim());
            DriverKpDTO.setSg(getSafeInt(o[5]));
            DriverKpDTO.setWz(getSafeInt(o[6]));
            DriverKpDTO.setTs(getSafeInt(o[7]));
            DriverKpDTO.setLh(getSafeInt(o[8]));
            DriverKpDTO.setHd(getSafeInt(o[9]));
            DriverKpDTO.setMt(getSafeInt(o[10]));
            DriverKpDTO.setPraise(getSafeInt(o[11]));
//            DriverKpDTO.setZj((BigInteger) o[12] == null?0:((BigInteger) o[13]).intValue());
            DriverKpDTO.setZj(getSafeInt(o[12]));
            DriverKpDTO.setIsOwner(getSafeInt(o[13]));
            DriverKpDTO.setIsNew(getSafeInt(o[15]));
            DriverKpDTO.setSg_0(getSafeInt(o[18]));
            DriverKpDTO.setSg_1(getSafeInt(o[19]));
            DriverKpDTO.setSg_2(getSafeInt(o[20]));
            DriverKpDTO.setTs_score(getSafeInt(o[21]));
            DriverKpDTO.setHd_score(getSafeInt(o[22]));
            DriverKpDTO.setMt_score(getSafeInt(o[23]));
            DriverKpDTO.setPraise_score(getSafeInt(o[24]));
            DriverKpDTO.setPay(0);
            DriverKpDTO.setPay_score(0);

            calcScore(DriverKpDTO,beg,end);
            /*score = score - DriverKpDTO.getSg()-DriverKpDTO.getWz()-DriverKpDTO.getTs()-DriverKpDTO.getLh()
                    +DriverKpDTO.getHd()+DriverKpDTO.getBy()+DriverKpDTO.getMt();
            DriverKpDTO.setScore(score);*/
            DriverKpDTOList.add(DriverKpDTO);
        }
        return DriverKpDTOList;
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

    void calcScore(DriverKpDTO DriverKpDTO,String beg,String end){
        String[] properties = {"zj", "insurance", };
        List<DriverKpParams> originalList = driverKpParamsDao.loadAll(DriverKpParams.class);
        DriverKpParams original;
        if(originalList.size() == 0)
            return;
        else{
            original = originalList.get(0);
        }

        int score;

        int isOwner = DriverKpDTO.getIsOwner();

        if(isOwner == 0)
            score = 0;
        else
            score = DriverKpDTO.getZj() * original.getZj_0();
        DriverKpDTO.setZj_score(getSmaller(score, original.getZj_total()));

        if(isOwner == 0)
            score = 0;
        else
            score = DriverKpDTO.getInsurance() * original.getInsurance_0();
        DriverKpDTO.setInsurance_score(getSmaller(score, original.getInsurance_total()));

        score = DriverKpDTO.getLaw() * original.getLaw_0();
        DriverKpDTO.setLaw_score(getSmaller(score, original.getLaw_total()));

        DriverKpDTO.setTs_score(getSmaller(DriverKpDTO.getTs_score(), original.getTs_total()));

        score = DriverKpDTO.getSg_0()*original.getSg_0()+DriverKpDTO.getSg_1()*original.getSg_1()+DriverKpDTO.getSg_2()*original.getSg_2();
        DriverKpDTO.setSg_score(getSmaller(score, original.getSg_total()));


            String sql = "select sum(grade) grade from \n" +
                    "(select count(1)act1 ,e1.act ,sum(grade) grade \n" +
                    "from electric_history e1 LEFT JOIN electric_grade e2 on e1.act = e2.act   \n" +
                    "where licenseNum='"+DriverKpDTO.getCph()+"'and date>="+beg+"and date<="+end+" GROUP BY act) act";
        List<BigDecimal> each = hibernateUtil.queryBySql(sql);

        score=0;
        if(each.get(0)!=null) {
            score=each.get(0).intValue();
        }
//        score = driverKpDTO.getWz() * original.getWz_0();
        DriverKpDTO.setWz_score(getSmaller(score, original.getWz_total()));

        score = DriverKpDTO.getLj() * original.getLj_0();
        DriverKpDTO.setLj_score(getSmaller(score, original.getLj_total()));

        score = DriverKpDTO.getLh() * original.getLh_0();
        DriverKpDTO.setLh_score(getSmaller(score, original.getLh_total()));

        score = DriverKpDTO.getZj_score()+DriverKpDTO.getInsurance_score()+DriverKpDTO.getLaw_score()+DriverKpDTO.getTs_score()+
                DriverKpDTO.getSg_score()+DriverKpDTO.getWz_score()+DriverKpDTO.getLj_score()+DriverKpDTO.getLh_score();

        DriverKpDTO.setScore(100 - score);

        DriverKpDTO.setHd_score(getSmaller(DriverKpDTO.getHd_score(), original.getHd_total()));

        DriverKpDTO.setMt_score(getSmaller(DriverKpDTO.getMt_score(), original.getMt_total()));

        DriverKpDTO.setPraise_score(getSmaller(DriverKpDTO.getPraise_score(),original.getMt_total()));

        score = DriverKpDTO.getPay()*original.getPay_0();
        DriverKpDTO.setPay_score(getSmaller(score, original.getPay_total()));

        score = DriverKpDTO.getHd_score()+DriverKpDTO.getMt_score()+DriverKpDTO.getPraise_score()+DriverKpDTO.getPay_score();
        DriverKpDTO.setScore2(getSmaller(score, original.getScore2()));
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