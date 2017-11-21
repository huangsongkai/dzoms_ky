<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印营运信息</title>

<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
$(document).ready(function(){
	window.print();
	setTimeout("window.close();",10000);
});
</script>
</head>
<style>
.table-d table{border:1px solid;border-collapse: collapse}
.table-d table td{border:1px solid ;}
  p{margin:0px}
</style>
<body style="font-size:18px;">
<%! int year = new java.util.Date().getYear()+1900;%>
<%! int month = new java.util.Date().getMonth()+1;%>
<%! int day = new java.util.Date().getDate();%>
<div style="width:900px" class="table-d">
<h2 align="center">哈尔滨市出租汽车经营证照（人员变更）审批表</h2>
<h4 align="right"><%=year%>年<%=month%>月<%=day%>日</h4>
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0"> 
  <tr>
    <td height="40" colspan="2"><div align="center">待办单位</div></td>
    <td width="17%" height="40"><div align="center">大众公司</div></td>
    <td width="17%" height="40"><div align="center">经手人</div></td>
    <td height="40" colspan="3"> <div align="center">王晓华</div></td>
  </tr>
  <%
  	request.setAttribute("carframeNum", request.getParameter("carframeNum"));
  %>
  <s:set name="v" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#request.carframeNum)}"></s:set>
  <tr>
    <td height="40" colspan="2"><div align="center">车牌号</div></td>
    <td width="17%" height="40"><div align="center"><s:property value="%{#v.licenseNum}"/></div></td>
    <td width="17%" height="40"><div align="center">营运证号</div></td>
    <td width="17%" height="40"><div align="center"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.BusinessLicense',#v.businessLicenseId).licenseNum}"/></div></td>
    <td width="17%" height="40"><div align="center">车型</div></td>
    <td width="17%" height="40"><div align="center"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#v.carMode).brand}"/></div></td>
  </tr>
  <tr>
  <%
  	int type1 = Integer.parseInt(request.getParameter("type1"));
  	int type2 = Integer.parseInt(request.getParameter("type2"));
  	request.setAttribute("type1",type1);
  	request.setAttribute("type2",type2);
  %>
   <%
  	request.setAttribute("down1Driver", request.getParameter("down1Driver"));
  	request.setAttribute("down2Driver", request.getParameter("down2Driver"));
  	request.setAttribute("down3Driver", request.getParameter("down3Driver"));
  	request.setAttribute("up1Driver", request.getParameter("up1Driver"));
  	request.setAttribute("up2Driver", request.getParameter("up2Driver"));
  	request.setAttribute("up3Driver", request.getParameter("up3Driver"));
  %>
    <td height="40" colspan="2"><div align="center">发放证照</div></td>
    <td height="40" colspan="5"> 
      &nbsp;添加驾驶员  <s:if test="%{#request.type1==1}">☑</s:if><s:else> □</s:else> 
      &nbsp;注销驾驶员  <s:if test="%{#request.type1==2}">☑</s:if><s:else> □</s:else> 
      &nbsp;更换驾驶员  <s:if test="%{#request.type1==3}">☑</s:if><s:else> □</s:else> 
    </td>
    </tr>
  <tr>
    <td height="40" colspan="2"><div align="center">补发证照</div></td>
    <td height="40" colspan="5">
      &nbsp; &nbsp;营运证 &nbsp; &nbsp;<s:if test="%{#request.type2==1}">☑</s:if><s:else> □</s:else> 
      &nbsp; &nbsp;准驾证 &nbsp; &nbsp;<s:if test="%{#request.type2==2}"><☑</s:if><s:else> □</s:else> 
      电子营运证<s:if test="%{#request.type2==3}">☑</s:if><s:else> □</s:else> 
    </td>
    </tr>
  <tr>
    <td width="4%">
      <p align="center">申</p>
      <p align="center">办</p>
      <p align="center">理</p>
      <p align="center">由</p>
      <p align="center">及</p>
      <p align="center">证</p>
      <p align="center">明</p>
      <p align="center">材</p>
      <p align="center">料</p></td>
    <td colspan="6"  align="left">
    	<p>&nbsp;</p>
    	<s:if test="%{#request.up1Driver!=''||#request.up2Driver!=''||#request.up3Driver!=''}">
    		<p>新增：
    			<s:if test="%{#request.up1Driver!=''}">&nbsp;&nbsp;主驾</s:if>
    			<s:if test="%{#request.up2Driver!=''}">&nbsp;&nbsp;副驾</s:if>
    			<s:if test="%{#request.up3Driver!=''}">&nbsp;&nbsp;三驾</s:if>
    		</p>
    	</s:if>
    	<s:if test="%{#request.down1Driver!=''||#request.down2Driver!=''||#request.down3Driver!=''}">
    		<p>注销：
    			<s:if test="%{#request.down1Driver!=''}">&nbsp;&nbsp;主驾</s:if>
    			<s:if test="%{#request.down2Driver!=''}">&nbsp;&nbsp;副驾</s:if>
    			<s:if test="%{#request.down3Driver!=''}">&nbsp;&nbsp;三驾</s:if>
    		</p>
    	</s:if>
    </td>
    </tr>
  <tr>
    <td rowspan="3">
      <p align="center">注</p>
      <p align="center">销</p>
      <p align="center">驾</p>
      <p align="center">驶</p>
      <p align="center">员</p>
  
    <td width="11%" height="40"><p align="center"> 承 包 人 </p>
      <p align="center">( 车 主 ）</p></td>
    <td height="40"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.down1Driver).name}"/>&nbsp;</td>
    <td height="40"><div align="center">资格证号</div></td>
    <td colspan="3"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.down1Driver).qualificationNum}"/>&nbsp;</td>
    </tr>
  <tr>
    <td width="11%" height="40"><div align="center">副驾驶员姓名</div></td>
    <td height="40"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.down2Driver).name}"/>&nbsp;</td>
    <td height="40"><div align="center">资格证号</div></td>
    <td colspan="3"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.down2Driver).qualificationNum}"/>&nbsp;</td>
    </tr>
  <tr>
    <td width="11%" height="40"><div align="center">三驾驶员姓名</div></td>
    <td height="40"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.down3Driver).name}"/>&nbsp;</td>
    <td height="40"><div align="center">资格证号</div></td>
    <td colspan="3"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.down3Driver).qualificationNum}"/>&nbsp;</td>
    </tr>
  <tr>
    <td rowspan="2"><p align="center">新</p>
      <p align="center">增</p>
      <p align="center">补</p>
      <p align="center">发</p>
      <p align="center">驾</p>
      <p align="center">驶</p>
      <p align="center">员</p></td>
    <td height="60"><p align="center">承 包 人 </p>
      <p align="center">( 车 主 ）</p></td>
    <td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.up1Driver).name}"/>&nbsp;</td>
    <td><div align="center">资格证号</div></td>
    <td colspan="3"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.up1Driver).qualificationNum}"/>&nbsp;</td>
    </tr>
  <tr>
    <td height="60"><div align="center">副驾驶员姓名</div></td>
    <td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.up2Driver).name}"/>&nbsp;</td>
    <td><div align="center">资格证号</div></td>
    <td colspan="3"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.up2Driver).qualificationNum}"/>&nbsp;</td>
  </tr>
  <tr>
    <td height="90" colspan="4"><div align="left">经办人：</div>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p align="right"><%=year%>年<%=month%>月<%=day%>日</p></td>
    <td colspan="3">
    <div align="left">经办人：</div>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p align="right"><%=year%>年<%=month%>月<%=day%>日</p>
    </td>
  </tr>
  </table>
<p>注：</p>
 <ol>
  <li>办理证照审批由各公司统一办理，非公司管理人员送审不予受理，无单位公章不予受理。</li>
  <li>经办人、科长未审核签章证照微机员不予受理。</li>
  <li>证照微机员打证后审批表返回证照管理员报关。</li>
  <li>办理证照或补发证照时在空格内化√</li>
</ol>
  <p>
</div>

</body>
</html>
