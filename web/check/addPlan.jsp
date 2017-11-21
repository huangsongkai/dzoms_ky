<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-7
  Time: 下午11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
  <!-- c-->
  <script>
    function checkIfSaved(){
      var title = $("#title").val();
      var time = $("#time").val();
      return title != "" && title != undefined && time != undefined && time != "";
    }
    function openView(view,args){
      window.showModalDialog(view,args,
             'dialogWidth:1024px;dialogHeight:800px;edge:raised;resizable:yes;scroll:no;status:no;center:yes;help:no;minimize:yes;maximize:yes;');
    }
    function addGroup(){
      if(checkIfSaved()){
        var title = $("#title").val();
        var time = $("#time").val();
        $.post("/DZOMS/check/addPlan",{"plan.title":title,"plan.time":time},function(data){
          data = $.parseJSON(data);
          var planId = data["int"];
          $("#hid").val(planId);
          openView("/DZOMS/check/addGroup.jsp?planId="+planId, {"planId":planId});
          $("#plan_detail_show").submit();
        });
      }else{
        alert("请先保存数据");
      }
    }
  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>自检计划</li>
                <li>新增自检计划</li>
        </ul>
</div>
<div class="line">
    <div class="panel margin-small"  style="margin-top: 100px;">
          	<div class="panel-head">
          		添加计划	
          	</div>
          	<div class="panel-body">
          		<form action="/DZOMS/check/addPlan" method="post" id="form" class="form-inline">
          			<div class="form-group">
          				  <div class="label">
          				  	<label>
          				  		标题
          				  	</label>
          				  </div>
          				  <div class="field">
          				  	<s:textfield value="%{plan.title}" name="plan.title" id="title" cssClass="input"/>
          				  </div>
          			</div>
          			
          				<div class="form-group">
          				  <div class="label">
          				  	<label>
          				  		年月
          				  	</label>
          				  </div>
          				  <div class="field">
          				  <s:textfield value="%{plan.time}" name="plan.time" id="time" cssClass="input datepick"/>
          				  </div>
          			</div>
          			           <input type="button" onclick="addGroup()" class="button bg-main" value="建立计划"/>
              </form>
               <form action="/DZOMS/check/planDetail" method="post" id="plan_detail_show">
                  <input type="hidden" name="planId" value="" id="hid"/>
               </form>
    
          		
          	</div>
    </div>

</div>
  

</body>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
