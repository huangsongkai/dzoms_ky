<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>

<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<title>查询结果</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
    <script>
        $(document).ready(function(){
            $("#show_div").find("input").change(resetClass);
            resetClass();
        });

        function resetClass(){
            $(".selected_able").hide();
            var selects = [];
            $("input[name='sbx']:checked").each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
                selects.push($(this).val());//将选中的值添加到数组chk_value中
            });
            //	alert(selects);

            for(var i = 0;i<selects.length;i++){
                $("."+selects[i]).show();
            }
        }
        
        function _detail(){
        	var selected_val = $("input[name='cbx']:checked").val();
					if(selected_val==undefined){
						alert('您没有选择任何一条数据');
						return false;
					}
					var url = "/DZOMS/contract/contractPreShow?contract.id="+selected_val;
					window.open(url,"合同明细",'width=800,height=600,resizable=yes,scrollbars=yes');
        }
        
        function _detail2(){
        	var selected_val = $("input[name='cbx']:checked").val();
        	var checkId = $("input[name='cbx']:checked").attr('checkId');
					if(selected_val==undefined){
						alert('您没有选择任何一条数据');
						return false;
					}
					var url = "/DZOMS/common/getObj?url=%2fvehicle%2fAbandonApproval%2fvehicle_abandon09.jsp&ids[0].id="+checkId+"&ids[0].className=com.dz.module.vehicle.VehicleApproval&ids[1].className=com.dz.module.contract.Contract&ids[1].id="+selected_val;
					window.open(url,"审批单明细",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

	
	$(document).ready(function(){
		
	});
</script>
  </head>
 <body>
<div class="line">
   <div class="panel  margin-small" >
          	<div class="panel-head">
          		<strong class="text-black">查询结果</strong>
          		<!--<div class="line">
            <div class="xm1 xm8-move">
            <a href="#" onclick="_detail()">
            	<i class="icon-search" style="font-size: 12px;"></i>
            	<span class="h6"><strong>合同信息</strong></span>
            </a>
            </div>
            <div class="xm1">
            <a href="#" onclick="_detail2()">
            	<i class="icon-search" style="font-size: 12px;"></i>
            	<span class="h6"><strong>审批单信息</strong></span>
            </a>
            </div>
            
        </div>-->

          	</div>
        <div class="panel-body">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th class="dept selected_able">部门</th>
                        
                        <th class="oldLicenseNum selected_able">原车号</th>
                        <th class="oldDriverName selected_able">原车主</th>
                        <th class="oldDriverId selected_able">身份证</th>
                        <th class="oldCarframeNum selected_able">车架号</th>
                        <th class="finalTime selected_able">合同终止日</th>
                        <th class="oldContract selected_able">原合同</th>
                        <th class="oldApproval selected_able">审批单</th>
                        
                        <th class="licenseNum selected_able">新车号</th>
                        <th class="driverName selected_able">车主</th>
                        <th class="driverId selected_able">身份证</th>
                        <th class="carframeNum selected_able">车架号</th>
                        <th class="carStatus selected_able">状态</th>
                        <th class="contractBeginDate selected_able">合同开始日</th>
                        <th class="newContract selected_able">合同详情</th>
                        <th class="newApproval selected_able">审批单</th>
                    </tr>
<%
	request.setAttribute("the_quate","'");
%>
<s:set name="qt" value="%{#request.the_quate}"></s:set> 

<s:if test="%{#request.pairlist!=null}">
  <s:iterator value="%{#request.pairlist}" var="pair">
  	
  <s:set name="v" value="%{#pair[0]}"></s:set>
  <s:set name="ocIdHql" value="%{'select max(id) from Contract c where c.carframeNum='+#qt+#v.carframeNum+#qt}"></s:set>
  <s:set name="ocId" value="%{@com.dz.common.other.ObjectAccess@execute(#ocIdHql)}"></s:set>
  <s:set name="oc" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract',#ocId)}"></s:set>
  <s:set name="oaId" value="%{@com.dz.common.other.ObjectAccess@execute('select id from VehicleApproval where checkType=1 and handleMatter=0 and state>0 and contractId='+#oc.id)}"></s:set>
  
  <s:set name="n" value="%{#pair[1]}"></s:set>
  <s:set name="ncIdHql" value="%{'select max(id) from Contract c where c.carframeNum='+#qt+#n.carframeNum+#qt}"></s:set>
  <s:set name="ncId" value="%{@com.dz.common.other.ObjectAccess@execute(#ncIdHql)}"></s:set>
  <s:set name="nc" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract',#ncId)}"></s:set>
  <s:set name="naId" value="%{@com.dz.common.other.ObjectAccess@execute('select id from VehicleApproval where checkType=0 and state>0 and contractId='+#nc.id)}"></s:set>
<tr>
 <td class="dept selected_able"><s:property value="%{#v!=null?#v.dept:#n.dept}"/></td>
 
<td class="oldLicenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
<td class="oldDriverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#oc.idNum).name}"/></td>
<td class="oldDriverId selected_able"><s:property value="%{#oc.idNum}"/></td>
<td class="oldCarframeNum selected_able"><s:property value="%{#v.carframeNum }"/></td>
<td class="finalTime selected_able"><s:property value="%{#oc.abandonedChargeTime }"/></td>
<td class="oldContract selected_able"><a href="/DZOMS/contract/contractPreShow?contract.id=${oc.id}" target="_blank">详情</a></td>
<td class="oldApproval selected_able"><a href="/DZOMS/common/getObj?url=%2fvehicle%2fAbandonApproval%2fvehicle_abandon09.jsp&ids[0].id=${oaId}&ids[0].className=com.dz.module.vehicle.VehicleApproval&ids[1].className=com.dz.module.contract.Contract&ids[1].id=${oc.id}" target="_blank">详情</a></td>

<td class="licenseNum selected_able"><s:property value="%{#n.licenseNum}"/></td>
<td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#n.driverId).name}"/></td>
<td class="driverId selected_able"><s:property value="%{#n.driverId}"/></td>
<td class="carframeNum selected_able"><s:property value="%{#n.carframeNum }"/></td>
<td class="carStatus selected_able">
	<s:if test="%{#n.state==0}">
 		新车待开业
 	</s:if>
 	<s:if test="%{#n.state==1}">
 		运营中
 	</s:if>
 	<s:if test="%{#n.state==2}">
 		已报废
 	</s:if>
 	<s:if test="%{#n.state==3}">
 		二手车待开业
 	</s:if></td>
<td class="contractBeginDate selected_able"><s:property value="%{#nc.contractBeginDate }"/></td>
<td class="newContract selected_able">
<s:if test="%{#nc!=null}">
<a href="/DZOMS/contract/contractPreShow?contract.id=${nc.id}" target="_blank">详情</a>
</s:if>
</td>
<td class="newApproval selected_able">
<s:if test="%{#nc!=null}">
	<a href="/DZOMS/common/getObj?url=%2fvehicle%2fCreateApproval%2fvehicle_approval09.jsp&ids[0].id=${naId}&ids[0].className=com.dz.module.vehicle.VehicleApproval&ids[1].className=com.dz.module.contract.Contract&ids[1].id=${nc.id}" target="_blank">详情</a>
	</s:if>
</td>
 </tr>
                    </s:iterator>
                </s:if>
               </table>
       </div>
        <div class="panel-foot border-red-light bg-red-light">
            合计：<s:property value="%{#request.pairlist.size()}"/>条记录。
        </div>
    </div>
</div>
 <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		<strong class="text-black">显示项</strong>
          		
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="dept" checked="checked"><span class="icon icon-check text-green"></span>部门</label>

<label class="button active"><input type="checkbox" name="sbx" value="oldLicenseNum" checked="checked"><span class="icon icon-check text-green"></span>原车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="oldDriverName" checked="checked"><span class="icon icon-check text-green"></span>原承租人</label>
<label class="button"><input type="checkbox" name="sbx" value="oldDriverId"><span class="icon icon-check text-green"></span>身份证</label>
<label class="button active"><input type="checkbox" name="sbx" value="oldCarframeNum" checked="checked"><span class="icon icon-check text-green"></span>原车架号</label>
<label class="button active"><input type="checkbox" name="sbx" value="finalTime" checked="checked"><span class="icon icon-check text-green"></span>废业办结日</label>
<label class="button active"><input type="checkbox" name="sbx" value="oldContract" checked="checked"><span class="icon icon-check text-green"></span>原合同详情</label>
<label class="button active"><input type="checkbox" name="sbx" value="oldApproval" checked="checked"><span class="icon icon-check text-green"></span>废业审批单详情</label>

<label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>新车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="driverName" checked="checked"><span class="icon icon-check text-green"></span>承租人</label>
<label class="button"><input type="checkbox" name="sbx" value="driverId"><span class="icon icon-check text-green"></span>身份证</label>
<label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号</label>
<label class="button active"><input type="checkbox" name="sbx" value="carStatus" checked="checked"><span class="icon icon-check text-green"></span>车辆状态</label>
<label class="button active"><input type="checkbox" name="sbx" value="contractBeginDate" checked="checked"><span class="icon icon-check text-green"></span>合同开始日期</label>
<label class="button active"><input type="checkbox" name="sbx" value="newContract" checked="checked"><span class="icon icon-check text-green"></span>合同详情</label>
<label class="button active"><input type="checkbox" name="sbx" value="newApproval" checked="checked"><span class="icon icon-check text-green"></span>开业审批单详情</label>
            </div>

        </div>

    </div>
   	
  </div>
</html>
