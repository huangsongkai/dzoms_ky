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

        function _update(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/invoice_revoke?vehicle.carframeNum="+selected_val+"&url=%2fvehicle%2fvehicle%2finvoice_add.jsp";
            window.parent.location.href=url;
        }
        
        function _detail(){
        	 var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/vehicleShow?vehicle.carframeNum="+selected_val+"&url=%2fvehicle%2fvehicle%2finvoice_show.jsp";
            window.open(url,"车辆发票信息查看",'width=800,height=600,resizable=yes,scrollbars=yes');
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
	                               		<s:if test="#session.roles.{?#this.rname=='发票修改权限'}.size>0">   	
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            状态回退</button>
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
          
            <s:if test="%{#request.vehicle!=null}">
                <table class="table table-bordered table-hover table-striped">

                    <tr>
                        <th>选择</th>

<th class="carframeNum selected_able">车架号</th>
<th class="invoiceNumber selected_able">发票号</th>
<th class="invoiceDate selected_able">开票日期</th>
<th class="invoiceMoney selected_able">价税合计</th>
<th class="purseFrom selected_able">销货单位名称</th>
<th class="licenseNum selected_able">车牌号</th>
<th class="invoiceRegister selected_able">登记人</th>
<th class="invoiceRegistTime selected_able">登记时间</th>
                        
                    </tr>
                    
        
        <s:iterator value="%{#request.vehicle}" var="v">
                   
                    <tr onDblClick="changesinformation('<s:property value="%{#v.carframeNum}"/>')">
 <td><input type="radio" name="cbx" value="<s:property value="%{#v.carframeNum}"/>" ></td>
 <td class="carframeNum		selected_able"><s:property value="%{#v.carframeNum		}"/></td>
<td class="invoiceNumber	selected_able"><s:property value="%{#v.invoiceNumber	}"/></td>
<td class="invoiceDate 		selected_able"><s:property value="%{#v.invoiceDate 		}"/></td>
<td class="invoiceMoney 	selected_able"><s:property value="%{#v.invoiceMoney 	}"/></td>
<td class="purseFrom 		selected_able"><s:property value="%{#v.purseFrom 		}"/></td>
<td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
<td class="invoiceRegister 	selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.invoiceRegister).uname}"/></td>
<td class="invoiceRegistTime selected_able"><s:property value="%{#v.invoiceRegistTime}"/></td>
 </tr>
                    </s:iterator>
                </table>
           </s:if>
           <s:if test="%{#request.vehicle!=null}">
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
        <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
           <% request.setAttribute("q","'");%>
      <s:set name="sumHql" value="%{'select sum(invoiceMoney) from Vehicle where 1=1 '+#attr.condition+'and dept like '+#request.q+'%'+vehicle.dept+'%'+#request.q}"></s:set>
      <s:set name="sumOfMoney" value="%{@com.dz.common.other.ObjectAccess@execute(#sumHql)}"></s:set>
            合计金额：<s:property value="%{@java.lang.String@format('%6.2f',#sumOfMoney)}"/>
        </div>
    </div>
</div>
  <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          	显示项
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号</label>

<label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>	车架号		</label>
<label class="button active"><input type="checkbox" name="sbx" value="invoiceNumber" checked="checked"><span class="icon icon-check text-green"></span>发票号		</label>  
<label class="button active"><input type="checkbox" name="sbx" value="invoiceDate" checked="checked"><span class="icon icon-check text-green"></span>开票日期	</label>
<label class="button active"><input type="checkbox" name="sbx" value="invoiceMoney" checked="checked"><span class="icon icon-check text-green"></span>价税合计	</label>
<label class="button active"><input type="checkbox" name="sbx" value="purseFrom" checked="checked"><span class="icon icon-check text-green"></span>	销货单位名称</label>
<label class="button active">
                    <input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号
                </label>
<label class="button active"><input type="checkbox" name="sbx" value="invoiceRegister" checked="checked"><span class="icon icon-check text-green"></span>登记人		</label>
<label class="button active"><input type="checkbox" name="sbx" value="invoiceRegistTime" checked="checked"><span class="icon icon-check text-green"></span>	登记时间	</label>
            </div>

        </div>

    </div>
   	
   </div>


<form action="vehicleSele" method="post" name="vehicleSele">
		<input type="hidden" name="url" value="/vehicle/vehicle/invoice_search_result.jsp" />
    <s:hidden name="vehicle.carframeNum" />
    <s:hidden name="vehicle.engineNum" />
    <s:hidden name="vehicle.carMode" />
    <s:hidden name="vehicle.inDate" />
    <s:hidden name="vehicle.certifyNum" />
    <s:hidden name="vehicle.dept" />
    <s:hidden name="vehicle.pd" />
    <s:hidden name="vehicle.driverId" />
    <s:hidden name="driverName" />
    <s:hidden name="vehicle.invoiceNumber" />
    <s:hidden name="vehicle.taxNumber" />
    <s:hidden name="vehicle.licenseNum" />
    <s:hidden name="vehicle.operateCard" />
    <s:hidden name="vehicle.businessLicenseNum" />
    <s:hidden name="condition" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
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
