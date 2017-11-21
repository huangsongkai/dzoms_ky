<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
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
	<title>车辆新增</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
	<script>
		$(document).ready(function(){
			getList1('vehicleMode.fuel','vehicleMode_fuel');
			
			$("[name='vehicleSele']").find("input,select").change(function(){
				$("[name='vehicleSele']").submit();
			});
			
			$("[name='vehicleSele']").submit();
		});
	</script>
  </head>
  <body style="background-color:transparent;">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>查询车辆型号</li>
    </ul>
</div>
<div class="line">
	<div class="panel  margin-small xm4" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        	<form name="vehicleSele" action="/DZOMS/vehicle/vehicleModeSelect" method="post"  target="result_form">
        	 <table class="table xm12">
                        <tr>
                            <td style="border-top: 0px;">燃料种类</td>
                            <td  style="border-top: 0px;"> 
                            	<select class="input" id="vehicleMode_fuel" name="vehicleMode.fuel"></select>
                            </td>
                           
                        </tr>
                        <!--<tr>
                        	 <td class="tableleft">燃料种类</td>
                            <td><select id="vehicleMode.fuel" name="vehicleMode.fuel" class="input">
                                 <option>汽油</option>
                                  <option>柴油</option>
                                    <option>汽油/柴油</option>
                                </select>
                            </td>
                        </tr>-->
                       
                    </table>
                    
</form>
        </div>
  </div>
	
</div>



<div>
    <iframe name="result_form" width="100%" height="800px" scrolling="no">

    </iframe>

</div>


</body>
</html>




