<%@ page import="com.dz.module.vehicle.newcheck.TJMessage" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-4-18
  Time: 下午2:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
   	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	
	   <style>
    	#test{
            height: 650px;
        }
    </style>
</head>
<body>
<div id="test" >
	<%Map<String,List<TJMessage>> map = (Map) request.getAttribute("maps");%>
<%List<TJMessage> left = map.get("unchecked");%>
<%List<TJMessage> right = map.get("checked");%>
<%int lt = 0;int rt = 0;%>
    <div class="panel xm6" >
      <div class="panel-head">
          <strong>未检查</strong>
      </div>
        <div class="panel-body"  style="height: 600px;overflow: scroll;">
            <table class="left table table-bordered table-hover table-striped ">
                <tr>
                    <th>车号</th>
                    <th>承租人</th>
                    <th>电话</th>
                    <th>分公司归属</th>
                </tr>
                <%for(TJMessage message:left){lt++;%>
                <tr>
                    <td><%=message.getLicenseNUm()%></td>
                    <td><%=message.getRenter()%></td>
                    <td><%=message.getTelephone()%></td>
                    <td><%=message.getDept()%></td>
                </tr>
                <%}%>

            </table>
        </div>
        <div class="panel-foot">
            合计：<%=lt%>
        </div>

    </div>

    <div class="panel xm6"  >
        <div class="panel-head">
            <strong>已检查</strong>
        </div>
        <div class="panel-body"  style="height: 600px;overflow: scroll;">
            <table class="right  table table-bordered table-hover table-striped">
                <tr>
                    <th>车号</th>
                    <th>承租人</th>
                    <th>电话</th>
                    <th>分公司归属</th>
                </tr>
                <%for(TJMessage message:right){rt++;%>
                <tr>
                    <td><%=message.getLicenseNUm()%></td>
                    <td><%=message.getRenter()%></td>
                    <td><%=message.getTelephone()%></td>
                    <td><%=message.getDept()%></td>
                </tr>
                <%}%>

            </table>
        </div>
        <div class="panel-foot">
            合计：<%=rt%>
        </div>
    </div>

	</div>

</body>
</html>
