package com.dz.kaiying.util;

import java.math.BigDecimal;

/**
 * Created by song on 16/8/4.
 */
public class SafeEqualChecker {
    public static boolean isEqualSimpleType(Object dest, Object orig){
        if(dest == null && orig == null)
            return true;
        if(dest == orig)
            return true;
        if(dest.getClass() != orig.getClass()) {
            return false;
        }
        if(dest instanceof String) {
            return dest.equals(orig);
        }
        if (dest instanceof Integer || dest instanceof Long || dest instanceof Double){
            boolean b = dest.toString().equals(orig.toString());
            return b;
        }
        if (dest instanceof BigDecimal){
            return ((BigDecimal) dest).compareTo((BigDecimal)orig) == 0;
        }
        return false;
    }



}
