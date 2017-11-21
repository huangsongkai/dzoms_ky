<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Page pg = (Page)request.getAttribute("page");
%>

<m:permission role="查询车辆型号">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

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
		var url = "/DZOMS/vehicle/vehicleModePreshow?vehicleMode.carMode="+selected_val;
		window.open(url,"车辆型号明细",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/vehicle/vehicleModePreupdate?vehicleMode.carMode="+selected_val;
		window.open(url,"车辆型号修改",'width=800,height=600,resizable=yes,scrollbars=yes');
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
	                               		 	<s:if test="#session.roles.{?#this.rname=='车辆型号修改权限'}.size>0">   	
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
			                                </s:if>
                                     </div>
                                </div>
          	        	</div>
          	        </div>
          	</div>
   
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
                    <th>选择</th>
                    <th class="carMode selected_able">车辆型号</th>
            <th class="licenseDate selected_able">发证日期</th>
            <th class="company selected_able">车辆制造企业名称</th>
            <th class="color selected_able">车身颜色</th>
            <th class="brand selected_able">车辆品牌/车辆名称</th>
            <th class="fuel selected_able">燃料种类</th>
            <th class="emission selected_able">排放标准</th>
            <th class="tire selected_able">轮胎规格</th>
                </tr>
                <s:if test="%{#request.vehicleMode!=null}">

                    <s:iterator value="%{#request.vehicleMode}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.carMode}'/>" ></td>
            <td class="carMode selected_able"><s:property value="%{#v.carMode}"/></td>
            <td class="licenseDate selected_able"><s:property value="%{#v.licenseDate}"/></td>
            <td class="company selected_able"><s:property value="%{#v.company}"/></td>
            <td class="color selected_able"><s:property value="%{#v.color}"/></td>
            <td class="brand selected_able"><s:property value="%{#v.brand}"/></td>
            <td class="fuel selected_able"><s:property value="%{#v.fuel}"/></td>
            <td class="emission selected_able"><s:property value="%{#v.emission}"/></td>
            <td class="tire selected_able"><s:property value="%{#v.tire}"/></td>
                        </tr>
                    </s:iterator>
</s:if>
            </table>
          <s:if test="%{#request.vehicleMode!=null}">
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
            <label class="button active"><input type="checkbox" name="sbx" value="carMode" checked="checked"><span class="icon icon-check text-green"></span>车辆型号</label>
            <label class="button active"><input type="checkbox" name="sbx" value="licenseDate" checked="checked"><span class="icon icon-check text-green"></span>发证日期</label>
            <label class="button active"><input type="checkbox" name="sbx" value="company" checked="checked"><span class="icon icon-check text-green"></span>车辆制造企业名称</label>
            <label class="button active"><input type="checkbox" name="sbx" value="color" checked="checked"><span class="icon icon-check text-green"></span>车身颜色</label>
            <label class="button active"><input type="checkbox" name="sbx" value="brand" checked="checked"><span class="icon icon-check text-green"></span>车辆品牌/车辆名称</label>
            <label class="button active"><input type="checkbox" name="sbx" value="fuel" checked="checked"><span class="icon icon-check text-green"></span>燃料种类</label>
            <label class="button active"><input type="checkbox" name="sbx" value="emission" checked="checked"><span class="icon icon-check text-green"></span>排放标准</label>
            <label class="button active"><input type="checkbox" name="sbx" value="tire" checked="checked"><span class="icon icon-check text-green"></span>轮胎规格</label>

            </div>

        </div>

    </div>
   	
   </div>
  
    <form action="vehicleModeSelect" method="post" name="vehicleSele">
    <s:hidden name="vehicleMode.carMode" />
    <s:hidden name="vehicleMode.fuel" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
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
