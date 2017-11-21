<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印营运信息</title>

<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
<script>
$(document).ready(function(){
	window.print();
	setTimeout("window.close();",1000);
});
</script>
</head>
<style>
.table-d table{border:1px solid;border-collapse: collapse}
.table-d table td{border:1px solid ;}
  p{margin:0px}
  td{height:45px;}
  
</style>
<body style="font-size:18px;">
<%! int year = new java.util.Date().getYear()+1900;%>
<%! int month = new java.util.Date().getMonth()+1;%>
<%! int day = new java.util.Date().getDate();%>
<div style="width:900px" class="table-d">
<h1 align="center">聘用出租车驾驶员申请表</h1>
 <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0"> 
  <tr >
    <td colspan="2" style="border:0px">部门：<s:property value="%{driver.dept}"/></td>
    <td colspan="2" style="border:0px"><div align="right">申请日期：<%=year%>年<%=month%>月<%=day%>日</div></td>
    </tr>
  <tr>
    <td width="25%"><div align="center">
      <p>&nbsp;</p>
      <p>申请人姓名</p>
    </div></td>
    <td  width="25%"><s:property value="%{driver.name}"/></td>
    <td  width="25%"><div align="center">
      <p>&nbsp;</p>
      <p>推荐人姓名</p>
    </div></td>
    <td  width="25%">&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>申请驾驶车辆号码</p>
    </div></td>
    <td><s:property value="%{driver.applyLicenseNum=='黑A'?'':driver.applyLicenseNum}"/></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>聘用驾驶员电话</p>
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>家庭现住址</p>
    </div></td>
    <td>&nbsp;</td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>电子从业资格证</p>
    </div></td>
    <td><div align="center">
          <p>&nbsp;</p>
          <p>
           <span style="font-size: 22px;"> □</span>
          有
         <span style="font-size: 22px;"> □</span>
          无
          </p>
    </div></td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>是否从事过出租行业</p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>是
       <span style="font-size: 22px;"> □</span>
        共____年     否
       <span style="font-size: 22px;"> □</span>
      </p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>原所在公司、车号</p>
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>申请事项</p>
    </div></td>
    <td colspan="3"><div align="center">
      <p>&nbsp;</p>
      <p>
     新包车<s:if test="driver.applyMatter=='新包车'"> <span style="font-size: 22px;">☑</span></s:if><s:else> <span style="font-size: 22px;">□</span></s:else>&nbsp;&nbsp;
       转租<s:if test="driver.applyMatter=='转租'"> <span style="font-size: 22px;">☑</span></s:if><s:else> <span style="font-size: 22px;">□</span></s:else>&nbsp;&nbsp;
	驾驶员<s:if test="driver.applyMatter=='驾驶员'||driver.applyMatter=='临驾'"> <span style="font-size: 22px;">☑</span></s:if><s:else> <span style="font-size: 22px;">□</span></s:else>&nbsp;&nbsp;
      </p>
    </div></td>
    </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>驾驶员属性</p>
    </div></td>
    <td colspan="3"><div align="center">
      <p>&nbsp;</p>
      <p>正驾
       <span style="font-size: 22px;"> □</span> 
        副驾
       <span style="font-size: 22px;"> □</span>
临时 
<span style="font-size: 22px;"><s:if test="driver.applyMatter=='临驾'">☑</s:if><s:else>□</s:else></span>
      </p>
    </div></td>
    </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>作息时间</p>
    </div></td>
    <td colspan="3"><div align="center">
      <p>&nbsp;</p>
      <p>白班 
       <span style="font-size: 22px;"> □</span>
        夜班
       <span style="font-size: 22px;"> □</span>
大班 
<span style="font-size: 22px;">□</span>
替班
<span style="font-size: 22px;">□</span>
      </p>
    </div></td>
    </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>加油地点</p>
    </div></td>
    <td>&nbsp;</td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>交班地点</p>
    </div></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>婚姻状况</p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;        </p>
      <p>已婚
       <span style="font-size: 22px;"> □</span>
        未婚
       <span style="font-size: 22px;"> □</span>
      </p>
      <p>&nbsp;</p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>政治面貌</p>
    </div></td>
    <td><div align="center">
      <p>群众
       <span style="font-size: 22px;"> □</span>
团员
<span style="font-size: 22px;">□</span>
      </p>
      <p>党员 
       <span style="font-size: 22px;"> □</span>
        复原军人
       <span style="font-size: 22px;"> □</span>
      </p>
    </div></td>
  </tr>
  <tr style="height: 260px;">
    <td><div align="center">
      <p>&nbsp;</p>
      <p>家庭成员</p>
    </div></td>
    <td colspan="3">
    	<div align="center">
      <p>成员类型：_________________成员姓名：__________________</p>
       <p>&nbsp;</p>
      <p>工作单位：__________________电话：______________________</p>
       <p>&nbsp;</p>
        <p>成员类型：_________________成员姓名：__________________</p>
      <p>&nbsp;</p>
      <p>工作单位：__________________电话：______________________</p>
    </div>
    </td>
    </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>驾驶员身高</p>
    </div></td>
    <td>&nbsp;</td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>对哈市的熟悉程度</p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>一般
       <span style="font-size: 22px;"> □</span>
        熟悉
       <span style="font-size: 22px;"> □</span>
      </p>
    </div></td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>文化程度</p>
    </div></td>
    <td><div align="center">
      <p>初中
        <span style="font-size: 22px;"> □</span>
高中
  <span style="font-size: 22px;"> □</span>
      </p>
      <p>大学 
       <span style="font-size: 22px;"> □</span>
        大专
       <span style="font-size: 22px;"> □</span>
      </p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>语言表达能力</p>
      <p>（由审核人填写）</p>
    </div></td>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>一般
       <span style="font-size: 22px;"> □</span>
        良好
       <span style="font-size: 22px;"> □</span>
      </p>
    </div></td>
  </tr>
  <tr>
    <td><div align="center">
      <p>&nbsp;</p>
      <p>对从事出租车行业的</p>
      <p>自我评价及兴趣爱好</p>
    </div></td>
    <td colspan="3">&nbsp;</td>
    </tr>
  <tr style="height: 100px;">
    <td><div align="center">
      <p>&nbsp;</p>
      <p>分部经理意见</p>
    </div></td>
    <td colspan="3">&nbsp;</td>
    </tr>
</table>

<p>注：</p>
 <ol>
  <li>请字迹工整，规范填写</li>
  <li>请在背面驾驶员聘用协议上签字（*）。</li>
  <li>填写完毕后，将此表和（身份证，驾驶证，资格证，户口本）送到内勤窗口处。</li>
  <li>统一照一寸照片和人车照，并由分部经理进行面试审核。</li>
 </ol>
<p align="right">审核人：____________</p>
</div>

</body>
</html>
