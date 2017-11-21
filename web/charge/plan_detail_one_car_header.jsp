<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-22
  Time: 下午12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
      function carFocus(){
      	$("input[name='licenseNum']").val("黑A");
      }

      $(document).ready(function(){
          $("input[name='licenseNum']").bigAutocomplete({
              url:"/DZOMS/select/VehicleBylicenseNum"
          });
      });
  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>单车收费计划查询</li>
    </ul>
</div>
<div class="line">
	<form action="/DZOMS/charge/planDetailOneCar"  target="show" method="post" class="form-inline">
        <label style="margin-left: 40px;">车牌号</label><input type="text" class="input" value="黑A" name="licenseNum" onfocus="carFocus()">
        <label>开始年月</label><input type="text" class="input datetimepicker" name="timePass.startTime">
        <label>结束年月</label><input type="text" class="input datetimepicker" name="timePass.endTime">
        <input type="submit" value="提交" class="button bg-main">
   </form>
</div>
    
    <iframe name="show" style="width: 100%;height: 800px;" scrolling="yes">

    </iframe>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>
</html>
