package com.dz.kaiying.service;

import com.dz.kaiying.DTO.DriverKpDTO;
import com.dz.kaiying.util.HibernateUtil;
import com.dz.kaiying.util.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by song on 2017/7/5.
 */
@Service
public class DriverKpService {
    @Autowired
    HibernateTemplate hibernateTemplate;
    @Autowired
    HibernateUtil hibernateUtil;

    public List<DriverKpDTO> getDtos(String ym){
        String month_first_day = TimeUtil.getFirstMonthDateByYM(ym);
        String month_last_day = TimeUtil.getLastMonthDateByYM(ym);
        //添加时间限制
        String dtoListSql = "select v.dept fgs, d.name xm, v.license_num cph, v.carframe_num djh, d.driver_class zfj, sg, wz,ts,lh,hd, mt,praise " +
                "from driver d left JOIN vehicle v on d.carframeNum = v.carframe_num " +
                "left Join (select count(1) sg, carId from accident where check_time > $month_first_day and check_time < $month_last_day GROUP BY carId ) as a on v.carframe_num = a.carId " +
                "left Join (select count(1) lh, id_num from meeting_check WHERE is_checked is null and need_check_time > $month_first_day and need_check_time < $month_last_day group by id_num ) l on l.id_num=d.id_num  " +
                "left Join (select count(1) wz, carframeNum from electric_history where date > $month_first_day and date < $month_last_day GROUP BY carframeNum ) e on e.carframeNum = v.carframe_num " +
                "left Join (select count(1) ts, vehicle_id from complain where complain_time > $month_first_day and complain_time < $month_last_day GROUP BY vehicle_id ) c on c.vehicle_id = v.carframe_num " +
                "left Join (select count(1) hd, id_num from activity_driver,activity where activity.id=activity_driver.activity_id and regist_time > $month_first_day and regist_time < $month_last_day GROUP BY id_num ) ac on ac.id_num = d.id_num " +
                "left Join (select count(1) mt,id_num from group_praise_driver gpd,group_praise gp where gpd.group_praise_id = gp.id and praise_time > $month_first_day and praise_time < $month_last_day GROUP BY id_num ) g on g.id_num = d.id_num " +
                "left Join (select count(1) praise, id_num from praise where regist_time > $month_first_day and regist_time < $month_last_day GROUP BY id_num ) p on p.id_num = d.id_num " +
                "where is_in_car = 1 " +
                "order by cph  ";
        dtoListSql = dtoListSql.replace("$month_first_day", month_first_day);
        dtoListSql = dtoListSql.replace("$month_last_day", month_last_day);
        List<Object[]> driverObjectList = hibernateUtil.queryBySql(dtoListSql);

        List<DriverKpDTO> driverKpDTOList = new ArrayList<>();
        for(Object[] o :driverObjectList ){
            int score = 100;
            DriverKpDTO driverKpDTO = new DriverKpDTO();
            driverKpDTO.setFgs(((String) o[0]).trim());
            driverKpDTO.setXm(((String) o[1]).trim());
            driverKpDTO.setCph(((String) o[2]).trim());
            driverKpDTO.setDjh(((String) o[3]).trim());
            driverKpDTO.setZfj(((String) o[4]).trim());
            driverKpDTO.setSg((BigInteger) o[5] == null?0:((BigInteger) o[5]).intValue());
            driverKpDTO.setWz((BigInteger) o[6] == null?0:((BigInteger) o[6]).intValue());
            driverKpDTO.setTs((BigInteger) o[7] == null?0:((BigInteger) o[7]).intValue());
            driverKpDTO.setLh((BigInteger) o[8] == null?0:((BigInteger) o[8]).intValue());
            driverKpDTO.setHd((BigInteger) o[9] == null?0:((BigInteger) o[9]).intValue());
            driverKpDTO.setMt((BigInteger) o[10] == null?0:((BigInteger) o[10]).intValue());
            driverKpDTO.setBy((BigInteger) o[11] == null?0:((BigInteger) o[11]).intValue());

            score = score - driverKpDTO.getSg()-driverKpDTO.getWz()-driverKpDTO.getTs()-driverKpDTO.getLh()
                    +driverKpDTO.getHd()+driverKpDTO.getBy()+driverKpDTO.getMt();
            driverKpDTO.setScore(score);
            driverKpDTOList.add(driverKpDTO);
        }
        return driverKpDTOList;
    }

}
