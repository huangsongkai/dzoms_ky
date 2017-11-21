<%@ page import="com.dz.module.charge.BankRecordTmp" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-25
  Time: 上午12:24
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
  <script>
  	function reimport(id){
  		$.post("/DZOMS/charge/reimportFromTmp",{id:id},function(data){
  			if (data) {
  				window.location.reload();
  			}
  		});
  	}
  	
  	function update(id){
  		var $tr = $(".Brt"+id);
  		var licenseNum = $tr.find(".licenseNum").text();
  		var driverName = $tr.find(".driverName").text();
  		var cardNum = $tr.find(".cardNum").text();
  		
  		$("#openDialog").click();
  		
  		$(".dialog-win .licenseNum").val(licenseNum);
  		$(".dialog-win .id").val(id);
  		$(".dialog-win .name").val(driverName);
  		$(".dialog-win .cardNum").val(cardNum);
  	}
  	
  	function update1(){
  		var id = $(".dialog-win").find(".id").val();
  		var licenseNum = $(".dialog-win").find(".licenseNum").val();
  		var driverName = $(".dialog-win").find(".name").val();
  		var bankCardNum = $(".dialog-win").find(".cardNum").val();
  		$.post("/DZOMS/charge/updateTmp",{"tmp.id":id,"tmp.licenseNum":licenseNum,"tmp.driverName":driverName,"tmp.bankCardNum":bankCardNum},function(data){
  			if (data) {
  				window.location.reload();
  			}
  		});
  	}
  	
  </script>
</head>
<body>
  <%Object o = request.getAttribute("tables");%>
  <%if(o == null){%>
    <span>无数据</span>
  <%}else{%>
    <%List<BankRecordTmp> brs = (List)o;%>
    <table class="table table-bordered table-hover table-striped">
    <tr>
      <th>车牌号</th>
      <th>司机</th>
      <th>卡号</th>
      <th>金额</th>
      <th>记录人</th>
      <th>录入时间</th>
      <s:if test="%{status==2}">
      	<th>错误原因</th>
      	<th>修改</th>
      	<th>重新导入</th>
      </s:if>
    </tr>
    <%for(BankRecordTmp brt:brs){%>
      <tr class="Brt<%=brt.getId()%>">
        <td class="licenseNum"><%=brt.getLicenseNum()%></td>
        <td class="driverName"><%=brt.getDriverName()%></td>
        <td class="cardNum"><%=brt.getBankCardNum()%></td>
        <td><%=brt.getMoney()%></td>
        <td><%=brt.getRecorder()%></td>
        <td><%=brt.getRecodeTime()%></td>
        <s:if test="%{status==2}">
        	<%
        		request.setAttribute("brterror",brt.getError());
        	%>
      	<th><s:property value="%{#request.brterror}"/></th>
      	<th><a href="#" onclick="update(<%=brt.getId()%>)">修改</a></th>
      	<th><a href="#" onclick="reimport(<%=brt.getId()%>)">重新导入</a></th>
      	</s:if>
      </tr>
    <%}%>
    </table>
  <%}%>
 
 <a style="display: none;" id="openDialog" class="button dialogs bg-gray margin" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%"></a>
	<div id="mydialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>数据修改</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>车牌号</strong>
          			<input class="input licenseNum" />
          			<strong>姓名</strong>
          			<input class="input name"/>
          			<strong>银行卡号</strong>
          			<input  class="input cardNum" />
          			<input type="hidden" class="id" />
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green" onclick="update1()">添加</button> 
   			</div> 
  		</div> 
   </div>
</body>
</html>
