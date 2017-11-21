<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-22
  Time: 上午12:27
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
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <script>
    function deleteC(x){
      var chargePlanId = $(x).attr("id");
      var r=confirm("确定删除该条记录？");
      if(r==true){
      	$.post('/DZOMS/charge/deleteChargePlan',{"chargePlan.id":chargePlanId},function(data){
        	document.form.submit();
     	  });
      }
    }
  </script>
    <script>
      $(document).ready(function(){
        $.post("/DZOMS/charge/getCurrentTime",{"department":"一部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth1").html("<strong>"+"一部:"+"</strong>"+data["ItemTool"]);
        });
        $.post("/DZOMS/charge/getCurrentTime",{"department":"二部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth2").html("<strong>"+"二部:"+"</strong>"+data["ItemTool"]);
        });
        $.post("/DZOMS/charge/getCurrentTime",{"department":"三部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth3").html("<strong>"+"三部:"+"</strong>"+data["ItemTool"]);
        });
      });
      function carFocus(){
      	$("input[name='licenseNum']").val("黑A");
      }
  </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>欠款清账</li>
    </ul>
</div>
<div class="line padding">
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
	<form id="form" action="/DZOMS/charge/getOweDeleteList" method="post" class="form-inline form-tips" style="width: 100%;">
           <div class="panel margin-small" >
          	<div class="panel-head">
          		查询条件
          		
          	</div>
          	<div class="panel-body">

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield name="licenseNum" cssClass="input" value="%{licenseNum}" onfocus="carFocus()"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            年月
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield name="time" cssClass="input datetimepicker" value="%{time}"/>

                    </div>
                </div>
                <input type="submit" value="查看" class="button bg-green">
            </div>
        </div>
        <br>
    </form>
</div>
<div class="line">
      <div class="panel margin-small" >
          	<div class="panel-head">
          		查询结果	
          	</div>
          	<div class="panel-body">
            <%List<ChargePlan> plans = (List<ChargePlan>)request.getAttribute("plans");%>
            <%if(plans != null){%>
            <table class="table table-bordered table-hover table-striped">
                <tr>
                    <th>类型</th>
                    <th>金额</th>
                    <th>记录时间</th>
                    <th>记录人员</th>
                    <th>操作</th>
                </tr>
                <%for(ChargePlan plan:plans){%>
                <%String rawType = plan.getFeeType();
                String feeType = null;
                if(rawType.equals("add_bank")){
                feeType = "哈尔滨银行";
                }else if(rawType.equals("add_bank2")){
                    feeType = "招商银行";
                }else if(rawType.equals("add_oil")){
                feeType = "油补";
                }else if(rawType.equals("add_cash")){
                feeType = "现金";
                }else if(rawType.equals("add_other")){
                feeType = "其他";
                }else if(rawType.equals("add_insurance")){
                feeType = "保险";
                }%>
                <tr>
                    <td><%=feeType%></td>
                    <td><%=plan.getFee()%></td>
                    <td><%=plan.getInTime()%></td>
                    <td><%=plan.getRegister()%></td>
                    <td><%=plan.getIsClear()?"无操作":"<a onclick='deleteC(this);' id='"+plan.getId()+"'>删除</a>"%></td>
                </tr>
                <%}%>
            </table>
            <%}%>

        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
<script>
	$('.datetimepicker').simpleCanleder();
</script>

</html>
