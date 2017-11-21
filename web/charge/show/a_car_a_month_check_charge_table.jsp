<%@ page import="com.dz.module.charge.CheckTablePerCar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.CheckChargeTable" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
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
<%--<div>台帐</div>--%>
<table class="table  table-bordered table-hover table-striped">
  <tr>
    <th>年月</th>
    <th>车牌号</th>
    <th>司机</th>
    <th>部门</th>
    <th>计划总额</th>
    <th>银行</th>
    <th>现金</th>
    <th>保险</th>
    <th>油补</th>
    <th>其他</th>
    <th>收入合计</th>
    <th>上月累欠</th>
    <th>本月累欠</th>
  </tr>
  <%List<CheckTablePerCar> tables = (List<CheckTablePerCar>)request.getAttribute("a_car_table");%>
  <%BigDecimal bd1 = new BigDecimal(0.00);%>
  <%BigDecimal bd2 = new BigDecimal(0.00);%>
  <%BigDecimal bd3 = new BigDecimal(0.00);%>
  <%BigDecimal bd4 = new BigDecimal(0.00);%>
  <%BigDecimal bd5 = new BigDecimal(0.00);%>
  <%BigDecimal bd6 = new BigDecimal(0.00);%>
  <%BigDecimal bd7 = new BigDecimal(0.00);%>
  <%BigDecimal bd8 = new BigDecimal(0.00);%>
  <%BigDecimal bd9 = new BigDecimal(0.00);%>
  <%BigDecimal bd10 = new BigDecimal(0.00);%>
  <%for(CheckTablePerCar record:tables){%>
  <tr>
    <%Calendar cal = Calendar.getInstance();cal.setTime(record.getTime());%>
    <td><%=cal.get(Calendar.YEAR)+"年"+(cal.get(Calendar.MONTH)+1)+"月"%></td>
    <td><%=record.getCarNumber()%></td>
    <td><%=record.getDriverName()%></td>
    <td><%=record.getDept()%></td>
    <td><%=record.getPlanAll()%></td>
    <%bd1 = bd1.add(record.getPlanAll());%>
    <td><%=record.getBank()%></td>
    <%bd2 = bd2.add(record.getBank());%>
    <td><%=record.getCash()%></td>
    <%bd3 = bd3.add(record.getCash());%>
    <td><%=record.getInsurance()%></td>
    <%bd4 = bd4.add(record.getInsurance());%>
    <td><%=record.getOil()%></td>
    <%bd5 = bd5.add(record.getOil());%>
    <td><%=record.getOther()%></td>
    <%bd6 = bd6.add(record.getOther());%>
    <td><%=record.getRealAll()%></td>
    <%bd7 = bd7.add(record.getRealAll());%>
    <td><%=record.getLeft()%></td>
    <%bd8 = bd8.add(record.getLeft());%>
    <td><%=record.getThisMonthLeft()%></td>
    <%bd9 = bd9.add(record.getThisMonthLeft());%>
  </tr>
  <%}%>
  <tr>
    <th>合计</th>
    <th>-</th>
    <th>-</th>
    <th>-</th>
    <th><%=bd1%></th>
    <th><%=bd2%></th>
    <th><%=bd3%></th>
    <th><%=bd4%></th>
    <th><%=bd5%></th>
    <th><%=bd6%></th>
    <th><%=bd7%></th>
    <th><%=bd8%></th>
    <th><%=bd9%></th>
  </tr>
</table>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
  $('.datetimepicker').datetimepicker();
</script>
</html>
