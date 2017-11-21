<%@ page import="java.util.Map"  pageEncoding="UTF-8" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
	String path=request.getContextPath();
	String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/";
%>
<%--导入错误的记录--%>
<s:if test="%{#request.errorMap!=null}">
	<div class="line">
		<div class="panel  margin-small">
			<div class="panel-head">
				<div class="float-left">
					<h4><strong class="text-black">导入失败的条目:</strong></h4>
				</div>

				<div style="text-align: right;">
					<a href="javascript:;" class="button border-main bg-yellow" data-click="panel-collapse"><i
							class="icon icon-minus text-white"></i></a>
					<a href="javascript:;" class="button border-main bg-red" data-click="panel-remove"><i
							class="icon icon-times text-white"></i></a>
				</div>

			</div>
			<div class="panel-body">

				<table id="errTable">
					<tr>
						<th>身份证号</th>
						<th>原因</th>
					</tr>
					<s:iterator value="#request.errorMap.keySet()" id="idNum">
						<tr>
							<td><s:property value="#idNum"/></td>
							<td><s:property value="#request.errorMap[#idNum]"/></td>
						</tr>
					</s:iterator>
				</table>
			</div>
		</div>
	</div>
</s:if>
<s:elseif test="%{#request.errorMsg!=null}">
	<p>${requestScope.errorMsg}</p>
</s:elseif>