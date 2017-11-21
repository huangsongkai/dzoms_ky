<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.dz.common.test.DataTrackFilter"%>
<%@page import="com.dz.common.global.*"%>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java"
	import="java.util.*,java.util.HashMap,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			
	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());    
  	WaitDealController waitDealController = ctx.getBean(WaitDealController.class);
  	request.setAttribute("waitDealMap", waitDealController.getWaitDealMap());
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>待办事项</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script>

        function goTo(url){
        	window.location = url;
        }
        
        function openView(view,args,type){
           // window.showModalDialog(view,args,'dialogWidth:620px;dialogHeight:500px;edge:raised;resizable:yes;scroll:yes;status:no;center:yes;help:no;minimize:yes;maximize:yes;');
           goTo(view+"?accidentId="+args[0]);
        };
</script>
</head>

<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>待办事项</li>
                <li><s:property value="%{#parameters.waitDealType}"/></li>
        </ul>
</div>
	<div class="line">
        	<!-- <div class="alert alert-yellow"><span class="close"></span><strong>注意：</strong>您有5条未读信息，<a href="vehicle/CreatApproval/approval_list.jsp">点击查看</a>。</div> -->
         <div class="panel  margin-small" >
          	<div class="panel-head">
          		<div class="float-left">
          			<h4><strong class="text-black">查询条件</strong></h4>
          		</div>
          		
          	
          		
          	</div>
          	<div class="panel-body" style="height: 500px; overflow: scroll;">
                	<table id="wait_deal" class="table table-striped table-hover table-bordered">
                		<tr>
                			<th>待办类别</th><th>消息</th><th>事项</th>
                		</tr>
                		<s:iterator id="map" value="%{#request.waitDealMap}">
                		<s:if test="%{@org.apache.commons.lang3.StringUtils@equals(#map.key,#parameters.waitDealType)}">
                			<s:iterator var="v" value="%{#map.value}">
                			<tr>
                				<td><s:property value="%{#parameters.waitDealType}"/></td>
                				<td><s:property value="%{#v.msg}"/></td>
                				<td><a href="<s:property value="%{#v.url}"/>"><s:property value="%{#v.state}"/></a></td>
                			</tr>
                			</s:iterator>
                		</s:if>
                		</s:iterator>
                	</table>
                </div>
            </div>
    </div>
</body>
<script>
 $(document).ready(function() {
    	try{
    		 App.init();
    	}catch(e){
    		//TODO handle the exception
    	}
    	
       
        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

    });
    </script>
</html>