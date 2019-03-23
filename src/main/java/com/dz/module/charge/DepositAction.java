package com.dz.module.charge;

import com.dz.common.global.BaseAction;
import com.dz.module.user.User;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@Controller
@Scope(value = "prototype")
public class DepositAction extends BaseAction {
    @Autowired
    private DepositService service;

    private Deposit deposit;

    private String licenseNum;
    private String driverName;
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

    public void withdraw() throws IOException {
        JSONObject jsonObject = new JSONObject();
        try {
            User user = (User) session.getAttribute("user");
            service.withdraw(deposit.getId(), deposit.getBackMoney(), user.getUname());
            jsonObject.put("isSuccess",true);
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

    public String search() {
        List<Deposit> res;
        res = service.search(licenseNum, driverName, depositId, inDateBegin, inDateEnd, backDateBegin, backDateEnd,0);
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
