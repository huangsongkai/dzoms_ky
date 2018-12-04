package com.dz.module.contract;

import com.dz.common.other.ScriptContext;

import javax.persistence.*;
import java.io.Serializable;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by Wang on 2018/11/28.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "contract_template")
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
        ScriptContext scriptContext = ScriptContext.getInstance();
        Object jsObject = scriptContext.getService(name,version);
        this.methodObject = jsObject;
       try{
           if(methodObject!=null){
//               this.supportVersion = methodObject.getMember("version").toString();
               double sum = 0.0;
               for (int i = 0; i < 24; i++) {
                   Double val = (Double)scriptContext.runFunc(methodObject,null,12000,24,i);
                   sum += val;
               }
               if(Math.abs(sum-12000.0)<2.0){
                   //在误差范围内
                   this.validate = true;
               }
           }
       }catch (Exception e){
           this.validate = false;
       }
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
