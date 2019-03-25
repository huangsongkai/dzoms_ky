<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="com.dz.module.user.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
    </head>
    <script>
    	function  dele_alert(id){
    		var r=confirm("确认删除该用户？");
               console.log(r);
                
               if((""+r).startsWith("true")){
               	$(".user_"+id+" .deleuser").click();
               }
              
    	}

    	function rst_alert(id) {
			if(confirm("确认重置该用户的密码为123？")){
				$(".user_"+id+" .rstuser").click();
			}
		}
    </script>
    <body>
    		<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>个人管理</li>
                <li>查询用户</li>
        </ul>
</div>

       <div style="height: 600px;overflow-y: scroll;margin-left: 20px;margin-right: 20px;">
       	<div class="panel">
    		<div class="panel-head">查询用户</div>
    		<div class="panel-body">
    			<table class="table table-hover table-striped table-bordered">
    		<tr>
    		    <td>id</td>
    			<td>用户名</td>
    			<td>部门</td>
    			<td>职位</td>
				<s:if test="#session.roles.{?#this.rname=='添加用户'}.size>0">
    			<td>权限管理</td>
    			<td>删除用户</td><td>重置用户密码</td>
				</s:if>
    		</tr>
    		<%List<User> users = (List<User>)request.getAttribute("users");%>
    		<% int i=0;%>
    	    <%for(User record:users){%>
    	    	<tr class="user_<%=record.getUid()%>">
    	    	    <td><%=record.getUid()%></td>
    	    		<td><%=record.getUname()%></td>
    	    		<td><%=record.getDepartment()%></td>
    	    		<td><%=record.getPosition()%></td>
					<s:if test="#session.roles.{?#this.rname=='添加用户'}.size>0">
    	    		<td><a class="button bg-blue" href="/DZOMS/manage/user_role.jsp?user.uid=<%=record.getUid()%>">权限管理</a></td>
    			    <td>
						<button class="button bg-red" onclick="dele_alert(<%=record.getUid()%>)">删除</button>
    			    	<a  style="display: none;" class="button bg-red" href="/DZOMS/manage/deleteUser?user.uid=<%=record.getUid()%>">
							<span class="deleuser">删除用户</span></a>
					</td>
						<td>
							<button class="button bg-red" onclick="rst_alert(<%=record.getUid()%>)">重置密码</button>
							<a style="display: none;" class="button bg-red" href="/DZOMS/manage/resetUserPassword?user.uid=<%=record.getUid()%>">
								<span class="rstuser">重置密码</span></a>
							</a>
						</td>
					</s:if>
    	    	</tr>
    	    	<% i++;}%>
   	 
    		
    	</table>
    		</div>
    		<div class="panel-foot">
    			合计：<span><%=i%></span>
    		</div>
    		
    		
    	</div>
       </div>
    	
    	
    	
 	</body>
</html>