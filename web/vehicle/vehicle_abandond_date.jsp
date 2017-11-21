<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="车辆废业起始日期修改权限,车辆废业结束日期修改权限" any="true">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>车辆废业日期</title>
	
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
		
	function search(){
		var condition = " and state=1 and id in (select contractId from VehicleApproval where state=8 and handleMatter=0 ) ";
		condition += $("[name='dt']").val();
		var dept = $("[name='dept']").val();
		if(dept.length>0){
			condition += " and branchFirm ='"+dept+"'";
		}
		
		condition += " order by carNum ";
		
		$("[name='condition']").val(condition);

		$("[name='vehicleSele']").submit();
	}
	
	$(document).ready(function(){
		$("form  select").change(search);
		search();
	});
	</script>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>车辆废业日期</li>
    </ul>
</div>
 
<form name="vehicleSele" action="/DZOMS/common/selectToList" method="post"
      class="definewidth m20" target="result_form" style="width: 100%;">
      <input type="hidden" name="url" value="/vehicle/vehicle_abandond_date_result.jsp" />
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
                            
                             <td class="tableleft">废业日期</td>
                            <td><select name="dt" class="input">
                            	<option value=" and abandonedFinalTime is null ">未录入</option>
                            	<option value=" and abandonedFinalTime is not null ">已完成</option>
                            	<option value=" ">全部</option>
                            </select></td>
                        
                            <!--<td>车辆识别代码/车架号</td>
                            <td><input type="text" id="carframe_num" name="vehicle.carframeNum" class="input" /></td>
                        
                            <td>发动机号</td>
                            <td><input type="text" id="engine_num" name="vehicle.engineNum" class="input" /></td>
-->
                          <!--  <td>承租人</td>
                            <td><input type="text" id="driver_name" name="driverName" class="input"/></td>
-->

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
