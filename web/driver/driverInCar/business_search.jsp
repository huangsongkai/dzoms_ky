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
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css"/>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
	<jsp:include page="/common/msg_info.jsp"></jsp:include>
<script>
$(document).ready(function(){
			$("#search_form").find("select").change(function(){
				$("#search_form").submit();
			});
			
			$("#search_form").submit();
			
			$("[name='idNum']").bigAutocomplete({
				url:"/DZOMS/select/driverById",
				callback:function(){
					$("#search_form").submit();
				}
			});
		});
		
		function resetName(select){
			var value = $(select).find("option:selected").val();
			if(value=='null'){
				$(select).removeAttr("name");
			}else{
				$(select).attr("name","isInCar");
			}
		}
</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员管理</li>
               
                <li>证照查询</li>
              
        </ul>
</div>		<!-- 主页面 -->
<div class="line">
	 <div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
          	  <div class="panel-body">
          	  	<form method="post" style="width: 100%;" class="definewidth m20 form-inline" id="search_form" action="/DZOMS/driver/driverInCar/searchLicense" target="result_form">
			<div class="form-group padding">
				<div class="label">
					<label>姓名</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" size="20" name="name"/>
				</div>
			</div>
			<div class="form-group padding">
				<div class="label">
					<label>身份证号</label>
				</div>
				<div class="field">
					<input type="text" class="input input-auto" size="20" name="idNum"/>
				</div>
			</div>
			<div class="form-group padding">
				<div class="label">
					<label>是否在车</label>
				</div>
				<div class="field">
					<select onchange="resetName(this)" class="input">
							<option value="null">全部</option>
							<option value="true">是</option>
							<option value="false">否</option>
						</select>
				</div>
			</div>
			
			<div class="form-group padding">
							<div class="label"><label>部门</label></div>
							<div class="field">
							<select name="driver.dept" class="input">
          		      	 		<option value="all">全部</option>
          		      	 		<option value="一部">一部</option>
          		      	 		<option value="二部">二部</option>
          		      	 		<option value="三部">三部</option>
          		      	 	</select>
							</div>
						</div>
          		 
          		        <div class="form-group padding">
          		      	 <div class="label">
          		      	 	 <label>车牌号</label>
          		      	 </div>
          		      	 <div class="field">
          		      	 	<input type="text"  name="licenseNum" class="input" value="黑A"/>
          		      	 </div>
          		       </div>
          		       
          	<div class="form-group padding">
          		<input type="submit" value="查询" />
          		</div>
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
    });
</script>
</html>
