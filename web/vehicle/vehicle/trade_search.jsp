<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>查询经营权信息</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script>
	function refreshSearch(){
		var alreadyInput = $("#alreadyInput").val().trim();
		var condition;
		if (alreadyInput.length==0) {
			$("input[name='condition']").val(" and state in (0,1) ");
		} else{
			condition = (alreadyInput=="是" ?" and businessLicenseId is not null ":" and businessLicenseId is null ");
			$("input[name='condition']").val(" and state in (0,1) "+condition);
		}
		$("input[name='condition']").val($("input[name='condition']").val()+" order by licenseNum");
		$("[name='vehicleSele']").submit();
	}
	
		$(document).ready(function(){
			$("[name='vehicleSele']").find("select").change(function(){
				refreshSearch();
			});
						
			refreshSearch();
			
			$("[name='vehicleSele']").find("input").change(function(){
				if($(this).val().trim().length==0)
						refreshSearch();
			});
			
			$("[name='vehicle.carframeNum']").bigAutocomplete({
				url:"/DZOMS/select/vehicleById",
				callback:refreshSearch
			});
			
			$("[name='vehicle.licenseNum']").bigAutocomplete({
				url:"/DZOMS/select/vehicleByLicenseNum",
				callback:refreshSearch
			});
			
			$("[name='vehicle.businessLicenseNum']").change(function(){
				refreshSearch();
			});
			
			
			
		});
	</script>
  </head>
  
 <div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>查询经营权信息</li>
        </ul>
</div>
<form name="vehicleSele" action="/DZOMS/vehicle/vehicleSele" method="post"
      class="definewidth m20" target="result_form">
      <input type="hidden" name="url" value="/vehicle/vehicle/trade_search_result.jsp" />
      <input type="hidden" name="condition" />
   <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          		
          	</div>
        <div class="panel-body">
        	<div class="line">
        		 <div class="xm12 padding">
         
                    <table class="table">
                        <tr>
                            <td>车辆识别代码/车架号</td>
                            <td><input type="text" name="vehicle.carframeNum" class="input" /></td>
                       
                       
                            <td>车牌号</td>
                            <td><input type="text"  value="黑A"  name="vehicle.licenseNum" class="input" /></td>
                            <td>经营权号</td>
                            <td><input type="text" name="businessLicenseNum" class="input" /></td>
                        </tr>
                        <tr>
                            <td>起始日期</td>
                            <td><input type="text"  name="vehicle.businessLicenseBeginDate" class="input datepick" /></td>
                            <td>终止日期</td>
                            <td><input type="text"  name="vehicle.businessLicenseEndDate" class="input datepick" /></td>
                           <td>是否已录入信息</td>
                            <td><select id="alreadyInput">
                            	<option> </option>
                            	<option selected="selected">是</option>
                            	<option>否</option>
                            </select></td>
                        </tr>
                    </table>
               
            </div>
        </div>
      </div>
    </div>
  </div>

</form>
<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

    </iframe>

</div>

</body>
 <script src="/DZOMS/res/js/apps.js"></script>
    <script>
 $('.datepick').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onSelectDate:function(){
		refreshSearch();
	}
});
 
 
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