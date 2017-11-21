<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>申请信息</title> 
</head>
<body>
<form name="form1" id="form1" action="${pageContext.request.contextPath}/approve">

<table border="1" class='view-info'>
	<tr>
		<td width="150" class="label">申请人：</td>
		<td  name="userId">
		<input type="hidden" name="id" value="${leave.id}">
		<input type="text" style="border:0" readOnly="true" name="userId" value="${leave.userId}"/></td>
	</tr>
	<tr>
		<td class="label">请假类型：</td>
		<td name="leaveType"><input type="text" style="border:0" readOnly="true" name="leaveType" value="${leave.leaveType}"/></td>
	</tr>
	<tr>
		<td class="label">请假<font color="red">开始</font>日期：</td>
		<td name="startTime"><input type="text" style="border:0" readOnly="true" name="startTime" value="${leave.startTime}"/></td>
	</tr>
	<tr>
		<td class="label">请假<font color="red">结束</font>日期：</td>
		<td name="endTime"><input type="text" style="border:0" readOnly="true" name="endTime" value="${leave.endTime}"/></td>
	</tr>
	<tr>
		<td class="label">理由：</td>
		<td name="reason"><input type="text" style="border:0" readOnly="true" name="reason" value="${leave.reason}"/></td>
	</tr>
	<tr>
		<td class="label">是否同意：</td>
		<td>
			<select id="result" name="deptLeaderPass">
				<option value="true">同意</option>
				<option value="false">驳回</option>
			</select>
		</td>
	</tr>
	<tr id="leaderBackReasonTr">
		<td class="label">意见：</td>
		<td>
			<textarea id="advice" name="advice"></textarea>
		</td>
	</tr>
	<tr>			
			<td align="center">
			<input type="submit"  value="保存" />
			</td>
		</tr>
</table>
</form>
</body>
</html>