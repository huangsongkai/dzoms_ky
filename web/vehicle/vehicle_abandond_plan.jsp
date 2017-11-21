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
	<title>车辆废业计划</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
	
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	
	<script>
		var rawCondition = "and state in (0,-1) ";
		var now = new Date();
		
	function searchByYear(){
		var conditionByYear = " and ( (abandonedTime is null and contractEndDate >= STR_TO_DATE('"+now.getFullYear()+"-01-01','%Y-%m-%d') "+
													" and contractEndDate <= STR_TO_DATE('"+now.getFullYear()+"-12-31','%Y-%m-%d') )"+
													" or ( abandonedTime is not null "+
													" and abandonedTime >= STR_TO_DATE('"+now.getFullYear()+"-01-01','%Y-%m-%d') "+
													" and abandonedTime <= STR_TO_DATE('"+now.getFullYear()+"-12-31','%Y-%m-%d') ) )";
		
		var condition = rawCondition + conditionByYear;
		var dept = $("[name='dept']").val();
		if(dept.length>0){
			condition += " and branchFirm ='"+dept+"'";
		}
		
		$("[name='condition']").val(condition);

		$("[name='vehicleSele']").submit();
	}
	
	function searchByMonth(){
		var month = $("[name='months']").val();
		month = parseInt(month);
//		month = (month<10?"0":"") + month;
		
		//abandonedTime
		
		var conditionByMonth = " and ( (abandonedTime is null and contractEndDate >= STR_TO_DATE('"+now.getFullYear()+"-"+month+"-01','%Y-%m-%d') "+
													" and contractEndDate < STR_TO_DATE('"+(month==12?now.getFullYear()+1:now.getFullYear())+"-"+(month==12?1:month+1)+"-01','%Y-%m-%d') )"+
													" or ( abandonedTime is not null "+
													" and abandonedTime >= STR_TO_DATE('"+now.getFullYear()+"-"+month+"-01','%Y-%m-%d') "+
													" and abandonedTime < STR_TO_DATE('"+(month==12?now.getFullYear()+1:now.getFullYear())+"-"+(month==12?1:month+1)+"-01','%Y-%m-%d') ) )";
		var condition = rawCondition + conditionByMonth;
		
		var dept = $("[name='dept']").val();
		if(dept.length>0){
			condition += " and branchFirm ='"+dept+"'";
		}
		
		$("[name='condition']").val(condition);
		$("[name='vehicleSele']").submit();
	}
	
	var mname = ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'];
	
	$(document).ready(function(){
		var month = now.getMonth();
		$("[name='months']").html("");
		for (var i = month; i < 12; i++) {
			$("<option/>").val(i+1).text(mname[i]).appendTo($("[name='months']"));
		}
		$("[name='months']").val(month);
	});
	</script>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>车辆废业计划</li>
    </ul>
</div>
 
<form name="vehicleSele" action="/DZOMS/common/selectToList" method="post"
      class="definewidth m20" target="result_form" style="width: 100%;">
      <input type="hidden" name="url" value="/vehicle/vehicle_abandond_plan_result.jsp" />
      <input type="hidden" name="condition" />
      <input type="hidden" name="className" value="com.dz.module.contract.Contract" />
   <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          	<strong class="text-black">查询条件</strong>
          	</div>
        <div class="panel-body">
        	<div class="line">
        		<div class="xm12 padding">
     
                <blockquote class="panel-body">
                    <table class="table" style="border: 0px;">
                        <!--<tr>
                            <td>车辆购入日期</td>
                            <td><input type="text" id="vehicle.in_date" name="vehicle.inDate" class="input datepick" /></td>
                        </tr>
                        <tr>
                            <td>车辆制造日期</td>
                            <td><input type="text" id="vehicle.pd" name="vehicle.pd"  class="input datepick"/></td>

                        </tr>
                          <tr>
                            <td>承租人身份证号</td>
                            <td><input type="text" id="vehicle.driver_id" name="vehicle.driverId" class="input" /></td>
                        </tr>-->
                        <tr>
                          <!--  <td>承租人</td>
                            <td><input type="text" id="driver_name" name="driverName" class="input"/></td>
-->
                       
                            <td class="tableleft">归属部门</td>
                            <td><select name="dept" class="input">
                            	<option></option>
                            	<option>一部</option>
                            	<option>二部</option>
                            	<option>三部</option>
                            </select></td>
                        
                            <!--<td>车辆识别代码/车架号</td>
                            <td><input type="text" id="carframe_num" name="vehicle.carframeNum" class="input" /></td>
                        
                            <td>发动机号</td>
                            <td><input type="text" id="engine_num" name="vehicle.engineNum" class="input" /></td>
-->
                          <!--  <td>承租人</td>
                            <td><input type="text" id="driver_name" name="driverName" class="input"/></td>
-->

                       			
                            <td class="tableleft">月份</td>
                            <td>
																<select name="months"></select>
                            </td>
                            
                            <td class="tableleft">
                            	<input type="button" value="按月查询" onclick="searchByMonth()" />
                            </td>
                            
                            <td class="tableleft">
                            	<input type="button" value="按年查询" onclick="searchByYear()" />
                            </td>
                        
                            <!--<td>车辆识别代码/车架号</td>
                            <td><input type="text" id="carframe_num" name="vehicle.carframeNum" class="input" /></td>
                        
                            <td>发动机号</td>
                            <td><input type="text" id="engine_num" name="vehicle.engineNum" class="input" /></td>
-->
                        </tr>
                        <!--<tr>
                            <td>车辆型号</td>
                            <td><input type="text" id="vehicle.car_mode" name="vehicle.carMode" class="input"/></td>
                        </tr>
                        <tr>
                            <td class="tableleft">合格证编号</td>
                            <td><input type="text" id="vehicle.certify_num" name="vehicle.certifyNum" class="input"/></td>
                        </tr>
                        <tr>
                            <td class="tableleft">车牌号</td>
                            <td><input type="text" id="vehicle.license_num" name="vehicle.licenseNum" class="input" /></td>
                        </tr>-->
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
