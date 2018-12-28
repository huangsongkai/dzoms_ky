package com.dz.module.contract;

import com.dz.common.other.ScriptContext;
import org.apache.commons.lang3.tuple.Pair;

import javax.persistence.*;
import javax.script.ScriptException;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by Wang on 2018/11/28.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "contract_template")
@Deprecated
public class ContractTemplate implements Serializable {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private int id;

    private String name;
    private String method;
    private String version;
    private String comment;

    @Transient
    private Boolean validate;
    @Transient
    private String supportVersion;
    @Transient
    private Object methodObject;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    private void doValidate(){
        ContractTemplateUtil.getInstance();
        ScriptContext scriptContext = ScriptContext.getInstance();
        Pair<String,Object> jsVersion = scriptContext.getServiceWithVersion(method,version);
       try{
           if(jsVersion!=null){
               this.methodObject = jsVersion.getRight();
               this.supportVersion = jsVersion.getLeft();
//               this.supportVersion = methodObject.getMember("version").toString();

               Calendar calendar = Calendar.getInstance();
               Date fromDate = calendar.getTime();
               calendar.add(Calendar.YEAR,8);
               Date endDate = calendar.getTime();
               List rentPlans = (List) scriptContext.runFunc(methodObject,(Object) null,fromDate,endDate,96000.0);
//               System.out.println(rentPlans);
               Object calTotal = scriptContext.getService("calTotal");
               Object moneyObj = scriptContext.runFunc(calTotal,(Object) null,rentPlans);
               Double totalMoney = Double.parseDouble(moneyObj.toString());
//               System.out.println(totalMoney);
               if(Math.abs(totalMoney-96000.0)<2.0){
                   //在误差范围内
                   this.validate = true;
               }
           }
       }catch (Exception e){
           e.printStackTrace();
           this.validate = false;
       }
    }

    public List generateRents(Date fromDate,Date toDate,double totalMoney) throws ScriptException, NoSuchMethodException {
        ContractTemplateUtil.getInstance();
        Object methodObj = this.getMethodObject();
        ScriptContext scriptContext = ScriptContext.getInstance();
       return (List) scriptContext.runFunc(methodObj,(Object) null,fromDate,toDate,totalMoney);
    }

    public Boolean getValidate() {
        if(validate==null)
            doValidate();
        return validate;
    }

    public String getSupportVersion() {
        if (supportVersion == null) {
            doValidate();
        }
        return supportVersion;
    }

    public Object getMethodObject() {
        if (methodObject == null) {
            doValidate();
        }
        return methodObject;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
