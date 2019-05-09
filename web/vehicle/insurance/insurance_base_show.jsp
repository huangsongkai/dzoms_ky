<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>基础保费</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
    <style>
        .label{
             white-space:pre-line;
        }
    </style>
</head>
<%
    String carframeNum = request.getParameter("carframeNum");
    String insuranceBase = request.getParameter("insuranceBase");
    Vehicle vehicle = ObjectAccess.getObject(Vehicle.class,carframeNum);
    %>
<body>
<% if (vehicle==null){%>
<script>
    alert("车辆<%=carframeNum%>不存在！");
    window.close();
</script>
<% } %>
<% if (vehicle.getState()==2){%>
<script>
    alert("车辆已报废！");
    window.close();
</script>
<% } %>
<%
    if (insuranceBase!=null && insuranceBase.length()>0){
        String message;
        try {
            double amount = Double.parseDouble(insuranceBase);
            vehicle.setInsuranceBase(BigDecimal.valueOf(amount));
            Session hsession = HibernateSessionFactory.getSession();
            Transaction tx = hsession.beginTransaction();
            hsession.update(vehicle);
            tx.commit();
            message = "修改成功！";
        }catch (Exception ex){
            message = "操作失败！原因是："+ ex.getMessage();
        }finally {
            HibernateSessionFactory.closeSession();
        }
%>
<script>
    alert("<%=message%>");
    $(window.opener.document).find("#insurance_base").val(<%=message.equals("修改成功！")?insuranceBase:vehicle.getInsuranceBase()%>);
    window.close();
</script>
<%
    }
%>
<div class="line">
    <form action="#" method="post" class="form-x">
        <div class="form-group">
            <div class="label"><label for="carframeNum">车架号</label></div>
            <div class="field field-icon-right">
                <span class="icon icon-check"></span>
                <input type="text" class="input" id="carframeNum" name="carframeNum" value="<%=carframeNum%>" size="30" placeholder="车架号" readonly/>
            </div>
        </div>
        <% if (vehicle.getLicenseNum()!=null && vehicle.getLicenseNum().length()==7){%>
        <div class="form-group">
            <div class="label"><label for="carNum">车牌号</label></div>
            <div class="field field-icon-right">
                <span class="icon icon-check"></span>
                <input type="text" class="input" id="carNum" name="carNum" value="<%=vehicle.getLicenseNum()%>" size="30" placeholder="车牌号" readonly/>
            </div>
        </div>
        <%}%>

        <div class="form-group">
            <div class="label"><label for="insuranceBase">基础保费</label></div>
            <div class="field field-icon-right">
                <span class="icon icon-check"></span>
                <input type="text" class="input" id="insuranceBase" name="insuranceBase" value="<%=vehicle.getInsuranceBase()%>" size="30" placeholder="基础保费" />
            </div>
        </div>
        <div class="form-button">
            <button class="button" type="submit">修改</button>
        </div>
    </form>
</div>
</body>
</html>