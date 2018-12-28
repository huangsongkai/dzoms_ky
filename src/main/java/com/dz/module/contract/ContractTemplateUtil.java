package com.dz.module.contract;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.ScriptContext;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.script.ScriptException;
import java.io.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Wang on 2018/11/28.
 */
@Deprecated
public class ContractTemplateUtil {
    private static ContractTemplateUtil ourInstance = null;

    public static ContractTemplateUtil getInstance() {
        if (ourInstance == null) {
            synchronized (ContractTemplateUtil.class){
                if (ourInstance == null) {
                    ourInstance = new ContractTemplateUtil();
                }
                ourInstance.reloadScripts();
            }
        }
        return ourInstance;
    }

    private ContractTemplateUtil() {
    }

    public void addScript(SysScript script) throws RuntimeException {
        Session hsession = null;
        Transaction tx = null;
        try {
            ScriptContext scriptContext = ScriptContext.getInstance();
            scriptContext.runScript(script.getScript());

            hsession = HibernateSessionFactory.getSession();
            tx = hsession.beginTransaction();
            hsession.saveOrUpdate(script);
            tx.commit();
        }catch (HibernateException ex){
            throw new RuntimeException("数据库存储错误！");
        } catch (ScriptException e) {
            throw new RuntimeException("脚本格式有错错误！");
        } finally {
            HibernateSessionFactory.closeSession();
        }
    }

    public void reloadScripts(){
        Session hsession = null;
        try {
            ScriptContext scriptContext = ScriptContext.getInstance();

            hsession = HibernateSessionFactory.getSession();
            Query query = hsession.createQuery("from SysScript ");
            List<SysScript> sysScripts = query.list();
            for (SysScript sysScript : sysScripts) {
                if(sysScript.isActive())
                    try {
                        scriptContext.runScript(sysScript.getScript());
                    } catch (ScriptException e) {
                        e.printStackTrace();
                        System.out.println("脚本格式有错:"+sysScript.getName()+sysScript.getVersion());
                    }
            }

        }catch (HibernateException ex){
            throw new RuntimeException("数据库存储错误！");
        } finally {
            HibernateSessionFactory.closeSession();
        }
    }

    public static void main(String[] args) throws IOException, ScriptException, NoSuchMethodException {
        ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        HibernateSessionFactory.rebuildSessionFactory(applicationContext);

        ContractTemplateUtil util = ContractTemplateUtil.getInstance();

//        SysScript sysScript = new SysScript();
//        sysScript.setName("合同模版基础模块");
//        sysScript.setType("base");
//        sysScript.setVersion("1.0.0");
//
//        InputStream inputStream =  new FileInputStream("H:\\Code\\WorkSpaces\\git\\ky\\dzoms\\src\\main\\java\\com\\dz\\module\\contract\\template.js");
//        StringBuffer sb = new StringBuffer();
//        BufferedReader reader=new BufferedReader(new InputStreamReader(inputStream));
//        String line = "";
//        while ((line=reader.readLine())!=null){
//            sb.append(line);
//            sb.append('\n');
//        }
//        sysScript.setScript(sb.toString());
//        sysScript.setActive(true);
//        util.addScript(sysScript);

        util.reloadScripts();
        ContractTemplate template = ObjectAccess.getObject(ContractTemplate.class,1);
        System.out.println(template.getValidate());
        System.out.println(template.getSupportVersion());
        System.out.println(template.getMethod());

        Calendar calendar = Calendar.getInstance();
        Date from = calendar.getTime();
        calendar.add(Calendar.YEAR,2);
        System.out.println(template.generateRents(from,calendar.getTime(),12000.0));

//        ScriptContext scriptContext = ScriptContext.getInstance();
//        Object average_template_service = scriptContext.getService("average_template_service");
//        System.out.println(average_template_service);
//        Date date = new Date();
//        Object days = scriptContext.runFunc(average_template_service,"calDaysOfDate",date);
//        System.out.println(days);
    }
}
