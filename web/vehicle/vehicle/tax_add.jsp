<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.dz.common.other.*" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>新增购置税信息</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script src="/DZOMS/res/js/itemtool.js"></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<jsp:include page="/common/msg_info.jsp"></jsp:include>
	<script>
        $(document).ready(function(){
            $("#carframe_num").bigAutocomplete({
                url:"/DZOMS/select/vehicleById",
                condition:"taxNumber is null",
                doubleClick:true,
                doubleClickDefault:'LFV'
            });
        });

        $(document).ready(function(){
            $("#vehicle_taxFrom").bigAutocomplete({
                url:"/DZOMS/select/itemsOfvehicle_taxFrom",
                doubleClick:true,
                doubleClickDefault:''
            });
            //getList1('vehicle_purseFrom','vehicle_purseFrom');
        });

        $(document).ready(function(){
            $("#vehicle_taxMoney").bigAutocomplete({
                url:"/DZOMS/select/itemsOfvehicle_taxMoney",
                doubleClick:true,
                doubleClickDefault:''
            });
        });

        itemsDefault("#vehicle_taxFrom","vehicle_taxFrom");
        itemsDefault("#vehicle_taxMoney","vehicle_taxMoney");
	</script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
	<ul class="bread text-main" style="font-size: larger;">

		<li>车辆管理</li>
		<li>新增</li>
		<li>新增购置税信息</li>
	</ul>
</div>

<div class="xm5 xm2-move">
	<div class="alert alert-yellow padding">
		<span class="close rotate-hover"></span><strong>注意：</strong>录入购置信息前需要录入发票信息。</div>
	<div class="panel">
		<div class="panel-head">
			新增购置税信息
		</div>
		<div class="panel-body">
			<form action="/DZOMS/vehicle/tax_add" method="post" class="form-x form-tips">
				<input type="hidden" name="url" value="/vehicle/vehicle/tax_add.jsp" />
				<div class="form-group">
					<div class="label"><label>车架号</label></div>
					<div class="field">
						<s:textfield id="carframe_num" cssStyle="width: 95%;float: left;" name="vehicle.carframeNum"  cssClass="input" data-validate="required:必填" value="%{bean[0].carframeNum}"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>核发日期</label></div>
					<div class="field">
						<s:textfield name="vehicle.taxDate" value="%{bean[0].taxDate}" cssClass="input datepick" cssStyle="width: 95%;float: left;" data-validate="required:必填"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>购置税号</label></div>
					<div class="field">
						<s:textfield name="vehicle.taxNumber" value="%{bean[0].taxNumber}" cssStyle="width: 95%;float: left;" cssClass="input" data-validate="required:必填,regexp#(^[0-9]+$):格式不正确"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>购置税应收</label></div>
					<div class="field">
						<s:textfield name="vehicle.taxMoney" id="vehicle_taxMoney" value="%{bean[0].taxMoney}"  cssClass="input" cssStyle="width: 90%;float: left;" data-validate="required:必填"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
						<a class="icon icon-wrench" style="width: 5%;" href="javascript:openItem('vehicle_taxMoney','购置税金额')"></a>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>发证机关</label></div>
					<div class="field">
						<s:textfield cssClass="input" cssStyle="width: 95%;float: left;" id="vehicle_taxFrom" name="vehicle.taxFrom" value="%{bean[0].taxFrom}" data-validate="required:请选择"></s:textfield>
						<!--<input name="vehicle.taxFrom" class="input" data-validate="required:必填"/>-->
						<a class="icon icon-wrench" style="width: 5%;" href="javascript:openItem('vehicle_taxFrom','购置税发证机关')"></a>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>登记人</label></div>
					<div class="field">
						<s:textfield cssClass="input" readonly="readonly" value="%{#session.user.uname}" />
						<s:hidden name="vehicle.taxRegister" value="%{#session.user.uid}"/>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>登记时间</label></div>
					<div class="field">
						<s:if test="%{bean==null||bean[0]==null}">
							<input class="input" readonly="readonly" name="vehicle.taxRegistTime"
								   value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
						</s:if>
						<s:else>
							<s:textfield cssClass="input" readonly="readonly" name="vehicle.taxRegistTime"
										 value="%{bean[0].taxRegistTime}"/>
						</s:else>
					</div>
				</div>
				<div class="form-button">
					<div class="field">
						<input type="submit" class="button bg-green" value="提交">
						<input type="button" class="button" name="backid"
							   id="backid" onclick="location.href='/DZOMS/vehicle/AbandonApproval/judge.jsp'" value="取消">
					</div>
				</div>
			</form>
		</div>

	</div>

</div>

<div class="line">
	<%
		List<Tax> list = ObjectAccess.query(Tax.class, " state=0 ");
		request.setAttribute("list", list);
	%>
	<s:if test="%{#request.list!=null&&#request.list.size()>0}">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<th class="carframeNum selected_able">车架号</th>
				<th class="taxNumber selected_able">购置税号</th>
				<th class="taxDate selected_able">核发日期</th>
				<th class="taxMoney selected_able">购置税应收金额</th>
				<th class="taxFrom	selected_able">发证机关</th>
				<th class="taxRegister 	selected_able">登记人</th>
				<th class="taxRegistTime selected_able">登记时间</th>
				<th class="modify selected_able">修改</th>
				<th class="delete selected_able">删除</th>
			</tr>
			<s:iterator value="%{#request.list}" var="v">
				<tr>
					<td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
					<td class="taxNumber selected_able"><s:property value="%{#v.taxNumber}"/></td>
					<td class="taxDate selected_able"><s:property value="%{#v.taxDate}"/></td>
					<td class="taxMoney selected_able"><s:property value="%{#v.taxMoney}"/></td>
					<td class="taxFrom selected_able"><s:property value="%{#v.taxFrom}"/></td>
					<td class="taxRegister selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.taxRegister).uname}"/></td>
					<td class="taxRegistTime selected_able"><s:property value="%{#v.taxRegistTime}"/></td>
					<td class="modify selected_able"><a href="javascript:modifyV('<s:property value="%{#v.carframeNum}"/>')">修改</a></td>
					<td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.carframeNum}"/>')">删除</a></td>
				</tr>
			</s:iterator>
		</table>

		<div class="xm9-move xm2">
			<form action="/DZOMS/vehicle/tax_relook" method="post">
				<input type="hidden" name="url" value="/vehicle/vehicle/tax_add.jsp"/>
				<input type="submit" value="全部通过" class="button bg-green" />
			</form>
		</div>
	</s:if>
</div>

<form action="/DZOMS/vehicle/tax_delete" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/tax_add.jsp"/>
	<input type="hidden" name="vehicle.carframeNum" />
	<input type="submit" style="display: none;" id="del_but" />
</form>

<form action="/DZOMS/common/getObj" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/tax_add.jsp"/>
	<input type="hidden" name="ids[0].className" value="com.dz.module.vehicle.Tax" />
	<input type="hidden" name="ids[0].id" />
	<input type="hidden" name="ids[0].isString" value="true" />
	<input type="submit" style="display: none;" id="modify_but" />
</form>

<script>
    function deleteV(cid){
        $('input[name="vehicle.carframeNum"]').val(cid);
        if (confirm("确认删除车架号为"+cid+"的购置税信息？")) {
            $("#del_but").click();
        }
    }

    function modifyV(cid){
        $('input[name="ids[0].id"]').val(cid);
        $("#modify_but").click();
    }
</script>

</body>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</html>

