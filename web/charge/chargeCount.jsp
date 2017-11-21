<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-22
  Time: 下午1:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>收费类型查询</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
   <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
</head>
<body style="height:600px; overflow:auto">
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>收费类型查询</li>
    </ul>
</div>
<form style="width: 100%;" action="/DZOMS/charge/getChargeCount" method="post" class="form-inline form-tips">
     <div class="panel margin-small" >
          	<div class="panel-head">
          		查询条件
          		
          	</div>
          	<div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        部门
                    </label>
                </div>
                <div class="field">
                    <s:select list="{'全部','一部','二部','三部'}" name="department" cssClass="input" value="%{department}"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        年月
                    </label>
                </div>
                <div class="field">
                    <s:textfield name="time" value="%{time}" cssClass="input datetimepicker"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        收费类型
                    </label>
                </div>
                <div class="field">
                    <s:select cssClass="input" list="#{'add_bank':'哈尔滨银行','add_bank2':'招商银行','add_insurance':'保险','add_cash':'现金','add_oil':'油补','add_other':'其它'}" name="feeType" value="%{feeType}"/>
                </div>
            </div>
            <input type="submit" value="查询" class="button bg-green">
        </div>
    </div>
</form>
<% Object o = request.getAttribute("map");%>
<%if(o != null){%>
<%Map<String,List<ChargePlan>> map = (Map<String,List<ChargePlan>>)o;%>
    <%Object o_oil = map.get("oil");%>
    <%Object o_bank = map.get("bank");%>
    <%Object o_other = map.get("other");%>
    <%Object o_insurance = map.get("insurance");%>
    <%Object o_cash = map.get("cash");%>
    <%if(o_oil != null){%>
    <table class="table">
        <tr>
            <th>类型</th>
            <th>金额</th>
            <th>记录时间</th>
            <th>记录人员</th>
        </tr>
        <%List<ChargePlan> plans = (List<ChargePlan>)o_oil;%>
        <span>总个数：<%=plans.size() - 1%>  类型：油补</span>
        <%for(ChargePlan plan:plans){%>
        <%if(!"total".equals(plan.getFeeType())){%>
        <tr>
            <th>油补</th>
            <th><%=plan.getFee()%></th>
            <th><%=plan.getInTime()%></th>
            <th><%=plan.getRegister()%></th>
        </tr>
        <%}%>
        <%}%>
        <%for(ChargePlan plan:plans){%>
        <%if("total".equals(plan.getFeeType())){%>
        <tr>
            <th>总额</th>
            <th><%=plan.getFee()%></th>
            <th>-</th>
            <th>-</th>
        </tr>
        <%}%>
        <%}%>
    </table>
    <%}%>

    <%if(o_bank != null){%>
    <table class="table">
        <tr>
            <th>类型</th>
            <th>金额</th>
            <th>记录时间</th>
            <th>记录人员</th>
        </tr>
        <%List<ChargePlan> plans = (List<ChargePlan>)o_bank;%>
        <span>总个数：<%=plans.size() - 1%>  类型：银行</span>
        <%for(ChargePlan plan:plans){%>
        <%if(!"total".equals(plan.getFeeType())){%>
        <tr>
            <th>银行</th>
            <th><%=plan.getFee()%></th>
            <th><%=plan.getInTime()%></th>
            <th><%=plan.getRegister()%></th>
        </tr>
        <%}%>
        <%}%>
        <%for(ChargePlan plan:plans){%>
        <%if("total".equals(plan.getFeeType())){%>
        <tr>
            <th>总额</th>
            <th><%=plan.getFee()%></th>
            <th>-</th>
            <th>-</th>
        </tr>
        <%}%>
        <%}%>
    </table>
    <%}%>

    <%if(o_cash != null){%>
    <table class="table">
        <tr>
            <th>类型</th>
            <th>金额</th>
            <th>记录时间</th>
            <th>记录人员</th>
        </tr>
        <%List<ChargePlan> plans = (List<ChargePlan>)o_cash;%>
        <span>总个数：<%=plans.size() - 1%>  类型：现金</span>
        <%for(ChargePlan plan:plans){%>
        <%if(!"total".equals(plan.getFeeType())){%>
        <tr>
            <th>现金</th>
            <th><%=plan.getFee()%></th>
            <th><%=plan.getInTime()%></th>
            <th><%=plan.getRegister()%></th>
        </tr>
        <%}%>
        <%}%>
        <%for(ChargePlan plan:plans){%>
        <%if("total".equals(plan.getFeeType())){%>
        <tr>
            <th>总额</th>
            <th><%=plan.getFee()%></th>
            <th>-</th>
            <th>-</th>
        </tr>
        <%}%>
        <%}%>
    </table>
    <%}%>

    <%if(o_insurance != null){%>
    <table class="table">
        <tr>
            <th>类型</th>
            <th>金额</th>
            <th>记录时间</th>
            <th>记录人员</th>
        </tr>
        <%List<ChargePlan> plans = (List<ChargePlan>)o_insurance;%>
        <span>总个数：<%=plans.size() - 1%>  类型：保险</span>
        <%for(ChargePlan plan:plans){%>
        <%if(!"total".equals(plan.getFeeType())){%>
        <tr>
            <th>保险</th>
            <th><%=plan.getFee()%></th>
            <th><%=plan.getInTime()%></th>
            <th><%=plan.getRegister()%></th>
        </tr>
        <%}%>
        <%}%>
        <%for(ChargePlan plan:plans){%>
        <%if("total".equals(plan.getFeeType())){%>
        <tr>
            <th>总额</th>
            <th><%=plan.getFee()%></th>
            <th>-</th>
            <th>-</th>
        </tr>
        <%}%>
        <%}%>
    </table>
    <%}%>

    <%if(o_other != null){%>
    <table class="table">
        <tr>
            <th>类型</th>
            <th>金额</th>
            <th>记录时间</th>
            <th>记录人员</th>
        </tr>
        <%List<ChargePlan> plans = (List<ChargePlan>)o_other;%>
        <span>总个数：<%=plans.size()-1%>  类型：其他</span>
        <%for(ChargePlan plan:plans){%>
        <%if(!"total".equals(plan.getFeeType())){%>
        <tr>
            <th>其他</th>
            <th><%=plan.getFee()%></th>
            <th><%=plan.getInTime()%></th>
            <th><%=plan.getRegister()%></th>
        </tr>
        <%}%>
        <%}%>
        <%for(ChargePlan plan:plans){%>
        <%if("total".equals(plan.getFeeType())){%>
        <tr>
            <th>总额</th>
            <th><%=plan.getFee()%></th>
            <th>-</th>
            <th>-</th>
        </tr>
        <%}%>
        <%}%>
    </table>
    <%}%>
    <%}%>
</body>
<script>
	$('.datetimepicker').simpleCanleder();
</script>
</html>