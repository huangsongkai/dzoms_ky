<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>查看营运信息</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>
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
                <li>查看</li>
                <li>查看营运信息</li>
        </ul>
</div>
	
	<div>
		<form class="form-x" method="post" action="/DZOMS/vehicle/service_add">
<input type="hidden" name="url" value="/vehicle/vehicle/service_add.jsp" />
    <div class="xm10 xm1-move">
        <table class="table table-condensed">
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车架号
                            </label>
                        </div>
                        <div class="field">
			<s:textfield cssClass="input" theme="simple" id="carframeNum" name="vehicle.carframeNum"></s:textfield>
                        </div>

                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车牌号
                            </label>
                        </div>
                        <div class="field">
						
			<s:textfield cssClass="input" theme="simple" name="vehicle.licenseNum" ></s:textfield>
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
                            <s:textfield cssClass="input" name="vehicle.operateCard"/>
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
                            <s:textfield cssClass="input"  name="vehicle.operateCardTime"/>
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
                        	<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',vehicle.serviceRightRegister).uname}" />
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
                        	<s:textfield cssClass="input" readonly="readonly" name="vehicle.serviceRightRegistDate" />
                        </div>
                    </div>
                </td>
            </tr>
			</table>
	</div>
	
		
</form>
		</div>	

	</body>
</html>

