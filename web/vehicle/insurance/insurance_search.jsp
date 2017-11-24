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
	<title>保险查询</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script>
	function refreshSearch(){

		$("[name='vehicleSele']").submit();
	}
	
		$(document).ready(function(){
			$("[name='vehicleSele']").find("select").change(function(){
				refreshSearch();
			});
						
			refreshSearch();
			
			$("[name='vehicleSele']").find("input").change(function(){
				//if($(this).val().trim().length==0)
						refreshSearch();
			});
			
			$("[name='insurance.carframeNum']").bigAutocomplete({
				url:"/DZOMS/select/InsuranceBycarframeNum",
				callback:refreshSearch
			});
			
			$("[name='insurance.insuranceNum']").bigAutocomplete({
				url:"/DZOMS/select/InsuranceByinsuranceNum",
				callback:refreshSearch
			});
			
			$("[name='vehicle.licenseNum']").bigAutocomplete({
				url:"/DZOMS/select/vehicleByLicenseNum",
				callback:refreshSearch
			});
			
		});
	</script>
	<style>
        .label{
            text-align: right;
        }
    </style>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>查询保险信息</li>
        </ul>
</div>
<form name="vehicleSele" action="/DZOMS/vehicle/insuranceSele" method="post"
      class="definewidth m20" target="result_form" style="width: 100%;">
    <div class="line">
   	    <div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        		<div class="line">
        			<blockquote class="xm9">
        				<table class="table table-bordered">
        					<tr>
        						<td>车架号</td>
        						<td><input type="text" id="carframe_num" name="insurance.carframeNum" class="input" /></td>
        						<td>车牌号</td>
        						<td><input type="text" name="vehicle.licenseNum" class="input"  value="黑A" /></td>
        						<td>保单号</td>
        						<td><input type="text" name="insurance.insuranceNum" class="input"  /></td>
        						<td>保险类别</td>
        						<td>
        							<select name="insurance.insuranceClass" class="input">
        								<option value="">全部</option>
        								<option value="强">强险单</option>
        								<option value="商">商业保险单</option>
        								<option value="承运">承运人责任险</option>
        							</select>
        						</td>
        					</tr>
        				
        				</table>
         			</blockquote>
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



