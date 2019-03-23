package com.dz.module.contract;

import com.dz.common.el.ELUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.jexl3.JexlScript;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;

import javax.persistence.*;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Created by Wang on 2018/11/28.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "contract_template2")
public class ContractTemplate2 implements Serializable {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private int id;

    private String name;
    /**
     * 预付金总额
     */
    private double rentFirst;
    /**
     * 预付金摊销总期数
     */
    private int rentDivideStages;
    /**
     * 定金
     */
    private double deposit;
    private String comment;
    private String uname;
    @Temporal(TemporalType.TIMESTAMP)
    private Date createTime;
    /**
     * 是否已启用
     */
    private boolean enabled;

    /**
     * 用户自定义变量
     */
    private String userDefined;
    /**
     * 约定定义
     */
    private String rules;

    /**
     * 输入模式  0-常规模式 1-专业模式
     */
    private int inputMode;

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

    public double getRentFirst() {
        return rentFirst;
    }

    public void setRentFirst(double rentFirst) {
        this.rentFirst = rentFirst;
    }

    public int getRentDivideStages() {
        return rentDivideStages;
    }

    public void setRentDivideStages(int rentDivideStages) {
        this.rentDivideStages = rentDivideStages;
    }

    public double getDeposit() {
        return deposit;
    }

    public void setDeposit(double deposit) {
        this.deposit = deposit;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getUserDefined() {
        return userDefined;
    }

    public void setUserDefined(String userDefined) {
        this.userDefined = userDefined;
    }

    public String getRules() {
        return rules;
    }

    public void setRules(String rules) {
        this.rules = rules;
    }

    public int getInputMode() {
        return inputMode;
    }

    public void setInputMode(int inputMode) {
        this.inputMode = inputMode;
    }

    public List<ContractPlanItem> generateRents(Date beginDate, Date endDate) {
        Map<String,Object> elMap = new HashMap<>();
        elMap.put("page",TemplatePage.class);
        elMap.put("math",Math.class);

        ELUtil el = new ELUtil(elMap);
        el.setVariable("模板名称",name);
        if(beginDate!=null && endDate!=null){
            el.setVariable("起始日期",beginDate);
            el.setVariable("结束日期",endDate);
            el.compileAndEvaluate("$[总天数]=page:calDateSpan($[起始日期],$[结束日期])");
            el.compileAndEvaluate("$[期数]=math:ceil($[总天数]/30.0)");
            el.compileAndEvaluate(userDefined==null?"":userDefined);
        }

        Calendar beginDateCalender = Calendar.getInstance();
        beginDateCalender.setTime(beginDate);
        Calendar endDateCalender = Calendar.getInstance();
        endDateCalender.setTime(endDate);

        List<ContractPlanItem> resultList = new ArrayList<>();
        JSONArray jarr = JSONArray.fromObject(rules);
        for (int i = 0; i < jarr.size(); i++) {
            JSONObject jobj = jarr.getJSONObject(i);
            Object condition = el.compileAndEvaluate(jobj.getString("condition"));
            if (condition == null || condition.equals(false)) {
                continue;
            }
            int itemsCount = jobj.optInt("itemsCount",1);
            String rentString = el.prepareCompile(jobj.getString("rent"));
            String spanBeginString = el.prepareCompile(jobj.getString("spanBegin"));
            String spanEndString = el.prepareCompile(jobj.getString("spanEnd"));

            JexlScript rentScript = el.getEngine().createScript(rentString,"$0");
            JexlScript spanBeginScript = el.getEngine().createScript(spanBeginString,"$0");
            JexlScript spanEndScript = el.getEngine().createScript(spanEndString,"$0");
            for (int j = 0; j < itemsCount; j++) {
                double rent = ((Number) rentScript.execute(el.getContext(),j)).doubleValue();
                int spanBegin = ((Number) spanBeginScript.execute(el.getContext(), j)).intValue();
                int spanEnd = ((Number) spanEndScript.execute(el.getContext(),j)).intValue();
                Calendar spanFrom = (Calendar) beginDateCalender.clone();
                spanFrom.add(Calendar.MONTH,spanBegin-1);

                if(spanFrom.getTimeInMillis()>=endDateCalender.getTimeInMillis()){
                    //约定起始日期>=结束日期
                    continue;
                }

                Calendar spanTo = (Calendar) beginDateCalender.clone();
                spanTo.add(Calendar.MONTH,spanEnd-1);
                if(spanTo.getTimeInMillis()>=endDateCalender.getTimeInMillis()){
                    //约定结束日期>=结束日期
                    spanTo = (Calendar) endDateCalender.clone();
                }
                resultList.add(new ContractPlanItem(spanFrom.getTime(),spanTo.getTime(),rent));
            }
        }

        return resultList;
    }

    public static class TemplatePage{
        public static int toInt(String text){
            try {
                return NumberUtils.createInteger(text);
            }catch (NumberFormatException|NullPointerException ex){
                return 0;
            }
        }

        public static String nullIf(String text){
            return StringUtils.isBlank(text)?"":text;
        }

        public static int calDaysOfDate(Date date){
            int dt = date.getDate();
            if(dt>26){
                return dt - 26;
            }else {
                return dt + 4;
            }
        }

        public static int calDateSpan(Date beginDate,Date endDate){
            int monthDiff = (endDate.getYear() - beginDate.getYear())*12 + endDate.getMonth()-beginDate.getMonth();
            return monthDiff*30 + calDaysOfDate(endDate)-calDaysOfDate(beginDate);
        }

        static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        public static Date toDate(String dateString){
            try {
                return simpleDateFormat.parse(dateString);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return null;
        }
    }
}
