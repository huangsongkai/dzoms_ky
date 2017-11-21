<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form action="http://localhost:8080/activitiDemo/start">
<%-- ${pageContext.request.contextPath}/start --%>
<table border="1">
		<tr>
			<td>请假类型：</td>
			<td>
				<select name="leaveType">
					<option>公休</option>
					<option>调休</option>
					<option>事假</option>
					<option>婚假</option>
					<option>病假</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>请假开始时间：</td><!-- 去掉fp_ -->
			<td><input type="text" id="startTime" name="startTime" /></td>
		</tr>
		<tr>
			<td>请假结束时间：</td>
			<td><input type="text" id="endTime" name="endTime"  /></td>
		</tr>
		<tr>
			<td>理由：</td>
			<td>
				<textarea id="reason" name="reason"></textarea>
			</td>
		</tr>					
		<tr>			
			<td align="center">
			<input type="submit"  value="保存" />
			</td>
		</tr>
		<tr>			
			<td align="center">
			<a href='http://www.baidu.com'>baidu</a>
			</td>
		</tr>							
	</table>
</form>