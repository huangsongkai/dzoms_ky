<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.charge.CheckChargeTable" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-21
  Time: 下午10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.math.*" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>部门对账表</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <script>
$(document).ready(function(){
  $("#rawTh tr:eq(0) td").each(function(index){
    $("#newTh th").eq(index).width($(this).width());
  });
});
  </script>
</head>
<body>
<div class="panel">
  <div class="panel-body bg-white">
  	<div class="line" style="width: 100%;">
<table class="table table-bordered table-hover table-striped" >
    <tr id="newTh">
    	<th>序号</th>
      <th>车牌号</th>
      <th>司机</th>
      <th>部门</th>
      <th>计划总额</th>
      <th>现金收入</th>
      <th>银行收入</th>
      <th>油补转入</th>
      <th>保险转入</th>
      <th>其它收入</th>
      <th>收入合计</th>
      <th>本月欠款</th>
      <th>上月累欠</th>
      <th>本月存款</th>
      <th>本月累欠</th>
    </tr>
    </table>
</div>
<div class="line" style="width: 100%;height:540px; overflow:auto">
	<%BigDecimal bd1 = new BigDecimal(0.00);%>
    <%BigDecimal bd2 = new BigDecimal(0.00);%>
    <%BigDecimal bd3 = new BigDecimal(0.00);%>
    <%BigDecimal bd4 = new BigDecimal(0.00);%>
    <%BigDecimal bd5 = new BigDecimal(0.00);%>
     <%BigDecimal bd_other = new BigDecimal(0.00);%>
    <%BigDecimal bd6 = new BigDecimal(0.00);%>
    <%BigDecimal bd7 = new BigDecimal(0.00);%>
    <%BigDecimal bd8 = new BigDecimal(0.00);%>
    <%BigDecimal bd9 = new BigDecimal(0.00);%>
    <%BigDecimal bd10 = new BigDecimal(0.00);%>
    <%int index=1;%>
    <table  id="rawTh" class="table table-bordered table-hover table-striped">
      <%List<CheckChargeTable> tables = (List<CheckChargeTable>)request.getAttribute("tables");%>
      <%for(CheckChargeTable record:tables){%>
      <tr>
      	<td><%=index++%></td>
        <td><%=record.getCarNumber()%></td>
        <td><%=record.getDriverName()%></td>
        <td><%=record.getDept()%></td>
        <td><%=record.getPlanAll()%></td>
      <%bd1 = bd1.add(record.getPlanAll());%>
      <td><%=record.getCash()%></td>
      <%bd2 = bd2.add(record.getCash());%>
      <td><%=record.getBank()%></td>
      <%bd3 = bd3.add(record.getBank());%>
      <td><%=record.getOilAdd()%></td>
      <%bd4 = bd4.add(record.getOilAdd());%>
      <td><%=record.getInsurance()%></td>
      <%bd5 = bd5.add(record.getInsurance());%>
      <td><%=record.getOther()%></td>
      <%bd_other = bd_other.add(record.getOther());%>
      <td><%=record.getTotal()%></td>
      <%bd6 = bd6.add(record.getTotal());%>
      <td><%=record.getThisMonthOwe()%></td>
      <%bd7 = bd7.add(record.getThisMonthOwe());%>
      <td><%=record.getLastMonthOwe()%></td>
      <%bd8 = bd8.add(record.getLastMonthOwe());%>
      <td><%=record.getThisMonthLeft()%></td>
      <%bd9 = bd9.add(record.getThisMonthLeft());%>
      <td><%=record.getThisMonthTotalOwe()%></td>
      <%bd10 = bd10.add(record.getThisMonthTotalOwe());%>
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
      <th><%=bd_other%></th>
      <th><%=bd6%></th>
      <th><%=bd7%></th>
      <th><%=bd8%></th>
      <th><%=bd9%></th>
      <th><%=bd10%></th>
    </tr>
    </table>
</div>
    <!--<div class="line">
      <div class="xm4 xm4-move">
        <a href="javascript:void beforePage();" class="button">上一页</a>
        <input type="text" id="ps" onblur="toPage();" class="input input-auto" size="3">
        <a href="javascript:void nextPage();" class="button">下一页</a>
      </div>

    </div>-->
  </div>
</div>

<%--
<form action="/DZOMS/charge/mainCharge" method="post" id="form">
  <s:hidden type="hidden" id="currentPage" value="%{currentPage}" name="currentPage" />
</form>

<script>
  var totalPage = <s:property value="%{pageLimit}"/>;
  function beforePage(){
    var currentPage = $("#currentPage").val();
    currentPage--;
    if(currentPage <= 0){
      alert("没有更多数据了.");
    }else{
      $("#currentPage").val(currentPage);
      $("#form").submit();
    }
  }
  function nextPage(){
    var currentPage = $("#currentPage").val();
    currentPage++;
    if(currentPage > totalPage){
      alert("没有更多数据了.");
    }else{
      $("#currentPage").val(currentPage);
      $("#form").submit();
    }
  }
  function toPage(){
    var pi = $("#ps").val();
    if(1 <= pi && pi <= totalPage){
      $("#currentPage").val(pi);
      $("#form").submit();
    }else{
      alert("没有更多数据");
      $("#ps").val("");
    }
  }
  $(document).ready(function(){
    $("#ps").attr("placeholder",$("#currentPage").val()+"/"+totalPage);
  });

</script>
--%>
</body>
</html>
