package com.dz.common.convertor;

import com.opensymphony.xwork2.conversion.TypeConversionException;

import org.apache.struts2.util.StrutsTypeConverter;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class DateTypeConverter extends StrutsTypeConverter {
	public  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
	public  SimpleDateFormat dateFormat0 = new SimpleDateFormat("yyyy-MM-dd");
	public  SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy/MM");
	public  SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	public  SimpleDateFormat dateFormat20 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public  SimpleDateFormat dateFormat3 = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	public  SimpleDateFormat dateFormat4 = new SimpleDateFormat("HH:mm");
	public  SimpleDateFormat dateFormat5 = new SimpleDateFormat("MM/dd");
	public  SimpleDateFormat dateFormat6 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");

	final static String pattern =  "^\\d{4}(\\/)\\d{1,2}\\/\\d{1,2}$";
	final static String pattern0 =  "^\\d{4}(\\-)\\d{1,2}\\-\\d{1,2}$";
	final static String pattern1 =  "^\\d{4}(\\/)\\d{1,2}$";
	final static String pattern2 =  "^\\d{4}(\\/)\\d{1,2}\\/\\d{1,2}\\s+\\d{2}:\\d{2}:\\d{2}$";
	final static String pattern20 =  "^\\d{4}(\\-)\\d{1,2}\\-\\d{1,2}\\s+\\d{2}:\\d{2}:\\d{2}$";
	final static String pattern3 =  "^\\d{4}(\\/)\\d{1,2}\\/\\d{1,2}\\s+\\d{2}:\\d{2}$";
	final static String pattern4 =  "^\\d{2}:\\d{2}$";
	final static String pattern5 =  "^\\d{1,2}\\/\\d{1,2}$";
	final static String pattern6 = "^\\d{4}-\\d{1,2}-\\d{1,2}\\s+\\d{2}:\\d{2}:\\d{2}\\.\\d{1,3}$";
	
	@SuppressWarnings("rawtypes")
	@Override
	public synchronized Object convertFromString(Map arg0, String[] values, Class arg2) {
		System.out.println("Convert from "+values[0]);
		if(values[0]==null||values[0].isEmpty()){
			return null;
		}
		String str = values[0].trim();
		Date date = null;
		try {
			if(str.matches(pattern)){
				date =  dateFormat.parse(str); 
			}
			if(str.matches(pattern0)){
				date =  dateFormat0.parse(str); 
			}
				
			if(str.matches(pattern1))
				date =   dateFormat1.parse(str); 
			if(str.matches(pattern2))
				date =   dateFormat2.parse(str); 
			if(str.matches(pattern20))
				date =   dateFormat20.parse(str); 
			if(str.matches(pattern3))
				date =   dateFormat3.parse(str); 
			if(str.matches(pattern4))
				date =   dateFormat4.parse(str); 
			if(str.matches(pattern5))
				date =   dateFormat5.parse(str);
			if(str.matches(pattern6)){
				date = dateFormat6.parse(str);
			}
			System.out.println(date);
			return date;
		} catch (Exception k) {
			System.out.println("exception get at time:"+values[0]);
			throw new TypeConversionException("invalid");
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String convertToString(Map arg0, Object arg1) {
		// TODO Auto-generated method stub
		return dateFormat.format(arg1);
	}
	
	public static String convertToString(Date date) {
		// TODO Auto-generated method stub
		return new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(date);
	}
	
	public static void main(String[] args) {
		DateTypeConverter convert = new DateTypeConverter();
		String sdate="2014-8-12";
		System.out.println(convert.convertFromString(null, new String[]{sdate}, null));
		
		Date date = new Date();
		String str  = convert.convertToString(null, date);
		System.out.println(str);
	}

}
