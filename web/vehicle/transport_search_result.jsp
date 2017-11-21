<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
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
	<title>车辆查询结果</title>
	
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
        function showinformation(id){
            var url = "/DZOMS/vehicle/vehiclePreshow?vehicle.carframeNum="+id;
            //alert(url);
            window.open(url,"车辆详情",'width=800,height=600,resizable=yes,scrollbars=yes');
        }
  function _selectAll(){
     $("input[name='cbx']").each(function(){
       	$(this).prop("checked",true);
     });
  }
  
  function _printCarNumber(){
  	var carlist="";
    $("input[name='cbx']:checked").each(function(){
      var $this = $(this);
      carlist+=",'"+$this.val()+"'";
    });
          
    carlist=carlist.substr(1);
    
    var url = "/DZOMS/common/selectToList?className=com.dz.module.vehicle.Vehicle&condition=and+carframeNum+in+("+encodeURI(carlist)+")&url=%2fvehicle%2ftransport%2fprint_car_number.jsp";
    window.open(url,"打印车号",'width=800,height=600,resizable=yes,scrollbars=yes');
  }
  
  function _exportCarNumber(){
  	var carlist="";
    $("input[name='cbx']:checked").each(function(){
      var $this = $(this);
      carlist+=",'"+$this.val()+"'";
    });
          
    carlist=carlist.substr(1);
    
    var url = "/DZOMS/common/selectToList?className=com.dz.module.vehicle.Vehicle&condition=and+carframeNum+in+("+encodeURI(carlist)+")&url=%2fvehicle%2ftransport%2fexport_car_number.jsp";
    window.open(url,"打印二保",'width=800,height=600,resizable=yes,scrollbars=yes');
  }
  
  function _exportExcel(){
  	var path = $("[name='vehicleSele']").attr("action");
		var target = $("[name='vehicleSele']").attr("target");
		
		var url = "/DZOMS/driver/driverToExcel";
		$("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();
  }
  
  function _printSecond(){
  	var carlist="";
    $("input[name='cbx']:checked").each(function(){
      var $this = $(this);
      carlist+=",'"+$this.val()+"'";
    });
          
    carlist=carlist.substr(1);
    
    var url = "/DZOMS/common/selectToList?className=com.dz.module.vehicle.Vehicle&condition=and+carframeNum+in+("+encodeURI(carlist)+")&url=%2fvehicle%2ftransport%2fprint_second.jsp";
    window.open(url,"客运检车",'width=800,height=600,resizable=yes,scrollbars=yes');
  }
  
  function _carClerk(){
  	var carlist="";
    $("input[name='cbx']:checked").each(function(){
      var $this = $(this);
      carlist+=",'"+$this.val()+"'";
    });
          
    carlist=carlist.substr(1);
    
    var url = "/DZOMS/common/selectToList?className=com.dz.module.vehicle.Vehicle&condition=and+carframeNum+in+("+encodeURI(carlist)+")&url=%2fvehicle%2ftransport%2fcar_cleck.jsp";
    window.open(url,"通知",'width=800,height=600,resizable=yes,scrollbars=yes');
  }
    </script>
</head>
<body>
<div class="line margin-small">
<div><strong>自定义显示项</strong></div>
<div class="button-group checkbox bg-blue-light" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="driverName" checked="checked"><span class="icon icon-check text-green"></span>承租人</label>
<label class="button active"><input type="checkbox" name="sbx" value="driverId" checked="checked"><span class="icon icon-check text-green"></span>承租人身份证号</label>
<label class="button active"><input type="checkbox" name="sbx" value="engineNum" checked="checked"><span class="icon icon-check text-green"></span>发动机号</label>
<label class="button active"><input type="checkbox" name="sbx" value="moneyCountor" checked="checked"><span class="icon icon-check text-green"></span>计价器号</label>
<label class="button active"><input type="checkbox" name="sbx" value="carMode" checked="checked"><span class="icon icon-check text-green"></span>车辆型号</label>
<label class="button active"><input type="checkbox" name="sbx" value="fuel" checked="checked"><span class="icon icon-check text-green"></span>燃油类型</label>
<label class="button active"><input type="checkbox" name="sbx" value="color" checked="checked"><span class="icon icon-check text-green"></span>颜色</label>
<label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号</label>
<label class="button active"><input type="checkbox" name="sbx" value="dept" checked="checked"><span class="icon icon-check text-green"></span>归属部门</label>
</div>
<!--<div class="checkbox" id="show_div">
<input type="checkbox" name="sbx" value="licenseNum" checked="checked">车牌号<br>
<input type="checkbox" name="sbx" value="driverName" checked="checked">承租人
<input type="checkbox" name="sbx" value="driverId" checked="checked">承租人身份证号
<input type="checkbox" name="sbx" value="engineNum" checked="checked">发动机号
<input type="checkbox" name="sbx" value="moneyCountor" checked="checked">计价器号
<input type="checkbox" name="sbx" value="carMode" checked="checked">车辆型号
<input type="checkbox" name="sbx" value="fuel" checked="checked">燃油类型
<input type="checkbox" name="sbx" value="color" checked="checked">颜色
<input type="checkbox" name="sbx" value="carframeNum" checked="checked">车架号
<input type="checkbox" name="sbx" value="dept" checked="checked">归属部门
</div>-->
</div>
<div class="line">
   <div class="panel  margin-small" >
        <div class="panel-head">
          	    <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm7 xm3-move">
           	<div class="button-toolbar">
	            <div class="button-group">
            	 <button onclick="_selectAll()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			  本页全选</button>
			        <button onclick="_printCarNumber()" type="button" class="button icon-print text-green" style="line-height: 6px;">
			  打印车号</button>
			  <button onclick="_exportExcel()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			  导出车号</button>
			  <button onclick="_exportCarNumber()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			  打印二保</button>
			  <button onclick="_printSecond()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			  客运检车</button>
			  <button onclick="_carClerk()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			  通知</button>
          </div>
          </div>
            </div>
        </div>
       </div>
        <div class="panel-body ">
           
           
            <div class="xm12">
                <table class="table table-bordered table-hover table-striped">

                    <tr>
                        <th>选择</th>
<th class="licenseNum selected_able">车牌号</th>
<th class="driverName selected_able">承租人</th>
<th class="driverId selected_able">承租人身份证号</th>
<th class="engineNum selected_able">发动机号</th>
<th class="moneyCountor selected_able">计价器号</th>
<th class="carMode selected_able">车辆型号</th>
<th class="fuel selected_able">燃油类型</th>
<th class="color selected_able">颜色</th>
<th class="carframeNum selected_able">车架号</th>
<th class="dept selected_able">归属部门</th>
                    </tr>
                    <s:if test="%{#request.vehicle!=null}">
        
        <s:iterator value="%{#request.vehicle}" var="v">
                   
<tr onDblClick="showinformation('<s:property value="%{#v.carframeNum}"/>')">
<td><input type="checkbox" name="cbx" value="<s:property value="%{#v.carframeNum}"/>" ></td>
<td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
<td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>
<td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>
<td class="engineNum selected_able"><s:property value="%{#v.engineNum}"/></td>
<td class="moneyCountor selected_able"><s:property value="%{#v.moneyCountor}"/></td>
<td class="carMode selected_able"><s:property value="%{#v.carMode}"/></td>
<s:set name="p_carMode" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.VehicleMode',#v.carMode)}"></s:set>
<td class="fuel selected_able"><s:property value="%{#p_carMode.fuel}"/></td>
<td class="color selected_able"><s:property value="%{#p_carMode.color}"/></td>
<td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
<td class="dept selected_able"><s:property value="%{#v.dept}"/></td>
 </tr>
                    </s:iterator>
                </table>
            </div>
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
    </table>无查询结果
    </s:else>
        </div>
        <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
        </div>
 
</div>
</div>

<form action="vehicleSele" method="post" name="vehicleSele">
	<input type="hidden" name="url" value="/vehicle/transport_search_result.jsp" />
    <s:hidden name="vehicle.carframeNum" />
    <s:hidden name="vehicle.engineNum" />
    <s:hidden name="vehicle.carMode" />
    <s:hidden name="vehicle.inDate" />
    <s:hidden name="vehicle.certifyNum" />
    <s:hidden name="vehicle.dept" />
    <s:hidden name="vehicle.pd" />
    <s:hidden name="vehicle.driverId" />
    <s:hidden name="vehicle.driverName" />
    <s:hidden name="vehicle.licenseNum" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
</body>




