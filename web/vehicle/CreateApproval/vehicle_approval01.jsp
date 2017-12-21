<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.module.vehicle.VehicleApproval"%>
<%@ page language="java" import="java.util.*,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	VehicleApproval va = (VehicleApproval) session
			.getAttribute("vehicleapproval");
	String state = (String) session.getAttribute("state");
	User user = (User) session.getAttribute("user");
%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="开业发起">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalabel=0" />
<meta name="renderer" content="webkit">
<title>新车开业</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
	$("[name='contract.idNum']").bigAutocomplete({
		url:"/DZOMS/select/driverById",
		callback:function(){
			var idNum = $("[name='contract.idNum']").val();
			$.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":idNum,"isString":true},function(driver){
    			$('#contractorName').val(driver["name"]);
    			$("#contractorPhone").val(driver["phoneNum1"]);	
    			afterDriverChange();
    		});
    		
		}
	});
});

function afterDriverChange(){		
	//alert($("[name='contract.idNum']").val());
		$("#licenseNum").unbind("focus");
		$("#licenseNum").unbind("keydown");
		$("#licenseNum").unbind("keyup");
		
		$("#licenseNum").bigAutocomplete({
			url:"/DZOMS/select/vehicleByLicenseNum",
			condition:" state in (0,3) and driverId='"+$("[name='contract.idNum']").val()+"' ",
			callback:function(){
				var licenseNum = $("#licenseNum").val();
				$.post("/DZOMS/common/doit",{"condition":"from Vehicle where licenseNum='"+licenseNum+"' "},function(data){
					if (data!=undefined &&data["affect"]!=undefined ) {
						var vehicle = data["affect"];
    					$("#carframeNum").val(vehicle["carframeNum"]);
    				}
				});
			}
		});
		
		$("#carframeNum").unbind("focus");
		$("#carframeNum").unbind("keydown");
		$("#carframeNum").unbind("keyup");
		
		$("#carframeNum").bigAutocomplete({
			url:"/DZOMS/select/vehicleById",
			condition:" state in (0,3) and driverId='"+$("[name='contract.idNum']").val()+"' ",
			callback:function(){
				var cid = $("#carframeNum").val();
				$.post("/DZOMS/common/doit",{"condition":"from Vehicle where carframeNum='"+cid+"' "},function(data){
					if (data!=undefined &&data["affect"]!=undefined ) {
						var vehicle = data["affect"];
						$("#licenseNum").val(vehicle["licenseNum"]);
					}
				});
			}
		});
}
function GetQueryString(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var result = window.location.search.substr(1).match(reg);
    return result?decodeURIComponent(result[2]):null;
}

	
	$(document).ready(function(){
		<s:if test="%{#request.contractFrom==null}">
		$("#oldLicenseNum").prop("disabled",true);
		</s:if>
		$("#terminationDate").prop("disabled",true);
		$("#procedureEndDate").prop("disabled",true);
		$("#terminationDays").prop("disabled",true);
		
		
		$('input[name="vehicleApproval.cartype"]').click(function(){
			var val = $(this).val();
			var cartype = $(this).attr("cartype");
			
			$("#oldLicenseNum").val("");
			
			if (cartype==1) {//新车
				$("#oldLicenseNum").prop("disabled",true);
				$("#title").html("<h2><strong>新车生成开业</strong></h2>");
				$("#info_box").show();
			}else if(cartype==2){//更新
				$("#oldLicenseNum").prop("disabled",false);
				$("#title").html("<h2><strong>新车生成开业</strong></h2>");
				$("#info_box").show();
				
				$("#oldLicenseNum").unbind("focus");
				$("#oldLicenseNum").unbind("keydown");
				$("#oldLicenseNum").unbind("keyup");
				
				$("#oldLicenseNum").bigAutocomplete({
					url:"/DZOMS/select/vehicleByLicenseNum",
					condition:" state=2 ",
					callback:function(){
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
	     			}
				});



				$("#oldLicenseNum").val("黑A");

                if(GetQueryString("oldLicenseNum")){
                    $("#oldLicenseNum").val(GetQueryString("oldLicenseNum"));
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
                }

				$('form').submit(function(){
					if(!$('input[name="vehicleApproval.cartype"]:eq(0)').prop('checked')){
						if($("#oldLicenseNum").val().length!=7){
							alert("请输入正确的原车牌号！");
							return false;
						}
						
						return true;
					}
				});
			}
			else{//转包
				$("#oldLicenseNum").prop("disabled",false);
				$("#title").html("<h2><strong>二手车生成开业</strong></h2>");
				$("#info_box").show();
				
				$("#oldLicenseNum").unbind("focus");
				$("#oldLicenseNum").unbind("keydown");
				$("#oldLicenseNum").unbind("keyup");
				
				$("#oldLicenseNum").bigAutocomplete({
					url:"/DZOMS/select/vehicleByLicenseNum",
					condition:" state=3 ",
					callback:function(){
						var licenseNum = $("#oldLicenseNum").val();
						$.post("/DZOMS/common/doit",{"condition":"from Contract c where c.state=1 and c.carframeNum in (select v.carframeNum from Vehicle v where v.licenseNum='"+licenseNum+"') order by id desc "},function(data){
							var contract=data["affect"];
    						$("#contractFrom").val(contract["id"]);
   							$('[name="url"]').val("/vehicle/CreateApproval/vehicle_approval01.jsp");
							$('[name="vehicleApprovalCreate"]').attr("action","/DZOMS/vehicle/vehicleApprovalPreCreate").submit();
	     				});
	     			}
				});
				
				$("#oldLicenseNum").val("黑A");
			}
		});
	});
	
	$(document).ready(function(){
//		$("input[name='vehicleApproval.cartype']:eq(2)").click();
		if($("#contract_businessForm").val().trim().length==0){
			$("#contract_businessForm").val('承包');
		}
		
		if($('input[name="vehicleApproval.cartype"]:eq(0)').prop('checked')){
			$('input[name="vehicleApproval.cartype"]:eq(1)').click();
		}
		
		$('form').submit(function(){
			if($("#idNum").val().length!=18||$('#contractorName').val().length==0){
				alert("请输入正确的身份证号！");
				return false;
			}
			return true;
		});
	});
	
	
	
</script>
 <style>
       .label{
       	text-align: right;
       }
       td{
       	text-align: left;
       }
    </style>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>审批</li>
                <li>生成开业</li>
    </ul>
</div>
<!-- 主页面 -->

<div class="padding">
	<div class="panel">
		<div class="panel-head">
			<div class="line" style="text-align: center;" id="title">
	              <h2><strong>新车生成开业</strong></h2>
             </div>
		</div>
		<div class="panel-body">
	<form action="/DZOMS/vehicle/vehicleApprovalCreate" method="post" class="form-inline form-tips" name="vehicleApprovalCreate">
        <s:hidden name="vehicleApproval.checkType" value="0"></s:hidden>
        <s:hidden name="url" value="/vehicle/CreateApproval/approval_list.jsp"></s:hidden>
        <s:hidden name="contract.rentFirst" value="%{#request.contractFrom.rentFirst}"></s:hidden>
        <s:hidden name="contract.deposit" value="%{#request.contractFrom.deposit}"></s:hidden>
        <table class="table">
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label">
                            <label>
                                运营管理部
                            </label>
                        </div>
                        <div class="field">
                        	<s:if test="#request.contractFrom!=null">
                        		<s:select cssClass="input" name="contract.branchFirm" value="%{#request.contractFrom.branchFirm}" list="{'一部','二部','三部'}"  data-validate="required:请选择,length#>=1:至少选择1项"></s:select>
                        	</s:if>
                            <s:else>
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
                            		
                            		request.setAttribute("dp",dept);
                            	%>
                            	<s:select cssClass="input" name="contract.branchFirm" value="%{#request.dp}" list="#{'一部':'一部','二部':'二部','三部':'三部'}"  data-validate="required:请选择,length#>=1:至少选择1项"></s:select>
                            </s:else>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                承包人身份证号
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="idNum" name="contract.idNum" cssClass="input" />
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
                            <s:textfield id="contractorName" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',contract.idNum).name}" cssClass="input" readonly="readonly"/>
                        </div>
                    </div>
                </td>
             
            </tr>
            <tr>
            	  <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                承包人电话
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="contractorPhone"  cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',contract.idNum).phoneNum1}"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                购车方式
                            </label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input" id="contract_businessForm" name="contract.businessForm" list="{'','承包','挂靠'}" theme="simple" value="%{#request.contractFrom.businessForm}"></s:select>
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
                        	<s:if test="%{#request.contractFrom!=null}">
                        		<s:radio name="vehicleApproval.ascription" list="%{#{'true':'个人','false':'公司'}}" value="%{#request.contractFrom.ascription}"/>
                        	</s:if>
                        	<s:else>
                        		<s:radio name="vehicleApproval.ascription" list="%{#{'true':'个人','false':'公司'}}" value="false" />
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
                        	<s:if test="%{#request.contractFrom!=null}">
                        		<input type="radio" name="vehicleApproval.cartype" value="true" cartype="1" />新车
                        		<input type="radio" name="vehicleApproval.cartype" value="true" cartype="2" />更新
                        		<input type="radio" name="vehicleApproval.cartype" value="false" cartype="3" checked="checked" />重新发包
                        	</s:if>
                        	<s:else>
                        		<input type="radio" name="vehicleApproval.cartype" value="true" cartype="1" checked="checked" />新车
                        		<input type="radio" name="vehicleApproval.cartype" value="true" cartype="2" />更新
                        		<input type="radio" name="vehicleApproval.cartype" value="false" cartype="3" />重新发包
                        	</s:else>
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
                            <s:set name="tcar" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#request.contractFrom.carframeNum)}"></s:set>
 							<s:textfield name="contract.carNumOld" id="oldLicenseNum" cssClass="input" value="%{#tcar.licenseNum}"/>
 							<s:hidden id="contractFrom"  cssClass="input" name="contract.contractFrom"/>
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
                        	<s:if test="%{#request.contractFrom!=null}">
                        		<s:radio name="vehicleApproval.fueltype" list="#{'柴油':'柴油','汽油':'汽油','汽油/天燃气':'汽油/天燃气'}" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#tcar.carMode).fuel}"/>
                        	</s:if>
                        	<s:else>
                        		<s:radio name="vehicleApproval.fueltype" list="#{'柴油':'柴油','汽油':'汽油','汽油/天燃气':'汽油/天燃气'}" value="%{'汽油/天燃气'}"/>
                        	</s:else>
                           
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
                            <s:textfield id="licenseNum" name="contract.carNum" value="%{#tcar.licenseNum}"  cssClass="input"/>
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
                            <s:textfield id="carframeNum" name="contract.carframeNum" value="%{#tcar.carframeNum}"  cssClass="input" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label class="">
                                月承包费
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield id="rent" name="contract.rent" value="%{#request.contractFrom.rent}"  cssClass="input"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <s:if test="%{#request.contractFrom==null}">
        <div class=" container line-big" id="info_box">
            <div class="xm4">
                <div class="panel">
                    <div class="panel-head">
                        <strong>废业</strong>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <td>废业手续办理日</td>
                                <td>废业手续办结日</td>
                                <td>天数</td>
                            </tr>
                            <tr>
                                <td>
                              		<input type="text" class="input input-auto datepick" maxlength="50" size="10"  class="input"
                                           id="terminationDate" 
                                           name="vehicleApproval.terminationDate"></td>
                                <td><input type="text" class="input input-auto datepick" maxlength="50" size="10"  class="input"
                                           id="procedureEndDate" 
                                           name="vehicleApproval.procedureEndDate"></td>
                                <td><input type="text" class="input input-auto" maxlength="50" size="2"  class="input"
                                           id="terminationDays"
                                           name="vehicleApproval.terminationDays"></td>
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
                                <td><input type="text" class="input input-auto datepick" maxlength="50" size="10"  class="input"
                                           id="getCarDate" 
                                           name="vehicleApproval.getCarDate"></td>
                                <td><input type="text" class="input input-auto datepick" maxlength="50" size="10"  class="input"
                                           id="licenseRegisterDate" 
                                           name="vehicleApproval.licenseRegisterDate"></td>
                                <td><input type="text" class="input input-auto" maxlength="50" size="2"  class="input"
                                           id="getCarDays"
                                           name="vehicleApproval.getCarDays"></td>
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
                                <td><input type="text" class="input input-auto datepick" maxlength="50" size="10"  class="input"
                                           id="operateApplyDate" 
                                           name="vehicleApproval.operateApplyDate"></td>
                                <td><input type="text" class="input input-auto datepick" maxlength="50" size="10"  class="input"
                                           id="operateCardDate" 
                                           name="vehicleApproval.operateCardDate"></td>
                                <td><input type="text" class="input input-auto" maxlength="50" size="2"  class="input"
                                           id="operateDays"
                                           name="vehicleApproval.operateDays"></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        </s:if>
        <div>
            <!--<div class="form-group" style="width: 320px;">
                <div class="label padding">
                    <label class="">
                        有无银行卡号
                    </label>
                </div>
                <div class="field">
                    <div class="button-group radio">
                        <label class="button active">
                            <input  type="radio" checked="checked" value="true" name="vehicleApproval.creditCard"><span class="icon icon-check text-green"></span> 有
                        </label>
                        <label class="button">
                            <input  type="radio" value="false" name="vehicleApproval.creditCard"><span class="icon icon-times text-red"></span> 无
                        </label>
                    </div>
                </div>
            </div>-->

            <!--<div class="form-group" style="width: 320px;">
                <div class="label padding">
                    <label>
                        车损保险
                    </label>
                </div>
                <div class="field">
                    <div class="button-group radio">
                        <label class="button active">
                            <input  type="radio" checked="checked" value="0.3" name="vehicleApproval.damageInsurance"><span class="icon icon-check text-green"></span> 30%
                        </label>
                        <label class="button">
                            <input  type="radio" value="0.9"  name="vehicleApproval.damageInsurance"><span class="icon icon-check text-green"></span> 90%
                        </label>
                    </div>
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
                    <input type="text" class="input input-auto" size="10" maxlength="10" id="onetimeAfterpay" name="vehicleApproval.onetimeAfterpay"  class="input">元
                </div>
            </div>
            </s:if>
			<s:if test="%{contract.contractFrom!=null}">
			<table class="table table-bordered">
				<tr>
					<td>
						<div class="form-group" cssStyle="width: 320px;">
			                <div class="label padding">
			                    <label>
			                        补交保费
			                    </label>
			                </div>
			                <div class="field">
			                    <input type="text" class="input input-auto" size="10" maxlength="10" id="onetimeAfterpay" name="vehicleApproval.onetimeAfterpay"  class="input">元
			                </div>
                         </div>
					</td>
					<td>
						<div class="form-group">
			                <div class="label padding" cssStyle="width: 260px">
			                    <label class="">
			                        补交起始日
			                    </label>
			                </div>
			                <div class="field  form-not-disabled">
			                    <s:textfield id="payBeginDate" name="vehicleApproval.payBeginDate" cssClass="input datepick"/>
			                </div>
			            </div>
					</td>
					<td>
						<div class="form-group">
			                <div class="label padding" cssStyle="width: 260px">
			                    <label class="">
			                        补交终止日
			                    </label>
			                </div>
			                <div class="field  form-not-disabled">
			                    <s:textfield id="payEndDate" name="vehicleApproval.payEndDate" cssClass="input datepick"/>
			                </div>
                         </div>
					</td>
				</tr>
			</table>
           
            
            
            </s:if>
        </div>
        <blockquote class="border-main">
            <strong>承租人申请：</strong>
            <div>
                <s:textarea name="contract.driverRequest" cssClass="input-xlarge"
                            rows="3" cssStyle="width:100%" value="本人申请加入大众公司，按公司的管理规定营运。"></s:textarea>
            </div>
        </blockquote>
        <blockquote class="border-main">
            <strong>运营管理部-分部经理意见：</strong>
            <div>
                <s:textarea
                        id="branchManagerRemark"
                        name="vehicleApproval.branchManagerRemark" cssClass="input-xlarge"
                        rows="3" cssStyle="width:100%">

                </s:textarea>
            </div>
        </blockquote>
        <div class="xm9-move">
        	<input type="button" value="同意" class="button bg-green" onclick="approvalApply('#branchManagerRemark');">
            <input id="sub_but" type="submit" value="提交" class="button bg-green">
        </div>

    </form>
	    </div>
	</div>
  
</div>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>