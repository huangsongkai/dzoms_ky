<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Page pg = (Page)request.getAttribute("page");
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
	<script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
<script>
	$(document).ready(function(){
		$("#show_div").find("input").change(resetClass);
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
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/vehicle/insurancePreshow?insurance.id="+selected_val;
		window.open(url,"保险明细",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/vehicle/insurance_revoke?insurance.id="+selected_val+"&url=%2fvehicle%2finsurance%2finsurance_add.jsp";;
		window.parent.location.href=url;
	}
	
	
	function toBeforePage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==1){
			alert("没有上一页了。");
			return ;
		}
		$("input[name='currentPage']").val($("input[name='currentPage']").val()-1);
		document.vehicleSele.submit();
	}
	
	function toNextPage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==<%=pg.getTotalPage()%>){
			alert("没有下一页了。");
			return ;
		}
		$("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val())+1);
		document.vehicleSele.submit();
	}
	
	function toPage(pg){
		
		$("input[name='currentPage']").val(pg);
		document.vehicleSele.submit();
	}
	
	$(document).ready(function(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		$("#page-input").val(currentPage + "/<%=pg.getTotalPage()%>");
		
		$("#page-input").change(function(){
			
			var pg_num = parseInt($("#page-input").val());
			toPage(pg_num);
		});
		
		$("#page-input").focus(function(){
			$(this).val("");
		});
	});
</script>
  </head>
 <body>
<div>
   <div class="panel  margin-small" >
          	<div class="panel-head">
          		  <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm4 xm6-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                     	<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		查看</button>
	                               			<s:if test="#session.roles.{?#this.rname=='保险修改权限'}.size>0">  
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
			                                </s:if>
		                                    <!--<button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出</button>
			                                  <button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
			                                                            打印</button>-->
                                     </div>
                                </div>
          	        	</div>
          	        </div>
      </div>
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
                    <th>选择</th>
            <th class="insuranceClass selected_able">保险类别</th>
            <th class="insuranceNum selected_able">保单号</th>
            <th class="carframeNum selected_able">车架号</th>
            <th class="licenseNum selected_able">车牌号</th>
            <th class="driverName selected_able">被保险人</th>
           <!-- <th class="driverPhone selected_able">被保险人联系电话</th>
            <th class="driverId selected_able">被保险人身份证号</th>-->
            <th class="insuranceCompany selected_able">保险人公司名称</th>
            <th class="insuranceMoney selected_able">保险费</th>
                </tr>
               <s:if test="%{#request.insurance!=null&&#request.insurance.size()!=0}">  
        <s:iterator value="%{#request.insurance}" var="v">
                        <tr>
<td><input type="radio" name="cbx" value="<s:property value='%{#v.id}'/>" ></td>
<td class="insuranceClass selected_able"><s:property value="%{#v.insuranceClass}"/></td>
<td class="insuranceNum selected_able"><s:property value="%{#v.insuranceNum}"/></td>
<td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
<td class="licenseNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
<!--<td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>
<td class="driverPhone selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).phoneNum1}"/></td>-->
<td class="driverName selected_able"><s:property value="%{#v.driverId}"/></td>
<td class="insuranceCompany selected_able"><s:property value="%{#v.insuranceCompany}"/></td>
<td class="insuranceMoney selected_able"><s:property value="%{#v.insuranceMoney}"/></td>
                        </tr>
                    </s:iterator>
</s:if>
            </table>
         <s:if test="%{#request.insurance!=null&&#request.insurance.size()!=0}">
            <div class="line padding">
            	<div class="xm5-move">
            		<div>
            			<ul class="pagination">
                    <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                  </ul>
                   <ul class="pagination pagination-group">
                    <li style="border: 0px;">
                    	<form>
                    		<div class="form-group">
                    			<div class="field">
                    			<input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>" id="page-input" >
                    		</div>
                    			</div>
                    	</form>
                    	</li>
                   </ul>
                  <ul class="pagination">
                    <li><a href="javascript:toNextPage()">下一页</a></li>
                  </ul>
                  
            		</div>
            	</div>
            </div>
            </s:if>
            <s:else>
                	无查询结果
            </s:else>

    </div>
    <%
    	request.setAttribute("col","\'");
    %>
      <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
      <s:set name="sumHql" value="%{'select sum(insuranceMoney) from Insurance where 1=1 '}"></s:set>
      <s:if test="%{@org.apache.commons.lang3.StringUtils@isNotEmpty(insurance.carframeNum)}">
      	<s:set name="sumHql" value="%{#sumHql+' and carframeNum='+#request.col+insurance.carframeNum+#request.col}"></s:set>
      </s:if>
      <s:if test="%{@org.apache.commons.lang3.StringUtils@isNotEmpty(insurance.insuranceNum)}">
      	<s:set name="sumHql" value="%{#sumHql+' and insuranceNum='+#request.col+insurance.insuranceNum+#request.col}"></s:set>
      </s:if>
      <s:set name="sumOfMoney" value="%{@com.dz.common.other.ObjectAccess@execute(#sumHql)}"></s:set>
            合计金额：<s:property value="%{@java.lang.String@format('%6.2f',#sumOfMoney)}"/>
        </div>
   </div>
   <div class="line" style="display: none;">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
            <label class="button active">
                <input type="checkbox" name="sbx" value="insuranceClass" checked="checked"><span class="icon icon-check text-green"></span>保险类别
            </label>
            <label class="button active">
                <input type="checkbox" name="sbx" value="insuranceNum" checked="checked"><span class="icon icon-check text-green"></span>保单号
            </label>
            <label class="button active">
                <input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号
            </label> 
            <label class="button active">
                <input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号
            </label>
            <label class="button active">
                <input type="checkbox" name="sbx" value="driverName" checked="checked"><span class="icon icon-check text-green"></span>被保险人
            </label>
           <!-- <label class="button active">
                <input type="checkbox" name="sbx" value="driverPhone" checked="checked"><span class="icon icon-check text-green"></span>被保险人联系电话
            </label>
            <label class="button active">
                <input type="checkbox" name="sbx" value="driverId" checked="checked"><span class="icon icon-check text-green"></span>被保险人身份证号
            </label>-->
            <label class="button active">
                <input type="checkbox" name="sbx" value="insuranceCompany" checked="checked"><span class="icon icon-check text-green"></span>保险人公司名称
            </label>
						<label class="button active">
                <input type="checkbox" name="sbx" value="insuranceMoney" checked="checked"><span class="icon icon-check text-green"></span>保险费
            </label>
            </div>

        </div>

    </div>
   	
   </div>
  



<form action="insuranceSele" method="post" name="vehicleSele">
    <s:hidden name="insurance.carframeNum" />
    <s:hidden name="insurance.insuranceNum" />
    <s:hidden name="vehicle.licenseNum" />
    <s:hidden name="insurance.insuranceClass" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>


</div>
</body>

</html>
