<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.vehicle.VehicleApproval,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>添加表扬信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>

<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
//	$(document).ready(function(){
//		var jsonStr = $("#praiseFromIn").val();
//		var json = $.parseJSON(jsonStr);
//		for(var key in json){
//			$('input[name="'+key+'"]').val(json[key]);
//		}
//	});
	
	$(document).ready(function(){
		var praiseObject = '<s:property escape="false" value="%{praise.praiseFromIn}"/>';
		var json = $.parseJSON(praiseObject);
		
		$('input[name="praiseFromIn3"]').val(json["praise.praiseFromIn"]);
		$('input[name="praiseFromIn2"]').val(json["praiseFromIn3"]);
		$('input[name="praise.praiseFromIn"]').val(json["praiseFromIn2"]);
	});
</script>
</head>
<body>
    <div class="adminmin-bread">
        <ul class="bread">
            <li><a href="" class="icon-home"> 开始</a></li>
            <li>表扬落实</li>
        </ul>
    </div>
    
    <form name="dealpraise" action="/DZOMS/driver/praise/dealPraise" method="post">
        <s:hidden name="praise.id"/>
        <div class="container">
            <table class="table table-hover">
                <tr>
                    <td class="tableleft">表扬时间</td>
                    <td><s:textfield cssClass="datetimepicker input" type="text" name="praise.praiseTime" /></td>
                    <!--<td class="tableleft">表扬类别</td>
                    <td>
                        <s:textfield cssClass="input" name="praise.praiseClass"></s:textfield>
                    </td>-->
                    <!--<td class="tableleft ">表扬类型</td>
                    <td>
                    	<s:textfield cssClass="input" name="praise.praiseType"></s:textfield>
                    </td>-->
                </tr>
                <tr>
                    <td class="tableleft">表扬项目</td>
                    <td colspan="4">
                    	<%--
                    	<s:hidden name="praise.praiseObject" id="praiseObject"></s:hidden>
                    	--%>
                        <s:textfield cssClass="input" id="praiseObject_show" value="%{@com.dz.common.tablelist.TableListService@getFathersValueString(praise.praiseClass)}"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td class="tableleft">信息来源</td>
                    <td style="white-space: nowrap">
                        <s:textfield cssClass="input" name="praise.praiseFromOut"></s:textfield>
                    </td>
                    <td class="tableleft">姓名</td>
                    <td><s:textfield cssClass="input" name="praiseFromIn3">
                    </s:textfield></td>
                    <td class="tableleft">电话</td>
                    <td><input class="input" name="praiseFromIn2"/></td>
                    <td class="tableleft">手机</td>
                    <td><s:textfield cssClass="input" name="praise.praiseFromIn"/></td>
                </tr>
                <tr>
                	<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',praise.idNum)}"></s:set>
                	<s:set name="t_vehicle" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#t_driver.carframeNum)}"></s:set>
                    <td class="tableleft">车牌号</td>
                    <td>
                        <s:textfield cssClass="input" value="%{#t_vehicle.licenseNum}">
                        </s:textfield>
                    </td>
                    <td class="tableleft">司机</td>
                    
                    <td>
                    	<s:textfield cssClass="input" name="idNum" value="%{#t_driver.name}"/></td>
                    <td class="tableleft">电话</td>
                    <td><s:textfield cssClass="input" name="telephone" value="%{#t_driver.phoneNum1}"/></td>
                    <td class="tableleft">分公司归属</td>
                    <td><s:textfield cssClass="input" name="company" value="%{#t_vehicle.dept}"/></td>
                </tr>
                <tr>
                    <td class="tableleft">表扬人姓名</td>
                    <td><s:textfield cssClass="input" name="praise.praisePersonName"/></td>
                    <!--<td class="tableleft">表扬任性别</td>
                    <td>
                        <s:textfield cssClass="input" value="%{praise.praisePersonSex?'男':'女'}">
                        </s:textfield>
                    </td>-->
                    <td class="tableleft">表扬人电话</td>
                    <td><s:textfield cssClass="input" name="praise.praisePersonPhone"/></td>
                    <td class="tableleft">发票号</td>
                    <td><s:textfield cssClass="input" name="praise.ticketNumber"/></td>
                </tr>
                
                <tr>
                    <td>表扬内容</td>
                    <td colspan="7">
                        <s:textarea rows="5" cssClass="input" placeholder="多行文本框" name="praise.praiseContext"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td>表扬登记人</td>
                    <td><s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',praise.registrant).uname}"/></td>
                    <td colspan="3"></td>
                    <td>表扬登记时间</td>
                    <td><s:textfield cssClass="input" name="praise.registTime"/></td>
                </tr>
               <!--<tr>
                    <td>确认结果</td>
                    <td colspan="7">
                        <s:textfield rows="5" cssClass="input" value="真实"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td>确认人</td>
                    <td>
                    	<s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',praise.confirmPerson).uname}"/>
                    </td>
                    <td colspan="3"></td>
                    <td>确认时间</td>
                    <td><s:textfield cssClass="input" name="praise.confirmTime" readonly="readonly" /></td>
                </tr>
               -->
                <!--<tr>
                    <td>落实结果</td>
                    <td colspan="7">
                        <s:textarea rows="5" cssClass="input" placeholder="多行文本框" name="praise.dealReault"></s:textarea>
                    </td>
                </tr>-->
                <tr>
                	<td class="tableleft">分值</td>
                    <td><s:textfield cssClass="input" name="praise.grade"/></td>
                </tr>
                <tr>
                    <td>落实负责人</td>
                    <td><input class="input"  value="<%=((User)session.getAttribute("user")).getUname()%>"/>
                    <input type="hidden" name="praise.dealPerson" value="<%=((User)session.getAttribute("user")).getUid()%>"/></td>
                        
                    <td colspan="3"></td>
                    <td>落实时间</td>
                    <td><input  class="datepick input" name="praise.dealTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/></td>
                </tr>
                <tr>
                    <td colspan="6"> <div class="form-button"><button class="button bg-green" type="submit">录入</button></div></td>
                    <!--<td> <div class="form-button"><button class="button">退出</button></div></td>-->
                </tr>
            </table>
        </div>
    </form>
     <script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</body>
</html>
