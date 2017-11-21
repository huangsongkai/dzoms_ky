<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
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
	<title>电子违章查询</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
	
	<script>
$(document).ready(function(){
	$("#search_form").find("input,select").change(function(){
		$("#search_form").submit();
	});
			
	$("#search_form").submit();
});

var beforeSubmit = function(){
			var condition = " order by id desc ";
			
			$('[name="condition"]').val(condition);
			return true;
	};
	
function addNewAnaylse(){
  		var beginDate = $(".dialog-win").find(".beginDate").val();
  		var endDate = $(".dialog-win").find(".endDate").val();
  		
  		$.post("/DZOMS/vehicle/makeAnaylse",{"beginDate":beginDate,"endDate":endDate},function(data){
//  			if (data) {
//  				alert(data);
  				$("#search_form").submit();
//  			}
  		});
}
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
		var x=parseInt($(window).width()-win.outerWidth())/2;
		var y = e.offset().top;

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
		
	$('.datepick').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项

	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
});
	};
	});
</script>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
        <li>车辆管理</li>
        <li>查询</li>
        <li>电子违章信息统计</li>
    </ul>
</div>
 <div id="mydialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>新增统计</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			  <strong>起始日期</strong>
          			<input class="input beginDate datepick" />
          			<strong>结束日期</strong>
          			<input class="input endDate datepick"/>
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green dialog-close" onclick="addNewAnaylse()">添加</button> 
   			</div> 
  		</div> 
   </div>
<form method="post" class="form-inline" id="search_form" action="/DZOMS/common/selectToList" target="result_form" onsubmit="beforeSubmit()">
		<input type="hidden" name="url" value="/vehicle/electric/anaylse_search_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.vehicle.electric.ElectricAnaylse"/>
		<input type="hidden" name="condition" />
   <div class="line">
   		<div class="form-group">
          <input class="button" type="submit" value="查询" />
      </div>
      <div class="form-group">
          <input type="button" value="新增统计" class="button dialogs" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%" />
      </div>
   		<!--<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        	<div class="line">
        		<div class="xm12 padding">
                <blockquote class="panel-body">
                    <table class="table" style="border: 0px;">
                        <tr>
                           
                        </tr>
                    </table>
                </blockquote>
            </div>
        </div>
      </div>
    </div>-->
  </div>
</form>
<script>
$('.datepick').datetimepicker(
{
      lang:"ch",           //语言选择中文
      format:"Y-m-d H:i:s",
      onClose:function(){
      	$("#search_form").submit();
      }
});
</script>
<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

    </iframe>

</div>

</body>
 <script src="/DZOMS/res/js/apps.js"></script>
    <script>
    	function iFrameHeight() {
	try{
var ifm= document.getElementById("result_form");   
var subWeb = document.frames ? document.frames["result_form"].document : ifm.contentDocument;   
if(ifm != null && subWeb != null) {
   ifm.height = subWeb.body.scrollHeight+200;
}   }catch(e){}
}    

$(document).ready(function(){
	window.setInterval('iFrameHeight();',1000);
});
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
