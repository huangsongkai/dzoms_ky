<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'item_set.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<script type="text/javascript">
var obj = window.dialogArguments;
$(document).ready(function (){
	$('#add_button').click(function(){
			var str = prompt("请输入要添加的值");
			addOne(obj[0],obj[1],str);
		});
	refresh(obj[0],obj[1]);
	
	getAsDefaultValue(obj[0],function(val){
		if(val==undefined){
			$("#default_val").text("未设置默认值");
		}else{
			$("#default_val").text("当前默认值为:"+val);
		}
	});
});

</script>
<title >可选项操作</title>
  </head>

  <body>
  <div class="container">
  <div class="xb4 xb4-move">
  	<p id="default_val"></p>
	<table id="context"    class=" table table-bordered table-hover " >
	</table>
	<button id="add_button" class="button bg-green">添加</button>
	</div>
	</div>
  </body>
</html>
