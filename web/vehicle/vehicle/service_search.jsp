
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
	<title>查询计价器信息</title>
	
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
			$("input[name='condition']").val("");
		} else{
			condition = (alreadyInput=="是" ?" and operateCardRegistDate is not null ":" and operateCardRegistDate is null ");
			$("input[name='condition']").val(condition);
		}
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
			
			$("[name='vehicle.moneyCountor']").change(function(){
				refreshSearch();
			});
			
			$("[name='vehicle.licenseNum']").bigAutocomplete({
				url:"/DZOMS/select/vehicleByLicenseNum",
				callback:refreshSearch
			});
			
			/*$("[name='vehicle.operateCard']").change(function(){
				refreshSearch();
			});*/
			
		});
	</script>
  </head>
  
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>查询计价器信息</li>
        </ul>
</div>
<form name="vehicleSele" action="/DZOMS/vehicle/vehicleSele" method="post"
      class="definewidth m20" target="result_form">
      <input type="hidden" name="condition" />
      <input type="hidden" name="url" value="/vehicle/vehicle/service_search_result.jsp" />
    <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        	<div class="line">
        		 <div class="xm12 padding">
            <blockquote class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                        	  <td>车牌号</td>
                            <td><input type="text"  value="黑A"  name="vehicle.licenseNum" class="input" /></td>
                            
                            <td>车辆识别代码/车架号</td>
                            <td><input type="text"  name="vehicle.carframeNum" class="input" /></td>
                       
                       			<td>计价器号</td>
                            <td><input type="text" name="vehicle.moneyCountor" class="input" /></td>
                            
                            <!--<td>营运证号</td>
                            <td><input type="text"  name="vehicle.operateCard" class="input" /></td>-->
                            <td>是否已录入信息</td>
                            <td><select id="alreadyInput">
                            	<option> </option>
                            	<option  selected="selected">是</option>
                            	<option>否</option>
                            </select></td>
                        </tr>
                    </table>
                </blockquote>
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

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>



