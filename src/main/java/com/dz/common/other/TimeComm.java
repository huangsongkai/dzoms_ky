package com.dz.common.other;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeComm {
	public static Date getCurrentTime() {

		return new Date();
	}

	public static String getDateOfMon() {
		SimpleDateFormat sf = new SimpleDateFormat("MM-dd");
		return sf.format(new Date());
	}

	public static boolean isLeapYear() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int year = Integer.parseInt(sf.format(new Date()));
		
		boolean leadyear;
		
		if (year % 4 == 0 && year % 100 != 0) {
			leadyear = true;
		} else if (year % 400 == 0) {
			leadyear = true;
		} else {
			leadyear = false;
		}
		return leadyear;
	}
	
	public static Date convertDate(Date date){
		if(date!=null)
			return new Date(date.getTime());
		return null;
	}
	
	@SuppressWarnings("deprecation")
	public static String subDate(Date startdate,Date enddate){
		int month = 0;  
	    int day = 0;  
	    if (enddate.getDate() >= startdate.getDate()) {  
	        month = (enddate.getYear() - startdate.getYear()) * 12  
	                + enddate.getMonth() - startdate.getMonth();  
	        day = enddate.getDate() - startdate.getDate();  
	    } else {  
	        if (startdate.getDate() == getlastDay(startdate)) {  
	            if (enddate.getDate() == getlastDay(enddate)) {  
	                month = enddate.getYear() - startdate.getYear() * 12  
	                        + enddate.getMonth() - startdate.getMonth();  
	                day = 0;  
	            } else {  
	                month = enddate.getYear() - startdate.getYear() * 12  
	                        + enddate.getMonth() - startdate.getMonth() - 1;  
	                day = startdate.getDate();  
	  
	            }  
	        } else {  
	            if (enddate.getDate() == getlastDay(enddate)) {  
	                month = enddate.getYear() - startdate.getYear() * 12  
	                        + enddate.getMonth() - startdate.getMonth();  
	                day = 0;  
	            } else {  
	                month = enddate.getYear() - startdate.getYear() * 12  
	                        + enddate.getMonth() - startdate.getMonth() - 1;  
	  
	                int lastmonthday = getlastmonthDat(enddate);  
	                day = lastmonthday - startdate.getDate() + enddate.getDate();  
	  
	            }  
	        }  
	    }  
	    return  month + "个月,"+ (day+1)  +"天";  
	
	}
	
	public static long subDateToDays(Date startdate,Date enddate){
		long sub  = enddate.getTime() - startdate.getTime();
		sub/=1000;
		sub/=3600;
		sub/=24;
		sub+=1;
	    return sub;
	}

	@SuppressWarnings("deprecation")
	private static int getlastmonthDat(Date date) {
		date.setDate(1);  
	    date.setDate(date.getDate() - 1);  
	    return date.getDate();  
	}

	@SuppressWarnings("deprecation")
	private static int getlastDay(Date date) {
		date.setMonth(date.getMonth() + 1);  
	    date.setDate(1);  
	    date.setDate(date.getDate() - 1);  
	    return date.getDate();  
	}
	
	public static Date getDate(){
		return new Date();
	}
}
