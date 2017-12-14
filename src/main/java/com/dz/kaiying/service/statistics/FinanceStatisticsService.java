package com.dz.kaiying.service.statistics;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.module.charge.CheckChargeTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by song on 2017/7/13.
 */
@Service
public class FinanceStatisticsService extends StatisticsService{
    @Autowired
    HibernateDao<CheckChargeTable, Integer> financeStatisticsDao;
    public MonthsCountDto getStatusDistribution() {
        MonthsCountDto monthsCountDto = new MonthsCountDto();
        String[] sqls = {
                "select sum(planAll) from CheckChargeTable where time >= $firstDay and time<=$lastDay",
                "select sum(thisMonthTotalOwe) from CheckChargeTable where time >= $firstDay and time<=$lastDay",
        };
        monthsCountDto =  wholeYearBar(sqls, financeStatisticsDao);
        for(int i = 0 ; i < 12 ;i++){
            monthsCountDto.counts[1][i] =  monthsCountDto.counts[0][i]-  monthsCountDto.counts[1][i];
        }

        return monthsCountDto;
    }
    public MonthsCountDto getChargeMoney() {
        MonthsCountDto monthsCountDto = new MonthsCountDto();
        String[] sqls = {"select sum(total) from CheckChargeTable where dept='一部' and time >= $firstDay and time<$lastDay",
                "select sum(total) from CheckChargeTable where dept='二部' and time >= $firstDay and time<$lastDay ",
                "select sum(total) from CheckChargeTable where dept='三部' and time >= $firstDay and time<$lastDay "
        };
        return wholeYearBar(sqls, financeStatisticsDao);
    }

    @Override
    public int fetchCountsBySql(HibernateDao contractStatisticsDao, String sql, String firstDay, String lastDay){
        sql = sql.replace("$firstDay",firstDay).replace("$lastDay",lastDay);
        List result = contractStatisticsDao.find(sql);
        if(result.get(0) == null)
            return 0;
        return ((BigDecimal)result.get(0)).intValue();
    }

    public static void main(String args[]){
        BigDecimal bigDecimal = BigDecimal.valueOf(5.55);
        System.out.println(bigDecimal.intValue());
    }

}
