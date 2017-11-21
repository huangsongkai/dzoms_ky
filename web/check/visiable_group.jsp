<%@ page import="com.dz.module.vehicle.newcheck.Group" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-14
  Time: 下午11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>可见组</title>
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
    function addRecord(groupId){
    	
      openView("/DZOMS/check/getGroupWithRecord?groupId="+groupId,{});
    }
  </script>
</head>
<body style="min-height: 800px;">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>自检计划</li>
                <li>添加车辆</li>
        </ul>
</div>
<div class="line">
	 <div class="panel margin-small">
          	<div class="panel-head">
          		<div >
          			<h4><strong class="text-black">查询计划</strong></h4>
          		</div>
          		
          	
          		
          	</div>
          	<div class="panel-body">
          		<form action="/DZOMS/check/searchGroupByTimeAndUser" method="post" class="form-inline">
                    <div class="form-group">
                    	<div class="label">
                    		<label>年月</label>
                    	</div>
                    
                      <div class="field">
                      	  <input class="input datepick">
                      </div>
                      </div>
                      <input type="submit" value="提交" class="button bg-main"> 
                    
              </form>
          		 
          	</div>
   </div>
	
</div>

  
  <%Object o = request.getAttribute("groups");%>
  <%if(o != null){%>
    <%List<Group> groups = (List)o;%>
    	<div class="line">
	<div class="panel margin-small" >
          	<div class="panel-head">
          		计划详细	
          	</div>
          	<div class="panel-body">
    <table class="table table-bordered table-hover table-striped">
      <tr>
        <th>计划名称</th>
        <th>计划月份</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>地点</th>
        <th>最少检车数</th>
        <th>查看/添加记录</th>
      </tr>
      <%for(Group group : groups){%>
        <tr>
          <td><%=group.getPlan().getTitle()%></td>
          <td><%=group.getPlan().getTime()%></td>
          <td><%=group.getStartTime()%></td>
          <td><%=group.getEndTime()%></td>
          <td><%=group.getLocation()%></td>
          <td><%=group.getMinNum()%></td>
          <td><a class="button bg-yellow" onclick="addRecord(<%=group.getId()%>)">查看/添加</a></td>
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
