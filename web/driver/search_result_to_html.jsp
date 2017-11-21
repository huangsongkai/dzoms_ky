<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<s:iterator value="%{#request.list}" var="v">
    <tr>
    	<td><input type="checkbox" name="driverlist" value="<s:property value='%{#v.idNum}'/>"></td>
            <td><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
            <td><s:property value='%{#v.name}'/></td>
            <td><s:property value='%{#v.idNum}'/></td>
            <td><s:property value="%{#v.sex?'男':'女'}"/></td>
            <td><s:property value="%{#v.driverClass}"/></td>
            <td><s:property value="%{#v.team}"/></td>
            <td><s:property value="%{#v.dept}"/></td>
    </tr>
</s:iterator>