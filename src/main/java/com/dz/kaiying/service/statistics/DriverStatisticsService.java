package com.dz.kaiying.service.statistics;

import com.dz.kaiying.DTO.statistics.ValuePairDTO;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.IdCardUtil;
import com.dz.module.driver.Driver;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by song on 2017/7/7.
 */
@Service
public class DriverStatisticsService extends StatisticsService {
    @Resource
    HibernateDao<Driver, Integer> driverDao;
    public Map getLocationDistribution(){
        Map<String, Integer> locDist = new HashMap<String, Integer>();
        List<Driver> driverList = driverDao.find("from Driver where is_in_car=1");
        for(Driver driver : driverList){
            String loc = IdCardUtil.getProvinceByCardId(driver.getIdNum());
            if(locDist.get(loc) == null){
                locDist.put(loc, 1);
            }else {
                int i = locDist.get(loc) + 1;
                locDist.put(loc, i);
            }
        }
        return locDist;
    }
    public Map<Integer, Integer> getAgeDistribution(){
        Map<Integer, Integer> ageDist = new TreeMap<Integer, Integer>();
        List<Driver> driverList = driverDao.find("from Driver where is_in_car=1");
        for(Driver driver : driverList){
            int age = IdCardUtil.getAgeByCardId(driver.getIdNum());
            mapValuePlus(age, ageDist);
        }
        return ageDist;
    }



    public int[] getStatusDistribution() {
        int[] driverCount = new int[3];
        driverCount[0] = driverDao.find("from Driver where is_in_car=1").size(); //在车司机
        driverCount[1] = driverDao.find("from Driver").size()-driverCount[0];//离职司机
        driverCount[2] = driverDao.find("from Driver where insertTime >= '"+Calendar.getInstance().get(Calendar.YEAR)+"'").size();//今年新入职司机
        return driverCount;
    }

    public MonthsCountDto getDriverDistributionByMonth(){
        String[] sqls = {"from Driver where insertTime > $firstDay and insertTime < $lastDay"};
        return wholeYearBar(sqls, driverDao);
    }

    public  List<ValuePairDTO>  countByBranch() {
        int[] driverCount = new int[3];
        List<ValuePairDTO> distList = new ArrayList<ValuePairDTO>();
        distList.add(new ValuePairDTO("一部", driverDao.find("from Driver where is_in_car=1 and dept='一部'").size())); //在车司机
        distList.add(new ValuePairDTO("二部", driverDao.find("from Driver where is_in_car=1 and dept='二部'").size())); //在车司机
        distList.add(new ValuePairDTO("三部", driverDao.find("from Driver where is_in_car=1 and dept='三部'").size())); //在车司机
        return distList;
    }
}
