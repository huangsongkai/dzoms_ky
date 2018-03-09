package com.dz.common.el;

import javax.servlet.jsp.el.ELException;
import java.util.HashMap;
import java.util.Map;

public class MyVariableResolver implements javax.servlet.jsp.el.VariableResolver {

    private Map<String,Object> variableMap;

    public MyVariableResolver() {
        this.variableMap = new HashMap<>();
    }

    public void addVariable(String variable, Object value) {
        this.variableMap.put(variable, value);
    }

    public Object resolveVariable(String pName) throws ELException {
        return this.variableMap.get(pName);
    }

}
