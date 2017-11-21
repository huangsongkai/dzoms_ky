<%@ page import="com.dz.module.vehicle.newcheck.Plan" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-15
  Time: 上午10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
  <script>
    function openView(view,args){
      window.showModalDialog(view,args,
              'dialogWidth:1024px;dialogHeight:800px;edge:raised;resizable:yes;scroll:no;status:no;center:yes;help:no;minimize:yes;maximize:yes;');
    }
    function getGroups(id){
      openView("/DZOMS/check/getGroups_search?planId="+id, {});
    }
  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>自检计划</li>
                <li>查看自检计划执行结果</li>
        </ul>
</div>
<div class="line">
	<div class="panel margin-small" >
          	<div class="panel-head">
          		<div >
          			<h4><strong class="text-black">查询计划</strong></h4>
          		</div>
          	</div>
          	<div class="panel-body">
          		 <form method="post" action="/DZOMS/check/searchPlansByTime" class="form-inline">
                   <span><strong>年月</strong></span><input type="text" name="time" class="input datepick">
                   <input type="submit" value="查询" class="button bg-main">
               </form>
          	</div>
   </div>       	
	
</div>
 
<%Object o = request.getAttribute("plans");%>
<%if(o != null){%>
  <%List<Plan> plans = (List<Plan>)o;%>
  	<div class="line">
	<div class="panel margin-small" >
          	<div class="panel-head">
          	计划列表	
          	</div>
          	<div class="panel-body">
  <table class="table table-bordered table-hover table-striped">
    <tr>
      <th>计划名称</th>
      <th>计划时间</th>
      <th>查看组信息</th>
    </tr>
      <%for(Plan plan:plans){%>
    <tr>
      <td><%=plan.getTitle()%></td>
      <td><%=plan.getTime()%></td>
      <td><a class="button bg-blue" onclick="getGroups(<%=plan.getId()%>)">查看</a></td>
    </tr>
      <%}%>
  </table>
  </div>
  </div>
 </div>
<%}%>
</body>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</html>
