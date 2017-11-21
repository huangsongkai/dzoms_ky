<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.common.other.TimeComm"%>
<%@page import="com.dz.module.vehicle.VehicleApproval"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>废业生成</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/JsonList.js"></script>

</head>

<body>
	
	<div class="adminmin-bread">
		<ul class="bread">
                <li><a href="index.html" class="icon-home"> 开始</a></li>
                <li>车辆废业</li>
        </ul>
	</div>

		<!-- 主页面 -->
		<div class="form-disabled">
		<form name="vehicleApprovalWrite" action="/DZOMS/vehicle/vehicleApprovalUpdate" method="post"
			class="definewidth m20">
			<s:hidden name="vehicleApproval.checkType" value="1"></s:hidden>
			<s:hidden name="vehicleApproval.id" id="vehicleApprovalId"></s:hidden>
			<s:hidden name="url" value="/vehicle/AbandonApproval/judge.jsp"></s:hidden>
			<table class="table table-bordered table-hover m10">
				<tr>
					<td style="width: 10%" class="tableleft">所属部门</td>
					<td>
						<s:textfield id="department" name="contract.branchFirm" />
					</td>

					<td class="tableleft">车牌号</td>
					<td>
						<s:textfield  id="licenseNum" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',contract.carframeNum).licenseNum}"/>	
					</td>
				</tr>
				<tr>
					<td class="tableleft">车型</td>
					<td colspan=1>
						<s:radio name="vehicleApproval.fueltype" list="#{'柴油':'柴油','汽油':'汽油','汽油/天燃气':'汽油/天燃气'}" value="%{vehicleApproval.fueltype}"/>		
					</td>

					<td class="tableleft">车架号</td>
					<td colspan=2>
						<s:textfield id="carframeNum" name="contract.carframeNum" cssStyle="width:100%" />
					</td>
				</tr>
				<tr>
					<td class="tableleft">承包人姓名</td>
					<td>
						<s:textfield  id="contractorName" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',contract.idNum).name}"/>
					</td>

					<td class="tableleft">月承包费</td>
					<td><s:textfield  id="rent" name="contract.rent" /></td>
					<td>元</td>
				</tr>
				<tr>
					<td class="tableleft">机动车行驶证核发日期</td>
					<td><s:textfield id="licenseRegisterDate" name="vehicleApproval.licenseRegisterDate" /></td>

					<td class="tableleft">运营手续归属</td>
					<td><s:radio name="vehicleApproval.ascription" list="%{#{'false':'公司','true':'个人'}}"/></td>
				</tr>
				<tr>
					<!--<td class="tableleft">车辆保险</td>
					<td><input type="radio" name="vehicleApproval.insurance" checked="checked"/>含 <input
						type="radio" name="vehicleApproval.insurance" />不含</td>-->

					<td class="tableleft">承租合同期限</td>
					<td><s:textfield name="contract.contractBeginDate" 
						id="contract.contractBeginDate"/>至
						<s:textfield id="contract.contractEndDate" name="contract.contractEndDate" /></td>
				</tr>
				<tr>
					<%@page import="com.opensymphony.xwork2.util.*,com.dz.module.contract.*" %>
					<td class="tableleft">运营时长</td>
					<%
					java.util.Date date = new java.util.Date();
					ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
					Contract c = (Contract) vs.findValue("contract");
					long timespan = Math.min(c.getContractEndDate().getTime(), date.getTime()) - c.getContractBeginDate().getTime();
					long days = timespan / 3600000 / 24;
					long month = days /30;
					days = days % 30;
					String sspan = ""+month+"个月,"+days+"天";
					request.setAttribute("sspan", sspan);
					%>
					<td>
						<%--<s:textfield  id="operateDuration" value="%{@com.dz.common.other.TimeComm@subDate(contract.contractBeginDate,@org.apache.commons.lang.ObjectUtils@min(contract.contractEndDate,#request.nowDate))}" /> --%>
						<s:textfield  id="operateDuration" value="%{#request.sspan}" />
					</td>
					<td class="tableleft">办理事项</td>
					<td>
						<s:radio name="vehicleApproval.handleMatter" list="%{#{'false':'废业','true':'解除'}}"></s:radio>
						
				</tr>
				<tr>
					<td class="tableleft">原因</td>
					<td >
					<s:textfield name="contract.abandonReason"
						readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td class="tableleft">承租人申请</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							name="contract.abandonRequest" rows="3"
							cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
				<tr>
					<td class="tableleft">分部经理意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							name="vehicleApproval.branchManagerRemark" rows="3"
							cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			
				<tr>
					<td class="tableleft">保险管理员意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							name="vehicleApproval.assurerRemark" rows="3"
							cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
				<!--<tr>
					<td class="tableleft">收款员意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							name="vehicleApproval.cashierRemark" rows="3" 
							cssStyle="width:100%">
						</s:textarea>
					</td>
				</tr>-->
				<tr>
					<td class="tableleft">运营部经理意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							name="vehicleApproval.managerRemark" rows="3" 
							cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
				<tr class="form-not-disabled">
					<td class="tableleft">综合办公室意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							id="officeRemark"
							name="vehicleApproval.officeRemark" rows="3" 
							cssStyle="width:100%"></s:textarea>
					</td>
				</tr>

				<tr>
					<td class="tableleft"></td>
					<td colspan="3" style="text-align:right;">
						<input type="button" value="同意" class="btn btn-primary" onclick="approvalApply('#officeRemark');">
						<button type="submit" class="btn btn-primary" type="button">提交</button>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-success dialogs" name="backid"
							id="backid" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%">中止</button>
					</td>
				</tr>
			</table>
		</form>
		
		<form action="/DZOMS/vehicle/vehicleApprovalInterrupt" method="post" name="interruptForm">
			<s:hidden name="vehicleApproval.checkType" value="1"></s:hidden>
			<s:hidden name="vehicleApproval.id"></s:hidden>
			<s:hidden name="url" value="/vehicle/AbandonApproval/judge.jsp"></s:hidden>
			<s:hidden name="vehicleApproval.interruptPerson" value="%{#session.user.uid}"></s:hidden>
			<s:hidden name="vehicleApproval.interruptReason"></s:hidden>
		</form>
	</div>
<div id="mydialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>中止原因</strong> 
   			</div>
   			<div class="dialog-body">
          		<textarea class="input reason"></textarea>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close">取消</button> 
   				 <button class="button bg-green dialog-close" onclick="interrupt()">中止</button> 
   			</div> 
  		</div> 
   </div>
   
   <script>
   	function interrupt(){
   		var reason = $(".dialog-win .reason").val();
   		$('input[name="vehicleApproval.interruptReason"]').val(reason);
   		document.interruptForm.submit();
   	}
   </script>
</body>
</html>