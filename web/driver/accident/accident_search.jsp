<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.vehicle.VehicleApproval,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%><!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>查询事故信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<script type="text/javascript">   
function iFrameHeight() {
	try{
var ifm= document.getElementById("frame1");   
var subWeb = document.frames ? document.frames["frame1"].document : ifm.contentDocument;   
if(ifm != null && subWeb != null) {
   ifm.height = subWeb.body.scrollHeight+200;
}   }catch(e){}
}    

$(document).ready(function(){
	$("#form").submit();
//	window.setInterval('iFrameHeight();',3600);
});
</script>

<%--<script>--%>
<%--function search() {--%>
	<%--$("#context").html("");--%>
	<%--var $selected_option = $("#target").find("option:selected");--%>
	<%--var fn;--%>
	<%--switch ($selected_option.val()) {--%>
		<%--case "selectAll":--%>
			<%--fn = showAll;--%>
			<%--break;--%>
		<%--case "selectAllWaitForDeal":--%>
			<%--fn = showAllWaitForDeal;--%>
			<%--break;--%>
		<%--case "selectAllWaitForVisitBack":--%>
			<%--fn = showAllWaitForVisitBack;--%>
			<%--break;--%>
		<%--case "selectAllHandled":--%>
			<%--fn = showAllHandled;--%>
			<%--break;--%>
		<%--default:--%>
			<%--fn = showAll;--%>
	<%--}--%>
	<%--$.post('/DZOMS/driver/complain/'+$selected_option.val(),{"beginDate":$("#beginDate").val(),"endDate":$("#endDate").val()},fn);--%>
<%--}--%>

<%--function showAll(objs) {--%>
	<%--var list =  $.parseJSON(objs)["complains"];--%>
	<%----%>
	<%--var title_tr = '<tr><td>事故日期</td><td>事故类型</td><td>车牌号</td>'--%>
					<%--+'<td>违规项目</td><td>落实情况</td><td>处理情况</td>'--%>
					<%--+'<td>是否回访</td><td>回访结果</td><td>登记时间</td>'--%>
					<%--+'<td>登记人</td></tr>';--%>
	<%--$("#context").append(title_tr);--%>
	<%--for(var i=0;i<list.length;i++){--%>
		<%--var context_tr='<tr>'+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainClass"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainType"]+'</td>'--%>
				<%--+'<td>'+list[i]["licenseNum"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainObject"]+'</td>'--%>
				<%--+'<td>'+list[i]["alreadyDeal"]+'</td>'--%>
				<%--+'<td>'+list[i]["dealReault"]+'</td>'--%>
				<%--+'<td>'+list[i]["visitBack"]+'</td>'--%>
				<%--+'<td>'+list[i]["visitBackResult"]+'</td>'--%>
				<%--+'<td>'+list[i]["registTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["registrant"]+'</td>'+'</tr>';--%>
		<%--$("#context").append(context_tr);--%>
	<%--}--%>
<%--}--%>

<%--function showAllWaitForDeal(objs) {--%>
	<%--var list =  $.parseJSON(objs)["complains"];--%>
	<%--var title_tr = '<tr><td>事故日期</td><td>事故类型</td><td>车牌号</td>'--%>
					<%--+'<td>违规项目</td><td>登记时间</td>'--%>
					<%--+'<td>登记人</td><td>落实</td></tr>';--%>
	<%--$("#context").append(title_tr);--%>
	<%--for(var i=0;i<list.length;i++){--%>
		<%--var context_tr='<tr>'+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainClass"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainType"]+'</td>'--%>
				<%--+'<td>'+list[i]["licenseNum"]+'</td>'--%>
				<%--+'<td>'+list[i]["registTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["registrant"]+'</td>'--%>
				<%--+'<td><a href="complain/predealComplain.action?complain.id="'+list[i]["id"]+'">落实</a></td>'--%>
				<%--+'</tr>';--%>
		<%--$("#context").append(context_tr);--%>
	<%--}--%>
<%--}--%>

<%--function showAllWaitForVisitBack(objs) {--%>
	<%--var list =  $.parseJSON(objs)["complains"];--%>
	<%--var title_tr = '<tr><td>事故日期</td><td>事故类型</td><td>车牌号</td>'--%>
					<%--+'<td>违规项目</td><td>落实情况</td><td>处理情况</td>'--%>
					<%--+'<td>登记时间</td>'--%>
					<%--+'<td>登记人</td><td>回访</td></tr>';--%>
	<%--$("#context").append(title_tr);--%>
	<%--for(var i=0;i<list.length;i++){--%>
		<%--var context_tr='<tr>'+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainClass"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainType"]+'</td>'--%>
				<%--+'<td>'+list[i]["licenseNum"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainObject"]+'</td>'--%>
				<%--+'<td>'+list[i]["alreadyDeal"]+'</td>'--%>
				<%--+'<td>'+list[i]["dealReault"]+'</td>'--%>
				<%--+'<td>'+list[i]["registTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["registrant"]+'</td>'--%>
				<%--+'<td><a href="complain/previsit_backComplain.action?cpmplain.id="'+list[i]["id"]+'">回访</a></td>'--%>
				<%--+'</tr>';--%>
		<%--$("#context").append(context_tr);--%>
	<%--}--%>
<%--}--%>

<%--function showAllHandled(objs) {--%>
	<%--var list =  $.parseJSON(objs)["complains"];--%>
	<%--var title_tr = '<tr><td>事故日期</td><td>事故类型</td><td>车牌号</td>'--%>
					<%--+'<td>违规项目</td><td>落实情况</td><td>处理情况</td>'--%>
					<%--+'<td>是否回访</td><td>回访结果</td><td>登记时间</td>'--%>
					<%--+'<td>登记人</td></tr>';--%>
	<%--$("#context").append(title_tr);--%>
	<%--for(var i=0;i<list.length;i++){--%>
		<%--var context_tr='<tr>'+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainClass"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainType"]+'</td>'--%>
				<%--+'<td>'+list[i]["licenseNum"]+'</td>'--%>
				<%--+'<td>'+list[i]["complainObject"]+'</td>'--%>
				<%--+'<td>'+list[i]["alreadyDeal"]+'</td>'--%>
				<%--+'<td>'+list[i]["dealReault"]+'</td>'--%>
				<%--+'<td>'+list[i]["visitBack"]+'</td>'--%>
				<%--+'<td>'+list[i]["visitBackResult"]+'</td>'--%>
				<%--+'<td>'+list[i]["registTime"]+'</td>'--%>
				<%--+'<td>'+list[i]["registrant"]+'</td>'+'</tr>';--%>
		<%--$("#context").append(context_tr);--%>
	<%--}--%>
<%--}--%>

<%--</script>--%>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>事故查询</li>
        </ul>
	</div>
</div>

    <div class="line">
		<!-- 主页面 -->
		<form id="form" method="post" class="form-inline" action="accident_Selects" style="width: 100%;" target="frame1">
			
			<div class="xm12">
				<div class="panel margin-small">
					<div class="panel-head ">
          		          事故
          		      
          		   </div>
          	       <div class="panel-body">
          	       	    <div class="form-group">
          	       	    	<div class="label"><label>开始时间</label></div>
          	       	    	<div class="field">
          	       	    		<input type="text" id="beginDate" name="tp.startTime" class="datetimepicker input"/>
          	       	    	</div>
          	       	    </div>
          	       	    <div class="form-group">
          	       	    	<div class="label"><label>结束时间</label></div>
          	       	    	<div class="field">
          	       	    		<input type="text" id="endDate" name="tp.endTime" class="datetimepicker input"/>
          	       	    	</div>
          	       	    </div>
          	       	    <div class="form-group">
          	       	    	<div class="label"><label>状态</label></div>
          	       	    	<div class="field">
          	       	    		<select id="target" name="selectStyle" class="input">
                    		    <option value="4">查询全部</option>
                    		    <option value="3">查询未完成</option>
                    		    <option value="2">查询待赔付</option>
                    		    <option value="1">查询待修改</option>
                    		    <option value="0">查询待审核</option>
                    	        </select>
          	       	    	</div>
          	       	    </div>
          	       	    <input type="submit" value="查询" class="button bg-main">
					</div>
				
			</div>
			
			
			</div>
			
		</form>
	
	</div>
	<div class="line">
	   <div class="panel margin-small">
					<div class="panel-head ">
          		     查询结果
          		   </div>
          	       <div class="panel-body">
          	       	 <iframe name="frame1" width="100%" style="height: 500px;">
          	       	 	
          	       	 </iframe>
          	       </div>
       </div>
	
	</div>
	
    <script>
   	 $('.datetimepicker').datetimepicker();
	</script>
</body>

</html>
