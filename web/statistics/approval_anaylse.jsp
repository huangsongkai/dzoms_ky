<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User,com.dz.module.driver.meeting.*,org.javatuples.Triplet" pageEncoding="UTF-8" %>
<%@page import="org.springframework.web.context.support.*" %>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<% String path=request.getContextPath();
	String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/";

//	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());    
//	VehicleService vms = ctx.getBean(VehicleService.class);
%>

<!DOCTYPE html>
<html lang="zh-cn">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="renderer" content="webkit" />
	<title> 流程统计 </title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	<script src="/DZOMS/res/js/jquery.js"> </script>
	<script src="/DZOMS/res/js/pintuer.js"> </script>
	<script src="/DZOMS/res/js/respond.js"> </script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script>
	<script src="/DZOMS/res/js/admin.js"> </script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>

	<script>


	</script>


	<style>
		.label {
			width: 80px;
			text-align:right;
		}
		.form-group {
			width: 300px;
			margin-top: 5px;
		}
		.changecolor {
			background-color: #0099CC;
		}

	</style>

</head>

<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
			<li> 统计分析 </li> <li> 审批流程统计 </li>
		</ul>
	</div>
	<div class="line" style="height: 30; overflow:auto">
		<form action="approval_anaylse.jsp" method="post" class="form form-x">
			<div class="from-group">
				<div class="label xm2"><label class="float-left">月份</label></div>
				<div class="field xm2">
					<s:textfield cssClass="input input-auto datepick2" name="month" value="%{#parameters.month}" />
				</div>
			</div>
			<div class="form-button xm2"> <input class="button" value="查询" type="submit"></button> </div>
		</form>
	</div>
	<div>
		<table class="table table-hover table-striped table-bordered">
			<thead>
			<tr>
				<th>&nbsp;&nbsp;&nbsp;</th><th>已发起</th><th>已完成</th><th>进行中</th>
			</tr>
			</thead>
			<tbody>

			<%! SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
				SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy/MM");

				final static String pattern =  "^\\d{4}(\\/)\\d{1,2}\\/\\d{1,2}$";
				final static String pattern1 =  "^\\d{4}(\\/)\\d{1,2}$";
			%>

			<%
				String monthStr = request.getParameter("month");
				Date monthDate = null;
				if(monthStr==null||org.apache.commons.lang3.StringUtils.isBlank(monthStr)){
					monthDate = new Date();
				}else{
					if(monthStr.matches(pattern)){
						monthDate =  dateFormat.parse(monthStr);
					}else if(monthStr.matches(pattern1)){
						monthDate =  dateFormat1.parse(monthStr);
					}else{
						monthDate = new Date();
					}
				}

				Calendar dt = Calendar.getInstance();
				dt.setTime(monthDate);
				dt.set(Calendar.DATE, 1);
				dt.add(Calendar.DATE, -1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				request.setAttribute("dt", "'"+sdf.format(dt.getTime())+" 23:59:59'");
				Calendar inTimeEnd = (Calendar)dt.clone();
				inTimeEnd.add(Calendar.MONTH,1);
				request.setAttribute("dt2", "'"+sdf.format(inTimeEnd.getTime())+" 23:59:59'");
				//java.net.URLEncoder.encode("", "UTF-8");
			%>
			<tr>
				<td>新车开业</td>
				<td>
					<s:set name="n_total" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=0 and contractId in(select id from Contract where contractFrom is null) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=0 and contractId in(select id from Contract where contractFrom is null) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#n_total}"/>
					</s:a>
				</td>
				<td>
					<s:set name="n_already" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=0 and state=8 and contractId in(select id from Contract where contractFrom is null and state=0) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=0 and state=8 and contractId in(select id from Contract where contractFrom is null and state=0) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#n_already}"/>
					</s:a>
				</td>
				<td>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=0 and (state!=8 or contractId in(select id from Contract where contractFrom is null and state!=0)) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#n_total-#n_already}"/>
					</s:a>
				</td>
			</tr>
			<tr>
				<td>二手车开业</td>
				<td>
					<s:set name="r_total" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=0 and contractId in(select id from Contract where contractFrom is not null) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=0 and contractId in(select id from Contract where contractFrom is not null) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#r_total}"/>
					</s:a>
				</td>
				<td>
					<s:set name="r_already" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=0 and state=8 and contractId in(select id from Contract where contractFrom is not null and state=0) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=0 and state=8 and contractId in(select id from Contract where contractFrom is not null and state=0) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#r_already}"/>
					</s:a>
				</td>
				<td>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=0 and (state!=8 or contractId in(select id from Contract where contractFrom is not null and state!=0)) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#r_total-#r_already}"/>
					</s:a>
				</td>
			</tr>
			<tr>
				<td>更新</td>
				<td>
					<s:set name="f_total" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=1 and handleMatter=0 and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=1 and handleMatter=0 and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#f_total}"/>
					</s:a>
				</td>
				<td>
					<s:set name="f_already" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=1 and handleMatter=0 and state=8 and contractId in(select id from Contract where state=1) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=1 and handleMatter=0 and state=8 and contractId in(select id from Contract where state=1) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#f_already}"/>
					</s:a>
				</td>
				<td>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=1 and handleMatter=0 and (state!=8 or contractId in(select id from Contract where state!=1)) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#f_total-#f_already}"/>
					</s:a>
				</td>
			</tr>
			<tr>
				<td>转包</td>
				<td>
					<s:set name="g_total" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=1 and handleMatter=1 and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=1 and handleMatter=1 and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#g_total}"/>
					</s:a>
				</td>
				<td>
					<s:set name="g_already" value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from VehicleApproval where checkType=1 and handleMatter=1 and state=8 and contractId in(select id from Contract where state=1) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2)}"></s:set>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=1 and handleMatter=1 and state=8 and contractId in(select id from Contract where state=1) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#g_already}"/>
					</s:a>
				</td>
				<td>
					<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.vehicle.VehicleApproval&url=%2fvehicle%2fvehicle_approval_search_result.jsp&pageSize=5&condition='+@java.net.URLEncoder@encode(' and checkType=1 and handleMatter=1 and (state!=8 or contractId in(select id from Contract where state!=1)) and branchManagerApprovalDate>'+#request.dt+' and branchManagerApprovalDate<='+#request.dt2,'UTF-8')}">
						<s:property value="%{#g_total-#g_already}"/>
					</s:a>
				</td>
			</tr>
			</tbody>
			<tfoot>
			<tr>
				<td>合计</td>
				<td>
					<s:set name="total" value="%{#n_total+#r_total+#f_total+#g_total}"></s:set>
					<s:property value="%{#total}"/>
				</td>
				<td>
					<s:set name="already" value="%{#n_already+#r_already+#f_already+#g_already}"></s:set>
					<s:property value="%{#already}"/>
				</td>
				<td>
					<s:property value="%{#total-#already}"/>
				</td>
			</tr>
			</tfoot>
		</table>
	</div>

	<div>
		<iframe name="show" style="width: 100%;height: 800px;" >
		</iframe>
	</div>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"> </script>
</html>