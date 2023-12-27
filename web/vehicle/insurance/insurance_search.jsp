<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>保险查询</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script>
	function refreshSearch(){
		var dept = $("#dept").val();
		var carframe_num = $("#carframe_num").val();
		var licenseNum = $("#licenseNum").val();
		var insuranceNum = $("#insuranceNum").val();
		var insuranceClass = $("#insuranceClass").val();
		var inputFrom =  $("input[name=\"inputFrom\"]").val();
		var inputEnd =  $("input[name=\"inputEnd\"]").val();
		var startFrom =  $("input[name=\"startFrom\"]").val();
		var startEnd =  $("input[name=\"startEnd\"]").val();

		var vCondition = " ";
		if (dept != '全部') {
			vCondition += " and v.dept='"+dept+"' ";
		}

		if(carframe_num.trim().length>0){
			vCondition += " and v.carframeNum like '%"+carframe_num.trim()+"%' ";
		}

		if(licenseNum.trim().length>0){
			vCondition += " and v.licenseNum like '%"+licenseNum.trim()+"%' ";
		}

		var condition = " from Insurance ins where (EXISTS (select 1 FROM Vehicle v WHERE ins.carframeNum = v.carframeNum "+ vCondition+" ) " +
				" or NOT EXISTS (select 1 FROM Vehicle v WHERE ins.carframeNum = v.carframeNum)) ";
		// var condition = "from Insurance ins,(SELECT v FROM Vehicle v WHERE ins.carframeNum = v.carframeNum) " +
		// 		"where ins.carframeNum=v.carframeNum "

		if(insuranceNum.trim().length>0){
			condition += " and ins.insuranceNum like '%"+insuranceNum.trim()+"%' ";
		}

		if(insuranceClass.trim().length>0){
			condition += " and ins.insuranceClass like '%"+insuranceClass.trim()+"%' ";
		}

		if(inputFrom.trim().length>0){
			condition += " and ins.registTime >= STR_TO_DATE('"+inputFrom.trim()+"', '%Y/%m/%d') ";
		}

		if(inputEnd.trim().length>0){
			condition += " and ins.registTime < STR_TO_DATE('"+inputEnd.trim()+"', '%Y/%m/%d') ";
		}

		if(startFrom.trim().length>0){
			condition += " and DATE(ins.beginDate) >= STR_TO_DATE('"+startFrom.trim()+"', '%Y/%m/%d') ";
		}

		if(startEnd.trim().length>0){
			condition += " and DATE(ins.beginDate) < STR_TO_DATE('"+startEnd.trim()+"', '%Y/%m/%d') ";
		}

		condition += " order by ins.id desc ";
		$('[name="condition"]').val(condition);

		$("[name='vehicleSele']").submit();
	}

	function reset(){
		$("#dept").reset();
		$("#carframe_num").reset();
		$("#licenseNum").reset();
		$("#insuranceNum").reset();
		$("#insuranceClass").reset();
		$("input[name=\"inputFrom\"]").reset();
		$("input[name=\"inputEnd\"]").reset();
		$("input[name=\"startFrom\"]").reset();
		$("input[name=\"startEnd\"]").reset();
		// $("[name='vehicleSele']")[0].reset()
	}
	
		$(document).ready(function(){
			$("[name='vehicleSele']").find("select").change(function(){
				refreshSearch();
			});
						
			refreshSearch();
			
			$("[name='vehicleSele']").find("input").change(function(){
				//if($(this).val().trim().length==0)
						refreshSearch();
			});
			
			$("[name='insurance.carframeNum']").bigAutocomplete({
				url:"/DZOMS/select/InsuranceBycarframeNum",
				callback:refreshSearch
			});
			
			$("[name='insurance.insuranceNum']").bigAutocomplete({
				url:"/DZOMS/select/InsuranceByinsuranceNum",
				callback:refreshSearch
			});
			
			$("[name='vehicle.licenseNum']").bigAutocomplete({
				url:"/DZOMS/select/vehicleByLicenseNum",
				callback:refreshSearch
			});
			
		});
	</script>
	<style>
        .label{
            text-align: right;
        }
    </style>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>车辆管理</li>
                <li>查询</li>
                <li>查询保险信息</li>
        </ul>
</div>
<form name="vehicleSele" action="/DZOMS/common/selectToList2" method="post"
<%--<form name="vehicleSele" action="/DZOMS/vehicle/insuranceSele" method="post"--%>
      class="definewidth m20" target="result_form" style="width: 100%;">
	<input type="hidden" name="url" value="/vehicle/insurance/insurance_search_result.jsp" />
	<input type="hidden" name="condition" />
	<input type="hidden" name="column" value="ins"/>
	<div class="line">
   	    <div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        		<div class="line">
        			<blockquote class="xm9">
        				<table class="table table-bordered">
        					<tr>
								<td>部门</td>
								<td>
									<select id="dept" name="vehicle.dept">
										<option>全部</option>
										<option>一部</option>
										<option>二部</option>
										<option>三部</option>
									</select>
								</td>
        						<td>车架号</td>
        						<td><input type="text" id="carframe_num" name="insurance.carframeNum" class="input" /></td>
        						<td>车牌号</td>
        						<td><input type="text" id="licenseNum" name="vehicle.licenseNum" class="input"  value="黑A" /></td>
        						<td>保单号</td>
        						<td><input type="text" id="insuranceNum" name="insurance.insuranceNum" class="input"  /></td>
        						<td>保险类别</td>
        						<td>
        							<select id="insuranceClass" name="insurance.insuranceClass" class="input">
        								<option value="">全部</option>
        								<option value="强">强险单</option>
        								<option value="商">商业保险单</option>
        								<option value="承运">承运人责任险</option>
        							</select>
        						</td>
        					</tr>
							<tr>
								<td>录入时间</td>
								<td >
									<input type="text" class="input datepicker" name="inputFrom"></td>
								<td >到</td>
								<td ><input type="text" class="input datepicker" name="inputEnd"></td>
								<td>起始时间</td>
								<td ><input type="text" class="input datepicker" name="startFrom"></td>
								<td >到</td>
								<td ><input type="text" class="input datepicker" name="startEnd"></td>
								<td><input type="button" value="查询" onclick="refreshSearch()"></td>
								<td><input type="button" value="清空条件" onclick="reset()"></td>
							</tr>
        				</table>
         			</blockquote>
        		</div>
        </div>
       </div>
    </div>
  
</form>
<div>
    <iframe name="result_form" width="100%" height="100%" id="result_form" scrolling="auto">

    </iframe>

</div>
	<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
	<script>
		$('.datepicker').datetimepicker(
				{
					lang:"ch",           //语言选择中文
					datepicker:true,
					timepicker:false,    //关闭时间选项
					format:"Y/m/d"
				});
	</script>
</body>
</html>



