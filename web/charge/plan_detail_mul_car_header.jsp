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
   <title>Title</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>多车收费计划查询</li>
    </ul>
</div>
<div class="line">
	<form action="/DZOMS/charge/planDetailMulCar"  target="show" method="post" class="form-inline">
     <label style="margin-left: 40px;">部门</label>
        <select  name="department">
            <option>全部</option>
            <option>一部</option>
            <option>二部</option>
            <option>三部</option>
        </select>

    <label>年月</label><input type="text"  class="input datetimepicker"  name="time">
    <input type="submit" class="button bg-main">
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