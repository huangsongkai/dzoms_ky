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
<title>查询投诉信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>

<script>
$(document).ready(function(){
	$("#complain_search").find("input").change(function(){
		$("#complain_search").submit();
		if($("#complain_search input[name='states']:checked").length==1){
			$("#complain_search input[name='states']:checked").attr("disabled","disabled");
		}else{
			$("#complain_search input[name='states']:checked").removeAttr("disabled");
		}
	});
	
	$("#carNum").bigAutocomplete({
		url:"/DZOMS/select/vehicleByLicenseNum",
		callback:function(){
			
			$("#complain_search").submit();
		}
	});
	
	if($("#carNum").val().trim().length<2){
		$("#carNum").val("黑A");
	}
			
	$("#complain_search").submit();
	
	getSingleList("complain.complainObject", "complain.complainObject", ["complainObject2"]);
});

</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>投诉 查询</li>
              
        </ul>
        </div>
</div>
		<!-- 主页面 -->
<div class="line">
	 <div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
          	  <div class="panel-body">
					<form method="post" class="form-inline" id="complain_search" action="/DZOMS/driver/complain/searchComplain" target="result_form">
			              <div class="form-group">
			              	<div class="label">
			              		<label>开始时间</label>
			              	</div>
			              	<div class="field">
			              		<input type="text" id="beginDate" name="beginDate" class="datetimepicker input"/>
			              	</div>
			              </div>
			              <div class="form-group">
			              	<div class="label">
			              		<label>结束时间</label>
			              	</div>
			              	<div class="field">
			              		<input type="text" id="endDate" name="endDate" class="datetimepicker input"/>
			              	</div>
			              </div>
			              <div class="form-group">
			              	<div class="label"><label>投诉状态</label></div>
			              	<div class="field">
			              		<s:checkboxlist name="states" list="#{0:'待确认',1:'待落实',2:'待回访',3:'待完结',4:'已完结',-1:'不属实'}" 
                    		        value="{0,1,2,3,4,-1}" cssClass="checkbox" />
			              	</div>
			              </div>
			               <div class="form-group">
			              	<div class="label">
			              		<label>部门</label>
			              	</div>
			              	<div class="field">
			              		<select name="dept" id="dept" class="input" style="width: 100px;">
			              			<option value="" selected="selected">全部</option>
			              			<option value="一部">一部</option>
			              			<option value="二部">二部</option>
			              			<option value="三部">三部</option>
			              		</select>
			              	</div>
			              </div>
			              
			              <div class="form-group">
			              	<div class="label">
			              		<label>车号</label>
			              	</div>
			              	<div class="field">
			              		<input type="text" id="carNum" name="complain.carNum" class="input"/>
			              	</div>
			              </div>
			              
			              <div class="form-group">
			              	<div class="label">
			              		<label>投诉类型</label>
			              	</div>
			              	<div class="field">
			              		<select name="complain.complainClass" id="complainClass" class="input" style="width: 100px;" onfocus="getList1('complainClass','complainClass')" ></select>
			              	</div>
			              </div>
			              <div class="form-group">
			              	<div class="label">
			              		<label>违规项目</label>
			              	</div>
			              	<div class="field">
			              		<select name="complain.complainObject" class="input" />
			              		<input type="hidden" name="complainObject2" />
			              	</div>
			              </div>
			              
			               <div class="form-group">
			              	<div class="label">
			              		<label>排序方式</label>
			              	</div>
			              	<div class="field">
			              		<input type="radio" name="order" value="licenseNum" checked="checked" />按车号
			              		<input type="radio" name="order" value="complainTime" />按投诉日期
			              	</div>
			              </div>
			              
			              <input type="reset" class="button bg-yellow" value="清空条件"></input>
			              <input type="submit" class="button bg-yellow" value="查询"></input>
		</form>
					
					
				</div>
				
			</div>
	</div>
		
<div>
    <iframe name="result_form" width="100%" height="1800px" id="resule_form" scrolling="no">

    </iframe>

</div>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
   $('.datetimepicker').datetimepicker({
    	lang:"ch",           //语言选择中文
		format:"Y/m/d",      //格式化日期
		timepicker:false,    //关闭时间选项
		yearStart:2000,     //设置最小年份
		onClose:function(){
			$("#complain_search").submit();
		}
    });
</script>
</html>
