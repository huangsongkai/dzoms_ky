<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>银行导入详情</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
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
		if(currentPage==${requestScope.page.totalPage}){
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
		$("#page-input").change(function(){
			var pg_num = parseInt($("#page-input").val());
			toPage(pg_num);
		});
		
		$("#page-input").focus(function(){
			$(this).val("");
		});
	});
</script>

<script>
function _all(){
	$("input[name='ids']").prop('checked',true);
}

function _other(){
	$("input[name='ids']").each(function () {
		$(this).prop('checked',!$(this).prop('checked'));
	});
}

function _rollback(){
	ids=[];
	$("input[name='ids']:checked").each(function(){
		ids.push($(this).val());
	});
	
	if (ids.length==0) {
		alert('您没有选择任何数据！');
		return false;
	}
	
	var con = confirm('确定撤销选中的'+ids.length+'项数据？');
	if(con==true){
		var jsonStr = $.toJSON(ids);
		$.post("/DZOMS/charge/rollbackImport.action",{jsonStr:jsonStr},function(msg){
			alert(msg);
			document.vehicleSele.submit();
		});
	}
}
</script>
</head>
<body> 
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
        <li>财务管理</li>
        <li>查询</li>
        <li>银行导入详情</li>
    </ul>
</div>

<div class="line">
	<div class="panel">
		<div class="panel-head">
			<div class="line">
          	        	<div class="xm2">银行导入详情</div>
          	        	<div class="xm4 xm6-move">
          	        		       	<div class="button-toolbar">
	                                  <div class="button-group">
	                                     	<button onclick="_all()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		本页全选</button>
	                                    	<button onclick="_other()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            本页反选</button>
			                              <button onclick="_rollback()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                       撤销选中的导入项 </button>      
                                     </div>
                                </div>
          	        	</div>
      </div>
		</div>
		<div class="panel-body">
			
			<table class="table table-striped table-bordered table-hover" align="center">
				<thead>
					<tr>
						<th>选择</th><th>序号</th><th>车牌号</th><th>姓名</th><th>金额</th><th>进账月份</th>
					</tr>
				</thead>
				<tbody>
					<s:if test="%{#request.list!=null}">
						<s:set name="index" value="%{(#request.page.currentPage-1)*(#request.page.everyPage)+1}"/>
						<s:iterator value="%{#request.list}" var="v">
							<tr>
								<td>
									<input type="checkbox" name="ids" value="${v.id}">
								</td>
								<td><s:property value="%{#index}"/></td>
								<td><s:property value="%{#v.licenseNum}"/></td>
								<td><s:property value="%{#v.driverName}"/></td>
								<td><s:property value="%{#v.money}"/></td>
								
								<td><s:date name="%{#v.inTime}" format="yyyy/MM"/></td>
							</tr>
							<s:set name="index" value="%{#index+1}"/>
						</s:iterator>
					</s:if>
				</tbody>
			</table>
			
			<s:if test="%{#request.list!=null}">
			<div class="line padding">
				<div class="xm5-move">
					<div>
						<ul class="pagination">
							<li>
								<a href="javascript:toBeforePage()">上一页</a>
							</li>
						</ul>
						<ul class="pagination pagination-group">
							<li style="border: 0px;">
								<form>
									<div class="form-group">
										<div class="field">
											<input class="input input-auto" size="4" value="${requestScope.page.currentPage}/${requestScope.page.totalPage}" id="page-input">
										</div>
									</div>
								</form>
							</li>
						</ul>
						<ul class="pagination">
							<li>
								<a href="javascript:toNextPage()">下一页</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="panel-foot border-red-light bg-red-light">
            合计：${requestScope.page.totalCount}条记录。
      </div>
      </s:if>
      <s:else>
    	无查询结果
    	</s:else>
			
		</div>
	</div>
</div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
    <s:hidden name="condition" />
    <s:hidden name="className" />
    <s:hidden name="url" />
    <s:hidden name="pageSize" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>

</body>
</html>
