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
<m:permission role="合同新增">
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
<title>合同待新增</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
			$("#search_form").find(".input").change(function(){
				beforeSubmit();
			});
			beforeSubmit();
		});
		
function beforeSubmit(){
	var condition ="and state=3 ";
	
	var dept=$("[name='dept']").val();
	if(dept!="all"){
		condition += " and branchFirm='"+dept+"' ";
	}
	
	var carNum = $("[name='carNum']").val();
	if(checkLicenseNum(carNum)){
		condition += " and carNum='"+carNum+"' ";
	}
	
	var idNum = $("[name='idNum']").val();
	if(idNum.trim().length==18){
		condition += " and idNum='"+idNum+"' ";
	}
	
	$("[name='condition']").val(condition);
	$("#search_form").submit();

}

/*
$(document).ready(function(){
		$("[name='carNum']").bigAutocomplete({
			url:"/DZOMS/select/vehicleByLicenseNum",
			callback:beforeSubmit()
		});
		$("[name='idNum']").bigAutocomplete({
			url:"/DZOMS/select/driverById",
			callback:beforeSubmit()
		});
});
*/

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
                <li>合同待新增</li>
        </ul>
</div>
<div class="line">
	<div class="panel  margin-small" >
          	
          	<form class="form-inline" method="post"  id="search_form" action="/DZOMS/contractToNew" target="result_form">
          		<input type="hidden" name="condition" value="and state=3"></input>
          		<div class="form-group">
          		      	 <div class="label">
          		      	 	 <label>部门</label>
          		      	 </div>
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
          		      	 	<input type="text"  name="carNum" value="黑A" class="input"/>
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
