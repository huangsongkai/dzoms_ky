<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.dz.common.test.DataTrackFilter"%>
<%@page import="com.dz.common.global.*"%>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java"
	import="java.util.*,java.util.HashMap,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="上岗申请">
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
<title>上岗申请</title>
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
                <li>待岗管理</li>
                <li>上岗申请</li>
        </ul>
</div>
	<div class="line">
        	<!-- <div class="alert alert-yellow"><span class="close"></span><strong>注意：</strong>您有5条未读信息，<a href="vehicle/CreatApproval/approval_list.jsp">点击查看</a>。</div> -->
         <div class="panel  margin-small" >
          	<div class="panel-head">
          		待岗人员列表
          	</div>
          	
          	<div class="panel-body">
          	
                	<table id="wait_deal" class="table table-striped table-hover table-bordered wait_deal">
                	<tr>
                	<th class="licenseNum              selected_able">车牌号      </th>
                    <th class="name                    selected_able">姓名        </th>
                    <th class="sex                     selected_able">性别        </th>
                    <th class="driverClass selected_able">驾驶员属性</th>
                    <th class="phoneNum1 selected_able">电话号码</th>
                    <th class="qualificationNum        selected_able">资格证号    </th>
                    <th class="idNum                   selected_able">身份证号    </th>
                    <th class="employeeNum             selected_able">员工号      </th>
                    <th class="department              selected_able">分公司归属  </th>
                	<th>事项</th>
                		</tr>
                		<s:iterator var="v" value="%{#request.list}">
                			<tr>
                	 <td class="licenseNum         selected_able"><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
                            <td class="name               selected_able"><s:property value='%{#v.name}'/></td>
                            <td class="sex                selected_able"><s:property value="%{#v.sex?'男':'女'}"/></td>
                            <td class="driverClass selected_able"><s:property value="%{#v.driverClass}"/></td>
                            <td class="phoneNum1 selected_able"><s:property value="%{#v.phoneNum1}"/></td>
                            <td class="qualificationNum   selected_able"><s:property value='%{#v.qualificationNum}'/></td>
                            <td class="idNum              selected_able"><s:property value='%{#v.idNum}'/></td>
                            <td class="employeeNum        selected_able"><s:property value='%{#v.employeeNum}'/></td>
                         	<td class="department         selected_able"><s:property value='%{#v.dept}'/></td>
                			<td><a class="button bg-blue" href="/DZOMS/driver/leave/leaveCancelSelect2?driver.idNum=<s:property value="%{#v.idNum}"/>" target="_parent">申请上岗</a></td>
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
    <form action="/DZOMS/common/selectToList" method="post" name="subForm">
    	<s:hidden name="url"></s:hidden>
    	<s:hidden name="className"></s:hidden>
    	<s:hidden name="condition"></s:hidden>
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