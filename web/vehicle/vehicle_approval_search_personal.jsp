<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@page import="com.dz.module.user.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User)session.getAttribute("user");
int uid = user.getUid();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>开业审批状态跟踪</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
	
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	
	<script>
	function refreshSearch(){
		$("[name='vehicleSele']").submit();
	}
	
		$(document).ready(function(){
			$("[name='vehicleSele']").find("select").change(function(){
				$("[name='vehicleSele']").submit();
			});
						
			$("[name='vehicleSele']").submit();
			
			$("[name='vehicleSele']").find("input").change(function(){
				if($(this).val().trim().length==0)
						$("[name='vehicleSele']").submit();
			});
			
			$("[name='vehicleSele']").find("input[type='radio']").change(function () {
				$("[name='vehicleSele']").submit();
			});
			
			$("#driver_name").bigAutocomplete({
				url:"/DZOMS/select/driverByName",
				callback:refreshSearch
			});
			
			$("#license_num").bigAutocomplete({
				url:"/DZOMS/select/vehicleByLicenseNum",
				callback:refreshSearch
			});
			
		});
		
	var beforeSubmit = function(){
			var dept = $('#dept').val();
			
			var dataAlready = $('#dataAlready').val();
			
			var condition = " and (officeName=<%=uid%> ";
			
			condition+=" or cashierName=<%=uid%> ";
			condition+=" or financeName=<%=uid%> ";
			condition+=" or financeManagerName=<%=uid%> ";
			condition+=" or branchManagerName=<%=uid%> ";
			condition+=" or assurerName=<%=uid%> ";
			condition+=" or managerName=<%=uid%> ";
			condition+=" or directorName=<%=uid%> ) ";
			
			
			var contractCondition = "from Contract where 1=1 ";
			
			condition+= "and checkType='0' ";
			contractCondition+=$("input[name='approvalType']:checked").val();
			//condition+=$("#abandondType").val();
			
			var in_date_begin = $("#in_date_begin").val();
			if(in_date_begin.length>0){
				condition+= "and approvalBranchDate>='"+in_date_begin+"' ";
			}
			
			var in_date_end = $("#in_date_end").val();
			if(in_date_begin.length>0){
				condition+= "and approvalBranchDate<='"+in_date_end+"' ";
			}
			
			if(dept.trim().length>0){
				contractCondition += "and branchFirm='"+dept.trim()+"' ";
			}
			
			if (dataAlready=='true') {
				condition += "and state=8 ";
			} else if(dataAlready=='false'){
				condition += "and state!=8 and state>0 ";
			}else if(dataAlready=='interrupt'){
				condition += "and state<0 ";
			}else{
				condition += "and state>0 ";
			}
			
			if ($("#driver_name").val().trim().length>0) {
				contractCondition += "and idNum in (select idNum from Driver where name='"+$("#driver_name").val().trim()+"') ";
			}
			
			if ($("#license_num").val().trim().length>0) {
				contractCondition += "and carNum='"+$("#license_num").val().trim()+"' ";
			}
			
			condition+="and contractId in (select id "+contractCondition+") order by approvalBranchDate desc ";
			
			$('[name="condition"]').val(condition);
			return true;
	};
	</script>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>审批管理</li>
                <li>查询</li>
                <li>开业审批状态跟踪</li>
    </ul>
</div>
 
<form id="search_form" action="/DZOMS/common/selectToList" target="result_form" onsubmit="beforeSubmit()" method="post"
      class="definewidth m20" style="width: 100%;" name="vehicleSele">
    <input type="hidden" name="url" value="/vehicle/vehicle_approval_search_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.vehicle.VehicleApproval"/>
		<input type="hidden" name="condition" />
		<input type="hidden" name="pageSize" value="5" />
   <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        	<div class="line">
        		<div class="xm12 padding">
     
                <blockquote class="panel-body">
                    <table class="table" style="border: 0px;">
                        <tr>
                            <td width="15%">审批单创建日期</td>
                            <td width="5%">从</td>
                            <td width="15%"><input type="text" id="in_date_begin" class="input datepick" /></td>
                            <td width="5%">到</td>
                            <td width="15%"><input type="text" id="in_date_end" class="input datepick" /></td>
                        		<td width="5%"><input type="button" value="清空" onclick="$('#in_date_begin').val('');$('#in_date_end').val('');" /></td>
                            
                           <td width="5%">类型</td>
                            <td width="15%">
                            	<input type="radio" name="approvalType" value=" and contractFrom is null "/>新车&nbsp;
                            </td>
														
														<td width="15%">
															<input type="radio" name="approvalType" value=" and contractFrom is not null "/>二手车&nbsp;
														</td>
														
														<td><input type="radio" name="approvalType" value=" " checked="checked"/>全部</td>
                        </tr>
                       </table>
                       <table class="table" style="border: 0px;">
                        <tr>
                          	<td width="15%">车牌号</td>
                            <td width="20%"><input type="text" id="license_num" name="vehicle.licenseNum" class="input" /></td>
                            <td width="15%">承租人姓名</td>
                            <td width="10%"><input type="text" id="driver_name" name="driverName" class="input"/></td>

                            <td style="border-top: 0px;">归属部门</td>
                            <td style="border-top: 0px;"><select name="vehicle.dept" class="input" id="dept">
                            	<option></option>
                            	<option>一部</option>
                            	<option>二部</option>
                            	<option>三部</option>
                            </select></td>

														<td style="border-top: 0px;">是否已完成</td>
                            <td style="border-top: 0px;">
                            <select id="dataAlready" class="input">
                            	<option value="all">全部</option>
                            	<option value="true">是</option>
                            	<option value="false" selected="selected">否</option>
                            	<option value="interrupt">已中止</option>
                            </select>
                            </td>
                        </tr>
                    </table>
                </blockquote>
            </div>
        </div>
      </div>
    </div>
  </div>


</form>
<script>
$(".datepick").datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2100,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onClose:function(){
		$("[name='vehicleSele']").submit();
	}
});
</script>
<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

    </iframe>

</div>

</body>
</html>
