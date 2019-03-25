<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/common/global.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<form action="${ctx }/user/logon" method="get">
	<table>
		<tr>
			<td width="200" style="text-align: right;">UserName:</td>
			<td><input id="username" name="username" class="login-input" placeholder="用户名（见下左表）" /></td>
		</tr>
		<tr>
			<td style="text-align: right;">Password:</td>
			<td><input id="upwd" name="upwd" type="upwd" class="login-input" placeholder="默认为：000000" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<button type="submit">Login</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>