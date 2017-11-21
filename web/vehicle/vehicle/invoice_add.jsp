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
	<title>新增发票信息</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<jsp:include page="/common/msg_info.jsp"></jsp:include>
	<script>
        $(document).ready(function(){
            $("#carframe_num").bigAutocomplete({
                url:"/DZOMS/select/VehicleBycarframeNum",
                condition:"invoiceNumber is null",
                doubleClick:true,
                doubleClickDefault:'LFV'
            });
            //getList1('vehicle_purseFrom','vehicle_purseFrom');
        });

        $(document).ready(function(){
            $("#purseFrom").bigAutocomplete({
                url:"/DZOMS/select/itemsOfvehicle_purseFrom",
                doubleClick:true,
                doubleClickDefault:''
            });
            //getList1('vehicle_purseFrom','vehicle_purseFrom');
        });

        $(document).ready(function(){
            $("#vehicle_invoiceMoney").bigAutocomplete({
                url:"/DZOMS/select/itemsOfvehicle_invoiceMoney",
                doubleClick:true,
                doubleClickDefault:''
            });
        });

        $(document).ready(function(){
            itemsDefault("#purseFrom","vehicle_purseFrom");
            itemsDefault("#vehicle_invoiceMoney","vehicle_invoiceMoney");
        });
	</script>
	<style>
		.tableleft{
			text-align: right;
		}
	</style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
	<ul class="bread text-main" style="font-size: larger;">

		<li>车辆管理</li>
		<li>新增</li>
		<li>新增发票信息</li>
	</ul>
</div>

<div class="xm5 xm2-move">
	<div class="alert alert-yellow padding">
		<span class="close rotate-hover"></span><strong>注意：</strong>录入发票信息前需要录入车辆技术信息文字。</div>
	<div class="panel">
		<div class="panel-head">
			新增发票信息
		</div>
		<div class="panel-body">
			<form action="/DZOMS/vehicle/invoice_add" method="post" class="form-x form-tips">
				<input type="hidden" name="url" value="/vehicle/vehicle/invoice_add.jsp" />
				<div class="form-group">
					<div class="label"><label>车架号</label></div>
					<div class="field">
						<s:textfield id="carframe_num" cssStyle="width: 95%;float: left;" name="vehicle.carframeNum"  cssClass="input" data-validate="required:必填" value="%{bean[0].carframeNum}"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>开票日期</label></div>
					<div class="field"><s:textfield name="vehicle.invoiceDate" value="%{bean[0].invoiceDate}" cssClass="input datepick" cssStyle="width: 95%;float: left;" data-validate="required:必填"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>发票号码</label></div>
					<div class="field"><s:textfield name="vehicle.invoiceNumber" value="%{bean[0].invoiceNumber}" cssStyle="width: 95%;float: left;" cssClass="input" data-validate="required:必填"/>
						<span style="color:red;font-size:large;width: 5%;">*</span>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>计税合计</label></div>
					<div class="field"><s:textfield name="vehicle.invoiceMoney" id="vehicle_invoiceMoney" value="%{bean[0].invoiceMoney}"  cssClass="input" cssStyle="width: 90%;float: left;" data-validate="required:必填"/>
						<span style="color:red;font-size:large;float: left;width: 5%;">*</span>
						<a style="width: 5%;" class="icon icon-wrench" href="javascript:openItem('vehicle_invoiceMoney','计税合计')"></a>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>销货单位名称</label></div>
					<div class="field">
						<!--					<input name="vehicle.purseFrom" class="input" data-validate="required:必填"/>
                        -->					<s:textfield cssClass="input" cssStyle="width: 95%;float: left;" id="purseFrom" name="vehicle.purseFrom" value="%{bean[0].purseFrom}" data-validate="required:请选择">
					</s:textfield>
						<a style="width: 5%;" class="icon icon-wrench" href="javascript:openItem('vehicle_purseFrom','销货单位名称')"></a>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label>登记人</label></div>
					<div class="field">
						<s:textfield cssClass="input" readonly="readonly" value="%{#session.user.uname}" />
						<s:hidden name="vehicle.invoiceRegister" value="%{#session.user.uid}"/></div>
				</div>
				<div class="form-group">
					<div class="label"><label>登记时间</label></div>
					<div class="field">
						<s:if test="%{bean==null||bean[0]==null}">
							<input class="input" readonly="readonly" name="vehicle.invoiceRegistTime"
								   value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
						</s:if>
						<s:else>
							<s:textfield cssClass="input" readonly="readonly" name="vehicle.invoiceRegistTime"
										 value="%{bean[0].invoiceRegistTime}"/>
						</s:else>

					</div>
				</div>
				<div class="form-button padding">

					<div class="field"><input type="submit" class="button bg-main" value="提交">
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
		List<Invoice> list = ObjectAccess.query(Invoice.class, " state=0 ");
		request.setAttribute("list", list);
	%>
	<s:if test="%{#request.list!=null&&#request.list.size()>0}">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<th class="carframeNum selected_able">车架号</th>
				<th class="invoiceNumber selected_able">发票号</th>
				<th class="invoiceDate selected_able">开票日期</th>
				<th class="invoiceMoney selected_able">价税合计</th>
				<th class="purseFrom selected_able">销货单位名称</th>
				<th class="invoiceRegister selected_able">登记人</th>
				<th class="invoiceRegistTime selected_able">登记时间</th>
				<th class="modify selected_able">修改</th>
				<th class="delete selected_able">删除</th>
			</tr>
			<s:iterator value="%{#request.list}" var="v">
				<tr>
					<td class="carframeNum		selected_able"><s:property value="%{#v.carframeNum}"/></td>
					<td class="invoiceNumber	selected_able"><s:property value="%{#v.invoiceNumber	}"/></td>
					<td class="invoiceDate 		selected_able"><s:property value="%{#v.invoiceDate 		}"/></td>
					<td class="invoiceMoney 	selected_able"><s:property value="%{#v.invoiceMoney 	}"/></td>
					<td class="purseFrom 		selected_able"><s:property value="%{#v.purseFrom 		}"/></td>
					<td class="invoiceRegister 	selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.invoiceRegister).uname}"/></td>
					<td class="invoiceRegistTime selected_able"><s:property value="%{#v.invoiceRegistTime}"/></td>
					<td class="modify selected_able"><a href="javascript:modifyV('<s:property value="%{#v.carframeNum}"/>')">修改</a></td>
					<td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.carframeNum}"/>')">删除</a></td>
				</tr>
			</s:iterator>
		</table>

		<div class="xm9-move xm2">
			<form action="/DZOMS/vehicle/invoice_relook" method="post">
				<input type="hidden" name="url" value="/vehicle/vehicle/invoice_add.jsp"/>
				<input type="submit" value="全部通过" class="button bg-green" />
			</form>
		</div>
	</s:if>
</div>

<form action="/DZOMS/vehicle/invoice_delete" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/invoice_add.jsp"/>
	<input type="hidden" name="vehicle.carframeNum" />
	<input type="submit" style="display: none;" id="del_but" />
</form>

<form action="/DZOMS/common/getObj" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/invoice_add.jsp"/>
	<input type="hidden" name="ids[0].className" value="com.dz.module.vehicle.Invoice" />
	<input type="hidden" name="ids[0].id" />
	<input type="hidden" name="ids[0].isString" value="true" />
	<input type="submit" style="display: none;" id="modify_but" />
</form>

</body>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
<script>
    function deleteV(cid){
        $('input[name="vehicle.carframeNum"]').val(cid);
        if (confirm("确认删除车架号为"+cid+"的发票信息？")) {
            $("#del_but").click();
        }
    }

    function modifyV(cid){
        $('input[name="ids[0].id"]').val(cid);
        $("#modify_but").click();
    }
</script>
</html>
