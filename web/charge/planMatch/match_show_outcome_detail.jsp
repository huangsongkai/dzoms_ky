<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.module.charge.MonthPlan" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="com.dz.module.charge.IncomeDivide" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="com.dz.common.convertor.DateTypeConverter" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
%>
<%
	int outcomeId = toInt(request.getParameter("outcomeId"));
	ChargePlan outcome = ObjectAccess.getObject(ChargePlan.class,outcomeId);
	Contract contract = null;
	Vehicle vehicle = null;

	List<IncomeDivide> divides = Collections.emptyList();
    // List<MonthPlan> monthPlans = Collections.emptyList();
    // List<ChargePlan> outcomes = Collections.emptyList();
	
	 contract = ObjectAccess.getObject(Contract.class,outcome.getContractId());
	   vehicle = ObjectAccess.getObject(Vehicle.class,contract.getCarframeNum());
	Session hsession = HibernateSessionFactory.getSession();
   if (outcome!=null){
	  
       
       Query query1 = hsession.createQuery("from IncomeDivide " +
               "where monthPlanId=:outcomeId and type=1 ");
       query1.setInteger("outcomeId",outcomeId);
       divides = query1.list();
   }
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>提款-分配详情</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/admin.js"></script>
    <script>
        $(document).ready(function(){
            $("div.panel").each(function () {
                var tableInstance = this;
                $(this).find(".rawTh tr:eq(0) td").each(function(index){
                    $(tableInstance).find(".newTh th").eq(index).width($(this).width());
                });
            });
        });
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>提款-分配详情</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" action="#" class="form-inline form-tips" style="width: 100%;">
        <div class="panel  margin-small" >
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门
                        </label>
                    </div>
                    <div class="field">
                        <%=vehicle.getDept()%>
                    </div>
                </div>
                <div class="form-group">
                <div class="label padding">
                <label>
                车牌号
                </label>
                </div>
                <div class="field">
                    <%=vehicle.getLicenseNum()%>
                </div>
                </div>
                
				<div class="form-group">
                <div class="label padding">
                <label>
                提款项总额
                </label>
                </div>
                <div class="field">
                    <%=outcome.getFee()%>
                </div>
                </div>
				
				<div class="form-group">
                <div class="label padding">
                <label>
                提款项余额
                </label>
                </div>
                <div class="field">
                    <%=outcome.getBalance()%>
                </div>
                </div>
				
            </div>
        </div>
    </form>
</div>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>分配明细</strong>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr class="newTh">
                        <th>序号</th>
                        <th>月份</th>
                        <th>收入项</th>
						<th>收入总额</th>
						<th>分配金额</th>
                        <th>备注</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:200px; overflow:auto">
                <% BigDecimal bd1 = new BigDecimal(0.00);%>
                <% int index=1;%>
                <table class="rawTh table table-bordered table-hover">
                    <%if(divides!=null)
                        for(IncomeDivide record:divides){
							ChargePlan income = (ChargePlan)hsession.get(ChargePlan.class,record.getIncomeId());
					%>

          <tr>
                        <td><%=index++%></td>
                        <td><%=DateTypeConverter.dateFormat1.format(income.getTime())%></td>
                        <td><%=income.getFeeType()%></td>
                        <td><%=income.getFee()%></td>
                        <td><%=record.getAmount()%></td>
						<td><%=income.getComment()%></td>
                        <%bd1 = bd1.add(record.getAmount());%>
                    </tr>
                    <%}%>
					<tr>
					<td>合计</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td><%=bd1%></td>
					<td>-</td>
					</tr>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>