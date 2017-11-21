<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-4-18
  Time: 下午4:05
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
	 <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>自检</li>
                <li>统计</li>
        </ul>
</div>
    <form id="form" action="/DZOMS/check/selecctCheckRecordsByTimePass" method="post" target="iframe">
    	<div class="panel margin-big">
    		<div class="panel-head">复检查询</div>
    		<div class="panel-body">
    			        <label>开始日期：</label><input type="text" name="startTime"  class="datepick">
    			        <label>结束日期：</label><input type="text" name="endTime"    class="datepick">
    			        	<input type="submit" class="button bg-main">
    		</div>
    	</div>

      
        
    </form>
    <iframe name="iframe" style="width: 100%;height:450px" class="margin-big"></iframe>
</body>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</html>
