<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.dz.common.other.*" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>新增营运信息</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
	$("#carframe_num").bigAutocomplete({
		url:"/DZOMS/select/vehicleById",
		condition:" operateCard is null and moneyCountor is not null ",
		callback:function(){
			var carframe_num = $("#carframe_num").val();
			$.post("/DZOMS/common/getObject",
						{"className":"com.dz.module.vehicle.Vehicle","id":carframe_num,"isString":true},
						function(vehicle){
							if (vehicle != undefined) {
									$("#department").val(vehicle["dept"]);
									$("#licenseNum").val(vehicle["licenseNum"]);
							}
						});
		}
	});
	
	$("#licenseNum").bigAutocomplete({
		url:"/DZOMS/select/VehicleBylicenseNum",
		condition:" operateCard is null and moneyCountor is not null ",
		doubleClick:true,
		doubleClickDefault:'黑A',
		callback:function(){
			$.post("/DZOMS/common/doit",{"condition":"from Vehicle where licenseNum='"+$("#licenseNum").val()+"' "},function(data){
				if (data!=undefined &&data["affect"]!=undefined ) {
					var vehicle = data["affect"];
					$("#department").val(vehicle["dept"]);
					$("#carframe_num").val(vehicle["carframeNum"]);
				}
			});
		}
	});
	
	if($("#licenseNum").val().trim().length<7){
		$("#licenseNum").val('黑A');
	}
	
});

</script>
	<style>
        .label{
        	width: 200px;
            text-align:right;
        }
    </style>
	</head>
	<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>新增</li>
                <li>新增营运信息</li>
        </ul>
</div>
	
<div>
<form class="form-x" method="post" action="/DZOMS/vehicle/service_right_add" onsubmit="return confirm('营运证发放日期确认：'+$('#operateCardTime').val());">
	<input type="hidden" name="url" value="/vehicle/vehicle/service_right_add.jsp" />
		<div class="alert alert-yellow padding">
		<span class="close rotate-hover"></span><strong>注意：</strong>录入计价器信息前需要录入牌照信息。</div>
	<div class="panel xm10 xm1-move">
		<div class="panel-head">
			新增营运证信息
		</div>
		<div class="panel-body">
        <table class="table table-condensed">
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车牌号
                            </label>
                        </div>
                        <div class="field">
						<s:textfield cssClass="input" id="licenseNum" name="vehicle.licenseNum" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',bean[0].carframeNum).licenseNum}" ></s:textfield>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车架号
                            </label>
                        </div>
                        <div class="field">
						<s:textfield cssClass="input" id="carframe_num" name="vehicle.carframeNum" value="%{bean[0].carframeNum}" ></s:textfield>
                        </div>

                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                营运证号
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input" name="vehicle.operateCard" value="%{bean[0].operateCard}" data-validate="required:必填,regexp#(^[0-9]{6}$):格式不正确(6位数字)"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                营运证发放日期
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input datepick" id='operateCardTime'  name="vehicle.operateCardTime" data-validate="required:必填">
                          <s:param name="value">
                			<s:date name="%{bean[0].operateCardTime}" format="yyyy/MM/dd"></s:date>
                		  </s:param>
                          </s:textfield>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                登记人
                            </label>
                        </div>
                        <div class="field">
                        	<s:textfield cssClass="input" readonly="true" value="%{#session.user.uname}" />
							<s:hidden name="vehicle.serviceRightRegister" value="%{#session.user.uid}"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                登记时间
                            </label>
                        </div>
                        <div class="field">
                            <input class="input" readonly="readonly" name="vehicle.serviceRightRegistDate" 
						value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
				<td class="tableleft"></td>
				<td colspan="3" style="text-align:right;">
					<input type="submit" class="button bg-main" value="提交">
					<input type="button" class="button" name="backid"
							id="backid" onclick="location.href='#'" value="取消">
				</td>
			</tr>
			</table>
		</div>
	</div>
</form>
</div>

<div class="line">
<%
	List<ServiceRightInfo> list = ObjectAccess.query(ServiceRightInfo.class, " state=0 ");
	request.setAttribute("list", list);
%>
<s:if test="%{#request.list!=null&&#request.list.size()>0}">
<table class="table table-striped table-bordered table-hover">
<tr>
	<th class="carframeNum			selected_able">车架号</th>
	<th class="licenseNum			selected_able">车牌号</th>
	<th class="operateCard			selected_able">营运证号</th>
	<th class="operateCardTime		selected_able">营运证发放日期</th>
	<th class="operateCardRegister 	selected_able">登记人</th>
	<th class="operateCardRegistDate selected_able">登记时间</th>
	<th class="modify selected_able">修改</th>
	<th class="delete selected_able">删除</th>
</tr>
<s:iterator value="%{#request.list}" var="v">       
<tr>
<td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
<td class="licenseNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
<td class="operateCard selected_able"><s:property value="%{#v.operateCard}"/></td>
<td class="operateCardTime selected_able"><s:date name="%{#v.operateCardTime}" format="yyyy/MM/dd"/></td>
<td class="operateCardRegister selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.serviceRightRegister).uname}"/></td>
<td class="operateCardRegistDate selected_able"><s:property value="%{#v.serviceRightRegistDate}"/></td>
 <td class="modify selected_able"><a href="javascript:modifyV('<s:property value="%{#v.carframeNum}"/>')">修改</a></td>
 <td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.carframeNum}"/>')">删除</a></td>
</tr>
</s:iterator>
</table>

	<div class="xm9-move xm2">
		<form action="/DZOMS/vehicle/service_right_relook" method="post">
			<input type="hidden" name="url" value="/vehicle/vehicle/service_right_add.jsp"/>
			<input type="submit" value="全部通过" class="button bg-green" />
		</form>
	</div>
</s:if>
</div>

<form action="/DZOMS/vehicle/service_right_delete" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/service_right_add.jsp"/>
	<input type="hidden" name="vehicle.carframeNum" />
	<input type="submit" style="display: none;" id="del_but" />
</form>

<form action="/DZOMS/common/getObj" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/service_right_add.jsp"/>
	<input type="hidden" name="ids[0].className" value="com.dz.module.vehicle.ServiceRightInfo" />
	<input type="hidden" name="ids[0].id" />
	<input type="hidden" name="ids[0].isString" value="true" />
	<input type="submit" style="display: none;" id="modify_but" />
</form>
<script>
	function deleteV(cid){
		$('input[name="vehicle.carframeNum"]').val(cid);
		if (confirm("确认删除车架号为"+cid+"的发票信息？")) {
			$("#del_but").click();
		}
	}
	
	function modifyV(cid){
		$('input[name="ids[0].id"]').val(cid);
		$("#modify_but").click();
	}
</script>

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
<script>
$('[name="vehicle.twiceSupplyDate"]').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onClose:function(){
		var arr = $('[name="vehicle.twiceSupplyDate"]').val().split("/");
		arr[0] = parseInt(arr[0])+1;
		$('[name="vehicle.nextSupplyDate"]').val(""+arr[0]+"/"+arr[1]+"/"+arr[2]);
	}
});

$('[name="vehicle.moneyCountorTime"]').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onClose:function(){
		var arr = $('[name="vehicle.moneyCountorTime"]').val().split("/");
		arr[0] = parseInt(arr[0])+1;
		
		$('[name="vehicle.moneyCountorNextDate"]').val(""+arr[0]+"/"+arr[1]+"/"+arr[2]);
	}
});
</script>
</body>
</html>

