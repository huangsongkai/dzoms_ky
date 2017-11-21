<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>查询信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>

<script>
$(document).ready(function(){
			$("#search_form").find("input").change(function(){
				
				var begin_time = $("#beginDate").val().trim();
				var end_time = $("#endDate").val().trim();
				
				var condition = " and time >= STR_TO_DATE('"+begin_time+"','%Y/%m/%d') ";
				condition += " and time <= STR_TO_DATE('"+end_time+"','%Y/%m/%d') ";
				
				$("[name='condition']").val(condition);
				$("#search_form").submit();
			});
			
			$("#search_form").submit();
		});
</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员管理</li>
                <li>家访</li>
                <li>家访信息查询</li>
        </ul>
</div>
		<!-- 主页面 -->
<div class="line">
	<div class="panel  margin-small" >
          	<div class="panel-head">
          		<div class="float-left">
          			<h4><strong class="text-black">查询条件</strong></h4>
          		</div>
          		
          		<div style="text-align: right;">
                    <a href="javascript:;" class="button border-main bg-yellow" data-click="panel-collapse"><i class="icon icon-minus text-white"></i></a>
                    <a href="javascript:;" class="button border-main bg-red" data-click="panel-remove"><i class="icon icon-times text-white"></i></a>
                </div>
          		
          	</div>
          	<div class="panel-body">		
		<form method="post" class="form-inline" id="search_form" action="/DZOMS/driver/homevisit/searchHomeVisit" target="result_form">
			<input type="hidden" name="url" value="search_result.jsp"/>
			<input type="hidden" name="condition" />
			  <div class="form-group">
			  	<div class="label">
			  		<label>开始日期</label>
			  		
			  	</div>
			  	<div class="field">
			  		<input type="text" id="beginDate" name="beginDate" class="datepick input"/>
			  	</div>
			  </div>
			  
			  <div class="form-group">
			  	<div class="label">
			  		<label>结束日期</label>
			  		
			  	</div>
			  	<div class="field">
			  		<input type="text" id="endDate" name="endDate" class="datepick input"/>
			  	</div>
			  </div>
			
		</form>
		</div>
	</div>
</div>
<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" style="overflow:none;" scrolling="no">
		
    </iframe>
</div>
    <script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>

 <script src="/DZOMS/res/js/apps.js"></script>
    <script>
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
    $(document).ready(function() {
    	try{
    		 App.init();
    	}catch(e){
    		//TODO handle the exception
    	}
    	
       
        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

    });
    </script>
</html>
