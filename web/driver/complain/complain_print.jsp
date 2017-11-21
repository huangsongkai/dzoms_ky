<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>举报投诉、乘客受理记录</title>
<style>
.table-d table{border:1px solid;border-collapse: collapse}
.table-d table td{border:1px solid ;font-size:17px;
                }
  p{margin:0px}
  td{height:50px;}

</style>
<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
$(document).ready(function(){
	window.print();
	setTimeout("window.close();",1000);
});
</script>
</head>

<body>
	<div style="width:650px" class="table-d">
<div style="width:100%" align="center" class="table-d"> 
	<div style="height: 80px;"></div>
<h2 style="text-align: center;margin: 30px;">
            举报投诉、乘客受理记录</h2>
       <s:set name="car" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',complain.vehicleId)}"></s:set>
       <s:set name="d" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',complain.dealReault)}"></s:set>
             <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0"> 
                <tr>
                   <td width="10%"><div align="center">
                     <p>&nbsp;</p>
                     <p>受理</p>
                     <p>时间</p>
                     <p>&nbsp;</p>
                   </div>
                   </td>
                   <td width="15%">
                   	<div align="center">
                   		<s:date name="complain.complainTime" format="yyyy/MM/dd HH:mm:ss"/>
                   	</div>
                   </td>
                    <td width="10%">
                      <div align="center">
                      <p>&nbsp;</p>
                      <p>接待人</p>
                      <p>&nbsp;</p>
                      </div>
                    </td>
                    <td width="15%"><div align="center"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',complain.registrant).uname}"/></div></td>
                    <td width="10%"><div align="center">
                    <p>&nbsp;</p>
                      <p>涉及</p>
                      <p>车辆</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td width="15%" align="center"><s:property value="%{#car.licenseNum}"/></td>
                    <td width="10%"><div align="center">
                     <p>&nbsp;</p>
                      <p>涉及</p>
                      <p>驾驶员</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td width="15%"  align="center"><s:property value="%{#d.name}"/></td>
                </tr>
                <tr>
                    <td><div align="center">
                     
                      <p>投诉人</p>
                    </div></td>
                    <td><div align="center"><s:property value="complain.complainPersonName" /></div></td>
                    <td><div align="center">
                      
                      <p>性别</p>
                    </div></td>
                    <td><div align="center"><s:property value="%{complain.complainPersonSex?'男':'女'}" /></div></td>
                    <td><div align="center">
                   
                      <p>联系电话</p>
                    </div></td>
                    <td colspan="3"><s:property value="complain.complainPersonPhone" /></td>
                </tr>
                <tr>
                    <td ><div align="center">
                      <p>&nbsp;</p>
                      <p>反</p>
                      <p>映</p>
                      <p>事</p>
                      <p>项</p>
                      <p>简</p>
                      <p>述</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td colspan="7" ><div align="center">投诉类型：<s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(complain.complainObject,'complain.complainObject')}"/></div></td>
                </tr>
                <tr>
                    <td ><div align="center">
                      <p>&nbsp;</p>
                      <p>调</p>
                      <p>查</p>
                      <p>核</p>
                      <p>实</p>
                      <p>情</p>
                      <p>况</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td  colspan="7"><div align="center">
                    	<p>&nbsp;</p>
                    	<p><s:property value="%{complain.state>0?'属实':'不属实'}"/></p>
                    	<p>&nbsp;</p>
<!--                    	<p><s:property value="%{complain.dealContext}"/></p>
-->                    </div></td>
                </tr>
                <tr>
                    <td ><div align="center">
                      <p>&nbsp;</p>
                      <p>处</p>
                      <p>理</p>
                      <p>结</p>
                      <p>果</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td  colspan="7"><div align="center">
                      <p>&nbsp;</p>
                      <p><s:property value="%{complain.dealContext}"/>
                      </p><p>&nbsp;</p>
                    </div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>办结时间</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td colspan="5"><div align="center"><s:date name="%{complain.confirmTime}" format="yyyy/MM/dd HH:mm:ss"/></div></td>
                    <td ><div align="center">
                      <p>&nbsp;</p>
                      <p>办理人</p>
                      <p>&nbsp;</p>
                    </div></td>
                    <td ><div align="center"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',complain.confirmPerson).uname}"/></div></td>
                </tr>
                <tr></tr>
           </table>
           <div style="height: 20px;"></div>
           <p align="left">负责人签字：</p>
 </div>
 </div>
</body>
</html>