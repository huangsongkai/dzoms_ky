package com.dz.kaiying.service.statistics;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.TimeUtil;

import java.util.Map;

/**
 * Created by song on 2017/7/11.
 */
public class StatisticsService {
    protected void mapValuePlus(Object key, Map map){
        if(map.get(key) == null){
            map.put(key, 1);
        }else {
            int i = (Integer)map.get(key) + 1;
            map.put(key, i);
        }
    }
    public class MonthsCountDto{
        String[] keys = new String[12];
        public int[][] counts = new int[100][12];


        public String[] getKeys() {
            return keys;
        }

        public void setKeys(String[] keys) {
            this.keys = keys;
        }

        public int[][] getCounts() {
            return counts;
        }

        public void setCounts(int[][] data) {
            this.counts = data;
        }
    }

    public int fetchCountsBySql(HibernateDao contractStatisticsDao, String sql, String firstDay, String lastDay){
        sql = sql.replace("$firstDay",firstDay).replace("$lastDay",lastDay);
        return contractStatisticsDao.find(sql).size();
    }

    public MonthsCountDto wholeYearBar(String[] sqls, HibernateDao hibernateDao) {
//        Map<String, int[]> map = new TreeMap<>();
        MonthsCountDto monthsCountDto = new MonthsCountDto();
        for(int i=11; i>-1; i--){
            String month = TimeUtil.getMonthByShift(0,0-i);
            String firstDay = TimeUtil.getFirstMonthDateByYM(month);
            String lastDay = TimeUtil.getLastMonthDateByYM(month);
            //历史该月的有效合同应该是开始时间早于该月的结束时间
            for(int j = 0; j < sqls.length; j++){
                monthsCountDto.counts[j][11-i] = fetchCountsBySql(hibernateDao, sqls[j], firstDay, lastDay);
            }
            monthsCountDto.keys[11-i] = month;
        }
        return monthsCountDto;
    }

}

