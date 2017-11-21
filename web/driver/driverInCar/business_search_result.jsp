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
		var url = "/DZOMS/driver/driverPreshow?driver.idNum="+selected_val;
		window.open(url,"驾驶员明细",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/driver/driverPreupdate?driver.idNum="+selected_val;
		window.open(url,"驾驶员修改",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _toExcel(){
		var path = $("[name='vehicleSele']").attr("action");
		var target = $("[name='vehicleSele']").attr("target");
		
		var url = "/DZOMS/driver/driverToExcel";
		$("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();
	}
	
	function _toPrint(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/driver/driverPreprint?driver.idNum="+selected_val;
		window.open(url,"驾驶员打印",'width=800,height=600,resizable=yes,scrollbars=yes');
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
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
		                                    <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出</button>
			                                  <button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
			                                                            打印</button>
                                     </div>
                                </div>
          	        	</div>
          	        </div>
          	</div>
       
 
            <!--<div class="xm1 xm8-move">
            <a href="#" onclick="_detail()">
            	<i class="icon-search" style="font-size: 20px;"></i>
            	<span class="h4"><strong>查看</strong></span>
            </a>
            </div>
            
            <div class="xm1">
             <button  onclick="_update()" class="badge" >
             	
            	<i class="icon-pencil" style="font-size: 20px;"></i>
            	<span class="h5"><strong>修改</strong></span>
             </button>
            </div>
            
          
            
            <div class="xm1">
             <a href="#" onclick="_toExcel()">
            	<i class="icon-file-excel-o" style="font-size: 20px;"></i>
            	<span class="h4"><strong>Excel</strong></span>
             </a>
            </div>
            <div class="xm1">
            <a href="#" onclick="_toPrint()">
            	<i class="icon-print" style="font-size: 20px;"></i>
            	<span class="h4"><strong>打印</strong></span>
             </a>
            </div>-->
      
    
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">
                <tr>
                    <th>选择</th>
<th class="licenseNum              selected_able">车牌号(当前)</th>
<th class="OwnerIdNum              selected_able">承租人(当前)</th>
<th class="name                    selected_able">驾驶员姓名  </th>
<th class="sex                     selected_able">性别</th>
<th class="age                     selected_able">年龄</th>
<th class="idNum                   selected_able">身份证号 </th>
<th class="qualificationNum        selected_able">资格证号</th>
<th class="department              selected_able">分公司归属(当前)</th>
<th class="restTime              	selected_able">作息时间(当前)</th>
<th class="driverClass              selected_able">驾驶员属性(当前)</th>
<th class="driverState              selected_able">当前状态</th>
<th class="ApplylicenseNum              selected_able">车牌号(申请)</th>
<th class="Applydepartment              selected_able">分公司归属(申请)</th>
<th class="ApplydriverClass              selected_able">驾驶员属性(申请)</th>
                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <tr>
<td><input type="radio" name="cbx" value="<s:property value='%{#v.idNum}'/>" ></td>
<td class="licenseNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
<s:set name="driverId" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).driverId}"></s:set>
<td class="OwnerIdNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#driverId).name}"/></td>
<td class="name selected_able"><s:property value="%{#v.name}"/></td>
<td class="sex selected_able"><s:property value="%{#v.sex?'男':'女'}"/></td>
<td class="age selected_able"><s:property value="%{#v.age}"/></td>
<td class="idNum selected_able"><s:property value="%{#v.idNum}"/></td>
<td class="qualificationNum selected_able"><s:property value="%{#v.qualificationNum}"/></td>
<td class="department selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).dept}"/></td>
<td class="restTime selected_able"><s:property value="%{#v.restTime}"/></td>
<td class="driverClass selected_able"><s:property value="%{#v.driverClass}"/></td>
<td class="driverState selected_able">
	<s:if test="%{#v.businessApplyCancelState==1&&#v.businessApplyState==1}">
		原证照申请注销中，新证照申请中
	</s:if>
	<s:elseif test="%{#v.businessApplyCancelState==1}">
		证照申请注销中
	</s:elseif>
	<s:elseif test="%{#v.businessApplyState==1}">
		证照申请中
	</s:elseif>
	<s:elseif test="%{#v.businessApplyState==2}">
		证照已申请
	</s:elseif>
	<s:elseif test="%{#v.businessApplyState==0||#v.businessApplyState==null}">
		证照未申请
	</s:elseif>
	<s:else>
		
	</s:else>
</td>
<td class="ApplylicenseNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.businessApplyCarframeNum).licenseNum}"/></td>
<td class="Applydepartment selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.businessApplyCarframeNum).dept}"/></td>
<td class="ApplydriverClass selected_able"><s:property value="%{#v.businessApplyDriverClass}"/></td>
                        </tr>
                    </s:iterator>
</s:if>
            </table>
          <s:if test="%{#request.list!=null}">
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
   </div>
   <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项
          		
          	
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="OwnerIdNum" checked="checked"><span class="icon icon-check text-green"></span>承租人</label>
<label class="button active"><input type="checkbox" name="sbx" value="name" checked="checked"><span class="icon icon-check text-green"></span>驾驶员姓名</label>
<label class="button active"><input type="checkbox" name="sbx" value="sex" checked="checked"><span class="icon icon-check text-green"></span>性别</label>
<label class="button active"><input type="checkbox" name="sbx" value="age" checked="checked"><span class="icon icon-check text-green"></span>年龄</label>
<label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号</label>
<label class="button active"><input type="checkbox" name="sbx" value="qualificationNum" checked="checked"><span class="icon icon-check text-green"></span>资格证号</label>
<label class="button active"><input type="checkbox" name="sbx" value="department" checked="checked"><span class="icon icon-check text-green"></span>分公司归属</label>
<label class="button active"><input type="checkbox" name="sbx" value="restTime" checked="checked"><span class="icon icon-check text-green"></span>作息时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="driverClass" checked="checked"><span class="icon icon-check text-green"></span>驾驶员属性</label>
<label class="button active"><input type="checkbox" name="sbx" value="driverState" checked="checked"><span class="icon icon-check text-green"></span>当前状态</label>
<label class="button active"><input type="checkbox" name="sbx" value="ApplylicenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号(申请)</label>
<label class="button active"><input type="checkbox" name="sbx" value="Applydepartment" checked="checked"><span class="icon icon-check text-green"></span>分公司归属(申请)</label>
<label class="button active"><input type="checkbox" name="sbx" value="ApplydriverClass" checked="checked"><span class="icon icon-check text-green"></span>驾驶员属性(申请)</label>
            </div>

        </div>

    </div>
   	
   </div>
  



    <form action="/DZOMS/driver/driverInCar/searchLicense" method="post" name="vehicleSele">
        <s:hidden name="beginDate" />
        <s:hidden name="endDate" />
        <s:hidden name="idNum"/>
        <s:if test="%{isInCar!=null}">
        	<s:hidden name="isInCar"/>
        </s:if>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage" />
    </form>


</div>
</body>
 <script src="/DZOMS/res/js/apps.js"></script>
    <script>
    $(document).ready(function() {
    	try{
    		 App.init();
    	}catch(e){
    		//TODO handle the exception
    	}
    	
       
        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

    });
    </script>
</html>
