package com.dz.module.contract;

import net.sf.json.JSONObject;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Wang on 2018/12/10.
 */
public class ContractPlanItem implements Serializable {
    private Date from;
    private Date to;
    private Double rent;

    public ContractPlanItem() {
    }

    public ContractPlanItem(Date from, Date to, Double rent) {
        this.from = from;
        this.to = to;
        this.rent = rent;
    }

    public Date getFrom() {
        return from;
    }

    public void setFrom(Date from) {
        this.from = from;
    }

    public Date getTo() {
        return to;
    }

    public void setTo(Date to) {
        this.to = to;
    }

    public Double getRent() {
        return rent;
    }

    public void setRent(Double rent) {
        this.rent = rent;
    }

    @Override
    public String toString() {
        return "{" +
                "\"from\":\"" + sdf.format(from) +
                "\", \"to\":\"" + sdf.format(to) +
                "\", \"rent\":" + rent +
                '}';
    }
    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

    public static ContractPlanItem fromContractJson(JSONObject json) {
        ContractPlanItem item = new ContractPlanItem();
        try {
            item.setFrom(sdf.parse(json.getString("begin")));
            item.setTo(sdf.parse(json.getString("end")));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        item.setRent(json.getDouble("money"));
        return item;
    }

    /**
     * 用于页面的输出
     * 与com.dz.module.contract.ContractPlanItem#toString()不同在于 to 包含该天
     */
    public String toStringForPage() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(to);
        calendar.add(Calendar.DATE,-1);
        return "{" +
                "\"from\":\"" + sdf.format(from) +
                "\", \"to\":\"" + sdf.format(calendar.getTime()) +
                "\", \"rent\":" + String.format("%.2f",rent) +
                '}';
    }
}
