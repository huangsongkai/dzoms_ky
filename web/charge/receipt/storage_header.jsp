<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-3-6
  Time: 下午4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
</head>

<body>
<div class="margin-big-bottom">
  <div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;"> 
      <li>财务管理</li>
      <li>发票</li>
      <li>库存管理</li>
    </ul>
  </div>
</div>
	<form action="/DZOMS/charge/receipt/searchIns" method="post" target="result" class="form-inline" style="width: 100%;">
	<div class="panel margin-small">
		  <div class="panel-head">
		  	 查询条件
		  </div>
		  <div class="panel-body">
		  	  <div class="form-group">
		  	  	<div class="label">
		  	  		<label>开始日期</label>
		  	  	</div>
		  	  	<div class="field">
		  	  		 <input type="text" name="startTime" class="input datetimepicker">
		  	  	</div>
		  	  </div>
		  	  <div class="form-group">
		  	  	<div class="label">
		  	  		<label>结束日期</label>
		  	  	</div>
		  	  	<div class="field">
		  	  		 <input type="text" name="endTime" class="input datetimepicker">
		  	  	</div>
		  	  </div>
		  	    <input type="submit" class="button bg-main" value="提交">
		  </div>
	</div>
</form>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker({
        lang:"ch",           //语言选择中文
        format:"Y/m/d",      //格式化日期
        timepicker:false,    //关闭时间选项
        yearStart:2000,     //设置最小年份
        yearEnd:2050,        //设置最大年份
        //todayButton:false    //关闭选择今天按钮

    });
</script>
<iframe name="result" style="width: 100%;height: 800px;border: 0px;"></iframe>
</body>

</html>
