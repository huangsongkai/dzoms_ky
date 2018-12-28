package com.dz.common.other;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.MutablePair;
import org.apache.commons.lang3.tuple.Pair;

import javax.script.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.*;

/**
 * Created by Wang on 2018/11/27.
 */
public class ScriptContext {
    public static final String LASTEST = "lastest";
    private static ScriptContext ourInstance = null;

    static ScriptEngineManager scriptEngineManager = new ScriptEngineManager();
    static ScriptEngine nashorn = null;
    Invocable invocable;

    public static ScriptContext getInstance() {
        if (ourInstance == null) {
            synchronized (ScriptContext.class){
                if (ourInstance == null) {
                    String javaVersion = System.getProperty("java.version");
                    String[] strs = StringUtils.split(javaVersion, '.');
                    if (Integer.parseInt(strs[0]) <= 1 && Integer.parseInt(strs[1]) < 8) {
                        try {
                            URL openjdk_asm = new URL("jar:file:./libs/openjdk-asm.jar!/");
                            URL openjdk_nashorn = new URL("jar:file:./libs/nashorn.jar!/");
                            URLClassLoader loader = URLClassLoader.newInstance(new URL[]{openjdk_asm,openjdk_nashorn});
                            Class<?> factoryClass = loader.loadClass("jdk.nashorn.api.scripting.NashornScriptEngineFactory");
                            ScriptEngineFactory factory = (ScriptEngineFactory) factoryClass.newInstance();
                            scriptEngineManager.registerEngineName("Nashorn",factory);
                            Method getEngineWithLoader = factoryClass.getDeclaredMethod("getScriptEngine",ClassLoader.class);
//                            nashorn = factory.getScriptEngine(loader);
                            nashorn = (ScriptEngine) getEngineWithLoader.invoke(factory,loader);
                        } catch (MalformedURLException e) {
                            e.printStackTrace();
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        } catch (InstantiationException e) {
                            e.printStackTrace();
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } catch (NoSuchMethodException e) {
                            e.printStackTrace();
                        } catch (InvocationTargetException e) {
                            e.printStackTrace();
                        }

                    }
                    ourInstance = new ScriptContext();
                }
            }
        }
        return ourInstance;
    }

    private ScriptContext() {
        if (nashorn == null) {
            nashorn = scriptEngineManager.getEngineByName("Nashorn");
        }

        invocable = (Invocable)nashorn;
    }

    public void runScript(String script) throws ScriptException {
        nashorn.eval(script);
    }

    public void registService(String name,String version,Object serviceObject){
        Map<String,Object> versionMap;
//        serviceObject.setMember("version",version);
        if (serviceMap.containsKey(name)){
            versionMap = serviceMap.get(name);
        }else {
            versionMap = new HashMap<>();
        }
        versionMap.put(version,serviceObject);

        String maxVersion = null;
        for (String v : versionMap.keySet()) {
            if(!v.equals(LASTEST) && (maxVersion==null || maxVersion.compareTo(v)<0)){
                maxVersion = v;
            }
        }

        if (maxVersion==null || maxVersion.equals(version)){
            versionMap.put(LASTEST,serviceObject);
        }

        serviceMap.put(name,versionMap);
    }

    public void registBinding(String name,String callName){
        bindings.put(callName,name);
    }

    public Object getService(String name,String version){
        Map<String,Object> versionMap = serviceMap.get(name);
        if (versionMap == null) {
            return null;
        }
        if(versionMap.containsKey(version)){
            return versionMap.get(version);
        }
        return versionMap.get(LASTEST);
    }
    
    public Pair<String,Object> getServiceWithVersion(String name,String version){
        Map<String,Object> versionMap = serviceMap.get(name);
        if (versionMap == null) {
            return null;
        }
        if(versionMap.containsKey(version)){
            Object o = versionMap.get(version);
            return new MutablePair<>(version,o);
        }
        Object o = versionMap.get(LASTEST);
        SortedSet<String> versions = new TreeSet<>(versionMap.keySet());
        versions.remove(LASTEST);
        
        return new MutablePair<>(versions.last(),o);
    }

    public Object getService(String name){
        return getService(name,LASTEST);
    }

    public Object getServiceByBinding(String callName){
        if(bindings.containsKey(callName)){
            return getService(bindings.get(callName));
        }
        return null;
    }

    public boolean containsBinding(String callName){
        return bindings.containsKey(callName);
    }

    public Object runFunc(Object funcInstance,Object self,Object... params) throws ScriptException, NoSuchMethodException {
        List<Object> ol = new ArrayList<>();
        ol.add(self);
        ol.addAll(Arrays.asList(params));
        return invocable.invokeMethod(funcInstance,"call",ol.toArray());
    }

    public Object runFunc(Object instance,String method,Object... params) throws ScriptException, NoSuchMethodException {
        return invocable.invokeMethod(instance,method,params);
    }

    private Map<String,String> bindings = new HashMap<>();
    private Map<String,Map<String,Object>> serviceMap = new HashMap<>();

    public Set<String> getServiceSet(){
        return serviceMap.keySet();
    }

    public Set<String> getAvailableVersions(String name){
        Map<String,Object> versionMap = serviceMap.get(name);
        if (versionMap == null) {
            return Collections.emptySet();
        }
        return versionMap.keySet();
    }

    public static void main(String[] args) throws ScriptException, NoSuchMethodException {
//        ScriptContext scriptContext = ScriptContext.getInstance();
//        scriptContext.regist("add","function(name,a,b){return a+b;}");
//        Object result = scriptContext.call("add",1,2);
//        System.out.println(result);
        ScriptEngineManager scriptEngineManager = new ScriptEngineManager();
//        jdk.nashorn.api.scripting.NashornScriptEngineFactory scriptEngineFactory = new jdk.nashorn.api.scripting.NashornScriptEngineFactory();
//        scriptEngineManager.registerEngineName("Nashorn",scriptEngineFactory);
        ScriptEngine nashorn = scriptEngineManager.getEngineByName("Nashorn");
//        ScriptEngine nashorn = scriptEngineFactory.getScriptEngine(Thread.currentThread().getContextClassLoader());
        Invocable invocable = (Invocable)nashorn;
        Object fn = nashorn.eval("function(a,b){return a+b;}");
        System.out.println(fn.getClass());
        System.out.println(fn);
        Object r = invocable.invokeMethod(fn,"call",null,1,2);
        System.out.println(r);
    }

}
