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
$(document).ready(function(){
	var iframe = window.parent.parent.document.getElementsByName("body")[0];
	var iframeP = window.parent.document.getElementById("body-right");
	$(iframe).css("height","1500");
	$(iframeP).css("height","1500");
});

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
        <li>车辆开业审批单</li>
        <li>查看</li>
    </ul>
</div>
<div class="panel">
	<div class="panel-body">
    <form action="vehicleApprovalUpdate" method="post"
          class="definewidth m20 form-inline form-tips" id="vehicleApprovalUpdate">
        <s:hidden name="bean[0].id"></s:hidden>
        <s:hidden name="bean[0].contractId"></s:hidden>
        <s:hidden name="bean[0].state" readonly="true"></s:hidden>
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
                            <s:textfield id="department" name="bean[1].branchFirm" cssClass="input" readonly="true"></s:textfield>
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
                            	value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',bean[1].idNum).name}"/>
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
                            	 value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',bean[1].idNum).phoneNum1}"></s:textfield>
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
                            <s:select cssClass="input" readonly="true" id="contract_businessForm" name="bean[1].businessForm" list="{'承包','挂靠'}" theme="simple"></s:select>
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
<s:radio name="bean[0].ascription" list="%{#{'false':'公司','true':'个人'}}"/>
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
		                	<s:set name="hrb_bankcard" value="%{@com.dz.common.other.ObjectAccess@execute('from BankCard where idNumber='+#request.quate+bean[1].idNum+#request.quate+' and cardClass like '+#request.quate+'哈尔滨%'+#request.quate)}"></s:set>
		                	<s:set name="yz_bankcard" value="%{@com.dz.common.other.ObjectAccess@execute('from BankCard where idNumber='+#request.quate+bean[1].idNum+#request.quate+' and cardClass like '+#request.quate+'邮政%'+#request.quate)}"></s:set>
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
                            <s:radio name="bean[0].cartype" 
                            	list="#{'true':'新车','false':'二手车'}" value="%{bean[0].cartype}"/>
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
                            	value="%{bean[1].carNumOld}"/>
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
                            <s:radio name="bean[0].fueltype"  
                            	list="#{'柴油':'柴油','汽油':'汽油','汽油/天燃气':'汽油/天燃气'}" value="%{bean[0].fueltype}"/>
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
                            <s:textfield id="licenseNum" name="bean[1].carNum" cssClass="input" readonly="true"/>
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
                            	name="bean[1].carframeNum" cssStyle="width:100%" />
                        </div>
                    </div>
                </td>
                <%--
                <s:if test="%{bean[1].contractFrom!=null}">
                <td>
                    <div class="form-group form-disabled">
                        <div class="label padding">
                            <label class="">
                                月承包费
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="rent" name="bean[1].rent" cssClass="input" readonly="true"/>
                        </div>
                    </div>
                </td>
                </s:if>
                <s:else>
                <td>
                    <div class="form-group form-not-disabled">
                        <div class="label padding">
                            <label class="">
                                月承包费
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="rent" name="bean[1].rent" cssClass="input" />
                        </div>
                    </div>
                </td>
                </s:else>
                --%>
                <td>
                    <div class="form-group form-disabled">
                        <div class="label padding">
                            <label class="">
                                月承包费
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="rent" name="bean[1].rent" cssClass="input" readonly="true"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <s:if test="%{bean[1].contractFrom==null}">
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
                                    <s:textfield id="terminationDate" name="bean[0].terminationDate" cssClass="input input-auto " size="10" readonly="true" />
                                </td>
                                <td>
                                    <s:textfield id="procedureEndDate" name="bean[0].procedureEndDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:if test="%{bean[0].terminationDate!=null&&bean[0].procedureEndDate!=null}">
                                		<s:textfield id="terminationDays" name="bean[0].terminationDays" cssClass="input input-auto " value="%{@com.dz.common.other.TimeComm@subDateToDays(bean[0].terminationDate,bean[0].procedureEndDate)}" size="2" readonly="true"/>
                                	</s:if>
                                	<s:else>
                                		<s:textfield id="terminationDays" name="bean[0].terminationDays" cssClass="input input-auto " size="2" readonly="true"/>
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
                                <td>提车日</td>
                                <td>行车执照登记日期</td>
                                <td>天数</td>
                            </tr>
                            <tr>
                                <td>
                                    <s:textfield id="getCarDate" name="bean[0].getCarDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:textfield id="licenseRegisterDate" name="bean[0].licenseRegisterDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:if test="%{bean[0].getCarDate!=null&&bean[0].licenseRegisterDate!=null}">
                                		<s:textfield id="getCarDays" name="bean[0].getCarDays" cssClass="input input-auto " value="%{@com.dz.common.other.TimeComm@subDateToDays(bean[0].getCarDate,bean[0].licenseRegisterDate)}" size="2" readonly="true"/>
                                	</s:if>
                                	<s:else>
                                		<s:textfield id="getCarDays" name="bean[0].getCarDays" cssClass="input input-auto " size="2" readonly="true"/>
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
                                <td>申报日</td>
                                <td>营运证核发日期</td>
                                <td>天数</td>
                            </tr>
                            <tr>

                                <td class="tableleft">
                                    <s:textfield id="operateApplyDate" name="bean[0].operateApplyDate" cssClass="input input-auto " size="10" />
                                </td>
                                <td>
                                    <s:textfield id="operateCardDate"  name="bean[0].operateCardDate" cssClass="input input-auto " size="10"  readonly="true"/>
                                </td>
                                <td>
                                    <s:if test="%{bean[0].operateApplyDate!=null&&bean[0].operateCardDate!=null}">
                                		<s:textfield id="operateDays" name="bean[0].operateDays" cssClass="input input-auto " value="%{@com.dz.common.other.TimeComm@subDateToDays(bean[0].operateApplyDate,bean[0].operateCardDate)}" readonly="true" size="2" />
                                	</s:if>
                                	<s:else>
                                		<s:textfield id="operateDays" name="bean[0].operateDays" cssClass="input input-auto " readonly="true" size="2" />
                                	</s:else>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        </s:if>
        <!--<div>
            <div class="form-group">
                <div class="label padding">
                    <label class="">
                        有无邮政储蓄卡
                    </label>
                </div>
                <div class="field">
                    <s:radio name="bean[0].creditCard" list="#{'true':'有','false':'无'}" />
                </div>
            </div>

            <div class="form-group">
                <div class="label padding" style="width: 260px">
                    <label>
                        车损保险
                    </label>
                </div>
                <div class="field">
                    <s:radio name="bean[0].damageInsurance" list="#{'0.3':'30%','0.9':'90%'}"  />
                </div>
            </div>-->

            <s:if test="%{bean[1].contractFrom==null}">
            <div class="form-group" cssStyle="width: 320px;">
                <div class="label padding">
                    <label>
                        首年保险金额
                    </label>
                </div>
                <div class="field">
                    <s:textfield cssClass="input input-auto" size="5" maxlength="5" id="onetimeAfterpay" name="bean[0].onetimeAfterpay" readonly="true"></s:textfield>元
                </div>
            </div>
            </s:if>
			<s:if test="%{bean[1].contractFrom!=null}">
            <div class="form-group">
                <div class="label padding" cssStyle="width: 260px">
                    <label class="">
                        补交保费
                    </label>
                </div>
                <div class="field">
                    <s:textfield id="onetimeAfterpay" name="bean[0].onetimeAfterpay" cssClass="input" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding" cssStyle="width: 260px">
                    <label class="">
                        补交起始日
                    </label>
                </div>
                <div class="field">
                    <s:textfield id="payBeginDate" name="bean[0].payBeginDate" cssClass="input"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding" cssStyle="width: 260px">
                    <label class="">
                        补交终止日
                    </label>
                </div>
                <div class="field">
                    <s:textfield id="payEndDate" name="bean[0].payEndDate" cssClass="input"/>
                </div>
            </div>
           </s:if>
           
        </div>
        </blockquote>
        
        <blockquote class="form-disabled">
            <strong>承租人申请：</strong>
            <div>
                <s:textarea name="bean[1].driverRequest" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%"></s:textarea>
            </div>
        </blockquote>
        
        <blockquote class="form-disabled">
            <strong>运营管理部-分部经理意见：</strong>
            <div>
                <s:textarea
                        id="branchManagerRemark"
                        name="bean[0].branchManagerRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        <blockquote class="form-disabled" style="display: none;">
            <strong>运营管理部-保险员意见：</strong>
            <div>
                <s:textarea id="assurerRemark"
                            name="bean[0].assurerRemark" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>

    <s:set name="bean_state" value="%{bean[0].state<=0?(-bean[0].state):bean[0].state}"></s:set>
    <% int[] applyStateMap = {0,1,2,4,5,6,7,3};request.setAttribute("applyStateMap",applyStateMap); %>
    <s:set name="stage" value="%{#request.applyStateMap[#bean_stage] + (bean[0].state<=0?1:0)}"></s:set>
        <s:if test="%{#stage>2}">
        <blockquote class="form-disabled">
            <strong>综合业务部-经理意见：</strong>
            <div>
                <s:textarea id="managerRemark"
                            name="bean[0].managerRemark" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%">
                    
                </s:textarea>
            </div>
        </blockquote>
        </s:if>

        <s:if test="%{#stage>3}">
            <blockquote class="form-disabled">
                <strong>运营管理部-经理意见：</strong>
                <div>
                    <s:textarea id="cashierRemark"
                                name="bean[0].cashierRemark" cssClass="input-xlarge"
                                rows="3" cssStyle="width:100%">
                    </s:textarea>
                </div>
            </blockquote>
        </s:if>

    <s:if test="%{#stage>4}">
        <blockquote class="form-disabled">
            <strong>计财部收款员意见：</strong>
            <div>
                <s:textarea
                        id="financeRemark"
                        name="bean[0].financeRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        </s:if>

    <s:if test="%{#stage>5}">
        <blockquote class="form-disabled">
            <strong>计财部经理意见：</strong>
            <div>
                <s:textarea
                        id="financeManagerRemark"
                        name="bean[0].financeManagerRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        </s:if>

    <s:if test="%{#stage>6}">
        <blockquote class="form-disabled">
            <strong>主管副总经理意见：</strong>
            <div>
            	<s:if test="%{bean[1].contractFrom==null}">
            	<!--优惠天数：--><s:textfield name="bean[0].discountDays" value="3" cssStyle="display: none;"></s:textfield>
                </s:if>
                <s:textarea id="directorRemark"
                            name="bean[0].directorRemark" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%">
                    
                </s:textarea>
            </div>
        </blockquote>
        </s:if>

    <s:if test="%{#stage>7}">
        <blockquote class="border-main form-disabled">
            <strong>综合办公室意见：</strong>
            <div>
                <s:textarea id="officeRemark"
                            name="bean[0].officeRemark" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%">
                </s:textarea>
            </div>
        </blockquote>
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

    </form>
</div>
</div>
</body>
</html>
