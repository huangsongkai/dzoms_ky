package com.dz.kaiying.util;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by song on 2017/7/7.
 */
public class IdCardUtil {
    public static final String cityCode[] = { "11", "12", "13", "14", "15",
            "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41",
            "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61",
            "62", "63", "64", "65", "71", "81", "82", "91" };
    public static Map<String, String> cityCodes = new HashMap<String, String>();

    static {
        cityCodes.put("11", "北京");
        cityCodes.put("12", "天津");
        cityCodes.put("13", "河北");
        cityCodes.put("14", "山西");
        cityCodes.put("15", "内蒙古");
        cityCodes.put("21", "辽宁");
        cityCodes.put("22", "吉林");
        cityCodes.put("23", "黑龙江");
        cityCodes.put("31", "上海");
        cityCodes.put("32", "江苏");
        cityCodes.put("33", "浙江");
        cityCodes.put("34", "安徽");
        cityCodes.put("35", "福建");
        cityCodes.put("36", "江西");
        cityCodes.put("37", "山东");
        cityCodes.put("41", "河南");
        cityCodes.put("42", "湖北");
        cityCodes.put("43", "湖南");
        cityCodes.put("44", "广东");
        cityCodes.put("45", "广西");
        cityCodes.put("46", "海南");
        cityCodes.put("50", "重庆");
        cityCodes.put("51", "四川");
        cityCodes.put("52", "贵州");
        cityCodes.put("53", "云南");
        cityCodes.put("54", "西藏");
        cityCodes.put("61", "陕西");
        cityCodes.put("62", "甘肃");
        cityCodes.put("63", "青海");
        cityCodes.put("64", "宁夏");
        cityCodes.put("65", "新疆");
        cityCodes.put("71", "台湾");
        cityCodes.put("81", "香港");
        cityCodes.put("82", "澳门");
        cityCodes.put("91", "国外");
    }
    public static String getProvinceByCardId(String cardId){
        return cityCodes.get(cardId.substring(0,2));
    }
    public static int getAgeByCardId(String cardId){
        int year = Integer.parseInt(cardId.substring(6,10));
        return Calendar.getInstance().get(Calendar.YEAR)-year;
    }

    public static void main(String args[]){
        System.out.println(IdCardUtil.getAgeByCardId("230103199909091212"));
    }

}
