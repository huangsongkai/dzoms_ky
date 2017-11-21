package com.dz.kaiying.service.statistics;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.module.electric.ElectricHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by song on 2017/7/13.
 */
@Service
public class ElectricHistoryStatisticsService extends StatisticsService{
    @Autowired
    HibernateDao<ElectricHistory, Integer> accidentStatisticsDao;
    public MonthsCountDto getStatusDistribution() {
        MonthsCountDto monthsCountDto = new StatisticsService.MonthsCountDto();
        String[] sqls = {
                "select 1 from ElectricHistory as e,Vehicle as v where e.licenseNum = v.licenseNum and date >= $firstDay and date<$lastDay and v.dept='一部'",
                "select 1 from ElectricHistory as e,Vehicle as v where e.licenseNum = v.licenseNum and date >= $firstDay and date<$lastDay and v.dept='二部'",
                "select 1 from ElectricHistory as e,Vehicle as v where e.licenseNum = v.licenseNum and date >= $firstDay and date<$lastDay and v.dept='三部'",
//                "from Contract where contract_begin_date > $firstDay and contract_begin_date<$lastDay and branch_firm='二部'",
//                "from Contract where contract_begin_date > $firstDay and contract_begin_date<$lastDay and branch_firm='三部'"
        };
        return wholeYearBar(sqls, accidentStatisticsDao);
    }
}
