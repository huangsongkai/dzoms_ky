<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
	
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>查看</li>
                <li>查看经营权证信息</li>
        </ul>
</div>
<form class="form-x"  action="/DZOMS/vehicle/trade_add">
    <div class="container">
        <table class="table">
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车牌号
                            </label>
                        </div>
                        <div class="field">
                           <s:textfield  cssClass="input" theme="simple" name="vehicle.licenseNum" ></s:textfield>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                车架号
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input" theme="simple" id="carframeNum" name="vehicle.carframeNum" ></s:textfield>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                经营权证号
                            </label>
                        </div>
                        <div class="field">
                        	<s:set name="bl" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.BusinessLicense',#v.businessLicenseId)}"></s:set>
                            <s:textfield cssClass="input" value="%{#bl.licenseNum}" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                起始日期
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input" value="%{#bl.beginDate}" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                终止日期
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input" value="%{#bl.endDate}" />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="form-group">
                        <div class="label padding" style="width: 12%">
                            <label>
                                备注
                            </label>
                        </div>
                        <div class="field">
                        <s:textarea  cssClass="input" rows="5" name="vehicle.businessLicenseComment">

                        </s:textarea>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label padding" >
                            <label>
                                登记人
                            </label>
                        </div>
                        <div class="field">
                        	<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#bl.register).uname}" />
               
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label padding" >
                            <label>
                                登记时间
                            </label>
                        </div>
                        <div class="field">
                        	<s:textfield cssClass="input" readonly="readonly" value="%{#bl.registDate}" />
                           
                        </div>
                    </div>
                </td>
            </tr>
           
        </table>
    </div>
</form>
</body>
</html>