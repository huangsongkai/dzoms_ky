<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>申请信息</title> 
</head>
<body>
<form name="fm" id="fm" action="${pageContext.request.contextPath}/start">
	<table border="1">
		<tr>
			<td>请假类型：</td>
			<td>
				<select name="fp_leaveType">
					<option>公休</option>
					<option>调休</option>
					<option>事假</option>
					<option>婚假</option>
					<option>病假</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>请假开始时间：</td>
			<td><input type="text" id="startTime" name="fp_startTime" class="datetime required" /></td>
		</tr>
		<tr>
			<td>请假结束时间：</td>
			<td><input type="text" id="endTime" name="fp_endTime" class="datetime required" /></td>
		</tr>
		<tr>
			<td>理由：</td>
			<td>
				<textarea id="reason" name="fp_reason"></textarea>
			</td>
		</tr>
	</table>
	<div>
		<table style="margin: auto" width="600">
			<tr>			
				<td align="right" >
					<input type="submit"  value="下一步" />
				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>