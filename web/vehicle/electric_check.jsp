<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>电子违章</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>审批信息</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
		
		<script>
		var fail = false;
		$(document).ready(function(){
				$.post("/DZOMS/common/electricConfig",{},function(data){
					var resultcode = data.resultcode;
					var reason = data.reason;
					var result = data.result;
					
					if(resultcode!=200){
						alert("远程服务器无法连接，错误原因："+reason);
					}
					
				});
				
				$.post("/DZOMS/common/electricTimesLeave",{},function(data){
					var resultcode = data.resultcode;
					var reason = data.reason;
					var result = data.result;
					
					if(resultcode!=200){
						alert("远程服务器无法连接，错误原因："+reason);
					}else{
						if(result.surplus>0)
							$("#leaveTimes").text('您还可查询'+result.surplus+"次。");
						else{
							$("#leaveTimes").text('您的appKey已过期，请登陆https://www.juhe.cn/进行充值。');
						}
					}
					
				});
		});
		
		var $thead = $("<tr><th>违章时间</th><th>违章地点</th><th>违章行为</th><<th>违章扣分</th><th>违章罚款</th><th>是否处理</th></tr>");
		function getInfo(){
			$.post("/DZOMS/common/electricInfo",{"carNo":$('input[name="carNo"]').val(),"carframeNum":$('input[name="carframeNum"]').val()},function(data){
					var resultcode = data.resultcode;
					var reason = data.reason;
					var result = data.result;
					
					if(resultcode!=200){
						alert("远程服务器无法连接，错误原因："+reason);
					}else{
						var list = result.lists;
						
						if(list.length==0){
							$("#result").html('无违章记录。');
							return;
						}
						
						$("#result").html($thead);
						for(var i=0;i<lists.length;i++){
							var item = list[i];
							var $tr=$('<tr></tr>')
.append($('<td></td>').text(item.date))	
.append($('<td></td>').text(item.area)) 	
.append($('<td></td>').text(item.act))
.append($('<td></td>').text(item.code))
.append($('<td></td>').text(item.fen))
.append($('<td></td>').text(item.money))
.append($('<td></td>').text(item.handled));
							$("#result").append($tr);
/**date 	String 	违章时间
  	area 	String 	违章地点
  	act 	String 	违章行为
  	code 	String 	违章代码(仅供参考)
  	fen 	String 	违章扣分(仅供参考)
  	money 	String 	违章罚款(仅供参考)
  	handled 	String 	是否处理,1处理 0未处理 空未知*/
  							
  	
						}
					}
			});
		}
			
		</script>
	</head>
	<body>
		<blockquote id="leaveTimes" class="border-main margin-big"></blockquote>
		<blockquote class="border-main margin-big">
			<div class="panel-body">
				<form class="form-inline">
					<div class="form-group">
					<div class="label"><lable>车牌号</lable></div>
					<div class="field"><input name="carNo" class="input"/></div>
				</div>
				<div class="form-group">
					<div class="label"><lable>车架号</lable></div>
					<div class="field"><input name="carframeNum" class="input"/></div>
				</div>
				<div class="form-group">
					<div class="label"><lable></lable></div>
					<div class="field">
						<input type="hidden" name="cityId" />
						<input type="button" onclick="getInfo()" value="提交"/>
					</div>
				</div>
				
				
				</form>
				
		<div id="result">
			
		</div>
	</body>
</html>
