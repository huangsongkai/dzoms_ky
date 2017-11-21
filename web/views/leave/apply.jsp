<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>申请信息</title> 
</head>
<body>
<form name="form1" id="form1" action="${pageContext.request.contextPath}/workflow/auto/task/complete/${taskId}/${processInstanceId}">
		<div style="margin: 0 auto;">${renderedTaskForm}</div> 
		 <input type="hidden" name="taskId"
			value="${taskId}">
			<input type="hidden" name="processInstanceId"
			value="${processInstanceId}">
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