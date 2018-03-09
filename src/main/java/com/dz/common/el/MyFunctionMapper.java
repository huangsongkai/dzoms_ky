package com.dz.common.el;

import javax.servlet.jsp.el.FunctionMapper;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class MyFunctionMapper implements FunctionMapper {

    private Map<String,Object> functionMap;

    public MyFunctionMapper() {
        this.functionMap = new HashMap<>();
    }

    public MyFunctionMapper(Map<String,Object> map) {
        this.functionMap = map;
    }

    public Method resolveFunction(String prefix, String localName) {
        Object bean = this.functionMap.get(prefix);
        if (bean == null) {
            return null;
        }
        Class<?> clazz = bean.getClass();
        Method[] methods = clazz.getMethods();
        for (Method method : methods) {
            if (method.getName().equals(localName))
                return method;
        }
        return null;
    }

    public MyFunctionMapper setFunctions(String prefix, Object bean){
        this.functionMap.put(prefix,bean);
        return this;
    }

}
