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
            var url = "/DZOMS/vehicle/vehiclePreupdate?vehicle.carframeNum="+selected_val;
            //	alert(url);
            //$(window.top.document,"#main").attr("src",url);
            window.open(url,"车辆修改",'width=800,height=600,resizable=yes,scrollbars=yes');
        }
        
         function _toExcel(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/vehiclePreupdate?vehicle.carframeNum="+selected_val;
            //	alert(url);
            //$(window.top.document,"#main").attr("src",url);
            window.open(url,"车辆修改",'width=800,height=600,resizable=yes,scrollbars=yes');
        }
         
         function _toExcelDaily(){
         	
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
          	    <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm4 xm6-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                    	<a  class="button dialogs bg-gray margin" data-toggle="click" data-target="#SingleDailyDialog" data-mask="1" data-width="50%">
				   																	<i class="icon-file-excel-o" style="font-size: 20px;"></i>
            	     													<span class="h6 text-blue"><strong>导出日报表</strong></span>
				   															</a>
				   															<a  class="button dialogs bg-gray margin" data-toggle="click" data-target="#DailyDialog" data-mask="1" data-width="50%">
				   																	<i class="icon-file-excel-o" style="font-size: 20px;"></i>
            	     													<span class="h6 text-blue"><strong>导出报表(按日计)</strong></span>
				   															</a>
				   															<a  class="button dialogs bg-gray margin" data-toggle="click" data-target="#MonthDialog" data-mask="1" data-width="50%">
				   																	<i class="icon-file-excel-o" style="font-size: 20px;"></i>
            	     													<span class="h6 text-blue"><strong>导出月报表</strong></span>
				   															</a>
				   															<a  class="button dialogs bg-gray margin" data-toggle="click" data-target="#YearlyDialog" data-mask="1" data-width="50%">
				   																	<i class="icon-file-excel-o" style="font-size: 20px;"></i>
            	     													<span class="h6 text-blue"><strong>导出年报表</strong></span>
				   															</a>
		                                   <!-- <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出日报表</button>
			                                  <button onclick="_toExcelDaily()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出报表(按日计)</button>
			                                  <button onclick="_toExcelMonthly()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出月报表</button>
			                                  <button onclick="_toExcelYearly()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出年报表</button>    -->              
                                     </div>
                                </div>
          	        	</div>
          	        </div>	
          </div>
        <div class="panel-body">
            
          
                <table class="table table-striped table-bordered table-hover">

                    <tr>
<th>选择</th>
<th class="dept selected_able">部门</th>
<th class="serviceBegin selected_able">日期</th>
<th class="money selected_able">营运金额(平均)</th>
<th class="allDistance selected_able">行驶里程(平均)</th>
<th class="times selected_able">营运次数(平均)</th>
<th class="uselessDistance selected_able">空驶里程(平均)</th>
<th class="effectiveDistance selected_able">营运里程(平均)</th>
<th class="distancePer selected_able">空驶率</th>
                    </tr>
       <s:if test="%{#request.list!=null}">
       	<%
       		request.setAttribute("nformat",new java.text.DecimalFormat("#.00"));
       	%>
        <s:set name="nformat" value="%{#request.nformat}"></s:set>
        <s:iterator value="%{#request.list}" var="v">
                   
<tr>
 <td><input type="radio" name="cbx" value="<s:property value="%{#v.id}"/>" ></td>
 <td class="dept selected_able"><s:property value="%{#v.dept }"/></td>
<td class="serviceBegin selected_able"><s:property value="%{#v.date }"/></td>
<td class="money selected_able"><s:property value="%{#nformat.format(#v.money / #v.number)}"/></td>
<td class="allDistance selected_able"><s:property value="%{#nformat.format(#v.allDistance / #v.number) }"/></td>
<td class="times selected_able"><s:property value="%{#nformat.format(#v.times / #v.number) }"/></td>
<td class="uselessDistance selected_able"><s:property value="%{#nformat.format(#v.uselessDistance / #v.number) }"/></td>
<td class="effectiveDistance selected_able"><s:property value="%{#nformat.format(#v.effectiveDistance / #v.number) }"/></td>
<td class="distancePer selected_able"><s:property value="%{#nformat.format(#v.uselessDistance *1.0 / #v.allDistance *100) }"/>%</td>
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
          		显示项
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="dept" checked="checked"><span class="icon icon-check text-green"></span>部门</label>
<label class="button active"><input type="checkbox" name="sbx" value="serviceBegin" checked="checked"><span class="icon icon-check text-green"></span>日期</label>
<label class="button active"><input type="checkbox" name="sbx" value="money" checked="checked"><span class="icon icon-check text-green"></span>营运金额</label>
<label class="button active"><input type="checkbox" name="sbx" value="allDistance" checked="checked"><span class="icon icon-check text-green"></span>行驶里程</label>
<label class="button active"><input type="checkbox" name="sbx" value="times" checked="checked"><span class="icon icon-check text-green"></span>营运次数</label>
<label class="button active"><input type="checkbox" name="sbx" value="uselessDistance" checked="checked"><span class="icon icon-check text-green"></span>空驶里程</label>
<label class="button active"><input type="checkbox" name="sbx" value="effectiveDistance" checked="checked"><span class="icon icon-check text-green"></span>营运里程</label>
<label class="button active"><input type="checkbox" name="sbx" value="distancePer" checked="checked"><span class="icon icon-check text-green"></span>空驶率</label>
            </div>

        </div>

    </div>
   	
   </div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
		<input type="hidden" name="url" value="/vehicle/service/search_daily_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.vehicle.service.ServiceDaily"/>
		<s:hidden name="condition" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>

<!--弹出对话框-->
	<div id="SingleDailyDialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>导出日报表</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>选择日期</strong>
          		<input class="datepick input theDate"/>
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green dialog-close" onclick="SingleDailyExport()">导出</button> 
   			</div> 
  		</div> 
   </div>
   
   <div id="DailyDialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>导出报表(按日)</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>起始日期</strong>
          		<input class="datepick input beginDate"/>
      			</div>
      			<div>
         			<strong>结束日期(含)</strong>
          		<input class="datepick input endDate"/>
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green dialog-close" onclick="DailyExport()">导出</button> 
   			</div> 
  		</div> 
   </div>
   
   <div id="MonthDialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>导出月报表</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>选择月份</strong>
          		<input class="datepick input theMonth"/>
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green dialog-close" onclick="MonthlyExport()">导出</button> 
   			</div> 
  		</div> 
   </div>
   
   <div id="YearlyDialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>导出年报表</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>年份</strong>
          		<input class="input theYear"/>
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green dialog-close" onclick="YearlyExport()">导出</button> 
   			</div> 
  		</div> 
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
<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
<script>
var SingleDailyDialogHTML,DailyDialogHTML,MonthDialogHTML,YearlyDialogHTML;
$(document).ready(function(){
  SingleDailyDialogHTML = $("#SingleDailyDialog").html();
  DailyDialogHTML = $("#DailyDialog").html();
  MonthDialogHTML = $("#MonthDialog").html();
  YearlyDialogHTML = $("#YearlyDialog").html();
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
				$("#SingleDailyDialog").html(SingleDailyDialogHTML);
				$("#DailyDialog").html(DailyDialogHTML);
				$("#MonthDialog").html(MonthDialogHTML);
				$("#YearlyDialog").html(YearlyDialogHTML);
			});
		});
		masklayout.click(function(){
			win.remove();
			$(this).remove();
		});
		
$(".theDate,.beginDate,.endDate").datetimepicker({
	lang:"ch",          
	format:"Y/m/d",     
	timepicker:false,   
	yearStart:2000,    
	yearEnd:2050,      
});

$('.theMonth').simpleCanleder();
	};
});

function SingleDailyExport(){
	var theDate = $(".dialog-win .theDate").val();
	var url = "/DZOMS/vehicle/singleDailyExport?theDate="+theDate;
	window.open(url,"单日数据导出",'width=800,height=600,resizable=yes,scrollbars=yes');
}

function DailyExport(){
	
}

function MonthlyExport(){
	
}

function YearlyExport(){
	
}
</script>
</html>
