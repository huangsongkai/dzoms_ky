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
		if(selected_val==undefined){
			alert('您没有选择任何一条数据');
			return;
		}
		var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.driver.homevisit.HomeVisit&ids[0].id="+selected_val+"&ids[0].isString=false"+"&url=%2fdriver%2fhomevisit%2fshow.jsp";
		window.open(url,"家访信息",'width=800,height=600,resizable=yes,scrollbars=yes');
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
		if(currentPage==<s:property value="%{#session.page.totalPage}"/>){
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
		$("#page-input").val(currentPage + "/<s:property value="%{#session.page.totalPage}"/>");
		
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
          		<div class="float-left">
          			<span class="h4"><strong class="text-black">查询结果</strong></span>
          		</div>
          		
          		<div style="text-align: right;">
                    <a href="javascript:;" class="button border-main bg-yellow" data-click="panel-collapse"><i class="icon icon-minus text-white"></i></a>
                    <a href="javascript:;" class="button border-main bg-red" data-click="panel-remove"><i class="icon icon-times text-white"></i></a>
                </div>
          		
          	</div>
        <div class="line">
            <div class="xm1 xm8-move">
            <a href="#" onclick="_detail()">
            	<i class="icon-search" style="font-size: 30px;"></i>
            	<span class="h4"><strong>查看</strong></span>
            </a>
            </div>
            
           <!-- <div class="xm1">
             <a href="#" onclick="_update()" >
            	<i class="icon-pencil" style="font-size: 30px;"></i>
            	<span class="h4"><strong>修改</strong></span>
             </a>
            </div>
            -->
          
            
            <!--<div class="xm1">
             <a href="#" onclick="_toExcel()">
            	<i class="icon-file-excel-o" style="font-size: 30px;"></i>
            	<span class="h4"><strong>Excel</strong></span>
             </a>
            </div>
            <div class="xm1">
            <a href="#" onclick="_toPrint()">
            	<i class="icon-print" style="font-size: 30px;"></i>
            	<span class="h4"><strong>打印空表</strong></span>
             </a>
            </div>-->
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
<th>选择</th>
<th class="carframeNum selected_able">车号</th>
<th class="idName selected_able">姓名</th>
<th class="idNum selected_able">身份证号</th>
<th class="idPhone selected_able">联系电话</th>
<th class="firm selected_able">分公司归属</th>
<th class="time selected_able">家访日期</th>
<th class="registe selected_able">家访人</th>
<th class="record selected_able">家访记录</th>
<th class="comment selected_able">备注</th>
                </tr>
                <s:if test="%{#session.list!=null}">

                    <s:iterator value="%{#session.list}" var="v">
                        <tr>
<td><input type="radio" name="cbx" value="<s:property value="%{#v.id}"/>" ></td>
<td class="carframeNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
<td class="idName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNum).name}"/></td>
<td class="idNum selected_able"><s:property value="%{#v.idNum}"/></td>
<td class="idPhone selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNum).phoneNum1}"/></td>
<td class="firm selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNum).dept}"/></td>
<td class="time selected_able"><s:property value="%{#v.time}"/></td>
<td class="registe selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.register).uname}"/></td>
<td class="record selected_able"><s:property value="%{#v.record}"/></td>
<td class="comment selected_able"><s:property value="%{#v.comment}"/></td>
                        </tr>
                    </s:iterator>
								</s:if>
            </table>
            <div>
<s:if test="%{#session.list!=null}">
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
                    			<input class="input input-auto" size="4" value="1/<s:property value="%{#session.page.totalPage}"/>" id="page-input" >
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
  </div>
    <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		<div class="float-left">
          			<span class="h4"><strong class="text-black">显示项</strong></span>
          		</div>
          		
          		<div style="text-align: right;">
                    <a href="javascript:;" class="button border-main bg-yellow" data-click="panel-collapse"><i class="icon icon-minus text-white"></i></a>
                    <a href="javascript:;" class="button border-main bg-red" data-click="panel-remove"><i class="icon icon-times text-white"></i></a>
                </div>
          		
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车号</label>
<label class="button active"><input type="checkbox" name="sbx" value="idName" checked="checked"><span class="icon icon-check text-green"></span>姓名</label>
<label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号</label>
<label class="button active"><input type="checkbox" name="sbx" value="idPhone" checked="checked"><span class="icon icon-check text-green"></span>联系电话</label>
<label class="button active"><input type="checkbox" name="sbx" value="firm" checked="checked"><span class="icon icon-check text-green"></span>分公司归属</label>
<label class="button active"><input type="checkbox" name="sbx" value="time" checked="checked"><span class="icon icon-check text-green"></span>家访日期</label>
<label class="button active"><input type="checkbox" name="sbx" value="registe" checked="checked"><span class="icon icon-check text-green"></span>家访人</label>
<label class="button active"><input type="checkbox" name="sbx" value="record" checked="checked"><span class="icon icon-check text-green"></span>家访记录</label>
<label class="button active"><input type="checkbox" name="sbx" value="comment" checked="checked"><span class="icon icon-check text-green"></span>备注</label>
            </div>

        </div>

    </div>



<form action="driver/homevisit/searchHomeVisit" method="post" name="vehicleSele">
    <s:hidden name="beginDate" />
    <s:hidden name="endDate" />
    <input type="hidden" name="url" value="search_result.jsp"/>
		<s:hidden name="condition" />
    <s:hidden name="currentPage" value="%{#session.page.currentPage}" id="currentPage"></s:hidden>
</form>

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
</html>
