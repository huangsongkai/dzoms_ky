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
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>废业生成</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script src="/DZOMS/res/js/JsonList.js"></script>
	<script>
        var handleMap = {'false':0,'true':1};
        var handleList = ['废业','解除','废业'];
        function _update(){
            var handleMatter = "${bean[0].handleMatter}";
            if(confirm('审批单当前为'+handleList[handleMap[handleMatter]]+
                    ',\n确定将其改为'+handleList[handleMap[handleMatter]+1]+"?")){
                document.vehicleApprovalWrite.submit();
            }
        }
	</script>
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
	<form name="vehicleApprovalWrite" action="/DZOMS/vehicle/vehicleApprovalUpdateHandleMatter" method="post"
		  class="definewidth m20">
		<s:hidden name="bean[0].checkType" value="1"></s:hidden>
		<s:if test="%{bean==null||bean[0]==null}">
			<s:hidden name="vehicleApproval.id" id="vehicleApprovalId"></s:hidden>
		</s:if>
		<s:else>
			<s:hidden name="vehicleApproval.id" value="%{bean[0].id}" id="vehicleApprovalId"></s:hidden>
		</s:else>

		<s:hidden name="url" value="/vehicle/AbandonApproval/vehicle_abandon09.jsp"></s:hidden>

		<s:if test="#session.roles.{?#this.rname=='废业办理事项修改权限'}.size>0">
			<div class="xm3 xm9-left">
				<a href="#" onclick="_update()" class="button bg-blue-light">
					<i class="icon-pencil" style="font-size: 20px;"></i>
					<span class="h6"><strong>修改废业办理事项</strong></span>
				</a>
			</div>
		</s:if>

		<table class="table table-bordered table-hover m10">
			<tr>
				<td style="width: 10%" class="tableleft">所属部门</td>
				<td>
					<s:textfield id="department" name="bean[1].branchFirm" />
				</td>

				<td class="tableleft">车牌号</td>
				<td>
					<s:textfield  id="licenseNum" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',bean[1].carframeNum).licenseNum}"/>
				</td>
			</tr>
			<tr>
				<td class="tableleft">车型</td>
				<td colspan=1>
					<s:radio name="bean[0].fueltype" list="#{'柴油':'柴油','汽油':'汽油','汽油/天燃气':'汽油/天燃气','纯电动':'纯电动'}" value="%{bean[0].fueltype}"/>
				</td>

				<td class="tableleft">车架号</td>
				<td colspan=2>
					<s:textfield id="carframeNum" name="bean[1].carframeNum" cssStyle="width:100%" />
				</td>
			</tr>
			<tr>
				<td class="tableleft">承包人姓名</td>
				<td>
					<s:textfield  id="contractorName" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',bean[1].idNum).name}"/>
				</td>

				<td class="tableleft">月承包费</td>
				<td><s:textfield  id="rent" name="bean[1].rent" /></td>
				<td>元</td>
			</tr>
			<tr>
				<td class="tableleft">机动车行驶证核发日期</td>
				<td><s:textfield id="licenseRegisterDate" name="bean[0].licenseRegisterDate" /></td>

				<td class="tableleft">运营手续归属</td>
				<td><s:radio name="bean[0].ascription" list="%{#{'false':'公司','true':'个人'}}"/></td>
			</tr>
			<tr>
				<!--<td class="tableleft">车辆保险</td>
                <td><input type="radio" name="bean[0].insurance" checked="checked"/>含 <input
                    type="radio" name="bean[0].insurance" />不含</td>-->

				<td class="tableleft">承租合同期限</td>
				<td><s:textfield name="bean[1].contractBeginDate"
								 id="bean[1].contractBeginDate"/>至
					<s:textfield id="bean[1].contractEndDate" name="bean[1].contractEndDate" /></td>
			</tr>
			<tr>
				<%@page import="com.opensymphony.xwork2.util.*,com.dz.module.contract.*" %>
				<td class="tableleft">运营时长</td>
				<%
					java.util.Date date = new java.util.Date();
					ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
					Contract c = (Contract) vs.findValue("bean[1]");
					long timespan = Math.min(c.getContractEndDate().getTime(), date.getTime()) - c.getContractBeginDate().getTime();
					long days = timespan / 3600000 / 24;
					long month = days /30;
					days = days % 30;
					String sspan = ""+month+"个月,"+days+"天";
					request.setAttribute("sspan", sspan);
				%>
				<td>
					<%--<s:textfield  id="operateDuration" value="%{@com.dz.common.other.TimeComm@subDate(bean[1].contractBeginDate,@org.apache.commons.lang.ObjectUtils@min(bean[1].contractEndDate,#request.nowDate))}" /> --%>
					<s:textfield  id="operateDuration" value="%{#request.sspan}" />
				</td>
				<td class="tableleft">办理事项</td>
				<td>
					<s:radio name="bean[0].handleMatter" list="%{#{'false':'废业','true':'解除'}}"></s:radio>

				</td>
			</tr>
			<tr>
				<td class="tableleft">原因</td>
				<td >
					<s:textfield name="bean[1].abandonReason"
								 readonly="true" />
				</td>
			</tr>
			<tr>
				<td class="tableleft">承租人申请</td>
				<td colspan="3">
					<s:textarea cssClass="input-xlarge"
								name="bean[1].abandonRequest" rows="3"
								cssStyle="width:100%"></s:textarea>
				</td>
			</tr>
			<tr>
				<td class="tableleft">分部经理意见</td>
				<td colspan="3">
					<s:textarea cssClass="input-xlarge"
								name="bean[0].branchManagerRemark" rows="3"
								cssStyle="width:100%"></s:textarea>
				</td>
			</tr>

			<s:set name="bean_state" value="%{bean[0].state<=0?(-bean[0].state):bean[0].state}"></s:set>
			<% int[] applyStateMap = {0,1,3,2,4,5,6,7};request.setAttribute("applyStateMap",applyStateMap); %>
			<s:set name="stage" value="%{#request.applyStateMap[#bean_stage] + (bean[0].state<=0?1:0)}"></s:set>
			<s:if test="%{#stage>1}">
				<tr>
					<td class="tableleft">保险管理员意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
									name="bean[0].assurerRemark" rows="3"
									cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>
			<%--<tr>
					<td class="tableleft">收款员意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
							name="bean[0].cashierRemark" rows="3" 
							cssStyle="width:100%">
						</s:textarea>
					</td>
				</tr>--%>
			<s:if test="%{#stage>2}">
				<tr>
					<td class="tableleft">综合业务部经理意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
									name="bean[0].managerRemark" rows="3"
									cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>
			<s:if test="%{#stage>3}">
				<tr>
					<td class="tableleft">运营部经理意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
									name="bean[0].cashierRemark" rows="3"
									cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>
			<s:if test="%{#stage>4}">

				<tr>
					<td class="tableleft">综合办公室意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
									name="bean[0].officeRemark" rows="3"
									cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>
			<s:if test="%{bean[0].state>5 || bean[0].state<-4}">
				<tr>
					<td class="tableleft">计财部审核人意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
									name="bean[0].financeRemark" rows="3"
									cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>
			<s:if test="%{bean[0].state>6 || bean[0].state<-5}">
				<tr>
					<td class="tableleft">计财部经理意见</td>
					<td colspan="3">
						<s:textarea cssClass="input-xlarge"
									name="bean[0].financeManagerRemark"
									rows="3" cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>
			<s:if test="%{bean[0].state>7 || bean[0].state<-6}">

				<tr>
					<td class="tableleft">主管副总经理意见</td>
					<td colspan="3">
						<s:if test="%{bean[0].handleMatter==false}">
							<p style="text-align:left">
								合同起始日期：<s:date name="bean[1].contractBeginDate" format="yyyy/MM/dd"></s:date>&nbsp;&nbsp;
								合同终止日期：<s:date name="bean[1].contractEndDate" format="yyyy/MM/dd"></s:date>&nbsp;&nbsp;
								计划废业日期：
								<s:if test="%{bean[1].abandonedTime==null}">
									未指定，按正常废业
								</s:if>
								<s:else>
									<s:date name="bean[1].abandonedTime" format="yyyy/MM/dd"></s:date>
								</s:else>
								<!--</p>
                                <p style="text-align:left">-->
								计费终止日期：
								<s:if test="%{bean[1].abandonedChargeTime==null}">
									<s:date name="bean[1].contractEndDate" format="yyyy/MM/dd"></s:date>
								</s:if>
								<s:else>
									<s:date name="bean[1].abandonedChargeTime" format="yyyy/MM/dd"></s:date>
								</s:else>
							</p>
						</s:if>
						<s:textarea cssClass="input-xlarge"
									name="bean[0].directorRemark" rows="3"
									cssStyle="width:100%"></s:textarea>
					</td>
				</tr>
			</s:if>

			<s:if test="%{bean[0].state<0}">
				<blockquote class="border-main form-disabled">
					<strong>中止信息：</strong>
					<div>
						中止人：
						<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',bean[0].interruptPerson).uname}" ></s:textfield>
					</div>
					<div>
						中止日期：
						<s:textfield cssClass="input" name="bean[0].interruptTime" >
							<s:param name="value">
								<s:date name="bean[0].interruptTime" format="yyyy/MM/dd"/>
							</s:param>
						</s:textfield>
					</div>
					<div>
						中止原因
						<s:textarea
								name="bean[0].interruptReason" cssClass="input-xlarge"
								rows="3" cssStyle="width:100%">
						</s:textarea>
					</div>
				</blockquote>
			</s:if>

			<!-- <tr>
                <td class="tableleft"></td>
                <td colspan="3" align="right">
                    <button type="submit" class="btn btn-primary" type="button">提交</button>
                    &nbsp;&nbsp;
                    <button type="button" class="btn btn-success" name="backid"
                        id="backid" onclick="location.href='/DZOMS/vehicle/AbandonApproval/judge.jsp'">取消</button>
                </td>
            </tr> -->
		</table>
	</form>
</div>
</body>
</html>