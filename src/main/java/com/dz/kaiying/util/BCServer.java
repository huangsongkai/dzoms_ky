package com.dz.kaiying.util;

/**
 * Created by song on 2016/12/23.
 */
public class BCServer {
    public static String SERVER_URL = "http://127.0.0.1:7050";
    public static String CCID = "d98ef63f879dd66d47f650997b778ffcea6abc427cd5c11563ebfcfc9da9d8185fa4fa928eb8e7508b4da9a046f0ba2172638914303eaaf1e24d175cd4470f80";
    public static String getTimeStamp(){
        return System.currentTimeMillis() / 1000 + "";
    }
}
