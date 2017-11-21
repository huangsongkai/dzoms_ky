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
			<li> 统计分析 </li> <li> 财务统计 </li>
		</ul>
	</div>
	<div class="line" style="height: 30; overflow:auto">
		<form action="charge_anaylse.jsp" method="post" class="form form-x">
			<div class="from-group">
				<div class="label xm2"><label class="float-left">月份</label></div>
				<div class="field xm2">
					<s:textfield cssClass="input input-auto datepick2" name="month" value="%{#parameters.month}" />
				</div>
			</div>
			<div class="form-button xm2"> <input class="button" value="查询" type="submit"></button> </div>
		</form>
	</div>
	<div class="line" style="height: 300px; overflow:auto">
		<table class="table table-hover table-striped table-bordered">
			<thead>
			<tr>
				<th>部门</th><th>车号</th><th>调费次数</th><th>调费总额</th><th>收款次数</th><th>收款总额</th>
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

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				String hql="select new com.dz.module.charge.ChargePlanSum("
						+ "p.contractId as contractId,"
						+ "c.carNum as carNumber,"
						+ "c.branchFirm as dept,"
						+ "sum(case "
						+ "when p.feeType not like '%plan%' then 0.0 "
						+ "when p.feeType like '%sub%' then (-p.fee) "
						+ "else p.fee end"
						+ ") as planSum,"
						+ "sum(case "
						+ "when p.feeType not like '%plan%' then 0 "
						+ "else 1 end"
						+ ") as planTimes,"
						+ "sum(case "
						+ "when p.feeType like '%plan%' then 0.0 "
						+ "when p.feeType like '%sub%' then (-p.fee) "
						+ "when p.feeType like '%add%' then p.fee "
						+ "else 0.0 end"
						+ ") as receiveSum,"
						+ "sum(case "
						+ "when p.feeType like '%plan%' then 0 "
						+ "when p.feeType like '%sub%' then 1 "
						+ "when p.feeType like '%add%' then 1 "
						+ "else 0 end"
						+ ") as receiveTimes"
						+ ")"
						+ "from ChargePlan p,Contract c "
						+ "where p.contractId=c.id "
						+ "and p.inTime>=:inTime "
						+ "and p.inTime<:inTimeEnd "
						+ "group by c.id "
						+ "order by c.branchFirm,c.carNum ";
				Calendar dt = Calendar.getInstance();
				dt.setTime(monthDate);
				dt.set(Calendar.DATE, 1);
				dt.set(Calendar.HOUR_OF_DAY, 0);
				dt.set(Calendar.MINUTE, 0);
				dt.set(Calendar.SECOND, 0);
				dt.add(Calendar.SECOND, -1);

				Session s = HibernateSessionFactory.getSession();
				Query query = s.createQuery(hql);
				query.setDate("inTime", dt.getTime());

				Calendar inTimeEnd = (Calendar)dt.clone();
				inTimeEnd.add(Calendar.MONTH,1);

				query.setDate("inTimeEnd", inTimeEnd.getTime());

				List<ChargePlanSum> list = query.list();
				request.setAttribute("list", list);
				request.setAttribute("pl","'%plan%' and feeType!='last_month_left'");

				request.setAttribute("dt", "'"+sdf.format(dt.getTime())+" 23:59:59'");
			%>
			<s:set name="planTimes" value="0"></s:set>
			<s:set name="receiveTimes" value="0"></s:set>
			<s:set name="planSum" value="0.0"></s:set>
			<s:set name="receiveSum" value="0.0"></s:set>
			<s:if test="#request.list!=null">
				<s:iterator value="%{#request.list}" var="v">
					<tr cId='<s:property value="%{#v.contractId}"/>'>
						<td><s:property value="%{#v.dept}"/></td>
						<td><s:property value="%{#v.carNumber}"/></td>
						<td>
							<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.charge.ChargePlan&url=%2fstatistics%2fcharge_detail.jsp&pageSize=15&condition='+@java.net.URLEncoder@encode(' and fee!=0 and contractId='+#v.contractId+' and feeType like '+#request.pl+' and inTime>'+#request.dt,'UTF-8')}">
								<s:property value="%{#v.planTimes}"/>
							</s:a>
						</td>
						<td>
							<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.charge.ChargePlan&url=%2fstatistics%2fcharge_detail.jsp&pageSize=15&condition='+@java.net.URLEncoder@encode(' and fee!=0 and contractId='+#v.contractId+' and feeType like '+#request.pl+' and inTime>'+#request.dt,'UTF-8')}">
								<s:property value="%{#v.planSum}"/>
							</s:a>
						</td>
						<td>
							<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.charge.ChargePlan&url=%2fstatistics%2freceive_detail.jsp&pageSize=15&condition='+@java.net.URLEncoder@encode(' and fee!=0 and contractId='+#v.contractId+' and feeType not like '+#request.pl+' and inTime>'+#request.dt,'UTF-8')}">
								<s:property value="%{#v.receiveTimes}"/>
							</s:a>
						</td>
						<td>
							<s:a target="show" href="%{'/DZOMS/common/selectToList?className=com.dz.module.charge.ChargePlan&url=%2fstatistics%2freceive_detail.jsp&pageSize=15&condition='+@java.net.URLEncoder@encode(' and fee!=0 and contractId='+#v.contractId+' and feeType not like '+#request.pl+' and inTime>'+#request.dt,'UTF-8')}">
								<s:property value="%{#v.receiveSum}"/>
							</s:a>
						</td>
						<s:set name="planTimes" value="%{#planTimes+#v.planTimes}"></s:set>
						<s:set name="receiveTimes" value="%{#receiveTimes+#v.receiveTimes}"></s:set>
						<s:set name="planSum" value="%{#planSum+#v.planSum}"></s:set>
						<s:set name="receiveSum" value="%{#receiveSum+#v.receiveSum}"></s:set>
					</tr>
				</s:iterator>
			</s:if>
			</tbody>
			<tfoot>
			<tr>
				<td>合计</td>
				<td><s:property value="%{#request.list.size()}"/></td>
				<td><s:property value="%{#planTimes}"/></td>
				<td><s:property value="%{#planSum}"/></td>
				<td><s:property value="%{#receiveTimes}"/></td>
				<td><s:property value="%{#receiveSum}"/></td>
			</tr>
			</tfoot>
		</table>
	</div>

	<div>
		<iframe name="show" style="width: 100%;height: 500px;" >

		</iframe>
	</div>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"> </script>
</html>