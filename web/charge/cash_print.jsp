<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" %>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.module.charge.*" %>
<%@page import="org.springframework.web.context.support.*" %>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.opensymphony.xwork2.util.*" %>

<% String path=request.getContextPath(); 
	String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/"; 
	
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
  	ChargeService vms = ctx.getBean(ChargeService.class);
  	
  	ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>财务收款打印</title>
		<style>
		.table-d table{border:1px solid;border-collapse: collapse}
		.table-d table td{border:1px solid ;}
		
		p{
			margin:0px;
			}
		td{
			height:45px;
			border:0px;
			vertical-align:middle;
			text-align:center;
			}
		/*td.field {
			text-align:left;
			}*/
		body{
			style:font-size:18px;
			}
		
		</style>
		<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
		<script>
		$(document).ready(function(){
			window.print();
		});
		</script>
	</head>
	<body>
		<s:set name="c" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract',bean[0].contractId)}"></s:set>
		<div style="width:800px;margin:0px auto;" class="table-d">
			<h3 align="center" style="margin-top: 0px;margin-bottom: 0px;">哈尔滨大众出租车交款收据</h3>
			<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0"> 
			<tr> 
				<td>部门：</td>
				<td class="field"><s:property value="%{#c.branchFirm}"/></td>
				<td>收款时间：</td>
				<td class="field"><s:date name="bean[0].inTime" format="yyyy/MM/dd HH:mm:ss"/></td>
				<td>收据编号：</td>
				<td class="field"><s:property value="%{bean[0].id}"/></td>
			</tr>
			<tr>
				<td>牌照：</td>
				<td class="field"><s:property value="%{#c.carNum}"/></td>
				<td>收款类型：</td>
				<td class="field">
			<%
String type = vs.findString("bean[0].feeType");
			if (type == null) {
				response.sendRedirect("../common/success_and_close.html");
			}else if(type.equals("add_bank")){
              type = "哈尔滨银行回款";
            }else if(type.equals("add_bank2")){
              type = "招商银行回款";
            }else if(type.equals("add_insurance")){
              type = "保险回款";
            }else if(type.equals("add_cash")){
              type = "现金";
            }else if(type.equals("add_oil")){
              type = "油补";
            }else if(type.equals("add_other")){
              type = "其他";
            }

			%>
				<%=type%>
				</td>
				<td>本次金额：</td>
				<td class="field"><s:property value="%{bean[0].fee}"/></td>
			</tr>
			
			<%
			String carNum = vs.findString("#c.carNum");
			List<CheckChargeTable> lst = vms.getAllCheckChargeTable((Date)vs.findValue("bean[0].time"), "全部", carNum, 4);
			if(lst!=null&&lst.size()>0){
				request.setAttribute("planAll", lst.get(0).getPlanAll());
				request.setAttribute("totalOwe", lst.get(0).getThisMonthTotalOwe());
			}
			 %>
			<tr>
				<td>计划总额</td>
				<td><s:property value="%{#request.planAll}"/></td>
				<td>本月结余</td>
				<td><s:property value="%{#request.totalOwe}"/></td>
				<td colspan="2">
			</tr>
			
			<tr>
				<td colspan="2"></td><td>交款月份</td><td><s:date name="bean[0].time" format="yyyy/MM"/></td>
				<td>收款人</td><td>${sessionScope.user.uname}</td>
			</tr>
			</table>
		</div>
	</body>
</html>
