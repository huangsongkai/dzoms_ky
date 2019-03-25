package com.dz.common.el;

import com.dz.common.other.ExcelOutputUtil;
import org.apache.commons.jexl3.*;
import org.apache.commons.lang3.Validate;

import java.util.Collections;
import java.util.HashMap;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ELUtil {
    public static void main(String[] args){
        ELUtil elUtil = new ELUtil();
//        ELUtil.mapper.setFunctions("my", new ExcelOutputUtil.MyELFunctionExtend());

        Validate.isTrue(2 == (Integer) elUtil.evaluate("1 + 1"));
//        assertEquals("5", ELUtil.evaluate("10 - 5"));
//        System.out.println("${ 1+1 }".matches("\\$\\{(\\s|.)*?}"));
//        System.out.println("Hello ${ 1+1 }=${10-8}?".matches("\\$\\{(\\r|\\n| |.)*?}"));

//        System.out.println(elUtil.eval("Hello ${ 1+1 }=${10-8}?"));
//        System.out.println(elUtil.eval("${abc=123}"));
//        System.out.println(elUtil.eval("${abc}"));
//        System.out.println(elUtil.compileAndEval("${$[租金]=96000.0}"));
//        System.out.println(elUtil.compileAndEval("${$[租金]/10;$[租金]=120}"));
//        System.out.println(elUtil.compileAndEval("${$[租金]}"));
//        System.out.println(elUtil.eval("${My:geneSeq(1)}"));
//        System.out.println(elUtil.eval("${My:geneSeq(1)} ${My:geneSeq(1)} ${My:geneSeq(1)} ${My:geneSeq(1)}"));
//        JexlScript script = elUtil.engine.createScript("1 == $0","$0");
//        System.out.println(script.execute(null,1));
//        System.out.println(script.execute(null,2));
//        System.out.println(elUtil.compileAndEvaluate("math:cosinus(45.0)"));
//        System.out.println(elUtil.compileAndEvaluate("var f1=function(x1){x1 + 1};"));
//        System.out.println(elUtil.compileAndEvaluate("f1(1)"));
//        System.out.println(elUtil.compileAndEvaluate("f1(2)"));
//        System.out.println(elUtil.compileAndEvaluate("var t = 20; var s = function(x, y) {x + y + t}; t = 54;\n s(15, 7)"));
    }

    static String notNull(Object input){
        if (input == null) {
            return "";
        }
        return input.toString();
    }

    private JexlEngine engine;
    private JexlContext context;

    public ELUtil(){
       this(new HashMap<String, Object>());
    }

    public ELUtil(Map objectMap){
        JexlBuilder builder = new JexlBuilder();
        Map<String,Object> functionMap = new HashMap<>(objectMap);
        functionMap.put("My",new ExcelOutputUtil.MyELFunctionExtend());
        engine = builder.namespaces(functionMap).create();

        context = new MapContext();
//        context.set("My",new ExcelOutputUtil.MyELFunctionExtend());
        context.set("variableMap",new HashMap<>());
    }

    public void setVariable(String name,Object value){
        ((HashMap) context.get("variableMap")).put(name,value);
    }

    public Object evaluate(String input) {
        String[] lines = input.split("\\n");
        Object value = null;
        for (String line : lines) {
            JexlExpression expression = engine.createExpression(line);
            value = expression.evaluate(context);
        }
        return value;
    }

    public String eval(String inputString){
        String regex = "\\$\\{((\\s|.)*?)}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(inputString);

        StringBuffer buffer = new StringBuffer();
        while (matcher.find()){
            String midStr = matcher.group(0);
            String rawStr = midStr.substring(2,midStr.length()-1);

            Object value = evaluate(rawStr);
            matcher.appendReplacement(buffer,Matcher.quoteReplacement(notNull(value)));
        }
        matcher.appendTail(buffer);
        return buffer.toString();
    }

    public String prepareCompile(String inputString){
        String regex = "\\$\\[((\\s|.)*?)]";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(inputString);

        StringBuffer buffer = new StringBuffer();
        while (matcher.find()){
            String midStr = matcher.group(0);
            String rawStr = midStr.substring(2,midStr.length()-1);

            String value = "variableMap['"+rawStr+"']";
            matcher.appendReplacement(buffer,Matcher.quoteReplacement(notNull(value)));
        }
        matcher.appendTail(buffer);
        return buffer.toString();
    }

    public String compileAndEval(String expression){
        return eval(prepareCompile(expression));
    }

    public Object compileAndEvaluate(String expression){
        return evaluate(prepareCompile(expression));
    }

    public JexlContext getContext() {
        return context;
    }

    public JexlEngine getEngine() {
        return engine;
    }
}
