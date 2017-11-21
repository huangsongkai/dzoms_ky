<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.vehicle.newcheck.CheckRecord" %>
<%@ page import="com.dz.module.vehicle.newcheck.Group" %>
<%@ page import="com.dz.module.user.User" %>
<%@ page import="com.dz.module.vehicle.newcheck.UnPassDetail" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-14
  Time: 下午11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script>
	   function picture_show(x){
	  
	    $(x).next().toggle();	
	    }
</script>
</head>
<body>
<%String name = ((User)session.getAttribute("user")).getUname();%>
<%Object o = request.getAttribute("group");%>
<%if(o!=null){%>
<%Group group = (Group)o;%>
<table class="table table-bordered table-hover table-striped">
  <tr>
    <th>车牌号</th>
    <th>承包人</th>
    <th>部门</th>
    <th>是否通过</th>
    <th>理由</th>
    <th>检车人</th>
    <th>检车时间</th>
    <th>违规详情</th>
    <%--<th>删除</th>--%>
  </tr>
  <%for(CheckRecord checkRecord:group.getCheckRecords()){%>
  <tr>
    <td><%=checkRecord.getLicenseNum()%></td>
    <td><%=checkRecord.getDriver()%></td>
    <td><%=checkRecord.getDept()%></td>
    <td><%=checkRecord.getIsPassed()?"是":"否"%></td>
    <td><%=checkRecord.getUnPassReason()%></td>
    <td><%=checkRecord.getRecorder()%></td>
    <td><%=checkRecord.getRecordTime()%></td>
    <td>
    	<div>
    		
    		
    		 <%if(checkRecord.getUnPassDetail() != null && checkRecord.getUnPassDetail().size() > 0){%>
    		 	  
    		 	  	<span onclick="picture_show(this)" class="button">查看详细</span>
    		 	  	<div style="display: none;">
    		 	  				<%for(UnPassDetail upd:checkRecord.getUnPassDetail()){%>
								         <div class="media">
									            <a href="#">
										             <img style="width: 60px;height: 60px;" src="${pageContext.request.contextPath}<%=upd.getUnPassPicture()%>" class="radius" alt="...">
									            </a>
									           <div class="media-body">
										         <strong><%=upd.getUnPassReason()%></strong> 
									           </div>
								         </div>
								     <%}%>
		          </div>
         <%}else{%>
    				<span>无</span>
    			<%}%>
      </div>
    </td>
  </tr>
  <%}%>
</table>
<%}%>
</body>
</html>
