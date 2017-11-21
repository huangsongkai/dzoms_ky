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
        
        function updateAbandondTime(){
        	var $checked =  $('[name="cbx"]:checked');
        	var id = $checked.val();
        	
        	var endTime = $(".dialog-win .endTime").val();
        	var condition = "update Contract set abandonedTime = STR_TO_DATE('"+endTime+"','%Y/%m/%d') where id = "+id;
        	
        	$.post("/DZOMS/common/doit",{"condition":condition},function(data){
        		if(data["affect"]>0){
        			$('name="vehicleSele"').submit();
        		}
        	});
        	
        }

        function _update(){
        	var $checked =  $('[name="cbx"]:checked');
        	if ($checked!=undefined) {
        		$("#update-abandond-time").click();
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
<div class="line">
   <div class="panel  margin-small" >
          	<div class="panel-head">
          		<strong class="text-black">查询结果</strong>
          		<div class="line">
            <div class="xm1 xm8-move">
            <a href="#" onclick="_detail()">
            	<i class="icon-search" style="font-size: 16px;"></i>
            	<span class="h4"><strong>查看</strong></span>
            </a>
            </div>
            
            <div class="xm1">
             <a href="#" onclick="_update()" >
            	<i class="icon-pencil" style="font-size: 16px;"></i>
            	<span class="h4"><strong>修改废业日期</strong></span>
             </a>
            </div>
            
          
      
        </div>

          	</div>
        <div class="panel-body">
            
          
                <table class="table table-striped table-bordered table-hover">

                    <tr>
                        <th>选择</th>
                        <th class="dept selected_able">部门</th>
                        <th class="licenseNum selected_able">车牌号</th>
                        <th class="driverName selected_able">承租人</th>
                        <th class="driverId selected_able">身份证</th>
                        <th class="carframeNum selected_able">车架号</th>
                        <th class="engineNum selected_able">发动机号</th>
                        <th class="carMode selected_able">车辆型号</th>
                        <!--<th class="inDate selected_able">购入日期</th>
                        <th class="certifyNum selected_able">合格证编号</th>-->
                        <th class="pd selected_able">车辆制造日期</th>
                        
                        <th class="beginTime selected_able">合同开始日期</th>
                        <th class="endTime selected_able">合同终止日期</th>
                        <th class="planendTime selected_able">预计废业日期</th>
                    </tr>
                    <s:if test="%{#request.list!=null}">
        
        <s:iterator value="%{#request.list}" var="contract">
        
        <s:set name="v" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#contract.carframeNum)}"></s:set>
                   
<tr id="<s:property value="%{#contract.id}"/>">
 <td><input type="radio" name="cbx" value="<s:property value="%{#contract.id}"/>" ></td>
 <td class="dept selected_able"><s:property value="%{#v.dept}"/></td>
 <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
 <td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>
 <td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>
 
 <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum }"/></td>
 <td class="engineNum selected_able"><s:property value="%{#v.engineNum}"/></td>
 <td class="carMode selected_able"><s:property value="%{#v.carMode}"/></td>
<!-- <td class="inDate selected_able"><s:property value="%{#v.inDate}"/></td>
 <td class="certifyNum selected_able"><s:property value="%{#v.certifyNum}"/></td>-->
 
 <td class="pd selected_able"><s:property value="%{#v.pd}"/></td>

 <td class="beginTime selected_able"><s:property value="%{#contract.contractBeginDate}"/></td>
 <td class="endTime selected_able"><s:property value="%{#contract.contractEndDate}"/></td>
 <td class="planendTime selected_able">
 	<s:if test="%{#contract.abandonedTime==null}">
 		<s:property value="%{#contract.contractEndDate}"/>
 	</s:if>
 	<s:else>
 		<s:property value="%{#contract.abandonedTime}"/>
 	</s:else>
 </td>
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
        <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
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
                <label class="button active">
                    <input type="checkbox" name="sbx" value="dept" checked="checked"><span class="icon icon-check text-green"></span>部门
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="licenseNum"  checked="checked"><span class="icon icon-check text-green"></span>车牌号
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="driverName" checked="checked"><span class="icon icon-check text-green"></span>承租人
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="driverId" checked="checked"><span class="icon icon-check text-green"></span>承租人身份证号
                </label>
                
                <label class="button active">
                    <input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="engineNum" checked="checked"><span class="icon icon-check text-green"></span>发动机号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="carMode" checked="checked"><span class="icon icon-check text-green"></span>车辆型号
                </label>
              <!--  <label class="button active">
                    <input type="checkbox" name="sbx" value="inDate" checked="checked"><span class="icon icon-check text-green"></span>购入日期
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="certifyNum" checked="checked"><span class="icon icon-check text-green"></span>合格证编号
                </label>-->
                
                <label class="button active">
                    <input type="checkbox" name="sbx" value="pd"  checked="checked"><span class="icon icon-check text-green"></span>车辆制造日期
                </label>
                 <label class="button  active">
                    <input type="checkbox" name="sbx" value="beginTime"  checked="checked"><span class="icon icon-check text-green"></span>合同开始日期
                </label>
                 <label class="button  active">
                    <input type="checkbox" name="sbx" value="endTime"  checked="checked"><span class="icon icon-check text-green"></span>合同结束日期
                </label>
                 <label class="button  active">
                    <input type="checkbox" name="sbx" value="planendTime" checked="checked" ><span class="icon icon-check text-green"></span>预计废业日期
                </label>
            </div>

        </div>

    </div>
   	
   </div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
    <s:hidden name="url" value="/vehicle/vehicle_abandond_plan_result.jsp" />
    <s:hidden name="condition" />
    <s:hidden name="className" value="com.dz.module.contract.Contract" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>

<div id="mydialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>修改废业日期</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>废业日期</strong>
          			<input class="datepick2 input endTime" />
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green dialog-close" onclick="updateAbandondTime()">添加</button> 
   			</div> 
  		</div> 
   </div>

<a id="update-abandond-time"  class="button dialogs bg-gray margin" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%" style="display: none;"></a>

</body>
<script type="text/javascript" src="/DZOMS/res/jquery-ui/jquery-ui.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/jquery-ui/jquery-ui.css" />
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
    
    $(function(){
		$showdialogs=function(e){
		var trigger=e.attr("data-toggle");
		var getid=e.attr("data-target");
		var data=e.attr("data-url");
		var mask=e.attr("data-mask");
		var width=e.attr("data-width");
		var detail="";
		var masklayout=$('<div class="dialog-mask"></div>');
		if(width==null){width="80%";}
		
		if (mask=="1"){
			$("body").append(masklayout);
		}
		detail='<div class="dialog-win" style="position:fixed;width:'+width+';z-index:11;">';
		if(getid!=null){detail=detail+$(getid).html();}
		if(data!=null){detail=detail+$.ajax({url:data,async:false}).responseText;}
		detail=detail+'</div>';
		
		var win=$(detail);
		win.find(".dialog").addClass("open");
		$("body").append(win);
		var x=parseInt($(window).width()-win.outerWidth())/2;
		var y=e.offset().top - win.outerHeight()/2;
		
		if (y<=10){y="10"}
		win.css({"left":x,"top":y});
		win.find(".dialog-close,.close").each(function(){
			$(this).click(function(){
				win.remove();
				$('.dialog-mask').remove();
			});
		});
		masklayout.click(function(){
			win.remove();
			$(this).remove();
		});
		
		$.datepicker.setDefaults($.datepicker.regional['']);//先清理一下语言包的regional 
		$(".datepick2.endTime").datepicker({
			showMonthAfterYear: true,
		});
		
		//$(".datepick2").datepicker(/*{ altFormat: 'yy/mm/dd' }*/{showMonthAfterYear: true}); 
		$(".datepick2").datepicker('option', $.datepicker.regional['zh-CN']); 
		$(".datepick2").datepicker('option', 'dateFormat','yy/mm/dd');
		
		var $checked =  $('[name="cbx"]:checked');
		var $tr = $("#"+$checked.val());
		var planendTime = $tr.find("td.planendTime").val();
		
		var startDate = new Date(),endDate;
		var arr = planendTime.split("/");
        endDate = new Date(arr[0],arr[1]-1,arr[2]);
            
		$(".datepick2").datepicker("option","minDate",startDate);
       	$(".datepick2").datepicker("option","maxDate",endDate);
       	$('.datepick2').datepicker('option', 'changeYear', true);
       	$('.datepick2').datepicker('option', 'changeMonth', true); 
	};
});
    </script>
</html>
