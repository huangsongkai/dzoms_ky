<%@ page import="com.dz.module.charge.CheckChargeTable" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-20
  Time: 下午11:16
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
<table class="table table-bordered table-hover table-striped">
  <tr>
    <th>计划月份</th>
    <th>车牌号</th>
    <th>司机</th>
    <th>部门</th>
    <th>计划总额</th>
    <th>现金</th>
    <th>银行</th>
    <th>油补转入</th>
    <th>保险转入</th>
    <th>其他</th>
    <th>收入合计</th>
    <th>本月欠款</th>
    <th>上月累欠</th>
    <th>本月存款</th>
    <th>本月累欠</th>
  </tr>
    <%BigDecimal bg1 = new BigDecimal(0.00);%>
    <%BigDecimal bg2 = new BigDecimal(0.00);%>
    <%BigDecimal bg3 = new BigDecimal(0.00);%>
    <%BigDecimal bg4 = new BigDecimal(0.00);%>
    <%BigDecimal bg5 = new BigDecimal(0.00);%>
    <%BigDecimal bg6 = new BigDecimal(0.00);%>
    <%BigDecimal bg7 = new BigDecimal(0.00);%>
    <%BigDecimal bg8 = new BigDecimal(0.00);%>
    <%BigDecimal bg9 = new BigDecimal(0.00);%>
    <%BigDecimal bg10 = new BigDecimal(0.00);%>
    <%BigDecimal bg11 = new BigDecimal(0.00);%>
    <%SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");%>
    <%List<CheckChargeTable> tables = (List<CheckChargeTable>)request.getAttribute("tables");%>
    <%for(CheckChargeTable record:tables){%>
    <%bg1 = bg1.add(record.getPlanAll());%>
    <%bg2 = bg2.add(record.getCash());%>
    <%bg3 = bg3.add(record.getBank());%>
    <%bg4 = bg4.add(record.getOilAdd());%>
    <%bg5 = bg5.add(record.getInsurance());%>
    <%bg6 = bg6.add(record.getOther());%>
    <%bg7 = bg7.add(record.getTotal());%>
    <%bg8 = bg8.add(record.getThisMonthOwe());%>
    <%bg9 = bg9.add(record.getLastMonthOwe());%>
    <%bg10 = bg10.add(record.getThisMonthLeft());%>
    <%bg11 = bg11.add(record.getThisMonthTotalOwe());%>
  <tr>
    <td><%=sdf.format(record.getTime())%></td>
    <td><%=record.getCarNumber()%></td>
    <td><%=record.getDriverName()%></td>
    <td><%=record.getDept()%></td>
    <td><%=record.getPlanAll()%></td>
    <td><%=record.getCash()%></td>
    <td><%=record.getBank()%></td>
    <td><%=record.getOilAdd()%></td>
    <td><%=record.getInsurance()%></td>
    <td><%=record.getOther()%></td>
    <td><%=record.getTotal()%></td>
    <td><%=record.getThisMonthOwe()%></td>
    <td><%=record.getLastMonthOwe()%></td>
    <td><%=record.getThisMonthLeft()%></td>
    <td><%=record.getThisMonthTotalOwe()%></td>
  </tr>
    <%}%>
  <tr>
    <td>合计</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td><%=bg1%></td>
    <td><%=bg2%></td>
    <td><%=bg3%></td>
    <td><%=bg4%></td>
    <td><%=bg5%></td>
    <td><%=bg6%></td>
    <td><%=bg7%></td>
    <td><%=bg8%></td>
    <td><%=bg9%></td>
    <td><%=bg10%></td>
    <td><%=bg11%></td>
  </tr>
</body>
</html>
