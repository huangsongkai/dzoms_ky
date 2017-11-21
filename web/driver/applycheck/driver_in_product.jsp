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
<title>驾驶员基本信息</title>


<style>
.table-d table{border:1px solid;border-collapse: collapse}
.table-d table td{border:1px solid ;}
  p{margin:0px}
  td{height:46px;}
  
</style>
<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
//$(document).ready(function(){
//	window.print();
//	setTimeout("window.close();",1000);
//});
</script>
</head>

<body style="font-size:18px;">
<%! int year = new java.util.Date().getYear()+1900;%>
<%! int month = new java.util.Date().getMonth()+1;%>
<%! int day = new java.util.Date().getDate();%>
	
    
   
<div style="width:900px" class="table-d">       
<h1 style="text-align: center;margin: 0px;">
            哈尔滨大众交通运输有限责任公司</h1>
<h1 style="text-align: center;margin: 0px;">聘用出租车汽车驾驶员申请表 </h1>
       
             <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0"> 
                <tr>
                   <td width="20%"><div align="center">
                     <p>&nbsp;</p>
                     <p>申请人姓名</p>
                   </div></td>
                   <td colspan="3"><div align="center"><s:property value="driver.name" /></div></td>
                    <td width="8%"><div align="center">
                      <p>&nbsp;</p>
                      <p>性别</p>
                  </div></td>
                    <td colspan="2"><div align="center"><s:property value="%{driver.sex?'男':'女'}" /></div></td>
                    <td width="16%"><div align="center">
                      <p>&nbsp;</p>
                      <p>承包人签字</p>
                    </div></td>
                    <td width="21%">&nbsp;</td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>户籍所在地</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="driver.accountLocation" /></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>聘用驾驶员电话</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="driver.phoneNum1" /></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>家庭现住址</p>
                    </div></td>
                    <td colspan="4"><s:property value="driver.address" /></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>服务保证金</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="driver.fuwubaozhengjin"/></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>身份证号</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="driver.idNum"/></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>政治面貌</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="driver.politicalStatus" /></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>兴趣爱好、特长、微信号</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="driver.hobby" />&nbsp;<s:property value="driver.specialty" />&nbsp;<s:property value="driver.qq" /></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>受过何种表彰</p>
                    </div></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>安全服务事故记录</p>
                    </div></td>
                    <td colspan="4"><div align="center">
                      <p>&nbsp;</p>
                      <p>有 □&nbsp;&nbsp;无□
                      </p>
                    </div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>违章记录</p>
                    </div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>有 □&nbsp;&nbsp;无 □
                      </p>
                    </div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>驾驶证初领日期</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="driver.drivingLicenseDate"/></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>驾驶证档案号</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="driver.drivingLicenseNum"/></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>资格证初领日期</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="driver.qualificationDate"/></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>资格证号</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="driver.qualificationNum"/></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>家庭成员姓名</p>
                      <p>工作单位、电话</p>
                    </div></td>
                    <td colspan="8"><s:iterator value="families" var="v">
                                	<p>
                                			<s:property value='%{#v.role}'/>
                                		&nbsp;
                                			<s:property value='%{#v.name}'/>
                                		&nbsp;
                                			<s:property value='%{#v.phoneNum}'/>
                                		&nbsp;
                                			<s:property value='%{#v.work}'/>
                                	</p>
                                </s:iterator></td>

                </tr>
                <tr>
                    <td ><div align="center">
                      <p>&nbsp;</p>
                      <p>是否从事过出租车</p>
运营</div></td>
                    <td colspan="4"><div align="center">
                      <p>&nbsp;</p>
                      <p>是
                      	<s:if test="%{driver.taxiExperience}">
                      		 √
                      	</s:if>
                      	<s:else>
                      		 □
                      	</s:else>
                        
<s:if test="%{driver.taxiExperience}">共<u><s:property value='%{driver.taxiExperienceYears}'/></u>年</s:if>     否
<s:if test="%{driver.taxiExperience}">
                      		 □
                      	</s:if>
                      	<s:else>
                      		 √
                      	</s:else>
                      </p>
                    </div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>原所在公司、车号</p>
                    </div></td>
                    <td colspan="2">
                    <div align="center">
                      <p></p>
                      <p><s:property value='%{driver.oldCompany}'/>&nbsp;&nbsp;<s:property value='%{driver.oldLicenseNum}'/></p>
                    </div>
                    </td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>申请驾驶车辆牌号</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="%{driver.applyLicenseNum=='黑A'?'':driver.applyLicenseNum}"/></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>车型</p>
                    </div></td>
                    <td colspan="2">
                    	<div align="center">
                    	<%
                    		request.setAttribute("quate","'");
                    	%>
                    	<s:if test="%{driver.applyLicenseNum!=null&&driver.applyLicenseNum!=''&&driver.applyLicenseNum!='黑A'}">
                    		<s:set name="vehicle" value="@com.dz.common.other.ObjectAccess@execute('from Vehicle where state!=2 and licenseNum='+#request.quate+driver.applyLicenseNum+#request.quate)"></s:set>
                    		<s:if test="%{#vehicle!=null}">
                    			<s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#vehicle.carMode).fuel}"/>
                    		</s:if>
                    	</s:if>
                    	</div>
                    	
                    </td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>申请事项</p>
                    </div></td>
                    <td colspan="8"><div align="center">
                      <p>&nbsp;</p>
                      <p>
     新包车<s:if test="driver.applyMatter=='新包车'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
       转租<s:if test="driver.applyMatter=='转租'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
	驾驶员<s:if test="driver.applyMatter=='驾驶员'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
      </p>
                    </div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>驾驶员属性</p>
                    </div></td>
                    <td colspan="4"><div align="center">
                      <p>&nbsp;</p>
                      <p >
正驾<s:if test="driver.driverClass=='正驾'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
副驾<s:if test="driver.driverClass=='副驾'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
三驾<s:if test="driver.driverClass=='三驾'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
临驾<s:if test="driver.driverClass=='临驾'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
                      </p>
                    </div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>作息时间</p>
                    </div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>
白班<s:if test="driver.restTime=='白班'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
夜班<s:if test="driver.restTime=='夜班'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
大班<s:if test="driver.restTime=='大班'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
替班<s:if test="driver.restTime=='替班'">√</s:if><s:else>□</s:else>&nbsp;&nbsp;
                      </p>
                  </div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>交班时间</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="%{driver.shiftTime}"/></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>交班地点</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="%{driver.shiftLocation}"/></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>加油地点</p>
                    </div></td>
                    <td colspan="4"><div align="center"><s:property value="%{driver.fuelLocation}"/></div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>营运场站</p>
                    </div></td>
                    <td colspan="2"><s:property value="%{driver.operatingStation}"/></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>语言表达能力</p>
                    </div></td>
                    <td colspan="4"><div align="center">
                      <p>&nbsp;</p>
                      <p>
                      	<s:property value="%{driver.languageAbility}"/>
                      </p>
                    </div></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>对哈市熟悉程度</p>
                    </div></td>
                    <td colspan="2"><div align="center"><s:property value="%{driver.cityFamiliarty}"/></div></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>现场验车</p>
                    </div></td>
                    <td colspan="4"></td>
                    <td colspan="2"><div align="center">
                      <p>&nbsp;</p>
                      <p>运营管理部</p>
                    </div></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>考试成绩</p>
                    </div></td>
                    <td width="6%"><div align="center">
                      <p>&nbsp;</p>
                      <p>一次</p>
                    </div></td>
                    <td width="6%"></td>
                    <td width="6%"><div align="center">
                      <p>&nbsp;</p>
                      <p>二次</p>
                    </div></td>
                    <td></td>
                    <td width="7%"><div align="center">
                      <p>&nbsp;</p>
                      <p>三次</p>
                    </div></td>
                    <td width="10%"></td>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>考核人签字</p>
                    </div></td>
                    <td></td>
                </tr>
                <tr>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>考评情况</p>
                    </div></td>
                    <td colspan="5"><div align="left">
                      <p>&nbsp;</p>
                      <p>运营管理部</p>
                    </div></td>
                    <td colspan="2"><div align="left">
                      <p>&nbsp;</p>
                      <p>综合办公室</p>
                    </div></td>
                    <td><div align="left">
                      <p>&nbsp;</p>
                      <p>计财部</p>
                    </div></td>
                </tr>
                <tr>
                    <td><p align="center">&nbsp;</p>
                      <p align="center">主管副总经理</p>
                  <p align="center">意 见</p></td>
                    <td colspan="6"></td>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>证照经办人</p>
                  </div></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td rowspan="3"><div align="center">
                      <p>&nbsp;</p>
                      <p>家访工作纪录</p>
                    </div></td>
                    <td colspan="6" rowspan="3" ></td>
                    <td><div align="center">
                      <p>&nbsp;</p>
                      <p>证照办结时间 </p>
                    </div></td>
                    <td></td>
                </tr>
                <tr style="border:black;border: 1px;">
                  <td><div align="center">
                    <p>&nbsp;</p>
                    <p>证照领取人</p>
                    <p>签字</p>
                  </div></td>
                  <td></td>
                </tr>
                <tr></tr>
            </table>
            <div style="height: 20px;"></div>
            <div align="left" style="float: left;width: 300px;">申请日期：<%=year%>年<%=month%>月<%=day%>日</div>
            <div align="center" style="float:left;width: 300px;" ><s:property value="%{driver.dept}"/></div>
            <div align="right" style="float: right;">录入人：尹丽波</div>
 </div>
</body>
</html>