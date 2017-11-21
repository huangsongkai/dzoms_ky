<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.common.other.TimeComm"%>
<%@ page language="java" import="java.util.*,com.dz.module.user.User,
	com.dz.module.vehicle.*,com.dz.module.driver.*,com.dz.common.other.*,com.dz.common.global.*,com.dz.module.contract.BankCard"
		 pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>

<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="银行卡新增">
	<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>绑定银行卡到车辆</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
	<script src="/DZOMS/res/js/window.js"></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" type="text/css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js"></script>
	<script>
		function heredoc(fn) {
			return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
		}

		function checkBeforeSubmit(){
			$.post("/DZOMS/contract/bank_card/bindVehicle",{
				"bankCard.id":$('#cardId').val(),
				"bankCard.carNum":$("#carNum").val()
			},function(data){
				if(data!=undefined){
					if(data.status==true){
						alert("绑定成功！");
						$('form input').val("");
					}else{
						alert(data.msg);
					}
				}else {
					alert("网络传输失败！")
				}
			});
		}

		function refreshVehicle() {
			if($("#license_num").val().trim().length==7)
				$.post("/DZOMS/common/doit",{"condition":"from Vehicle where licenseNum='"+$("#license_num").val()+"'"},function(data){
					if (data["affect"]!=undefined && data["affect"] != null) {
						var vehicle=data["affect"] ;
						$('input[name="bankCard.carNum"]').val(vehicle["carframeNum"]);
					}
				});
		}

		//这里面不是注释！！！
		var msg = heredoc(function(){/*<s:actionerror/>*/});

		$(document).ready(function(){
			if(msg.trim()!=""){
				$("#alert-but").click();
			}

			enable_selected("#cardNumber","/DZOMS/select/BankCardBycardNumber",function(){
				if($("#cardNumber").val().trim().length==16||$("#cardNumber").val().trim().length==19){
					$('form').attr('action','/DZOMS/contract/bank_card/selectByCardNumber');
					$('form').submit();
				}
			});

			enable_selected("#license_num","/DZOMS/select/vehicleByLicenseNum",function(){
				refreshVehicle();
			});

			refreshVehicle();

		});

	</script>
</head>

<body>
<button class="dialogs" data-toggle="click" data-target="#alert-dialog" data-mask="1" data-width="50%" style="display: none;" id="alert-but"> </button>
<div id="alert-dialog">
	<div class="dialog">
		<div class="dialog-head">
			<span class="close rotate-hover"></span>
			<strong>消息</strong>
		</div>
		<div class="dialog-body"><s:actionerror/></div>
		<div class="dialog-foot">
			<button class="button dialog-close"> 确认</button>
		</div>
	</div>
</div>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
			<li>财务管理</li>
			<li>银行卡绑定</li>
		</ul>
	</div>
</div>
<!-- 主页面 -->
<div class="line">
	<div class="margin panel xm12">
		<div class="panel-head">
			绑定银行卡到车辆
		</div>
		<div class="panel-body">
			<form action="#" name="cardAddForm" method="post" class="form-inline form-tips">
				<input type="hidden" name="url" value="/contract/bank_card/card_bind.jsp">
				<table class="table  table-hover">
					<tr>
						<td>
							<div class="form-group">
								<div class="label">
									<label>车牌号:</label>
								</div>
								<div class="field">
									<s:if test="%{bean == null }">
										<s:textfield value="%{#parameters.licenseNum}" name="licenseNum" id="license_num" cssClass="input input-auto" size="7"
													 data-validate="required:必填;length#==9:字符需长度为7位"/>
										<s:hidden name="bankCard.carNum" id="carNum"></s:hidden>
									</s:if>
									<s:else>
										<s:textfield value="%{bean[0].licenseNum}" name="licenseNum" id="license_num" cssClass="input input-auto" size="7"
													 data-validate="required:必填;length#==9:字符需长度为7位"/>
										<s:hidden id="carNum" name="bankCard.carNum" value="%{bean[0].carframeNum}"></s:hidden>
									</s:else>
								</div>
							</div>
						</td>

						<td>
							<div class="form-group">
								<div class="label">
									<label>银行卡号:</label>
								</div>
								<div class="field">
									<s:hidden id="cardId" name="bankCard.id"></s:hidden>
									<s:textfield id="cardNumber" name="bankCard.cardNumber" cssClass="input input-auto" size="22"/>
								</div>
							</div>
						</td>

						<td>
							<div class="form-group">
								<div class="label">
									<label>身份证号:</label>
								</div>
								<div class="field">
									<s:textfield name="bankCard.idNumber" id="driverId" cssClass="input input-auto" size="20" readonly="true"/>
								</div>
							</div>
						</td>
						<td>
							<div class="form-group">
								<div class="label">
									<label>驾驶员姓名:</label>
								</div>
								<div class="field">
									<s:textfield cssClass="input input-auto" size="7" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',bankCard.idNumber).name}" id="driverName" readonly="true"/>
								</div>
							</div>
						</td>
						<td>
							<div class="form-group">
								<div class="label">
									<label>银行卡类别:</label>
								</div>
								<div class="field">
									<s:textfield cssClass="input input-auto" size="7"  name="bankCard.cardClass" id="cardClass" readonly="true"/>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan="3" style="text-align: right;">
							<input type="button" class="button bg-green" id="f-submit" value="提交">
						</td>
					</tr>
				</table>
			</form>

		</div>

	</div>

</div>

<script>
	button_bind("#f-submit","确认提交？","checkBeforeSubmit();");

	$(function(){
		$showdialogs=function(e){
			var trigger=e.attr("data-toggle");
			var getid=e.attr("data-target");
			var data=e.attr("data-url");
			var mask=e.attr("data-mask");
			var width=e.attr("data-width");
			var detail="";
			var masklayout=$('<div class="dialog-mask"></div>');
			if(width==null){width="80%";}

			if (mask=="1"){
				$("body").append(masklayout);
			}
			detail='<div class="dialog-win" style="position:fixed;width:'+width+';z-index:11;">';
			if(getid!=null){detail=detail+$(getid).html();}
			if(data!=null){detail=detail+$.ajax({url:data,async:false}).responseText;}
			detail=detail+'</div>';

			var win=$(detail);
			win.find(".dialog").addClass("open");
			$("body").append(win);

			/**
			 * Show next to selector
			 */
			var e_top = e.offset().top-win.outerHeight();

			var x=parseInt($(window).width()-win.outerWidth())/2;
			//var y=parseInt($(window).height()-win.outerHeight())/2;
			var y = e_top;
			if (y<=10){y="10"}
			win.css({"left":x,"top":y});
			win.find(".dialog-close,.close").each(function(){
				$(this).click(function(){
					win.remove();
					$('.dialog-mask').remove();
				});
			});
			masklayout.click(function(){
				win.remove();
				$(this).remove();
			});
		};
	});
</script>
</body>
</html>