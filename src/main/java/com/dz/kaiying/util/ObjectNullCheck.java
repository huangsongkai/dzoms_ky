package com.dz.kaiying.util;

import java.lang.reflect.Field;

/**
 * Created by song on 16/7/28.
 */
public class ObjectNullCheck {
    public static boolean check(Object o){
        try {
            for(Field f : o.getClass().getDeclaredFields()){
                f.setAccessible(true);
                if (f.get(o) != null) { //判断字段是否为空，并且对象属性中的基本都会转为对象类型来判断
                    return false;
                }
            }
        }catch (Exception e){
            return true;
        }
        return true;
    }

    public static <E>  E getNonNullObject(Class<E> t, E object){
        if(object == null ){
            E e = null;
            try {
                e = t.newInstance();
            } catch (InstantiationException e1) {
                e1.printStackTrace();
            } catch (IllegalAccessException e1) {
                e1.printStackTrace();
            }
            return e;
        }
        return object;
    }
}
