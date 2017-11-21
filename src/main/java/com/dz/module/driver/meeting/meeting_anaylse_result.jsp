<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8" %>
<%@page import="org.springframework.web.context.support.*" %>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.dz.common.global.Page"%>
<% String path=request.getContextPath(); String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/";Page pg = (Page)request.getAttribute("page"); %>

<!DOCTYPE html>
<html lang="zh-cn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="renderer" content="webkit" />
<title> 例会签到 </title> 
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"> </script> 
<script src="/DZOMS/res/js/pintuer.js"> </script> 
<script src="/DZOMS/res/js/respond.js"> </script> 
<script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script> 
<script src="/DZOMS/res/js/admin.js"> </script> 
<script>
function toBeforePage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==1){
			alert("没有上一页了。");
			return ;
		}
		$("input[name='currentPage']").val($("input[name='currentPage']").val()-1);
		document.vehicleSele.submit();
	}
	
	function toNextPage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==<%=pg.getTotalPage()%>){
			alert("没有下一页了。");
			return ;
		}
		$("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val())+1);
		document.vehicleSele.submit();
	}
	
	function toPage(pg){
		
		$("input[name='currentPage']").val(pg);
		document.vehicleSele.submit();
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

<style>
	.label {
		width: 80 px;
		text-align: right;
	}
	.form-group {
		width: 300 px;
		margin-top: 5 px;
	}
	.changecolor {
		background-color: #0099CC;
	}
							
</style>
</head>

<body>
	<div class="panel  margin-small" >
          	<div class="panel-head">
          	    <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<!--<div class="xm6 xm4-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                   <button onclick="_selectAll()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            本页全选</button>
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            更新所选车辆数据</button>
			                                 <button onclick="_updateAll()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            更新所有车辆数据(含条件)</button>
			                                                    
                                     </div>
                                </div>
          	        	</div>-->
          	        </div>	
          </div>
          	<div class="panel-body">
          	
				<table class="table table-bordered table-hover" id="meeting-time-detail">
					<tr>
						<!--<th>选择</th>--><th>车牌号</th><th>驾驶员</th><th>身份证号</th><th>分公司归属</th> <th>类别</th><th>是否签到</th> <th>签到方式 </th><th>签到时间</th><th>分值</th> <th>手动签到经手人</th><th>手动签到经手时间</th>  
					</tr>
					<s:if test="%{#request.list!=null}">
                    <s:iterator value="%{#request.list}" var="v">
                    <tr class="<s:property value="%{#v.isChecked?'bg-green-light':'bg-red-light'}" />">
						<%--<td><input type="radio" name="cbx" value="<s:property value="%{#v.idNum}" />" <s:property value="%{#v.isChecked?'disabled=\"true\"':''}" /> /></td> --%>
						<!--<td><input type="radio" name="cbx" value="<s:property value="%{#v.idNum}" />" /></td>-->
						<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNum)}" />
						<s:set name="t_meeting" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.meeting.Meeting',#v.meetingId)}" />
						<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#t_driver.carframeNum).licenseNum}"/></td>
						<td><s:property value="%{#t_driver.name}"/></td>
						<td><s:property value="%{#v.idNum}"/></td>
						<td><s:property value="%{#t_driver.dept}"/></td>
						<td><s:property value="%{#v.isBuhui()?'补会':'例会'}"/></td>
						<td><s:property value="%{#v.isChecked?'是':'否'}"/></td>
						<td><s:property value="%{#v.checkMethod}"/></td>
						<td><s:date name="%{#v.checkTime}" format="yyyy/MM/dd hh:mm:ss"/></td>
						<td><s:property value="%{#t_meeting.grade}"/></td>
						<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.manmalCheckPerson).uname}"/></td>
						<td><s:date name="%{#v.manmalCheckTime}" format="yyyy/MM/dd hh:mm:ss"/></td></tr>
                    </s:iterator>
                    </s:if>
				</table>
				<s:if test="%{#request.list!=null}">
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
                    			<input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>" id="page-input" >
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
            <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
        </div>
            </s:if>
	            <s:else>
	                	无查询结果
	            </s:else>
			</div>
		</div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
    <s:hidden name="condition" />
    <input type="hidden" name="url" value="/driver/meeting/meeting_anaylse_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.driver.meeting.MeetingCheck"/>
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
		
	
</body> 
</html>