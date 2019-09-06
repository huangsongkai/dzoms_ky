<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.dz.common.test.DataTrackFilter"%>
<%@page import="com.dz.common.global.*"%>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java"
	import="java.util.*,java.util.HashMap,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission any="true" role="投诉落实,投诉回访,投诉完结,投诉补充登记">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Page pg = (Page)request.getAttribute("page");
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>投诉处理</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script>
	$(document).ready(function(){
		$(".wait_deal a").click(function(){
			$("#body-right",window.parent.parent.document).height([2100]);
			$('[name="body"]',window.parent.parent.parent.document).height([2100]);
		});
	});
</script>
<script>
	function toBeforePage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==1){
			alert("没有上一页了。");
			return ;
		}
		$("input[name='currentPage']").val($("input[name='currentPage']").val()-1);
		document.subForm.submit();
	}
	
	function toNextPage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==<%=pg.getTotalPage()%>){
			alert("没有下一页了。");
			return ;
		}
		$("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val())+1);
		document.subForm.submit();
	}
	
	function toPage(pg){
		$("input[name='currentPage']").val(pg);
		document.subForm.submit();
	}
	
	$(document).ready(function(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		$("#page-input").val(currentPage + "/<%=pg.getTotalPage()%>");
		
		$("#page-input").change(function(){
			
			var pg_num = parseInt($("#page-input").val());
			toPage(pg_num);
		});
		
		$("#page-input").focus(function(){
			$(this).val("");
		});
	});
	
	
</script>
</head>

<body>
	<jsp:include page="/common/load_to_top.jsp"></jsp:include>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>投诉</li>
        </ul>
</div>
	<div class="line">
        	<!-- <div class="alert alert-yellow"><span class="close"></span><strong>注意：</strong>您有5条未读信息，<a href="vehicle/CreatApproval/approval_list.jsp">点击查看</a>。</div> -->
         <div class="panel  margin-small" >
          	<div class="panel-head">
          	</div>
          	<div class="panel-body">
                	<table id="wait_deal" class="table table-striped table-hover table-bordered wait_deal">
                		<tr>
                			<th>待办类别</th><th>部门</th><th>车牌号</th><th>承租人</th><th>事项</th>
                		</tr>
                		<s:iterator var="v" value="%{#request.list}">
                			<tr>
                			<td><s:if test="%{#v.state==0}">
		投诉落实
	</s:if>
	<s:elseif test="%{#v.state==1}">
		投诉落实
	</s:elseif>
	<s:elseif test="%{#v.state==2}">
		投诉回访
	</s:elseif>
	<s:elseif test="%{#v.state==3}">
		投诉完结
	</s:elseif>
	<s:elseif test="%{#v.state==4}">
		补充登记
	</s:elseif>
	<s:else>
		
	</s:else></td>
	<s:set name="car" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.vehicleId)}"></s:set>
                			<td><s:property value="%{#car.dept}"/></td>
							<td><s:property value="%{#car.licenseNum}"/></td>
							<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#car.driverId).name}"/></td>
                			<td>
<s:if test="%{#v.state==0}">
	<a class="button bg-blue" href="/DZOMS/driver/complain/preconfirmComplain.action?complain.id=${v.id}" target="_parent">落实</a>
	</s:if>
	<s:elseif test="%{#v.state==1||#v.state==-1}">
	<a class="button bg-blue" href="/DZOMS/driver/complain/preconfirmComplain.action?complain.id=${v.id}" target="_parent">回访</a>
	</s:elseif>
	<s:else>
	<a class="button bg-blue" href="/DZOMS/driver/complain/preattachComplain.action?complain.id=${v.id}" target="_parent">补充登记</a>
	</s:else>
                			</td>
                			</tr>
                		</s:iterator>
                	</table>
                </div>
            </div>
    <div class="line padding">
            	<div class="xm5-move">
            		<div>
            			<ul class="pagination">
                    <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                  </ul>
                   <ul class="pagination pagination-group">
                    <li style="border: 0px;">
                    	<form>
                    		<div class="form-group">
                    			<div class="field">
                    			<input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>%>" id="page-input" >
                    		</div>
                    			</div>
                    	</form>
                    	</li>
                   </ul>
                  <ul class="pagination">
                    <li><a href="javascript:toNextPage()">下一页</a></li>
                  </ul>
                  
            		</div>
            	</div>
            </div>
    </div>
<form action="/DZOMS/driver/complain/searchComplain" method="post" name="subForm">
	<s:hidden name="url"></s:hidden>
    <s:hidden name="beginDate" />
    <s:hidden name="endDate" />
    <s:hidden name="states" value="%{#parameters.states}"/>
    <s:hidden name="complain.carNum" />
    <s:hidden name="dept" />
    <s:hidden name="complain.complainClass" />
    <s:hidden name="complain.complainObject" />
    <s:hidden name="complainObject2" />
    <s:hidden name="order" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
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