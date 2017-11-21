<%@ page language="java" import="java.util.*,com.dz.module.driver.praise.*" pageEncoding="UTF-8"%>
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
    <title>驾驶员登记</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>媒体管理</li>
                <li>查看媒体荣誉</li>
              
        </ul>
</div>
<div class="line">
    <form method="post" name="addGroupPraise" action="addGroupPraise" style="width: 100%;">
    	<div id="driverlist"></div>
    	<div class="line">
    		<div class="panel xm11 margin-small">
    			<div class="panel-head">查看媒体荣誉</div>
    			<div class="panel-body">
    		<table class="table">
            <tr>
                <td style="text-align: right;"><strong>表扬时间</strong></td>
                <td style="text-align: left;"><s:textfield cssClass="input input-auto" size="15" value="%{bean[0].praiseTime}" /></td>
            </tr>
            <tr>
                <td style="text-align: right;"><strong>表扬类型</strong></td>
                <td> <s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(bean[0].praiseClass,'praiseClass1')}"/>
                	<s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(bean[0].praiseClass,'praiseClass2')}"/>
                	<s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(bean[0].praiseClass,'praiseClass3')}"/>
                	<s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(bean[0].praiseClass,'praiseClass4')}"/></td>
                <td style="text-align: right;"><strong>分值</strong></td>
                <td><s:textfield cssClass="input input-auto float-left" size="5" value="%{bean[0].grade}"/></td>
            </tr>
            <tr>
                <td style="text-align: right;"><strong>表扬内容</strong></td>
                <td colspan="5"><s:textarea rows="5" cssClass="input" value="%{bean[0].praiseReason}"></s:textarea> </td>
            </tr>
        </table>
    				
    			</div>
    		</div>
    	</div>
    </form>
   </div>
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
                                <th style="width:15%;">车队名称</th>
                                <th style="width:15%;">分公司归属</th>
                            </tr>
                            <%
	request.setAttribute("quate","'");
	request.setAttribute("GroupPraiseClass", GroupPraiseDriver.class);
%>
<s:set name="hql" value="%{' groupPraiseId='+#request.quate+bean[0].id+#request.quate}"></s:set>
<s:set name="list" value="@com.dz.common.other.ObjectAccess@query(#request.GroupPraiseClass,#hql)"></s:set>
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
</div>
</body>
</html>