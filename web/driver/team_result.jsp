<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*, com.dz.module.user.User" pageEncoding="UTF-8"%>
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
	var team ="asdas";
	
$(document).ready(function(){
	try{
		var scondition=$('[name="condition"]').val();
		var str = scondition.match(/team='\S+'/g)[0];
		var length = str.length - 7;
		team = str.substr(6,length);
	}catch(e){
		//TODO handle the exception
	}
});

	function _add(){
		var cond = "";
		$(".dialog-win .table2 :checkbox").each(function() {
			cond += "update Driver set team='"+team+"' where idNum='"+$(this).val()+"';";
		});
		$.post("/DZOMS/common/doit",{"condition":cond},function(data){
			try{
				if (data["affect"]>0) {
					//成功
					document.vehicleSele.submit();
				}
			}catch(e){
				//TODO handle the exception
			}
		});
	}

	function _delete(){
		var selected_val = $("input[name='cbx']:checked").val();
		if (selected_val==undefined||selected_val.trim().length==0) {
			return false;
		}
		$.post("/DZOMS/common/doit",{"condition":"update Driver set team=null where idNum='"+selected_val+"' "},function(data){
			try{
				if (data["affect"]>0) {
					//成功
					document.vehicleSele.submit();
				}
			}catch(e){
				//TODO handle the exception
			}
		});
	}
	
var $tableHead=$('<tr><th style="width:5%;">选择</th>' +
	'<th style="width:15%;">车牌号</th>' +
	'<th style="width:10%;">驾驶员</th>' +
	'<th style="width:25%;">身份证号</th>' +
	'<th style="width:5%;">性别</th>' +
	'<th style="width:10%;">属性</th>' +
	'<th style="width:15%;">车队名称</th>' +
	'<th style="width:15%;">分公司归属</th>' +
	'<tr>');

function toSearch() {
	var cond="";
	if ($(".dialog-win .department").val().length>0) {
		cond += " and dept='"+$(".dialog-win .department").val()+"' ";
	}
	cond += " and isInCar=true and (team is null or team='') ";
	
	$.post("/DZOMS/common/selectToList", {
		"url":"../driver/search_result_to_html.jsp",
		"className":"com.dz.module.driver.Driver",
		"condition":cond,
		"withoutPage": "true"
	}, function(html) {
		$(".dialog-win .table1").html("").append($tableHead).append(html);
	});
}

function tianjia() {
	if ($(".dialog-win .table1 :checked:first").parent().parent().html() == undefined)
		alert("您没有勾选任何数据");
	while ($(".dialog-win .table1 :checked:first").parent().parent().html() != undefined) {
		var txt='<tr>' + $(".dialog-win .table1 :checked:first").parent().parent().html() + '</tr>';
		$(".dialog-win .table2").append(txt);
		$(".dialog-win .table1 :checked:first").parent().parent().remove();
	}
}

function shanchu() {
	if ($(".dialog-win .table2 :checked:first").parent().parent().html() == undefined)
		alert("您没有勾选任何数据");
	while ($(".dialog-win .table2 :checked:first").parent().parent().html() != undefined) {
		var txt='<tr>' + $(".dialog-win .table2 :checked:first").parent().parent().html() + '</tr>';
		$(".dialog-win .table1").append(txt);
		$(".dialog-win .table2 :checked:first").parent().parent().remove();
	}
}

function quanxuan() {
	$(".dialog-win .table1 :checkbox").prop("checked", true);
	tianjia();
}

function qingkong() {
	$(".dialog-win .table2 :checkbox").prop("checked", true);
	shanchu();
	$(".dialog-win .table1 :checkbox").prop("checked", false);
}
</script>
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
		if(currentPage==<s:property value='%{#request.page.totalPage}'/>){
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
		$("#page-input").val(currentPage + "/<s:property value='%{#request.page.totalPage}'/>");
		
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
	<div class="line">
  	 <div class="panel  margin-small" >
  	 	<div class="panel-head">
  	 		  <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm4 xm6-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                     	<button  type="button" class="dialogs button icon-search text-blue" style="line-height: 6px;"  data-toggle="click" data-target="#mydialog" data-mask="1" data-width="90%">
	                               		添加成员</button>
	                                    	<button onclick="_delete()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            删除成员</button>
		                                  
                                     </div>
                                </div>
          	        	</div>
        </div>
  	 	</div>
  	 	
       
            
           
        <div class="panel-body">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <th>选择</th>
                    <th class="name selected_able">姓名</th>
                    <th class="idNum selected_able">身份证号</th>
                    <th class="licenseNum selected_able">车牌号</th>
                    <th class="driverClass selected_able">驾驶员属性</th>
                </tr>
                <s:if test="%{#request.list!=null}">
                <s:iterator value="%{#request.list}" var="v">
                <tr>
                	<td><input type="radio" name="cbx" value="<s:property value='%{#v.idNum}'/>" ></td>
 					<td class="name selected_able"><s:property value='%{#v.name}'/></td>
                    <td class="idNum selected_able"><s:property value='%{#v.idNum}'/></td>
                    <td class="licenseNum selected_able"><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
                    <td class="driverClass selected_able"><s:property value="%{#v.driverClass}"/></td>         
       			</tr>
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
                    			<input class="input input-auto" size="4" value="1/<s:property value='%{#request.page.totalPage}'/>" id="page-input" >
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
            </s:if>
            <s:else>
                	无查询结果
            </s:else>
        </div>
     </div>
	
    <form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
        <s:hidden name="url" value="/driver/team_result.jsp" />
		<s:hidden name="className" value="com.dz.module.driver.Driver"/>
		<s:hidden name="condition" />
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage" />
        <s:hidden name="withoutPage"></s:hidden>
    </form>
	</div>
	
<div id="mydialog">
	<div class="dialog">
		<div class="dialog-head">
			<span class="close rotate-hover"></span><strong>对话框标题</strong>
		</div>
		<div class="dialog-body">
				<div class="line">
		<div class="xm5">
			<div class="panel">
				<div class="panel-head">
					
							全部驾驶员
					
				</div>
				<div class="panel-body">
					<div style="height: 50px" id="selectDiv">
						<form class="form-inline" style="width: 100%;">
							<div class="form-group" style="width: auto;">
							<div class="label" style="width: auto">
								<label>
									公司
								</label>
							</div>
							<div class="field" style="width: auto;">
								<select class="input department" style="width: 70px;">
									<option></option>
									<option>一部</option>
									<option>二部</option>
									<option>三部</option>
								</select>
							</div>
						</div>
						<input class="button bg-green" type="button" value="查找" onclick="toSearch()">
						</form>
						
					</div>
					<div style="height: 500px;overflow: scroll">
						<table class="table table-bordered table-striped table1">
							<tr><th style="width:15%;">车牌号</th><th style="width:10%;">驾驶员</th><th style="width:5%;">选择</th><th style="width:25%;">身份证号</th><th style="width:5%;">性别</th><th style="width:10%;">属性</th><th style="width:15%;">车队名称</th><th style="width:15%;">分公司归属</th></tr>
						</table>
					</div>
				</div>
				<div class="panel-foot">
					<strong>
						合计:
					</strong>
				</div>
			</div>
		</div>
		<div class="xm1">
			<div class="panel">
            	<div class="panel-head"> <strong>操作</strong></div>
               <div class="panel-body">
               	 <div class="form-group">
                    <div style="height: 50px"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="添加" onclick="tianjia()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="删除" onclick="shanchu()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="全选" onclick="quanxuan()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="清空" onclick="qingkong()"></div>
                </div>
               </div>
               

            </div>
		</div>
		<div class="xm5">
			<div class="panel">
				<div class="panel-head">
					
							选择驾驶员
					
				</div>
				<div class="panel-body">
					<div style="height: 50px">
					</div>
					<div style="height:500px; overflow: scroll">
						<table class="table table-bordered table-striped table2">
							<tr><th style="width:15%;">车牌号</th><th style="width:10%;">驾驶员</th><th style="width:5%;">选择</th><th style="width:25%;">身份证号</th><th style="width:5%;">性别</th><th style="width:10%;">属性</th><th style="width:15%;">车队名称</th><th style="width:15%;">分公司归属</th></tr>
						</table>
					</div>
				</div>
				<div class="panel-foot">
					<strong>
						合计：
					</strong>
				</div>
			</div>
		</div>
	</div>
		
		</div>
		<div class="dialog-foot">
			<button class="button dialog-close">
				取消</button>
			<button class="button bg-green dialog-close"  onclick="_add()">
				确认</button>
		</div>
	</div>
</div>
</body>
</html>
