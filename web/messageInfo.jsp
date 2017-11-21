<%@page import="com.dz.common.other.ObjectAccess"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.user.message.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	User user = (User) session.getAttribute("user");
	ObjectAccess.execute("update MessageToUser set alreadyRead=true where mid="+id+" and uid="+user.getUid());
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
            />
    <meta name="renderer" content="webkit">
    <title>
        查看消息详情
    </title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

    <style>
        .label{
             white-space:pre-line;
        }
    </style>
    <script>

    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>查看</li>
                <li>消息详情</li>
        </ul>
</div>
	

    <div class="xm7 xm2-move">
    	<div class="panel">
    		
    		<div class="panel-head">查看消息详情</div>
    		<s:set name="m" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.message.Message',@java.lang.Integer@parseInt(#parameters.id))}"></s:set>
    		
    		<div class="panel-body">
    	<div class="form-group">
            <div class="label">
                <label>
                    消息类别
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" theme="simple" value="%{#m.type}" disabled="true"></s:textfield>
            </div>
       </div>
       <div class="form-group">
            <div class="label">
                <label>
                    相关驾驶员
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" theme="simple" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#m.idNum).name+'('+#m.idNum+')'}" disabled="true"></s:textfield>
            </div>
       </div>
       <div class="form-group">
            <div class="label">
                <label>
                    相关车辆
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" theme="simple" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#m.carframeNum).licenseNum+'('+#m.carframeNum+')'}" disabled="true"></s:textfield>
            </div>
       </div>
       <div class="form-group">
            <div class="label">
                <label>
                    消息发起者
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" theme="simple" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#m.fromUser).uname}" disabled="true"></s:textfield>
            </div>
       </div>
       <div class="form-group">
            <div class="label">
                <label>
                    消息时间
                </label>
            </div>
            <div class="field">
            	<s:textfield cssClass="input" theme="simple" disabled="true">
            		<s:param name="value">
            			<s:date name="%{#m.time}" format="yyyy/MM/dd HH:mm:ss"/>
            		</s:param>
            	</s:textfield>
            </div>
       </div>
       <div class="form-group">
            <div class="label">
                <label>
                    消息详情
                </label>
            </div>
            <div class="field">
            	<s:textarea cssClass="input" theme="simple" value="%{#m.msg}" disabled="true"></s:textarea>
            </div>
       </div>
    		</div>
    		
    	</div>
    </div>
			
</body>

</html>