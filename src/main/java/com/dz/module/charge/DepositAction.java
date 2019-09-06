package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.module.driver.Driver;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.function.Supplier;

@Controller
@Scope(value = "prototype")
public class DepositAction extends BaseAction {
    @Autowired
    private DepositService service;

    private Deposit deposit;

    private String licenseNum;
    private String driverName;
    private String idNum;
    private String depositId;
    private Date inDateBegin;
    private Date inDateEnd;
    private Date backDateBegin;
    private Date backDateEnd;

    private boolean isSuccess;
    private String errorMsg;

    public String add() {
        try {
            User user = (User) session.getAttribute("user");
            deposit.setuNameIn(user.getUname());
            service.add(deposit);
            isSuccess = true;
        } catch (RuntimeException ex) {
            isSuccess = false;
            errorMsg = ex.getMessage();
            return ERROR;
        }
        return SUCCESS;
    }

    private void wrapAsJson(Supplier<JSONObject> supplier) throws IOException {
        JSONObject jsonObject = new JSONObject();
        try {
            JSONObject json = supplier.get();
            jsonObject.put("isSuccess",true);
            jsonObject.accumulateAll(json);
        } catch (RuntimeException ex) {
            jsonObject.put("isSuccess",false);
            jsonObject.put("errorMsg",ex.getMessage());
            isSuccess = false;
        }
        response.setContentType("text/json");
        PrintWriter pw = response.getWriter();
        pw.print(jsonObject);
        pw.flush();
        pw.close();
    }

    public void withdraw() throws IOException {
        wrapAsJson(this::doWithdraw);
    }

    private JSONObject doWithdraw() {
        User user = (User) session.getAttribute("user");
        service.withdraw(deposit.getId(), deposit.getBackMoney(), user.getUname());
        return new JSONObject();
    }

    /**
     * 对没有绑定车辆的押金进行自动匹配
     * @throws IOException
     */
    public void match() throws IOException {
        wrapAsJson(()->{
            Session s = HibernateSessionFactory.getSession();
            Transaction tx = null;
            JSONObject json = new JSONObject();
            try {
                Deposit d = (Deposit) s.get(Deposit.class,deposit.getId());
                Driver driver = (Driver) s.get(Driver.class,deposit.getIdNum());

                tx = s.beginTransaction();
                if (driver.getCarframeNum()!=null){
                    //Vehicle vehicle = (Vehicle) s.get(Vehicle.class,driver.getCarframeNum());
                    d.setCarframeNum(driver.getCarframeNum());
                    s.saveOrUpdate(d);
                }else if(driver.getApplyLicenseNum()!=null){
                    Vehicle vehicle = (Vehicle) s.createCriteria(Vehicle.class)
                            .add(Expression.eq("licenseNum",driver.getApplyLicenseNum()))
                            .setMaxResults(1)
                            .uniqueResult();
                    if (vehicle==null){
                        json.put("isSuccess",false);
                        json.put("errorMsg","驾驶员申请时的"+driver.getApplyLicenseNum()+"不是有效的车牌号！");
                    }else {
                        d.setCarframeNum(vehicle.getCarframeNum());
                        s.saveOrUpdate(d);
                    }
                }else {
                    json.put("isSuccess",false);
                    json.put("errorMsg","驾驶员不在车，且申请时未记录车牌号，无法匹配！");
                }
                tx.commit();
            }catch (RuntimeException ex) {
                json.put("isSuccess",false);
                json.put("errorMsg",ex.getMessage());
            }finally {
                HibernateSessionFactory.closeSession();
            }
            return json;
        });
    }

    public void updateTicketId() throws IOException{
        wrapAsJson(()->{
            Session s = HibernateSessionFactory.getSession();
            Transaction tx = null;
            JSONObject json = new JSONObject();
            try {
                Deposit d = (Deposit) s.get(Deposit.class,deposit.getId());
                tx = s.beginTransaction();
                Deposit d2 = (Deposit) s.createCriteria(Deposit.class)
                        .add(Expression.eq("depositId",deposit.getDepositId()))
                        .setMaxResults(1)
                        .uniqueResult();
                if (d2==null){
                    d.setDepositId(deposit.getDepositId());
                    s.saveOrUpdate(d);
                }else {
                        json.put("isSuccess",false);
                        json.put("errorMsg","已存在票号为"+deposit.getDepositId()+"的条目！");

                }
                tx.commit();
            }catch (RuntimeException ex) {
                json.put("isSuccess",false);
                json.put("errorMsg",ex.getMessage());
            }finally {
                HibernateSessionFactory.closeSession();
            }
            return json;
        });
    }

    public String search() {
        List<Deposit> res;
        res = service.search(licenseNum, driverName,idNum, depositId, inDateBegin, inDateEnd, backDateBegin, backDateEnd,0);
        request.setAttribute("list", res);
        return SUCCESS;
    }



    public void remove() throws IOException {
        boolean res = service.remove(backDateBegin,backDateEnd);
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");

        JSONObject json = new JSONObject();
        PrintWriter out = ServletActionContext.getResponse().getWriter();
        json.put("success",res);
        out.write(json.toString());
        out.flush();
        out.close();
    }

    public void setService(DepositService service) {
        this.service = service;
    }

    public Deposit getDeposit() {
        return deposit;
    }

    public void setDeposit(Deposit deposit) {
        this.deposit = deposit;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDepositId() {
        return depositId;
    }

    public void setDepositId(String depositId) {
        this.depositId = depositId;
    }

    public Date getInDateBegin() {
        return inDateBegin;
    }

    public void setInDateBegin(Date inDateBegin) {
        this.inDateBegin = inDateBegin;
    }

    public Date getInDateEnd() {
        return inDateEnd;
    }

    public void setInDateEnd(Date inDateEnd) {
        this.inDateEnd = inDateEnd;
    }

    public Date getBackDateBegin() {
        return backDateBegin;
    }

    public void setBackDateBegin(Date backDateBegin) {
        this.backDateBegin = backDateBegin;
    }

    public Date getBackDateEnd() {
        return backDateEnd;
    }

    public void setBackDateEnd(Date backDateEnd) {
        this.backDateEnd = backDateEnd;
    }

    public boolean isSuccess() {
        return isSuccess;
    }

    public void setSuccess(boolean success) {
        isSuccess = success;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }
}
