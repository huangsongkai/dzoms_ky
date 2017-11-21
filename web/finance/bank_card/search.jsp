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
				$("#search_form").submit();
			});
			
			$("#search_form").submit();
		});
		function carFocus(){
			$('input[name="bankCard.carNum"]').val("黑A");
		}
</script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>银行卡查看</li>
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
          	 <form method="post" class="form-inline" id="search_form" action="/DZOMS/BankCardSearch" target="result_form">
			<table class="table">
				<tr>
					<td>
						<div class="form-group">
							<div class="label"><label>银行卡号</label></div>
							<div class="field">
								<input type="text" name="bankCard.cardNumber" class="input input-auto" size="22" />
							</div>
						</div>
					</td>
					<td>
						<div class="form-group">
							<div class="label"><label>身份证号</label></div>
							<div class="field">
								<input type="text" name="bankCard.idNumber" class="input input-auto" size="22"/>
							</div>
						</div>
					</td>
					
					<td>
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
					</td>
					<td>
						<div class="form-group">
							<div class="label"><label>车牌号</label></div>
							<div class="field">
								<input type="text" name="bankCard.carNum" class="input input-auto" size="22" value="黑A" onfocus="carFocus()"/>
							</div>
						</div>
					</td>
                    
                    <td>
						<div class="form-group">
							<div class="label"><label>排序</label></div>
							<div class="field">
								<input type="radio" name="order" value="cardNumber" /> 按卡号 &nbsp;
								<input type="radio" name="order" value="idNumber" /> 按身份证号 &nbsp;
								<input type="radio" name="order" value="carNum" checked="checked"/> 按车牌号 &nbsp;
							</div>
							<div class="field">
								<input type="radio" name="rank" value="true" checked="checked"/> 从小到大 &nbsp;
								<input type="radio" name="rank" value="false" /> 从大到小 &nbsp;
							</div>
						</div>
					</td>
                   
<!--                    <td colspan="2"><input type="button" value="查询" onclick="search()"></td>
-->				</tr>
			</table>
		</form>
          	</div>
   </div>
</div>
		
		<div>
    <iframe name="result_form" width="100%" height="1500px" scrolling="no">

    </iframe>

</div>
   <script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>
