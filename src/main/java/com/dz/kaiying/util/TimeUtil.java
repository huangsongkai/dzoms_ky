package com.dz.kaiying.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by song on 16/8/20.
 */
public class TimeUtil {


    public static Date stampToDate(String s){
        String res;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        long lt = new Long(s);
        Date date = new Date(lt);
//        res = simpleDateFormat.format(date);
//        return res;
        return date;
    }

    public static String getMonthByShift(int year, int month){
//        now.add(Calendar.YEAR, year);
        Calendar now = Calendar.getInstance();
        now.add(Calendar.MONTH, month);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        return sdf.format(now.getTime());
    }

    public static String now(){
        Calendar now = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        return sdf.format(now.getTime());
    }

    public static String getFirstMonthDateByYM(String ym){
        if(ym.equals("")){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
            ym = formatter.format(new Date());
        }
       return "'"+ym+"-01"+"'";
    }

    public static String getLastMonthDateByYM(String ym){
        if(ym.equals("")){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
            ym = formatter.format(new Date());
        }
        return "'"+ym+"-31 23:59:59"+"'";
    }

    public static void main(String args[]){
        for(int i = 0 ; i < 12; i++){
            System.out.println(TimeUtil.getMonthByShift(0, -i));
        }
    }
}
