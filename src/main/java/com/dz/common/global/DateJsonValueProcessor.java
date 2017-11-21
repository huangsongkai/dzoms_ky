package com.dz.common.global;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.text.SimpleDateFormat;

/**
 * Created by Wang on 2017/5/7.
 */
public class DateJsonValueProcessor implements JsonValueProcessor {
    public static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    @Override
    public Object processArrayValue(Object o, JsonConfig jsonConfig) {
        return simpleDateFormat.format(o);
    }

    @Override
    public Object processObjectValue(String s, Object o, JsonConfig jsonConfig) {
        return simpleDateFormat.format(o);
    }
}
