<%@ page import="com.dz.module.driver.Driver" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-10-11
  Time: 下午10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查询黑名单</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <script src="/DZOMS/res/js/admin.js"></script>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员管理</li>
                <li>聘用</li>
                <li>驾驶员查询</li>
              
        </ul>
     </div>   
</div>
<div class="container">
<div class="panel border-red">
	    <div class="panel-head  border-red bg-red">
	        <strong>黑名单</strong>
	    </div>
	    <div class="panel-body">
	       <table class="table table-hover">
  <tr>
    <th>身份证号</th>
    <th>名字</th>
    <th>年龄</th>
    <th>加入黑名单的原因</th>
    <th>移除</th>
  </tr>
  <% List<Driver> list = (List<Driver>)request.getAttribute("bad_drivers");
    for(Driver d:list){%>
      <tr>
        <td><%=d.getIdNum()%></td>
        <td><%=d.getName()%></td>
        <td><%=d.getAge()%></td>
        <td><%=d.getBadRecordReason()%></td>
        <td><a href="/DZOMS/driver/removeBadRecord?driver.idNum=<%=d.getIdNum()%>">移除</a></td>
      </tr>
  <%}%>
</table>
	        </div>
	</div>
</div>


</body>
</html>
