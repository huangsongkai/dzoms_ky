<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.vehicle.newcheck.CheckRecord" %><%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-4-18
  Time: 下午4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
   	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
    <script>
        function repass(id, notshow){
            if(notshow){
                alert("该车不需要复检");
            }else{
                var reason = prompt("请输入复检记录");
                $.post("/DZOMS/check/rePass", {"checkRecord.id":id,"reason":reason},function(data){
                    $("#form",parent.document).submit();
                });
            }
        }
    </script>
    <style>
    	#test{min-height:250px;overflow-y:auto;max-height:450px;}
    </style>
</head>
<body>
	<div class="panel" style="450px" id="test">
		 <%List<CheckRecord> checkRecords = (List<CheckRecord>) request.getAttribute("records");%>
    <table class="table table-bordered table-hover table-striped">
        <tr>
            <th>车牌号</th>
            <th>部门</th>
            <th>承包人</th>
            <th>是否通过</th>
            <th>是否复检</th>
            <th>检车人</th>
            <th>检车时间</th>
            <th>录入人</th>
            <th>录入时间</th>
            <th>企业联检</th>
            <th>复检</th>
        </tr>
    <%for(CheckRecord record:checkRecords){%>
        <tr>
            <td><%=record.getLicenseNum()%></td>
            <td><%=record.getDept()%></td>
            <td><%=record.getDriver()%></td>
            <td><%=record.getIsPassed()?"是":"否"%></td>
            <td><%=record.getIsPassed()?"不需要复检":(record.getRepass()?"已复检":"未复检")%></td>
            <td><%=record.getRecorder()%></td>
            <td><%=record.getRecordTime()%></td>
            <td><%=record.get_recorder()%></td>
            <td><%=record.get_recordTime()%></td>
            <td><%=record.getTogether()?"是":"否"%></td>
            <td><input type="button" class="button bg-blue" onclick="repass(<%=record.getId()%>,<%=record.getIsPassed()||record.getRepass()%>)" value="复检"></td>
        </tr>
    <%}%>
    </table>
	</div>
   
</body>
</html>
