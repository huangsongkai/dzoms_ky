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
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<m:permission role="合同新增,合同查询,合同修改权限" any="true">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>
<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>档案号重排</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
</head>
<body>
<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>合同</li>
                <li>档案号重排</li>
        </ul>
</div>
<div class="line">
	<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
          	<div class="panel-body">
          		<form class="form-inline" method="post"  id="search_form" action="/DZOMS/contract/contractSearchToUrl" target="result_form">
          		       <div class="form-group">
							<div class="label"><label>部门</label></div>
							<div class="field">
							<select name="dept" class="input">
          		      	 		<option value="一部">一部</option>
          		      	 		<option value="二部">二部</option>
          		      	 		<option value="三部">三部</option>
          		      	 	</select>
							</div>
						</div>
					 <input type="hidden" name="states" value="0">
					 <input type="hidden" name="order" value="carNum">
					 <input type="hidden" name="rank" value="true">
					 <input type="hidden" name="withoutPage" value="true">
					 <input type="hidden" name="url" value="/contract/contract_sort_result.jsp">
          		       <div class="form-group">
          		       	<input type="submit" value="查询" />
          		       </div>
          		</form>
          	</div>
    </div>
</div>
		<!-- 主页面 -->
	
	<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="yes">

    </iframe>

</div>
</body>
</html>
