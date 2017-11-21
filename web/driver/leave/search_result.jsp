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
		if(selected_val==undefined){
			alert('您没有选择任何一条数据');
			return;
		}
		var $tr = $("input[name='cbx']:checked").parents("tr");
		var finished = $tr.hasClass("finished");
		
		if (finished) {
			alert('该项已审批！');
			return;
		}
		
		person = $tr.find("td.name").text()+"("+$tr.find("td.idNum").text()+")";
		
		applyType = $tr.hasClass("leave");
		
		if (applyType) {
			applyUrl = "/DZOMS/driver/leave/ShenpiLeaveApply?driverleave.id="+selected_val;
		} else{
			applyUrl = "/DZOMS/driver/leave/ShenpiLeaveCancelApply?driverleave.id="+selected_val;
		}
		$("#show_dialog_but").click();
	}
	
	var applyUrl="";
	var applyType = false;
	var person="";
	
	function doApply(){
		$.post(applyUrl,{},function(data){
			$("[name='vehicleSele']").submit();
		});
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
	                                     	<!--<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		查看</button>-->
	                               		<s:if test="#session.roles.{?#this.rname=='待岗审批权限'}.size>0">
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            审批</button>
			                                                            </s:if>
<button id="show_dialog_but" class="button button-big bg-main dialogs" data-toggle="click" style="display: none;" data-target="#mydialog" data-mask="1" data-width="50%"> 弹出对话框</button>
                                     </div>
                                </div>
          	        	</div>
          	        </div>
          		
          	
          		
          	</div>
       
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
                    <th>选择</th>
                    <th class="name                    selected_able">姓名        </th>
<th class="idNum                   selected_able">身份证号    </th>
<th class="licenseNum              selected_able">车牌号      </th>
<th class="carframeNum             selected_able">车架号      </th>
<th class="department              selected_able">分公司归属  </th>
<th class="isRepresented            selected_able">是否代办      </th>
<th class="representName              selected_able">代办人  </th>
<th class="representIdnum               selected_able">代办人身份证号      </th>
<th class="operation               selected_able">事项      </th>
<th class="state               selected_able">状态      </th>
<th class="opeTime                 selected_able">时间	  </th>
<th class="operator                 selected_able">办理人	  </th>

                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <tr class="<s:if test="%{#v.operation=='待岗申请'}">leave</s:if> <s:if test="%{#v.finished==true}">finished</s:if>">
                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.id}'/>" ></td>
                          <td class="name selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNumber).name}"/></td>
<td class="idNum selected_able"><s:property value="%{#v.idNumber}"/></td>
<td class="licenseNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
<td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
<td class="department selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).dept}"/></td>
<td class="isRepresented selected_able"><s:property value="%{#v.isRepresented?'是':'否'}"/></td>
<td class="representName selected_able"><s:property value="%{#v.representName}"/></td>
<td class="representIdnum selected_able"><s:property value="%{#v.representIdnum}"/></td>
<td class="operation selected_able"><s:property value="%{#v.operation}"/></td>
<td class="state selected_able"><s:property value="%{#v.finished?'已审批':'未审批'}"/></td>
<td class="opeTime selected_able"><s:property value="%{#v.opeTime}"/></td>
<td class="operator selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.operator).uname}"/></td>
                        </tr>
                    </s:iterator>

            </table>
            <div>

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
</div>
    </div>
    <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项
          		
          	
          		
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="name" checked="checked"><span class="icon icon-check text-green"></span>姓名</label>
<label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号</label>
<label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号</label>
<label class="button active"><input type="checkbox" name="sbx" value="department" checked="checked"><span class="icon icon-check text-green"></span>分公司归属</label>
<label class="button active"><input type="checkbox" name="sbx" value="isRepresented" checked="checked"><span class="icon icon-check text-green"></span>是否代办</label>
<label class="button active"><input type="checkbox" name="sbx" value="representName" checked="checked"><span class="icon icon-check text-green"></span>代办人</label>
<label class="button active"><input type="checkbox" name="sbx" value="representIdnum" checked="checked"><span class="icon icon-check text-green"></span>代办人身份证号</label>
<label class="button active"><input type="checkbox" name="sbx" value="operation" checked="checked"><span class="icon icon-check text-green"></span>事项</label>
<label class="button active"><input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>状态</label>
<label class="button active"><input type="checkbox" name="sbx" value="opeTime" checked="checked"><span class="icon icon-check text-green"></span>时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="operator" checked="checked"><span class="icon icon-check text-green"></span>办理人</label>
            </div>

        </div>

    </div>



    <form action="/DZOMS/driver/leave/searchRecord" method="post" name="vehicleSele">
        <s:hidden name="beginDate" />
        <s:hidden name="endDate" />
        <s:hidden name="vehicle.licenseNum"/>
        <s:hidden name="driver.idNum"/>
        <s:hidden name="finished"/>
        <s:hidden name="operation"/>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage" />
    </form>


</div>
</div>

<div id="mydialog"> 
	<div class="dialog"> 
		<div class="dialog-head"> 
			<span class="close rotate-hover"></span><strong>审批</strong> 
		</div> 
		<div class="dialog-body"> 是否通过<span class="person"></span>的<span class="apply"></span>审批</div> 
		<div class="dialog-foot"> 
			<button class="button dialog-close"> 取消</button> 
			<button class="button bg-green dialog-close" onclick="doApply()"> 确认</button> 
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
    <script>
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
		
		$('.dialog-win span.person').text(person);
		$('.dialog-win span.apply').text(applyType?'待岗':'上岗');
		/**
		 * Show next to selector
		 */
		var e_top = e.offset().top-win.outerHeight();
		
		var x=parseInt($(window).width()-win.outerWidth())/2;
		//var y=parseInt($(window).height()-win.outerHeight())/2;
		var y = e_top;
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
	};
});
    </script>
</html>