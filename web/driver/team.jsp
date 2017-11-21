<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>车队管理</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<script>
	function updateTeam(team){
		if (team==undefined||team.trim().length==0) {
			return false;
		}
		var condition = " and team='"+team+"' and isInCar=true ";
		$('[name="condition"]').val(condition);
		$("#search_form").submit();
	}

	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		updateTeam(selected_val);
	}
	
	function _add(){
		var team = prompt("请输入新车队名称:").trim();
		$.post('/DZOMS/item_add',{'item.key':"driverTeam",'item.value':team},function(data){
			if($.trim(data) == 'success'){
				updateTeam(team);
			}else{
				alert(data);
			}	
		});
	}
	
	function _delete(){
		var selected_val = $("input[name='cbx']:checked").val();
		
		if (selected_val==undefined||selected_val.trim().length==0) {
			return false;
		}
		
		var condition = "update Driver set team=null where team='"+selected_val+"' ;";
		condition += "delete from ItemTool where key='driverTeam' and value='"+selected_val+"' ";
		
		$.post("/DZOMS/common/doit",{"condition":condition},function(data){
			try{
				if (data["affect"]>0) {
					//成功
					location.reload(true);
				}
			}catch(e){
				//TODO handle the exception
			}
		});
	}
</script>
</head>
<body>
	<form method="post" class="form-inline" id="search_form" action="/DZOMS/common/selectToList">
		<input type="hidden" name="url" value="/driver/team_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.driver.Driver"/>
		<input type="hidden" name="condition" />
	</form>
	<div class="line">
  	 <div class="panel" >
  	 	<div class="panel-head">
  	 		 <div class="line">
          	        	<div class="xm2">车队</div>
          	        	<div class="xm3 xm7-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                     	<button onclick="_add()" type="button" class="button icon-plus text-blue" style="line-height: 6px;">
	                               		新增</button>
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
		                                    <button onclick="_delete()" type="button" class="button icon-trash-o text-blue" style="line-height: 6px;">
			                                                           删除</button>
			                                 
                                     </div>
                                </div>
          	        	</div>
          	        </div>
  	 	</div>
  
        <div class="panel-body">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <th>选择</th>
                    <th class="team selected_able">车队名称</th>
                    <th class="teamNum selected_able">人数</th>
                </tr>
                
                <s:iterator value="%{#session.teamMap}" id="entry">
                <tr>
                	<td><input type="radio" name="cbx" value="<s:property value="%{#entry.key}"/>" ></td>
 					<td class="team selected_able"><s:property value="%{#entry.key}"/></td>
 					<td class="teamNum selected_able"><s:property value="%{#entry.value}"/></td>
       			</tr>
       			</s:iterator>
           	</table>
        </div>
     </div>
	</div>	
</body>
</html>
