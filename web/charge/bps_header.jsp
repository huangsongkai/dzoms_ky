<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-4-20
  Time: 下午3:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        $(document).ready(function(){
            $("#licenseNum").bigAutocomplete({
                url:"/DZOMS/select/VehicleBylicenseNum"
            });
        });
      function carFocus(){
      	$("#licenseNum").val("黑A");
      }
    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>单车约定查询</li>
    </ul>
</div>
<form method="post" action="/DZOMS/charge/searchBPS" target="iframe">
    <label style="margin-left: 40px;">车牌号:</label>
    <input type="text" name="licenseNum" class="input input-auto" size="10" value="黑A" id="licenseNum" onfocus="carFocus()">
    <input type="submit" class="button bg-main">
</form>
<iframe name="iframe" style="width: 100%;height:800px;" scrolling="yes" ></iframe>
</body>
</html>
