<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dz.module.user.User" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("user");
%>


<!DOCTYPE HTML>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>客运检车</title>
	
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
		  function refreshSearch(){
			  $("[name='vehicleSele']").submit();
		  }

		  $(document).ready(function(){
			  $("[name='vehicleSele']").find("select").change(function(){
				  $("[name='vehicleSele']").submit();
			  });

			  $("[name='vehicleSele']").submit();

			  $("[name='vehicleSele']").find("input").change(function(){
				  if($(this).val().trim().length==0)
					  $("[name='vehicleSele']").submit();
			  });

			  $("#driver_name").bigAutocomplete({
				  url:"/DZOMS/select/driverByName",
				  callback:refreshSearch
			  });

			  $("#carframe_num").bigAutocomplete({
				  url:"/DZOMS/select/vehicleById",
				  callback:refreshSearch,
				  doubleClick:true
//				doubleClickDefault:'LFV'
			  });

			  $("#license_num").bigAutocomplete({
				  url:"/DZOMS/select/vehicleByLicenseNum",
				  callback:refreshSearch
			  });

			  $("#engine_num").bigAutocomplete({
				  url:"/DZOMS/select/vehicleByEngineNum",
				  callback:refreshSearch
			  });

			  <%
          String position = user.getPosition();
                                      String dept="";

                                      if(position==null)
                                          dept="";
                                      else if(position.contains("一"))
                                          dept = "一部";
                                      else if(position.contains("二"))
                                          dept = "二部";
                                      else if(position.contains("三"))
                                          dept = "三部";
        %>
			  $('select[name="vehicle.dept"]').val("<%=dept%>");

		  });
	  </script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
  </head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>客运检车</li>
               
    </ul>
</div>

<form name="vehicleSele" style="width: 100%;" action="vehicleSele" method="post" id="search_form" class="form-inline" target="result_form">
   <div class="panel margin-small">
	   <input type="hidden" name="url" value="/vehicle/transport_search_result.jsp" />
	   <div class="panel-head">
	   	查询条件
	   </div>
	 <div class="panel-body">
		 <div class="line">
			 <div class="xm12 padding">

				 <blockquote class="panel-body">
					 <table class="table" style="border: 0px;">
						 <tr>
							 <td style="border-top: 0px;">承租人</td>
							 <td style="border-top: 0px;"><input type="text" id="driver_name" name="driverName" class="input" size="6"/></td>


							 <td style="border-top: 0px;">归属部门</td>
							 <td style="border-top: 0px;"><select name="vehicle.dept" class="input">
								 <option value="">全部</option>
								 <option value="一部">一部</option>
								 <option value="二部">二部</option>
								 <option value="三部">三部</option>
							 </select></td>

							 <td style="border-top: 0px;">车牌号</td>
							 <td style="border-top: 0px;"><input type="text" id="license_num" value="黑A" name="vehicle.licenseNum" class="input" size="9" /></td>

							 <td style="border-top: 0px;">车辆状态</td>
							 <td style="border-top: 0px;">
								 <select id="car_status" value="黑A" name="vehicle.state" class="input">
									 <option value="-1">全部</option>
									 <option value="0">新车待开业</option>
									 <option value="3">二手车待开业</option>
									 <option value="1">运营中</option>
									 <option value="2">已报废</option>
								 </select>
							 </td>

							 <td style="border-top: 0px;">营运证发放日期</td>
							 <td style="border-top: 0px;"><input type="text" name="operateCardTime_begin" class="input datepick" size="12" /></td>

							 <td style="border-top: 0px;">营运证终止日期</td>
							 <td style="border-top: 0px;"><input type="text" name="operateCardTime_end"  class="input datepick" size="12"/></td>


							 <td style="border-top: 0px;"><input type="submit" value="查询"></td>
						 </tr>
					 </table>
				 </blockquote>
			 </div>
		 </div>
	 		<%--<div class="form-group">--%>
	 			<%--<label>营运证发放日期</label>--%>
	 			<%--<div class="field">--%>
					<%--<input type="text" name="operateCardTime_begin" class="input datepick" />--%>
				<%--</div>--%>
	 		<%--</div>--%>
	 		<%--<div class="form-group">--%>
	 			<%--<label>营运证终止日期</label>--%>
	 			<%--<div class="field">--%>
					<%--<input type="text" name="operateCardTime_end"  class="input datepick"/>--%>
				<%--</div>--%>
	 		<%--</div>--%>
  </div>
</div>
</form>

<iframe name="result_form" width="100%" height="900px" scrolling="no">

</iframe>

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>

</body>
</html>




