<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path=request.getContextPath(); 
	String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/"; 
	
	
Map<String,String> mp = new HashMap<>();
mp.put("add_bank","哈尔滨银行");
mp.put("add_bank2","招商银行");
mp.put("add_cash","现金");
mp.put("add_insurance","保险");
mp.put("add_other","其它");
mp.put("sub_insurance","银行");
mp.put("sub_other","其它");
mp.put("plan_add_contract","合同费用");
mp.put("plan_add_insurance","保险费用");
mp.put("plan_add_other","其它费用");
mp.put("plan_base_contract","合同基础费用");
mp.put("plan_sub_contract","合同费用");
mp.put("plan_sub_insurance","保险费用");
mp.put("plan_sub_other","其它费用");

request.setAttribute("mp", mp);
%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>新车查错</title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<base href="<%=basePath%>" />
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
<style>
	.tableleft{
		text-align: right;
	}
</style>

<script>
$(document).ready(function(){
	$("input[type='text'],textarea").attr("disabled",true);
	
		var l = '<s:property escape="false" value="%{contract.planList}"/>';
		l = $.parseJSON(l);
		for(var i=0;i<l.length;i++){
			var beginTime = l[i]["begin"];
			var endTime = l[i]["end"];
			var rentAmount = l[i]["money"];
			var comment = l[i]["comment"];
			
			var $option = $('<option></option>');
			$option.append($('<input name="beginTime" readonly="readonly" style="display:none;"/>').val(beginTime));
			
			$option.append(""+beginTime);
			
			$option.append("--");
			$option.append($('<input name="endTime" readonly="readonly" style="display:none;"/>').val(endTime));
			
			$option.append(""+endTime);
			
			$option.append("\t￥");
			$option.append($('<input name="rentAmount" style="display:none;"/>').val(rentAmount));
			
			$option.append(""+rentAmount);
			
			$option.append("\t");
			$option.append($('<input name="comment" style="display:none;"/>').val(comment));
			
			$option.append(""+comment);
			
			$("#rentList").append($option);
		}

	$("#but_change").click(function(){
		$("input[type='text'],textarea").attr("disabled",false);
		$(".datepick").datetimepicker({
			lang:"ch",           //语言选择中文
			format:"Y/m/d",      //格式化日期
			timepicker:false,    //关闭时间选项
			yearStart:2000,     //设置最小年份
			yearEnd:2050,        //设置最大年份
		});
		$(".need_show").show();
		$(".need_change").hide();
		$(".my-top-panel").css("height","150px");
	});
	
	$("#but_submit").click(function(){
		$("#myform").submit();
	});
	
	$(".need_show").hide();
	$(".my-top-panel").css("height","400px");
	
});
</script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
                <li>系统管理</li>
                <li>新车查错</li>
        </ul>
</div>

	<div class="xm12">
		
		<div class="panel" style="min-height: 400px;">
			<div class="panel-head">
				查错类型：新车
			</div>
			<div class="panel-body">
			<form action="/DZOMS/adjustNewCar" id="myform" method="post" class="form-x form-tips">
			
			<div class="panel xm6 my-top-panel">
				<div class="panel-head">
				合同数据
				</div>
				<div class="panel-body">
					<div class="form-group">
						<div class="label"><label>合同起始日期</label></div>
						<div class="field">
							<s:textfield  name="contract.contractBeginDate" cssClass="input input-auto datepick"  >
								<s:param name="value">
			                		<s:date name="%{contract.contractBeginDate}" format="yyyy/MM/dd"></s:date>
			                	</s:param>
			                </s:textfield>
						</div>
					</div>
					<div class="form-group">
						<div class="label"><label>合同终止日期</label></div>
						<div class="field">
							<s:textfield  name="contract.contractEndDate" cssClass="input input-auto datepick" >
								<s:param name="value">
			                		<s:date name="%{contract.contractEndDate}" format="yyyy/MM/dd"></s:date>
			                	</s:param>
			                </s:textfield>
						</div>
					</div>
					<div class="form-group need_change">
						<div class="label"><label>租金计划</label></div>
						<div class="field">
                			<select  id="rentList" size="5" style="width: 400px;"  class="float-left">
                				
                			</select>
						</div>
					</div>
					<div class="form-group need_change">
						<div class="label"><label>合同录入人</label></div>
						<div class="field">
							<s:textfield value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',contract.inputer).uname}" cssClass="input input-auto"  />
						</div>
					</div>
					<div class="form-group need_change">
						<div class="label"><label>合同录入日期</label></div>
						<div class="field">
							<s:textfield  name="contract.inputTime" cssClass="input input-auto datepick" >
								<s:param name="value">
			                		<s:date name="%{contract.inputTime}" format="yyyy/MM/dd HH:mm:ss"></s:date>
			                	</s:param>
			                </s:textfield>
						</div>
					</div>
				</div>
			</div>
			
			<div class="panel xm6 my-top-panel" >
				<div class="panel-head">
				车辆数据
				</div>
				<div class="panel-body">
					<div class="form-group">
						<div class="label"><label>营运证发放日期</label></div>
						<div class="field">
							<s:textfield  name="vehicle.operateCardTime" cssClass="input input-auto  datepick"   >
								<s:param name="value">
			                		<s:date name="%{vehicle.operateCardTime}" format="yyyy/MM/dd"></s:date>
			                	</s:param>
			                </s:textfield>
						</div>
					</div>
					<div class="form-group need_change">
						<div class="label"><label>营运证录入人</label></div>
						<div class="field">
							<s:textfield value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',vehicle.serviceRightRegister).uname}" cssClass="input input-auto"   />
						</div>
					</div>
					<div class="form-group need_change">
						<div class="label"><label>营运证录入日期</label></div>
						<div class="field">
							<s:textfield  name="vehicle.serviceRightRegistDate" cssClass="input input-auto datepick"   >
								<s:param name="value">
			                		<s:date name="%{vehicle.serviceRightRegistDate}" format="yyyy/MM/dd"></s:date>
			                	</s:param>
			                </s:textfield>
						</div>
					</div>
				</div>
			</div>
			
			<div class="panel need_change">
				<div class="panel-head">
				财务约定调整
				</div>
				<div class="panel-body">
					<s:if test="#request.personal_list!=null&&#request.personal_list.size()>0">
					<div class="form-group">
						<div class="label"><label>人工录入的约定</label></div>
						<div class="field">
							<table class="table table-hover table-striped table-bordered">
							<thead>
							<tr>
								<th>约定类型</th><th>金额</th><th>起始时间</th><th>结束时间</th><th>操作人员</th><th>操作日期</th><th>备注</th>
							</tr>
							</thead>
							<tbody>
								<s:iterator value="%{#request.personal_list}" var="v">
									<tr>
										<td>
										<s:property value="%{#request.mp[#v.feeType]}"/>
										</td>
										<td>
										<s:if test="%{@org.apache.commons.lang3.StringUtils@contains(#v.feeType,'sub')}">
											<s:set name="fee" value="%{#v.fee*-1}"></s:set>
										</s:if>
										<s:else>
											<s:set name="fee" value="%{#v.fee}"></s:set>
										</s:else>
										<s:property value="%{#fee}"/>
										</td>
										<td><s:property value="%{#v.startTime}"/></td>
										<td><s:property value="%{#v.endTime}"/></td>
										<td><s:property value="%{#v.register}"/></td>
										<td><s:property value="%{#v.inTime}"/></td>
										<td><s:property value="%{#v.comment}"/></td>
									</tr>
								</s:iterator>
							</tbody>
							</table>
						</div>
					</div>
					</s:if>
					
					<s:if test="#request.auto_list!=null&&#request.auto_list.size()>0">
					<div class="form-group">
						<div class="label"><label>自动生成的约定</label></div>
						<div class="field">
							<table class="table table-hover table-striped table-bordered">
							<thead>
							<tr>
								<th>约定类型</th><th>金额</th><th>月份</th><th>相关人员</th><th>操作日期</th><th>备注</th>
							</tr>
							</thead>
							<tbody>
								<s:iterator value="%{#request.auto_list}" var="v">
									<tr>
										<td>
										<s:property value="%{#request.mp[#v.feeType]}"/>
										</td>
										<td>
										<s:if test="%{@org.apache.commons.lang3.StringUtils@contains(#v.feeType,'sub')}">
											<s:set name="fee" value="%{#v.fee*-1}"></s:set>
										</s:if>
										<s:else>
											<s:set name="fee" value="%{#v.fee}"></s:set>
										</s:else>
										<s:property value="%{#fee}"/>
										</td>
										<td><s:date name="%{#v.time}" format="yyyy/MM"/></td>
										<td><s:property value="%{#v.register}"/></td>
										<td><s:property value="%{#v.inTime}"/></td>
										<td><s:property value="%{#v.comment}"/></td>
									</tr>
								</s:iterator>
							</tbody>
							</table>
						</div>
					</div>
					</s:if>
				</div>
			</div>
		    <div class="xm2 xm10-left">
					<input type="button" class="need_change button bg-green" id="but_change" style="display: none;" value="纠错" />
					<input type="button" class="need_show button bg-green" id="but_submit" value="提交更改" />
		    </div>
			</form>
				
			</div>
			
		</div>
		
	</div>
	</body>
</html>
