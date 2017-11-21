<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-21
  Time: 下午9:15
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
  <title>测试</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
</head>
<body>
<%List<ChargePlan> plans = (List<ChargePlan>)request.getAttribute("plans");%>
<div>
  <div>本月记录取款</div>
  <table class="table table-bordered table-hover table-striped">
    <tr>
      <th>类型</th>
      <th>金额</th>
      <th>记录时间</th>
      <th>记录人员</th>
    </tr>
    <%for(ChargePlan plan:plans){%>
    <%String rawType = plan.getFeeType();
      String feeType = null;
      if(rawType.equals("sub_oil")){
        feeType = "油补取出";
      }else if(rawType.equals("sub_insurance")){
        feeType = "保险取出";
      }%>
    <tr>
      <td><%=feeType%></td>
      <td><%=plan.getFee()%></td>
      <td><%=plan.getInTime()%></td>
      <td><%=plan.getRegister()%></td>
    </tr>
    <%}%>
  </table>
</div>
</body>
</html>
