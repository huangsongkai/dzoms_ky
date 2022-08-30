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
//    int contractId = toInt(request.getParameter("contractId"));
    String carNum = request.getParameter("carNum");
    Vehicle vehicle = ObjectAccess.getObject(Vehicle.class,carNum);
//    Contract contract = ObjectAccess.getObject(Contract.class,contractId);
    String showAll = request.getParameter("showAll");
    boolean showEverything = false;

    if (showAll!=null && showAll.equalsIgnoreCase("yes")){
        showEverything = true;
    }

    List<MonthPlan> monthPlans = Collections.emptyList();
    List<ChargePlan> incomes = Collections.emptyList();
    List<ChargePlan> outcomes = Collections.emptyList();

   if (vehicle!=null){
       Session hsession = HibernateSessionFactory.getSession();
       Query query1 = hsession.createQuery("from MonthPlan " +
               "where carframeNum=:cid "+(showEverything?"":" and arrear>0 ")+
       "order by time ");
       query1.setString("cid",carNum);
       monthPlans = query1.list();

       Query query2 = hsession.createQuery("select cp from ChargePlan cp,Contract c where cp.contractId=c.id and c.carframeNum=:cid and cp.balance is not null and cp.feeType like 'add_%' "+ (showEverything?"":" and cp.balance>0 ") +
       "order by time ");
       query2.setString("cid",carNum);
       incomes = query2.list();

       Query query3 = hsession.createQuery("select cp from ChargePlan cp,Contract c where cp.contractId=c.id and c.carframeNum=:cid and cp.balance is not null and cp.feeType like 'sub_%' "+ (showEverything?"":" and cp.balance<0 ") +
       "order by time ");
       query3.setString("cid",carNum);
       outcomes = query3.list();
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
    <title>计划-收入分配查询详情</title>
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
		
		//match_show_income_detail.jsp
		function showIncomeDetails(planId) {
            window.open("match_show_income_detail.jsp?incomeId="+planId,"_blank")
        }
		
		function showOutcomeDetails(planId) {
            window.open("match_show_outcome_detail.jsp?outcomeId="+planId,"_blank")
        }
		
		function showMonthPlanDetails(planId) {
            window.open("match_show_monthplan_detail.jsp?monthPlanId="+planId,"_blank")
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>计划-收入分配详情</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" action="#" class="form-inline form-tips" style="width: 100%;">
        <input type="hidden" name="carNum" value="<%=carNum%>">
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
                            显示无需分配的条目
                        </label>
                    </div>
                    <div class="field">
                        <input type="radio" name="showAll" value="yes" <%=showEverything?"checked":""%> >是
                        <input type="radio" name="showAll" value="no" <%=showEverything?"":"checked"%> >否
                    </div>
                </div>
                    <input type="submit" value="查询" class="button bg-green"/>
            </div>
        </div>
    </form>

</div>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>月账单明细</strong>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr class="newTh">
                        <th>年月</th>
                        <th>计划总额</th>
                        <th>欠款总额</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:200px; overflow:auto">
                <%BigDecimal bd1 = new BigDecimal(0.00);%>
                <%BigDecimal bd2 = new BigDecimal(0.00);%>
                <%int index=1;%>
                <table  class="rawTh table table-bordered table-hover">
                    <%if(monthPlans!=null)
                        for(MonthPlan record:monthPlans){
                    %>
                    <tr>
                        <td><%=DateTypeConverter.dateFormat1.format(record.getTime())%></td>
                        <td><%=record.getPlanAll()%></td>
                        <td><%=record.getArrear()%></td>
                        <td><button onclick="showMonthPlanDetails(<%=record.getId()%>)">查看详情</button></td>
                        <%bd1 = bd1.add(record.getPlanAll());%>
                        <%bd2 = bd2.add(record.getArrear());%>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th><%=bd1%></th>
                        <th><%=bd2%></th>
                        <th>-</th>
                    </tr>
                </table>
            </div>
        </div>

    </div>
    <div class="panel">
        <div class="panel-head">
            <strong>收入明细</strong>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr class="newTh">
                        <th>年月</th>
                        <th>收入项</th>
                        <th>收款金额</th>
                        <th>未分配余额</th>
                        <th>收款人员</th>
                        <th>收款时间</th>
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:200px; overflow:auto">
                <% bd1 = new BigDecimal(0.00);%>
                <% bd2 = new BigDecimal(0.00);%>
                <% index=1;%>
                <table class="rawTh table table-bordered table-hover">
                    <%if(incomes!=null)
                        for(ChargePlan record:incomes){
                    %>
                    <tr>
                        <td><%=DateTypeConverter.dateFormat1.format(record.getTime())%></td>
                        <td><%=record.getFeeType()%></td>
                        <td><%=record.getFee()%></td>
                        <td><%=record.getBalance()%></td>
                        <td><%=record.getRegister()%></td>
                        <td><%=DateTypeConverter.dateFormat3.format(record.getInTime())%></td>
                        <td><%=record.getComment()%></td>
                        <td><button onclick="showIncomeDetails(<%=record.getId()%>)">查看详情</button></td>
                        <%bd1 = bd1.add(record.getFee());%>
                        <%bd2 = bd2.add(record.getBalance()==null?BigDecimal.ZERO:record.getBalance());%>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th>-</th>
                        <th><%=bd1%></th>
                        <th><%=bd2%></th>
                        <th>-</th>
                        <th>-</th>
                        <th>-</th>
                        <th>-</th>
                    </tr>
                </table>
            </div>
        </div>

    </div>
    <div class="panel">
        <div class="panel-head">
            <strong>提款明细</strong>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr class="newTh">
                        <th>年月</th>
                        <th>提款项</th>
                        <th>提款金额</th>
                        <th>未分配额</th>
                        <th>操作人员</th>
                        <th>提款时间</th>
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:200px; overflow:auto">
                <% bd1 = new BigDecimal(0.00);%>
                <% bd2 = new BigDecimal(0.00);%>
                <% index=1;%>
                <table class="rawTh table table-bordered table-hover">
                    <%if(outcomes!=null)
                        for(ChargePlan record:outcomes){
                    %>
                    <tr>
                        <td><%=DateTypeConverter.dateFormat1.format(record.getTime())%></td>
                        <td><%=record.getFeeType()%></td>
                        <td><%=record.getFee()%></td>
                        <td><%=record.getBalance()%></td>
                        <td><%=record.getRegister()%></td>
                        <td><%=DateTypeConverter.dateFormat3.format(record.getInTime())%></td>
                        <td><%=record.getComment()%></td>
                        <td><button onclick="showOutcomeDetails(<%=record.getId()%>)">查看详情</button></td>
                        <%bd1 = bd1.add(record.getFee());%>
                        <%bd2 = bd2.add(record.getBalance());%>
                    </tr>
                    <%}%>
                    <tr >
                        <th>合计</th>
                        <th>-</th>
                        <th><%=bd1%></th>
                        <th><%=bd2%></th>
                        <th>-</th>
                        <th>-</th>
                        <th>-</th>
                        <th>-</th>
                    </tr>
                </table>
            </div>
        </div>

    </div>
</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>

</html>