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
			$("#search_form").find("input,select").change(function(){
				$("#search_form").submit();
			});
			
			$("#search_form").submit();
		});

//function optionChange(){
//	if ($("#finished option:selected").val()=='all') {
//		$("#finished").attr("name","");
//	} else{
//		$("#finished").attr("name","finished");
//	}
//}
</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员管理</li>
               
                <li>上下车记录查询</li>
              
        </ul>
</div>

<div class="line">
	 <div class="panel  margin-small" >
          	<div class="panel-head">
          		
          			查询条件
          		
          	
          	</div>
          	  <div class="panel-body">
		<!-- 主页面 -->
		<form method="post" style="width: 100%;" class="definewidth m20" id="search_form" action="/DZOMS/driver/driverInCar/searchRecord" target="result_form">
			<table class="table">
				<tr>
					<td class="tableleft" style="border-top: 0px;">身份证号</td>
                    <td style="border-top: 0px;"><input type="text" name="driver.idNum" class="input"/></td>
                    
                    <td class="tableleft" style="border-top: 0px;">开始日期</td>
                    <td style="border-top: 0px;"><input type="text" id="beginDate" class="datetimepicker input" name="beginDate"/></td>
                    
                    <td class="tableleft" style="border-top: 0px;">结束日期</td>
                    <td style="border-top: 0px;"><input type="text" id="endDate" class="datetimepicker input" name="endDate"/></td>
                    
			        <td class="tableleft" style="border-top: 0px;">部门</td>
					<td style="border-top: 0px;">
						<select name="vehicle.dept" id="dept" class="input" style="width: 100px;">
			              			<option value="" selected="selected">全部</option>
			              			<option value="一部">一部</option>
			              			<option value="二部">二部</option>
			              			<option value="三部">三部</option>
			              		</select>
			        </td>
                    
					<td class="tableleft" style="border-top: 0px;">车牌号</td>
					<td style="border-top: 0px;"><input type="text"  value="黑A"  name="vehicle.licenseNum" class="input"/></td>
					
					<td class="tableleft" style="border-top: 0px;">事项</td>
					<td style="border-top: 0px;">
						<select class="input" name="operation">
							<option value="证照" selected="selected">全部</option>
							<option value="证照申请">证照申请</option>
							<option value="证照注销">证照注销</option>
						</select>
					</td>
					
					<td class="tableleft" style="border-top: 0px;">状态</td>
					<td style="border-top: 0px;">
						<select class="input" name="finished">
							<option value="false">未办结</option>
							<option value="true" selected="selected">已办结</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
</div>
<div>
    <iframe name="result_form" width="100%" height="1800px" id="result_form" scrolling="no">

    </iframe>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
   $('.datetimepicker').datetimepicker({
    	lang:"ch",           //语言选择中文
		format:"Y/m/d",      //格式化日期
		timepicker:false,    //关闭时间选项
		yearStart:2000,     //设置最小年份
		onClose:function(){
			$("#search_form").submit();
		}
    });
</script>
</html>
