package com.dz.kaiying.service.statistics;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.TimeUtil;
import com.dz.module.contract.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by song on 2017/7/9.
 */
@Service
public class ContractStatisticsService extends StatisticsService {
    @Autowired
    HibernateDao<Contract, Integer> contractStatisticsDao;
    public StatisticsService.MonthsCountDto getStatusDistribution() {
        MonthsCountDto monthsCountDto = new MonthsCountDto();
        String[] sqls = {"from Contract where state = 0 and contract_begin_date< $lastDay",
                "from Contract where contract_begin_date >= $firstDay and contract_begin_date<$lastDay and state=0",
                "from Contract where contract_end_date >= $firstDay and contract_end_date<$lastDay",
                "from Contract where contract_begin_date >= $firstDay and contract_begin_date<$lastDay and contract_from is not null",
        };
        return wholeYearBar(sqls, contractStatisticsDao);
    }

    public StatisticsService.MonthsCountDto getStatusDistributionByBranch() {
        MonthsCountDto monthsCountDto = new MonthsCountDto();
        String[] sqls = {"from Contract where contract_begin_date >= $firstDay and contract_begin_date<$lastDay and branch_firm='一部'",
                "from Contract where contract_begin_date >= $firstDay and contract_begin_date<$lastDay and branch_firm='二部'",
                "from Contract where contract_begin_date >= $firstDay and contract_begin_date<$lastDay and branch_firm='三部'"
        };
        return wholeYearBar(sqls, contractStatisticsDao);
    }



    public static void main(String args[]){
        String month = TimeUtil.getMonthByShift(0,0-1);
        String firstDay = TimeUtil.getFirstMonthDateByYM(month);
        String lastDay = TimeUtil.getLastMonthDateByYM(month);
        String sql = "from Contract where contract_end_date >= $firstDay and contract_end_date<$lastDay";
        sql = sql.replace("$firstDay",firstDay).replace("$lastDay",lastDay);
        System.out.println(sql);
    }
}
