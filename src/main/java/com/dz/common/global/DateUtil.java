package com.dz.common.global;

import java.util.Calendar;
import java.util.Date;

/**
 * @author doggy
 *         Created on 16-6-19.
 */
public class DateUtil {
    /**
     * 返回当前月份的下一个月份的Date日期.
     * @param now
     * @return
     */
    public static Date getNextMonth(Date now){
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        if(month == 11){
            year++;
            month = 0;
        }else {
            month++;
        }
        cal.set(Calendar.YEAR,year);
        cal.set(Calendar.MONTH,month);
        return cal.getTime();
    }

    public static Date getlastMonth(Date now){
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        if(month == 0){
            year--;
            month = 11;
        }else {
            month--;
        }
        cal.set(Calendar.YEAR,year);
        cal.set(Calendar.MONTH,month);
        return cal.getTime();
    }
    
    public static Date getlastMonth(){
    	Date now = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        if(month == 0){
            year--;
            month = 11;
        }else {
            month--;
        }
        cal.set(Calendar.YEAR,year);
        cal.set(Calendar.MONTH,month);
        return cal.getTime();
    }

    //比较date1与date2的年月关系，如果date1大于等于date2的年月，返回true
    @SuppressWarnings("deprecation")
    public static boolean isYM1BGYM2(Date date1,Date date2){
        if(date1 == null || date2 == null)
            return false;
        int year1 = date1.getYear();
        int month1 = date1.getMonth();
        int year2 = date2.getYear();
        int month2 = date2.getMonth();
        if(year1 > year2) return true;
        if(year1 == year2 && month1 >= month2) return true;
        return false;
    }

    /**
     * 如果date1与date2的年月相同返回true,否则返回false
     * @param date1
     * @param date2
     * @return
     */
    @SuppressWarnings("deprecation")
    public static boolean isYearAndMonth(Date date1, Date date2){
        if(date1 == null||date2 == null) return false;
        return date1.getYear() == date2.getYear() && date1.getMonth() == date2.getMonth();
    }

    
    public static boolean isInOneMonth26(Date onlyMonth,Date limit26){
        if(onlyMonth == null||limit26 == null) return false;
        return (onlyMonth.getYear() == limit26.getYear() && onlyMonth.getMonth() == limit26.getMonth() && limit26.getDate() <= 26)
        	||(onlyMonth.getYear() == limit26.getYear() && onlyMonth.getMonth() == limit26.getMonth()+1 && limit26.getDate() > 26)
        	||(onlyMonth.getYear() == limit26.getYear()+1 && onlyMonth.getMonth()==0 && limit26.getMonth()==11 && limit26.getDate() > 26);
    }
    
    public static Date getNextMonth26(Date srcDate){
        if(srcDate.getDate() >= 27){
            return getNextMonth(getNextMonth(srcDate));
        }else{
            return getNextMonth(srcDate);
        }
    }

    public static boolean isYM1BGYM2WithMonth26(Date date1,Date date2){
        if(date1 == null || date2 == null)
            return false;
        int year1 = date1.getYear();
        int month1 = date1.getMonth();
        int day1 = date1.getDate()>26?1:0;
        int year2 = date2.getYear();
        int month2 = date2.getMonth();
        int day2 = date2.getDate()>26?1:0;
        if(year1 > year2) return true;
        if(year1 == year2 && month1+day1 >= month2+day2) return true;
        return false;
    }
}
