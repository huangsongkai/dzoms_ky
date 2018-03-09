package com.dz.common.el;

import com.dz.common.other.ExcelOutputUtil;
import org.apache.commons.jexl2.Expression;
import org.apache.commons.jexl2.JexlContext;
import org.apache.commons.jexl2.JexlEngine;
import org.apache.commons.jexl2.MapContext;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;

import java.util.Collections;
import java.util.regex.MatchResult;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ELUtil {
    public static void main(String[] args){
        ELUtil ELUtil = new ELUtil();
//        ELUtil.mapper.setFunctions("my", new ExcelOutputUtil.MyELFunctionExtend());

//        assertEquals("2", ELUtil.evaluate("1 + 1"));
//        assertEquals("5", ELUtil.evaluate("10 - 5"));
//        System.out.println("${ 1+1 }".matches("\\$\\{(\\s|.)*?}"));
//        System.out.println("Hello ${ 1+1 }=${10-8}?".matches("\\$\\{(\\r|\\n| |.)*?}"));

        ELUtil.eval("Hello ${ 1+1 }=${10-8}?");
    }

    static void assertEquals(String expect,String value){
        Validate.isTrue(StringUtils.equals(expect,value));
    }

    JexlEngine engine;
    JexlContext context;

    public ELUtil(){
        engine = new JexlEngine();
        context = new MapContext();
        engine.setFunctions(Collections.<String, Object>singletonMap("my", new ExcelOutputUtil.MyELFunctionExtend()));
    }

    public String evaluate(String input) {
        Expression expression = engine.createExpression(input);
        Object value = expression.evaluate(context);
        return value==null?null:value.toString();
    }

    public String eval(String inputString){
        String regex = "\\$\\{((\\s|.)*?)}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(inputString);

        while (matcher.find()){
            System.out.println(matcher.group(1));
        }
        return inputString;
    }
}
