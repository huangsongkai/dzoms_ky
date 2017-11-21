<%@ page language="java" import="java.util.*,com.dz.module.user.User,com.dz.module.driver.activity.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>活动明细</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    <script type="text/javascript">
    
    </script>
    <style>
        .label{
            width: 120px;
            text-align: right;
        }
        .field{
            width: 200px;
        }
        .diy-lable{
            width: 120px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>活动</li>
                <li>活动明细</li>
              
        </ul>
    </div>
</div>
<form method="post" class="form-inline" name="addActivity" action="addActivity" enctype="multipart/form-data" style="width:100% ;">
	<div id="driverlist"></div>
    <div class="xm11 margin-small panel">
        <div class="panel-head">活动明细</div>
        <div class="panel-body">
        	 <div class="form-group margin-small">
            <div class="label"><label>活动日期</label></div>
            <div class="field">
            	<s:textfield cssClass="input" value="%{bean[0].activityTime}"></s:textfield>
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="label"><label>活动名称</label></div>
            <div class="field">
            <s:textfield cssClass="input" value="%{bean[0].activityName}"></s:textfield>
            </div>
        </div>

        <br>

        <div class="form-group margin-small">
            <div class="label"><label>类型</label></div>
            <div class="field">
            <s:textfield cssClass="input" value="%{bean[0].activityClass}"></s:textfield>
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="label"><label>分值</label></div>
            <div class="field">
            	<s:textfield cssClass="input" value="%{bean[0].grade}"></s:textfield>
            </div>
        </div>
        <br>

        <div class="margin-small float-left" style="width:330px">
            <div class="float-left" style="width: 120px;text-align: right;"><strong style="color: rgba(0, 0, 0, 0.99)">活动内容</strong></div>
            <div class="float-left">
            <s:textarea rows="5" cssClass="input" value="%{bean[0].activityContext}" cssStyle="width: 200px;"></s:textarea>
            </div>
        </div>

        <br>
        <div class="form-group margin-small" >
            <div class="label"><label>录入人</label></div>
            <div class="field">
            	<s:textfield cssClass="input" type="text" readonly="readonly" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',bean[0].registrant).uname}"></s:textfield>
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="label"><label>录入时间</label></div>
            <div class="field">
            	<s:textfield cssClass="input" value="%{bean[0].registTime}"></s:textfield>
            </div>
        </div>
        </div>
       
        
    </div>



</form>
<div class="line">
        <div class="xm5 margin-small">
            <div class="panel">
                <div class="panel-head">全部驾驶员</div>
                <div class="panel-body">

                    <div style="height: 500px;overflow: scroll">
                        <table class="table table-bordered" id="table1">
                            <tr>
                                <th style="width:20%;">车牌号</th>
                                <th style="width:10%;">驾驶员</th>
                                <th style="width:25%;">身份证号</th>
                                <th style="width:5%;">性别</th>
                                <th style="width:10%;">属性</th>
                                <!--<th>手机</th>-->
                                <th style="width:15%;">车队名称</th>
                                <th style="width:15%;">分公司归属</th>
                            </tr>
<%
	request.setAttribute("quate","'");
	request.setAttribute("ActivityClass", ActivityDriver.class);
%>
<s:set name="hql" value="%{' activityId='+#request.quate+bean[0].id+#request.quate}"></s:set>
<s:set name="list" value="@com.dz.common.other.ObjectAccess@query(#request.ActivityClass,#hql)"></s:set>
<s:iterator value="%{#list}" var="act">
	<tr>
	<s:set name="v" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#act.idNum)}"></s:set>
	<td><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
	<td><s:property value='%{#v.name}'/></td>
    <td><s:property value='%{#v.idNum}'/></td>
    <td><s:property value="%{#v.sex?'男':'女'}"/></td>
    <td><s:property value="%{#v.driverClass}"/></td>
    <td><s:property value="%{#v.team}"/></td>
    <td><s:property value="%{#v.dept}"/></td>
	</tr>
</s:iterator>
                        </table>
                    </div>
                </div>
            </div>

        </div>
        
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>

</html>