<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.opensymphony.xwork2.util.*" %>
<%@ page language="java"
	import="java.util.*,com.dz.module.user.User,com.dz.module.vehicle.*,com.dz.module.driver.*,com.dz.common.other.*,com.dz.common.global.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<s:set name="driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.affect.idNumber)}"></s:set>
<s:set name="vehicle" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#request.affect.carframeNum)}"></s:set>


<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
		<title>证照办理</title>
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
function refresh(){
	var name = $('[name="driver.name"]').val().trim();
    if (name.length==0) {
    	return false;
    }
    var url = "/DZOMS/common/doitToUrl?"
    	+"url=%2fdriver%2fdriverInCar%2fbusiness_recive_cancel.jsp&"
    	+"condition="
    	+ encodeURI("from Driverincar where operation='证照注销' and finished=false and idNumber in"
    	+"(select idNum from Driver where name='"+name+"')");
    	
    document.location.href = url;
}
        
$(document).ready(function(){

$("[name='driver.name']").bigAutocomplete({
	url:"/DZOMS/select/driverByName",
	condition:" idNum in (select idNumber from Driverincar where finished=false and operation='证照注销') ",
	callback:function(){
		refresh();
	}
});
});

</script>

	   <style>
	   	.form-group{
	   		width: 400px;
	   	}
        .label{
            width: 120px;
            text-align: right;
        }
    </style>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>证照办理</li>
                <li>注销</li>
        </ul>
        </div>
</div>
<div class="container">
    <form action="/DZOMS/driver/driverInCar/businessReciveCancel" name="driverBusinessApply" method="post"
    	style="width: 100%;" class="form-inline form-tips">

        <div class="panel">
            <div class="panel-head">
                <strong>证照信息</strong>
            </div>
            <div class="panel-body">
            	<div class="line">
	<div class="xm2">
		<div class="padding">
					    	<!--<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('data/driver/'+#driver.idNum+'/photo.jpg')=true}">
					    	    <img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/photo.jpg" class="radius img-responsive" style="width: 150px;height: 150px;">
					    	</s:if>
					    	<s:else>
					    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" style="width: 150px;height:150px;">
					    	</s:else>-->
					    	<strong>驾驶员照片</strong>
				        	<div>
		<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('/data/driver/'+#driver.idNum+'/photo.jpg')}">
			<img src="/DZOMS/data/driver/<s:property value='%{#driver.idNum}'/>/photo.jpg" class="radius img-responsive" id="headimg1"  style="width: 150px;height:150px;">
    	</s:if>
    	<s:else>
    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" id="headimg1"  style="width: 150px;height:150px;">
    	</s:else>
				        		
				        	</div>
				            
				        	<strong>人车照片</strong>
				        	<div>
		<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('/data/driver/'+#driver.idNum+'/drive_vehicle_photo.jpg')}">
			<img src="/DZOMS/data/driver/<s:property value='%{#driver.idNum}'/>/drive_vehicle_photo.jpg" class="radius img-responsive" id="headimg"  style="width: 150px;height:150px;">
    	</s:if>
    	<s:else>
    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" id="headimg"  style="width: 150px;height:150px;">
    	</s:else>
				        	</div>
				            
		                 </div>
	</div>
	<div class="xm10">
		<div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员姓名
                    </label>
                </div>
                <div class="field" >
                	<s:textfield cssClass="input"  name="driver.name" value="%{#driver.name}" />
                </div>
            </div>
            
           
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            身份证号
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"  name="driver.idNum" value="%{#driver.idNum}"/>
                    </div>
                </div>
                <br/>
		<div class="form-group">
                <div class="label padding">
                    <label>
                        车牌号
                    </label>
                </div>
                <s:hidden name="vehicle.carframeNum" value="%{#vehicle.carframeNum}"></s:hidden>
                <div class="field" >
                	<s:textfield name="vehicle.licenseNum" cssClass="input" value="%{#vehicle.licenseNum}"/>
					<s:hidden name="driver.carframeNum" value="%{#vehicle.carframeNum}"></s:hidden>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        承租人
                    </label>
                </div>
                <div class="field" >
                    <s:textfield id="vehicleOwner" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#vehicle.driverId).name}" cssClass="input"/>
                </div>
            </div>
            <br>
            

                
                
                <div class="form-group">
                    <div class="label padding" >
                        <label>
                            申请注销时间
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"  name="driver.businessApplyCancelTime" readonly="readonly" value="%{#driver.businessApplyCancelTime}"></s:textfield>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding" >
                        <label>
                            发证时间
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"  name="driver.applyTime" readonly="readonly" value="%{#driver.applyTime}"></s:textfield>
                    </div>
                </div>
                <br/>
                <div class="form-group">
                    <div class="label padding" >
                        <label>
                            驾驶员属性
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"  name="driver.driverClass" value="%{#driver.driverClass}" readonly="readonly" ></s:textfield>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding" >
                        <label>
                            作息时间
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"  name="driver.restTime" value="%{#driver.restTime}" readonly="readonly" ></s:textfield>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding" >
                        <label>
                            录入人
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                        <input type="hidden" name="driver.businessApplyCancelRegistrant" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding" >
                        <label>
                            登记时间
                        </label>
                    </div>
                    <div class="field">
                        <input  class="datepick input" readonly="readonly" name="driver.businessReciveCancelRegistTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
                    </div>
                </div>
            </div>
              <div class="form-group">
                <div class="label padding" >
                </div>
                <div class="field">  
                </div>
            </div>
            <div class="form-group">
                <div class="label padding" >
                </div>
                <div class="field">
                    <input type="button" class="button bg-green submitbutton margin-big-left" value="提交">
                </div>
            </div>
	</div>
</div>
            
        </div>
    </form>
    <script>
    add_but_bind('.submitbutton',function(){
    	driverBusinessApply.submit();
    });
    </script>
</div>
</body>
</html>
