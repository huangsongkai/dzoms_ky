<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.dz.common.other.TimeComm"%>
<%@ page language="java" import="java.util.*,com.dz.module.user.User, 
	com.dz.module.vehicle.*,com.dz.module.driver.*,com.dz.common.other.*,com.dz.common.global.*,com.dz.module.contract.BankCard"
	pageEncoding="UTF-8"%>
<%@page import="com.dz.module.search.*"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
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
<title>银行卡记录</title>
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

</head>

<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>银行卡信息修改</li>
    </ul>
    </div>
</div>

	<!-- 主页面 -->
	<div class="line">
		<div class="margin panel xm12">
			<div class="panel-head">
				银行卡信息
			</div>
			<div class="panel-body">
				<form action="bankCardUpdate" name="cardAddForm" method="post" class="form-inline form-tips">
				<s:hidden name="bankCard.id" value="%{bean[0].id}"/>
			<table class="table  table-hover">
				<tr>
					<td>
                		<div class="form-group">
						<div class="label">
							<label>车牌号:</label>
						</div>
						<div class="field">
							<s:textfield value="%{bean[2].licenseNum}" id="license_num" cssClass="input input-auto" size="7"
								 data-validate="required:必填,length#==9:字符需长度为7位" readonly="true"/>
							<s:hidden name="bankCard.carNum" value="%{bean[2].carframeNum}"></s:hidden>
						</div>
					    </div>
                    </td>
                    <td>
                		<div class="form-group">
						<div class="label">
							<label>身份证号:</label>
						</div>
						<div class="field">
							<s:textfield name="bankCard.idNumber" value="%{bean[0].idNumber}" cssClass="input"/>
						</div>
					    </div>
                    </td>
                    <td>
                		<div class="form-group">
						<div class="label">
							<label>驾驶员姓名:</label>
						</div>
						<div class="field">
							<s:textfield cssClass="input input-auto" size="7" value="%{bean[1].name}" id="driverName"/>
						</div>
					    </div>
                    </td>
                     <td>
                		<div class="form-group">
						<div class="label">
							<label>银行卡类别:</label>
						</div>
						<div class="field">
							<s:select cssClass="input itemtool" item-key="cardClass" id="cardClass" name="bankCard.cardClass" value="%{bean[0].cardClass}" list="%{@com.dz.common.itemtool.ItemToolService@selectByKey('cardClass')}" />
							<a class="icon-wrench" href="javascript:openItem('cardClass','银行卡类别')"></a>
						</div>
					    </div>
                    </td>
                      <td>
                		<div class="form-group">
						<div class="label">
							<label>银行卡号:</label>
						</div>
						<div class="field">
							<s:textfield name="bankCard.cardNumber" value="%{bean[0].cardNumber}" cssClass="input input-auto" size="22"/>
						</div>
					    </div>
                    </td>

				</tr>
				
				<!--<tr>
					<td>
                		<div class="form-group">
						<div class="label">
							<label>是否为主支付卡:</label>
						</div>
						<div class="field">
						<s:select cssClass="input" id="cardClass"  name="bankCard.isDefaultPay" value="%{bean[0].isDefaultPay}" list="%{#{'true':'是','false':'否'}}" >
						</s:select>
						</div>
					    </div>
                    </td>
                    <td>
                		<div class="form-group">
						<div class="label">
							<label>是否为主汇款卡:</label>
						</div>
						<div class="field">
						<s:select cssClass="input" id="cardClass"  name="bankCard.isDefaultRecive" value="%{bean[0].isDefaultRecive}" list="%{#{'true':'是','false':'否'}}" >
						</s:select>
						</div>
					    </div>
                    </td>

				</tr>-->
				<tr>
					<td>
						<input type="hidden" name="bankCard.isDefaultPay" value="true" />
						<input type="hidden" name="bankCard.isDefaultRecive" value="true" />
						<input type="submit" class="btn btn-primary" value="修改"></td>
					
				</tr>
			</table>
		</form>
				
			</div>
			
		</div>
		
	</div>
</body>
</html>