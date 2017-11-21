<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.charge.BankRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.dz.module.contract.BankCard" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-19
  Time: 下午4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
    <script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
  <script>
    function checkIfDoIt(){
      var result = window.confirm("确定执行清帐操作吗？\n本月的欠款将自动计入账户中，\n该操作不可恢复!!!");
      return result;
    }
    function show_records(){
      var department = $("#dept").val();
      if(department != undefined && department != ""){
        $("#department").val(department);
        $("#form1").submit();
      }
    }
  </script>
  <script>
    $(document).ready(function(){
      show_records();
      $.post("/DZOMS/charge/getCurrentMonth",{'department':'total'},function(data){
        $("#currentMonth").html(data);
        $.post("/DZOMS/charge/getCurrentMonth",{'department':'一部'},function(part1){
          if(part1 != data){
            $("#cleared").html($("#cleared").html()+'一部 ');
          }else{
            $("#uncleared").html($("#uncleared").html()+'一部 ');
          }
        });
        $.post("/DZOMS/charge/getCurrentMonth",{'department':'二部'},function(part1){
          if(part1 != data){
            $("#cleared").html($("#cleared").html()+'二部 ');
          }else{
            $("#uncleared").html($("#uncleared").html()+'二部 ');
          }
        });
        $.post("/DZOMS/charge/getCurrentMonth",{'department':'三部'},function(part1){
          if(part1 != data){
            $("#cleared").html($("#cleared").html()+'三部 ');
          }else{
            $("#uncleared").html($("#uncleared").html()+'三部 ');
          }
        });
      });
    });
  </script>
</head>
<body>
<div class="adminmin-bread">
    <ul class="bread">
        <li>开始</li>
        <li>财务</li>
        <li>清算</li>
    </ul>
</div>
<div class="line margin-small">
<div class="alert xm4"><strong>当前待结算年月：</strong><span id="currentMonth"></span></div>
<div class="alert xm4"><strong>已清算部门：</strong><span id="cleared"></span></div>
<div class="alert xm4"><strong>未清算部门：</strong><span id="uncleared"></span></div>
</div>
<div class="alert alert-main margin-small" style="margin-top: 0px;">
		<span class="close rotate-hover"></span><strong>上次操作结果:</strong>
		 <%=request.getAttribute("message") != null?request.getAttribute("message"):"无上次操作"%>
</div>
<div class="margin-small">
    <div class="panel">
    	<div class="panel-head">清帐:</div>
    	<div class="panel-body">
    		   <form action="/DZOMS/charge/finalClear" method="post" onSubmit="return checkIfDoIt();" class="form-inline">

            <div class="form-group">
                <div class="label padding">
                    <label>
                        部门：
                    </label>
                </div>
                <div class="field">
                    <select name="department" id="dept" onChange="show_records()" class="input">
                        <option value="一部">一部</option>
                        <option value="二部">二部</option>
                        <option value="三部">三部</option>
                    </select>
                </div>
            </div>
            <input type="submit" value="清帐" class="button bg-green"/>
        </form>
         <iframe name="records_show" id="records_show" width="100%" style="height: 500px;"></iframe>
        <form id="form1" action="/DZOMS/charge/getCheckChargeTableByDept" method="post" target="records_show">
            <input type="hidden" name="department" id="department">
        </form>
    	</div>
       
       
    </div>


</div>

</body>
</html>
