<%@page import="com.dz.common.factory.HibernateSessionFactory"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.charge.*,com.dz.common.other.*,org.hibernate.*" pageEncoding="UTF-8" %>
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
	<title> 财务统计 </title>
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
			<li> 详情 </li>
		</ul>
	</div>

	<div class="line" style="height: 300px; overflow:auto">
		<table class="table table-hover table-striped table-bordered">
			<thead>
			<tr>
				<th>部门</th><th>车号</th><th>收费类型</th><th>金额</th><th>时间</th><th>操作人员</th><th>备注</th>
			</tr>
			</thead>
			<tbody>
			<s:set name="planSum" value="0.0"></s:set>
			<s:if test="#request.list!=null&&#request.list.size()>0">
				<s:set name="c" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract',#request.list[0].contractId)}"></s:set>
				<%
					Map<String,String> mp = new HashMap<>();
					mp.put("add_bank","哈尔滨银行");
					mp.put("add_bank2","招商银行");
					mp.put("add_cash","现金");
					mp.put("add_insurance","保险");
					mp.put("add_other","其它");
					mp.put("sub_insurance","银行");
					mp.put("sub_other","其它");
					mp.put("plan_add_contract","合同费用");
					mp.put("plan_add_insurance","保险费用");
					mp.put("plan_add_other","其它费用");
					mp.put("plan_base_contract","合同基础费用");
					mp.put("plan_sub_contract","合同费用");
					mp.put("plan_sub_insurance","保险费用");
					mp.put("plan_sub_other","其它费用");

					request.setAttribute("mp", mp);
				%>
				<s:iterator value="%{#request.list}" var="v">
					<tr cId='<s:property value="%{#v.contractId}"/>'>
						<td><s:property value="%{#c.branchFirm}"/></td>
						<td><s:property value="%{#c.carNum}"/></td>
						<td>
							<s:property value="%{#request.mp[#v.feeType]}"/>
						</td>
						<td>
							<s:if test="%{@org.apache.commons.lang3.StringUtils@contains(#v.feeType,'sub')}">
								<s:set name="fee" value="%{#v.fee*-1}"></s:set>
							</s:if>
							<s:else>
								<s:set name="fee" value="%{#v.fee}"></s:set>
							</s:else>
							<s:property value="%{#fee}"/>
						</td>
						<td><s:property value="%{#v.inTime}"/></td>
						<td><s:property value="%{#v.register}"/></td>
						<td><s:property value="%{#v.comment}"/></td>
						<s:set name="planSum" value="%{#planSum+#fee}"></s:set>
					</tr>
				</s:iterator>
			</s:if>
			</tbody>
			<tfoot>
			<tr>
				<td>合计</td>
				<td>-</td>
				<td><s:property value="%{#request.list.size()}" /></td>
				<td><s:property value="%{#planSum}"/></td>
				<td>-</td>
				<td>-</td>
				<td>-</td>
				<td>-</td>
			</tr>
			</tfoot>
		</table>
	</div>

	<div>
	</div>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"> </script>
</html>