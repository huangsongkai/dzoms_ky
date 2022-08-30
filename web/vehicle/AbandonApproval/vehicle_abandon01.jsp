<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.common.other.TimeComm"%>
<%@page import="com.dz.module.vehicle.VehicleApproval"%>
<%@page import="com.opensymphony.xwork2.util.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" import="java.util.*,com.dz.module.user.User, 
	com.dz.module.contract.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) session.getAttribute("user");
%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="废业发起">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

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
<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
	function GetQueryString(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result?decodeURIComponent(result[2]):null;
	}
$(document).ready(function(){
	if(GetQueryString("licenseNum")){
		$("#vehicleNum").val(GetQueryString("licenseNum"));
		var licenseNum = $("#vehicleNum").val();
		var $cid = $('[name="contract.id"]');
		$.post("/DZOMS/common/doit",{"condition":"from Contract c where c.state in (0,-1) and c.carframeNum in (select v.carframeNum from Vehicle v where v.state=1 and v.licenseNum='"+licenseNum+"') "},function(data){
			var contract=data["affect"];
			$cid.val(contract["id"]);
			$('input[name="url"]').val("/vehicle/AbandonApproval/vehicle_abandon01.jsp");
			$('[name="vehicleApprovalWrite"]').attr("action","/DZOMS/vehicle/vehicleApprovalPreAbandond").submit();
		});
	}

	$("#vehicleNum").bigAutocomplete({
		url:"/DZOMS/select/VehicleBylicenseNum",
		condition:" state=1 and carframeNum in (select carframeNum from Contract where state in (0,-1)) ",
		callback:function(){
			var licenseNum = $("#vehicleNum").val();
			var $cid = $('[name="contract.id"]');
			$.post("/DZOMS/common/doit",{"condition":"from Contract c where c.state in (0,-1) and c.carframeNum in (select v.carframeNum from Vehicle v where v.state=1 and v.licenseNum='"+licenseNum+"') "},function(data){
				var contract=data["affect"];
    			$cid.val(contract["id"]);
    			$('input[name="url"]').val("/vehicle/AbandonApproval/vehicle_abandon01.jsp");
    			$('[name="vehicleApprovalWrite"]').attr("action","/DZOMS/vehicle/vehicleApprovalPreAbandond").submit();
    		});
		}
	});


	if ($("#vehicleNum").val().length<2) {
		$("#vehicleNum").val("黑A");
	}
});

var beforeSubmit = function(){
	if(!checkLicenseNum($('#vehicleNum').val())){
		alert("请输入正确的车牌号！");
		return false;
	}
	
	$("[name='contract.abandonRequest']").val($("#abandonRequest").val());
	return true;
};

	$(document).ready(function(){
		showFeiye();
		
		if($("#lastMonth").val().length==0){
			if( $('input[name="contract.contractBeginDate"]').val().length>0 &&
				$('input[name="contract.contractEndDate"]').val().length>0){
				var arr1 = $('input[name="contract.contractBeginDate"]').val().split('/');
				var arr2 = $('input[name="contract.contractEndDate"]').val().split('/');
				var ms = (arr2[0]-arr1[0])*12 + (arr2[1]-arr1[1]);
				$("#lastMonth").val(ms);
			}
		}
	});
	
	function showFeiye(){
		$(".feiye").show();
		$(".feiye input").prop("disabled",false);
		$(".jiechu").hide();
		$(".jiechu input").prop("disabled",true);
	}
	
	function hideFeiye(){
		$(".feiye").hide();
		$(".feiye input").prop("disabled",true);
		$(".jiechu").show();
		$(".jiechu input").prop("disabled",false );
	}
	
	
</script>
</head>

<body>
	
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>审批</li>
                <li>车辆审批</li>
                <li>生成废业</li>
    </ul>
</div>

		<!-- 主页面 -->
		<div>
		<form name="vehicleApprovalWrite" action="/DZOMS/vehicle/vehicleApprovalCreate" method="post"
			class="definewidth m20" onsubmit="beforeSubmit()">
			<s:hidden name="vehicleApproval.checkType" value="1"></s:hidden>
			<s:hidden name="url" value="/vehicle/AbandonApproval/judge.jsp"></s:hidden>
			<table class="table table-bordered table-hover m10">
				<tr>
					<td style="width: 10%" class="tableleft">所属部门</td>
					<td>
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
                            	<s:select name="contract.branchFirm" value="%{#request.dp}" list="{'一部','二部','三部'}"></s:select>
						<%--<s:select name="contract.branchFirm" list="{'一部','二部','三部'}"></s:select> --%>
					</td>

					<td class="tableleft">车牌号</td>
					<td><s:textfield name="vehicleNum" id="vehicleNum" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#request.contract.carframeNum).licenseNum}" ></s:textfield>
						<s:hidden name="contract.id"></s:hidden>
					</td>
				</tr>
				<tr>
					<td class="tableleft">车型</td>
					<s:set name="cartype" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#request.contract.carframeNum).carMode}"></s:set>
					<td colspan=1><s:textfield name="vehicleApproval.fueltype" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#cartype).fuel}"/></td>

					<td class="tableleft">车架号</td>
					<td colspan=2>
						<s:textfield id="carframeNum"
						name="contract.carframeNum" cssStyle="width:100%" /></td>
				</tr>
				<tr>
					<td class="tableleft">承包人姓名</td>
					<td>
						<s:textfield value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.contract.idNum).name}"/>
					</td>

					<td class="tableleft">月承包费</td>
					<td><s:textfield name="contract.rent" /></td>
					<td>元</td>
				</tr>
				<tr>
					<td class="tableleft">机动车行驶证核发日期</td>
					<td><s:textfield name="vehicleApproval.licenseRegisterDate" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#request.contract.carframeNum).licenseNumRegDate}" /></td>

					<td class="tableleft">运营手续归属</td>
					<td>
						<s:radio name="vehicleApproval.ascription" list="%{#{'false':'公司','true':'个人'}}" value="%{#request.contract.ascription}"/>
					</td>
				</tr>
				<tr>
					<!--<td class="tableleft">车辆保险</td>
					<td><input type="radio" name="vehicleApproval.insurance" checked="checked"/>含 <input
						type="radio" name="vehicleApproval.insurance" />不含</td>-->

					<td class="tableleft">承租合同期限</td>
					<td><s:textfield  name="contract.contractBeginDate" />至
						<s:textfield  name="contract.contractEndDate" />
					</td>
					
					<td class="tableleft feiye">合同到期剩余月数</td>
					<td class="feiye">
						<input id="lastMonth"></input>
					</td>
				</tr>
				<tr>
					<td class="tableleft">办理事项</td>
					<td><input type="radio" name="vehicleApproval.handleMatter" value="false" checked="checked" onclick="showFeiye()" /><span style="color: red;" >废业—更新车</span>
						<input type="radio" name="vehicleApproval.handleMatter" value="true" onclick="hideFeiye()" /><span style="color: red;" >解除—转包车</span></td>
				<!-- </tr>
				<tr class=""> -->
					<td class="tableleft feiye">废业原因</td>
					<td class="feiye">
						<s:textfield name="contract.abandonReason" value="合同终止"></s:textfield>
					</td>

					<td class="tableleft jiechu">解除原因</td>
					<td class="jiechu">
						<s:textfield name="contract.abandonReason" ></s:textfield>
					</td>
				</tr>
				<tr>
					<td class="tableleft">承租人申请</td>
					<td colspan="3" style="text-align: left;">
						<s:set name="tdriver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.contract.idNum)}"></s:set>
						<textarea class="input-xlarge"
							id="abandonRequest" rows="3"
							style="width:100%">在公司已领取出租车票据没有转卖、丢失，如有其他车辆使用，承担责任。
身份证号：<s:property value="%{#request.contract.idNum}"/>   资格证号：<s:property value="%{#tdriver.qualificationNum}"/>    联系电话：  <s:property value="%{#tdriver.phoneNum1}"/></textarea>
						<s:hidden name="contract.abandonRequest"></s:hidden>
						
					</td>
				</tr>
				<tr>
					<td class="tableleft">分部经理意见</td>
					<td colspan="3">
						<textarea class="input-xlarge"
							id="branchManagerRemark"
							name="vehicleApproval.branchManagerRemark" rows="3"
							style="width:100%"></textarea>
					</td>
				</tr>
				<tr>
					<td class="tableleft"></td>
					<td colspan="3" style="text-align:right;">
						<input type="button" value="同意" class="btn btn-primary" onclick="approvalApply('#branchManagerRemark');">
						<input type="submit" class="btn btn-primary" value="提交">
						<button type="button" class="btn btn-success" name="backid"
							id="backid" onclick="location.href='/DZOMS/vehicle/AbandonApproval/judge.jsp'">取消</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>