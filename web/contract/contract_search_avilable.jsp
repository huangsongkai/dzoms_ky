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
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="合同新增,合同查询,合同修改权限" any="true">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>
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
				$("#search_form").submit();
				if($("#search_form input[name='states']:checked").length==1){
					$("#search_form input[name='states']:checked").attr("disabled","disabled");
				}else{
					$("#search_form input[name='states']:checked").removeAttr("disabled");
				}
			});
			
			$("#search_form").submit();
		});
</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<!--<style>
	.label {
		width: 80px;
		text-align: right;
	}
	.form-group {
		width: 380px;
		margin-top: 5px;
	}
	
</style>	-->
</head>
<body>
	<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>合同</li>
                <li>有效合同查询</li>
        </ul>
</div>
<div class="line">
	<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
          	<div class="panel-body">
          		<form class="form-inline" method="post"  id="search_form" action="/DZOMS/contract/contractSearchAvilable" target="result_form">
          		    <input type="hidden" name="url" value="/contract/search_avliable_result.jsp">
					<div class="form-group">
          		      	 <div class="label">
          		      	 	 <label>有效区间</label>
          		      	 </div>
          		      	 <div class="field">
          		      	 	 <input type="text"  name="beginDateStart" class="datepick input"/>
          		      	 	 到<input type="text"  name="beginDateEnd" class="datepick input"/>
          		      	 </div>
          		       </div>
          		       
          		       <div class="form-group">
							<div class="label"><label>部门</label></div>
							<div class="field">
							<select name="dept" class="input">
          		      	 		<option value="all">全部</option>
          		      	 		<option value="一部">一部</option>
          		      	 		<option value="二部">二部</option>
          		      	 		<option value="三部">三部</option>
          		      	 	</select>
							</div>
						</div>
          		 
          		        <div class="form-group">
          		      	 <div class="label">
          		      	 	 <label>车牌号</label>
          		      	 </div>
          		      	 <div class="field">
          		      	 	<input type="text"  name="carNum" class="input" value="黑A"/>
          		      	 </div>
          		       </div>
          		      
          		        <div class="form-group">
          		      	 <div class="label">
          		      	 	 <label>承包人身份证号</label>
          		      	 </div>
          		      	 <div class="field">
          		      	 	  <input type="text" id="contractor" name="idNum" class="input"/>
          		      	 </div>
          		       </div>

          		       <div class="form-group">
          		      	 <div class="label">
          		      	 	 <label>排序</label>
          		      	 </div>
          		      	 <div class="field">
								<input type="radio" name="order" value="contractBeginDate" /> 按合同起始日期 &nbsp;
								<input type="radio" name="order" value="idNum" /> 按身份证号 &nbsp;
								<input type="radio" name="order" value="carNum" checked="checked"/> 按车牌号 &nbsp;
							</div>
							<div class="field">
								<input type="radio" name="rank" value="true" checked="checked"/> 从小到大 &nbsp;
								<input type="radio" name="rank" value="false" /> 从大到小 &nbsp;
							</div>
						   <div class="field">
							   <input type="submit" value="查询">
						   </div>
          		       </div>
          		</form>
          	</div>
    </div>
	
</div>
		<!-- 主页面 -->
	
	<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

    </iframe>

</div>
    <script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>
