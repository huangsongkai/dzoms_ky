<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-28
  Time: 下午11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
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
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <script src="/DZOMS/res/js/admin.js"></script>
  <script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>

</head>
<body>
<div class="margin-big-bottom">
  <div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
      <li>财务管理</li>
      <li>作废查询</li>
    </ul>
  </div>
</div>
<div class="line">
  <div class="panel  margin-small" >
    <div class="panel-head">
                     查询条件
    </div>
    <div class="panel-body">
      <form id="form" class="form-inline" action="/DZOMS/charge/receipt/searchRemoves" method="post" target="show">
        <div class="form-group">
          <div class="label"><label>开始日期</label></div>
          <div class="field"><input type="text" name="startTime" class="input datetimepicker"></div>
        </div>
        <div class="form-group">
          <div class="label"><label>结束日期</label></div>
          <div class="field"><input type="text" name="endTime" class="input datetimepicker"></div>
        </div>
        <input type="submit" class="button bg-main" value="提交">
      </form>
    </div>
  </div>
</div>

<div class="line">
  <iframe name="show" width="100%" height="500px" id="result_form" style="overflow:none;">

  </iframe>

</div>

</body>

<script>
  $('.datetimepicker').datetimepicker({
    lang:"ch",           //语言选择中文
    format:"Y/m/d",      //格式化日期
    timepicker:false,    //关闭时间选项
    yearStart:2000,     //设置最小年份
  });
  function iFrameHeight() {
    try{
      var ifm= document.getElementById("result_form");
      var subWeb = document.frames ? document.frames["result_form"].document : ifm.contentDocument;
      if(ifm != null && subWeb != null) {
        ifm.height = subWeb.body.scrollHeight+200;
      }   }catch(e){}
  }

  $(document).ready(function(){
    window.setInterval('iFrameHeight();',3600);
  });
</script>

<script src="/DZOMS/res/js/apps.js"></script>

</html>
</html>
