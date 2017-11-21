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
	<title>错误数据查询</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
	
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	
	<script>
$(document).ready(function(){
	$(".time-order").hide();
	
	$("#range").change(function(){
		if ($("#range").val() == '指定') {
			$(".time-order").show();
		}else{
			$(".time-order").hide();
		}
	});

});

$(document).ready(function(){
			$("#search_form").find("input,select").change(function(){
				$("#search_form").submit();
			});
			
			$("#search_form").submit();
});

function beforeSubmit(){
			var range = $('#range').val();
			var beginDate = $('#beginDate').val();
			var endDate = $('#endDate').val();
			
			var condition = " ";
			
			var date = new Date();

			switch (range){
				case '当日':
						endDate = beginDate = date.format("yyyy/MM/dd");
					break;
				case '当月':
						beginDate = date.format("yyyy/MM")+"/01";
						endDate = new Date(beginDate);
						if (endDate.getMonth()>=11) {
							endDate.setYear(endDate.getYear()+1);
							endDate.setMonth(endDate.getMonth()-11);
						}else{
							endDate.setMonth(endDate.getMonth()+1);
						}
						endDate = new Date(endDate.getTime()-24*60*60*1000);
						endDate = endDate.format("yyyy/MM/dd");
						break;
				case '当年':
						beginDate = date.format("yyyy")+"/01/01";
						endDate = new Date(beginDate);
						endDate.setYear(endDate.getYear()+1901);
						endDate = new Date(endDate.getTime()-24*60*60*1000);
						endDate = endDate.format("yyyy/MM/dd");
						break;
				default:
					break;
			}
			
			if(beginDate.trim().length>0){
				condition += "and serviceBegin >= STR_TO_DATE('"+beginDate.trim()+" 00:00:01','%Y/%m/%d %H:%i:%s') ";
				//condition += "and serviceBegin <= STR_TO_DATE('"+beginDate.trim()+" 23:59:59','%Y/%m/%d %H:%i:%s') ";
			}
			if(endDate.trim().length>0){
				condition += "and serviceEnd <= STR_TO_DATE('"+endDate.trim()+" 23:59:59','%Y/%m/%d %H:%i:%s') ";
			}
			
			$('[name="condition"]').val(condition);
			return true;
}
</script>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
        <li>车辆管理</li>
        <li>查询</li>
        <li>错误数据查询</li>
    </ul>
</div>
 
<form method="post" class="form-inline" id="search_form" action="/DZOMS/common/selectToList" target="result_form" onsubmit="beforeSubmit()">
		<input type="hidden" name="url" value="/vehicle/service/search_err_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.vehicle.service.ServiceError"/>
		<input type="hidden" name="condition" />
   <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		查询条件
          	</div>
        <div class="panel-body">
        	<div class="line">
        		<div class="xm12 padding">
                <blockquote class="panel-body">
                    <table class="table" style="border: 0px;">
                        <tr>
                            <td style="border-top: 0px;">日期范围</td>
                            <td style="border-top: 0px;">
                            <select id="range" class="input">
                            	<option selected="selected">当日</option>
                            	<option>当月</option>
                            	<option>当年</option>
                            	<option>指定</option>
                            </select>
                            </td>
                            <td class="time-order"><input class="datepick" id="beginDate" /></td>
                            <td class="time-order">到</td>
                            <td class="time-order"><input class="datepick" id="endDate" /></td>
                        </tr>
                    </table>
                </blockquote>
            </div>
        </div>
      </div>
    </div>
  </div>


</form>
<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

    </iframe>

</div>

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
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
