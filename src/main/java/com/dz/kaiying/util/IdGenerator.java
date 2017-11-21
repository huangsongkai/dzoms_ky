package com.dz.kaiying.util;

import java.util.Random;
import java.util.UUID;

/**
 * Created by song on 2016/12/21.
 */
public class IdGenerator {
    public static String getClientUUID(){
        return ("C_"+ UUID.randomUUID()).replace("-","");
    }
    public static String getInvoiceId(){
        String result = "";
        for(int i = 0; i < 10; i++){
            result += new Random().nextInt(10);
        }
        return  result;
    }
}
