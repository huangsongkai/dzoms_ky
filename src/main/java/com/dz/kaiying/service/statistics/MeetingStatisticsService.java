package com.dz.kaiying.service.statistics;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.module.driver.meeting.Meeting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by song on 2017/7/9.
 */
@Service
public class MeetingStatisticsService extends StatisticsService {
    @Autowired()
    HibernateDao<Meeting, Integer> meetingHibernateDao;
    public MonthsCountDto getStatusDistribution() {
        MonthsCountDto monthsCountDto = new MonthsCountDto();
        String[] sqls = {
                "from MeetingCheck where is_checked is null and need_check_time >= $firstDay and need_check_time < $lastDay",
                "from MeetingCheck where is_checked is not null and need_check_time >= $firstDay and need_check_time < $lastDay"
        };
        return wholeYearBar(sqls, meetingHibernateDao);
    }
}
