package com.dz.common.global;

import java.util.Date;

/**
 * @author doggy
 *         Created on 15-12-7.
 */

public class Global {
    @SuppressWarnings("deprecation")
    /**
     * 用于校验一个日期是否'年月'相等
     *
     */
	public static boolean isYearAndMonth(Date date1,Date date2){
        if(date1 == null||date2 == null) return false;
        return date1.getYear() == date2.getYear() && date1.getMonth() == date2.getMonth();
    }
}
