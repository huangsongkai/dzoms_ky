<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.module.vehicle.VehicleApproval"%>
<%@ page language="java" import="java.util.*,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
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
<title>新车开业</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<style>
	.label{
		text-align: right;
	}
</style>
<script>
	function setMoney(){
		var moneyStr = $("#money").val();
		try{
			var money = parseFloat(moneyStr);
			if (isNaN(money)) {
				alert("请填写一个金额！");
				return;
			}
			$("#rent").val(money);
		}catch(e){
			alert("请填写一个金额！");
		}
	}
</script>
<script>
$(document).ready(function(){
	var licenseNum = $("#oldLicenseNum").val();
	$.post("/DZOMS/common/doit",{"condition":"from Contract c where c.state=1 and c.carframeNum in (select v.carframeNum from Vehicle v where v.licenseNum='"+licenseNum+"') order by contractBeginDate desc "},function(data){
		var contract=data["affect"];
		if(contract!=undefined){
			var abandonedTime = new Date();
			abandonedTime.setTime(contract["abandonedTime"]["time"]);
			$("#terminationDate").val(abandonedTime.format("yyyy/MM/dd"));
	
			var abandonedFinalTime = new Date();
			abandonedFinalTime.setTime(contract["abandonedFinalTime"]["time"]);
			$("#procedureEndDate").val(abandonedFinalTime.format("yyyy/MM/dd"));
	
			var diff_day = abandonedFinalTime.diff(abandonedTime);
			$("#terminationDays").val(diff_day);
		}
	});
});
</script>
</head>

<body>
<div class="admin-bread">
    <ul class="bread">
        <li><a href="" class="icon-home"> 开始</a></li>
        <li>车辆开业</li>
        <li>车辆</li>
    </ul>
</div>
<!-- 主页面 -->
<div class="panel">
	<div class="panel-body">
    <form action="vehicleApprovalUpdate" method="post"
          class="definewidth m20 form-inline form-tips" id="vehicleApprovalUpdate" >
        <s:hidden name="vehicleApproval.id"></s:hidden>
        <s:hidden name="vehicleApproval.contractId"></s:hidden>
        <s:hidden name="vehicleApproval.state" readonly="true"></s:hidden>
        <s:hidden name="url" value="/vehicle/CreateApproval/approval_list.jsp"></s:hidden>
        <blockquote class="form-disabled">
            <strong>审核信息</strong>
        <table class="table table-hover">
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label">
                            <label>
                                运营管理部
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="department" name="contract.branchFirm" cssClass="input" readonly="true"></s:textfield>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                承包人姓名
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="contractorName"  cssClass="input" readonly="true"
                            	value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',contract.idNum).name}"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                承包人电话
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="contractorPhone" cssClass="input" readonly="true"
                            	 value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',contract.idNum).phoneNum1}"></s:textfield>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                购车方式
                            </label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input" readonly="true" id="contract_businessForm" name="contract.businessForm" list="{'承包','挂靠'}" theme="simple"></s:select>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label >
                                运营手续归属
                            </label>
                        </div>
                        <div class="field">
<s:radio name="vehicleApproval.ascription" list="%{#{'false':'公司','true':'个人'}}"/>
                        </div>
                    </div>
                </td>
                <td>
                   <div class="form-group">
		                <div class="label padding">
		                    <label>
		                        银行卡号
		                    </label>
		                </div>
		                <div class="field">
		                	<%request.setAttribute("quate","\'");%>
		                	<s:set name="hrb_bankcard" value="%{@com.dz.common.other.ObjectAccess@execute('from BankCard where idNumber='+#request.quate+contract.idNum+#request.quate+' and cardClass like '+#request.quate+'哈尔滨%'+#request.quate)}"></s:set>
		                	<s:set name="yz_bankcard" value="%{@com.dz.common.other.ObjectAccess@execute('from BankCard where idNumber='+#request.quate+contract.idNum+#request.quate+' and cardClass like '+#request.quate+'邮政%'+#request.quate)}"></s:set>
		                	<s:if test="%{#hrb_bankcard==null&&#yz_bankcard==null}">
		                		无银行卡
		                	</s:if>
		                	<s:else>
		                		<s:if test="%{#hrb_bankcard!=null}">
		                		<s:property value="%{#hrb_bankcard.cardNumber}"/>(哈尔滨银行)
		                		</s:if>
		                		<s:if test="%{#yz_bankcard!=null}">
		                		<s:property value="%{#yz_bankcard.cardNumber}"/>(邮政储蓄)
		                		</s:if>
		                	</s:else>
		                </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label >
                                承包车辆
                            </label>
                        </div>
                        <div class="field">
                            <s:radio name="vehicleApproval.cartype" 
                            	list="#{'true':'新车','false':'二手车'}" value="%{vehicleApproval.cartype}"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                原车牌号
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="oldLicenseNum" cssClass="input" readonly="true"
                            	value="%{contract.carNumOld}"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label >
                                车型
                            </label>
                        </div>
                        <div class="field">
                            <s:radio name="vehicleApproval.fueltype"  
                            	list="#{'柴油':'柴油','汽油':'汽油','汽油/天燃气':'汽油/天燃气','纯电动':'纯电动'}" value="%{vehicleApproval.fueltype}"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                牌照号
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="licenseNum" name="contract.carNum" cssClass="input" readonly="true"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                车架号
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="carframeNum" cssClass="input" readonly="true"
                            	name="contract.carframeNum" cssStyle="width:100%" />
                        </div>
                    </div>
                </td>
                
                <td>
                    <div class="form-group ">
                        <div class="label padding">
                            <label class="">
                                月承包费
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="rent" name="contract.rent" cssClass="input"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <s:if test="%{contract.contractFrom==null}">
        <div class=" container line-big">
            <div class="xm4">
                <div class="panel">
                    <div class="panel-head">
                        <strong>废业</strong>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <td>废业日</td>
                                <td>报废手续办结日期</td>
                                <td>天数</td>
                            </tr>
                            <tr>
                                <td>
                                    <s:textfield id="terminationDate" name="vehicleApproval.terminationDate" cssClass="input input-auto " size="10" readonly="true" />
                                </td>
                                <td>
                                    <s:textfield id="procedureEndDate" name="vehicleApproval.procedureEndDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:if test="%{vehicleApproval.terminationDate!=null&&vehicleApproval.procedureEndDate!=null}">
                                		<s:textfield id="terminationDays" name="vehicleApproval.terminationDays" cssClass="input input-auto " value="%{@com.dz.common.other.TimeComm@subDateToDays(vehicleApproval.terminationDate,vehicleApproval.procedureEndDate)}" size="2" readonly="true"/>
                                	</s:if>
                                	<s:else>
                                		<s:textfield id="terminationDays" name="vehicleApproval.terminationDays" cssClass="input input-auto " size="2" readonly="true"/>
                                	</s:else>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="xm4">
                <div class="panel">
                    <div class="panel-head">
                        <strong>新车</strong>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <td>购入日期</td>
                                <td>行驶证注册日期</td>
                                <td>天数</td>
                            </tr>
                            <tr>
                                <td>
                                    <s:textfield id="getCarDate" name="vehicleApproval.getCarDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:textfield id="licenseRegisterDate" name="vehicleApproval.licenseRegisterDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:if test="%{vehicleApproval.getCarDate!=null&&vehicleApproval.licenseRegisterDate!=null}">
                                		<s:textfield id="getCarDays" name="vehicleApproval.getCarDays" cssClass="input input-auto " value="%{@com.dz.common.other.TimeComm@subDateToDays(vehicleApproval.getCarDate,vehicleApproval.licenseRegisterDate)}" size="2" readonly="true"/>
                                	</s:if>
                                	<s:else>
                                		<s:textfield id="getCarDays" name="vehicleApproval.getCarDays" cssClass="input input-auto " size="2" readonly="true"/>
                                	</s:else>
                                </td>

                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="xm4">
                <div class="panel">
                    <div class="panel-head">
                        <strong>营运手续</strong>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <td>行驶证注册日期</td>
                                <td>营运证核发日期</td>
                                <td>天数</td>
                            </tr>
                            <tr>

                                <td class="tableleft">
                                    <s:textfield id="operateApplyDate" name="vehicleApproval.licenseRegisterDate" cssClass="input input-auto " size="10"  readonly="true" disabled="true"/>
                                </td>
                                <td>
                                    <s:textfield id="operateCardDate"  name="vehicleApproval.operateCardDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                	<s:if test="%{vehicleApproval.licenseRegisterDate!=null&&vehicleApproval.operateCardDate!=null}">
                                		<s:textfield id="operateDays" name="vehicleApproval.operateDays" cssClass="input input-auto " value="%{@com.dz.common.other.TimeComm@subDateToDays(vehicleApproval.licenseRegisterDate,vehicleApproval.operateCardDate)}" readonly="true" size="2" />
                                	</s:if>
                                	<s:else>
                                		<s:textfield id="operateDays" name="vehicleApproval.operateDays" cssClass="input input-auto " readonly="true" size="2" />
                                	</s:else>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        </s:if>
       <!-- <div>
            <div class="form-group">
                <div class="label padding">
                    <label class="">
                        有无邮政储蓄卡
                    </label>
                </div>
                <div class="field">
                   <s:radio name="vehicleApproval.creditCard" list="#{'true':'有','false':'无'}" />
                </div>
            </div>

            <div class="form-group">
                <div class="label padding" style="width: 260px">
                    <label>
                        车损保险
                    </label>
                </div>
                <div class="field">
                    <s:radio name="vehicleApproval.damageInsurance" list="#{'0.3':'30%','0.9':'90%'}"  />
                </div>
            </div>-->

            <s:if test="%{contract.contractFrom==null}">
            <div class="form-group" cssStyle="width: 320px;">
                <div class="label padding">
                    <label>
                        首年保险金额
                    </label>
                </div>
                <div class="field">
                    <s:textfield cssClass="input input-auto" id="onetimeAfterpay" name="vehicleApproval.onetimeAfterpay" readonly="true"></s:textfield>元
                </div>
            </div>
            </s:if>
			<s:if test="%{contract.contractFrom!=null}">
            <div class="form-group">
                <div class="label padding" cssStyle="width: 260px">
                    <label class="">
                        补交保费
                    </label>
                </div>
                <div class="field">
                    <s:textfield id="onetimeAfterpay" name="vehicleApproval.onetimeAfterpay" cssClass="input" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding" cssStyle="width: 260px">
                    <label class="">
                        补交起始日
                    </label>
                </div>
                <div class="field">
                    <s:textfield id="payBeginDate" name="vehicleApproval.payBeginDate" cssClass="input"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding" cssStyle="width: 260px">
                    <label class="">
                        补交终止日
                    </label>
                </div>
                <div class="field">
                    <s:textfield id="payEndDate" name="vehicleApproval.payEndDate" cssClass="input"/>
                </div>
            </div>
           </s:if>
          
        </div>
        </blockquote>
        
        <blockquote class="form-disabled">
            <strong>承租人申请：</strong>
            <div>
                <s:textarea name="contract.driverRequest" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%"></s:textarea>
            </div>
        </blockquote>
        
        <blockquote class="form-disabled">
            <strong>运营管理部-分部经理意见：</strong>
            <div>
                <s:textarea
                        id="branchManagerRemark"
                        name="vehicleApproval.branchManagerRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        <blockquote class="form-disabled" style="display: none;">
            <strong>运营管理部-保险员意见：</strong>
            <div>
                <s:textarea id="assurerRemark"
                            name="vehicleApproval.assurerRemark" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
    <blockquote class="form-disabled">
        <strong>综合业务部-经理意见：</strong>
        <div>
            <s:textarea id="managerRemark"
                        name="vehicleApproval.managerRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

            </s:textarea>
        </div>
    </blockquote>
    <blockquote class="form-disabled">
        <strong>运营管理部-经理意见：</strong>
        <div>
            <s:textarea id="cashierRemark"
                        name="vehicleApproval.cashierRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">
            </s:textarea>
        </div>
    </blockquote>
        <blockquote class="form-disabled">
            <strong>计财部收款员意见：</strong>
            <div>
                <s:textarea
                        id="financeRemark"
                        name="vehicleApproval.financeRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        
        <blockquote class="border-main">
            <strong>计财部经理意见：</strong>
            <div class="alert">请填写月承费 <input id="money" value="0" onblur="setMoney()" ></div>
            <div>
                <s:textarea
                        id="financeManagerRemark"
                        name="vehicleApproval.financeManagerRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        
        <div class="xm7-move">
        	<input type="button" value="同意" class="button bg-green" onclick="approvalApply('#financeManagerRemark');">
            <input type="submit" value="提交" class="button bg-green">
              <button type="button" class="button bg-green dialogs" name="backid"
							id="backid" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%">中止</button>
        </div>

    </form>
</div>
</div>
<form action="/DZOMS/vehicle/vehicleApprovalInterrupt" method="post" name="interruptForm">
			<s:hidden name="vehicleApproval.checkType" value="0"></s:hidden>
			<s:hidden name="vehicleApproval.id"></s:hidden>
			<s:hidden name="url" value="/vehicle/CreateApproval/approval_list.jsp"></s:hidden>
			<s:hidden name="vehicleApproval.interruptPerson" value="%{#session.user.uid}"></s:hidden>
			<s:hidden name="vehicleApproval.interruptReason"></s:hidden>
		</form>
		
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
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>
