package com.dz.common.global;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import java.lang.reflect.Field;
import java.util.Collection;
import java.util.Date;
import java.util.Set;

/**
 * Created by Wang on 2017/5/7.
 */
public class IgnoreFieldProcessorImpl implements PropertyFilter {

    /**
     * 忽略的属性名称
     */
    private String[] fields;

    /**
     * 是否忽略集合
     */
    private boolean ignoreColl = false;

    /**
     * 空参构造方法<br/>
     * 默认不忽略集合
     */
    public IgnoreFieldProcessorImpl() {
        // empty
    }

    /**
     * 构造方法
     * @param fields 忽略属性名称数组
     */
    public IgnoreFieldProcessorImpl(String[] fields) {
        this.fields = fields;
    }

    /**
     * 构造方法
     * @param ignoreColl	是否忽略集合
     * @param fields	忽略属性名称数组
     */
    public IgnoreFieldProcessorImpl(boolean ignoreColl, String[] fields) {
        this.fields = fields;
        this.ignoreColl = ignoreColl;
    }

    /**
     * 构造方法
     * @param ignoreColl 是否忽略集合
     */
    public IgnoreFieldProcessorImpl(boolean ignoreColl) {
        this.ignoreColl = ignoreColl;
    }

    public boolean apply(Object source, String name, Object value) {
        Field declaredField = null;
        //忽略值为null的属性
        if(value == null)
            return true;
        //剔除自定义属性，获取属性声明类型
        if(!"data".equals(name) && "data"!=name && !"totalSize".equals(name) && "totalSize"!=name ){
            try {
                declaredField = getDeclaredFieldByName(source, name);
            } catch (NoSuchFieldException e) {
                System.out.println(source.getClass().getName());
                e.printStackTrace();
            }
        }
        // 忽略集合
        if (declaredField != null) {
            if(ignoreColl) {
                if(declaredField.getType() == Collection.class
                        || declaredField.getType() == Set.class) {
                    return true;
                }
            }
        }

        // 忽略设定的属性
        if(fields != null && fields.length > 0) {
            return juge(fields, name);
        }
        return false;
    }

    private static Field getDeclaredFieldByName(Object source, String name) throws NoSuchFieldException {
        Class clazz = source.getClass();
        Field field = null;
        do{
            try {
                field = clazz.getDeclaredField(name);
            } catch (NoSuchFieldException e) {
                clazz = clazz.getSuperclass();
            }
        }while (field==null&&clazz!=null);
        return field;
    }

    /**
     * 过滤忽略的属性
     * @param s
     * @param s2
     * @return
     */
    public boolean juge(String[] s,String s2){
        boolean b = false;
        for(String sl : s){
            if(s2.equals(sl)){
                b=true;
            }
        }
        return b;
    }
    public String[] getFields() {
        return fields;
    }

    /**
     * 设置忽略的属性
     * @param fields
     */
    public void setFields(String[] fields) {
        this.fields = fields;
    }

    public boolean isIgnoreColl() {
        return ignoreColl;
    }

    /**
     * 设置是否忽略集合类
     * @param ignoreColl
     */
    public void setIgnoreColl(boolean ignoreColl) {
        this.ignoreColl = ignoreColl;
    }

    public static void main(String[]args){

    }

    public static JsonConfig getDefaultConfig(boolean ignoreColl,String... fields){
        JsonConfig config = new JsonConfig();
//        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor());
        config.setJsonPropertyFilter(new IgnoreFieldProcessorImpl(ignoreColl, fields)); // 忽略掉name属性及集合对象
        return config;
    }

    public static JsonConfig getDefaultConfig(){
        JsonConfig config = new JsonConfig();
//        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor());
        config.setJsonPropertyFilter(new IgnoreFieldProcessorImpl(true)); // 忽略掉集合对象
        return config;
    }
}
