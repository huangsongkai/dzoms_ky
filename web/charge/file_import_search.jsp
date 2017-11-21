<%@page import="com.dz.common.other.ObjectAccess"%>
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
	<title>银行导入查询</title>
	
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
	function refreshSearch(){
		$("[name='vehicleSele']").submit();
	}
	
		$(document).ready(function(){
			$("[name='vehicleSele']").find("select").change(function(){
				$("[name='vehicleSele']").submit();
			});
						
			$("[name='vehicleSele']").submit();
			
			$("[name='vehicleSele']").find("input").change(function(){
				if($(this).val().trim().length==0)
						$("[name='vehicleSele']").submit();
			});
			
		});
		
	var beforeSubmit = function(){
			var filename = $('#filename').val();
			var insertMonth = $('#insertMonth').val();
			
			var condition = " ";
			
			var in_date_begin = $("#in_date_begin").val();
			if(in_date_begin.length>0){
				condition+= "and insertTime>='"+in_date_begin+"' ";
			}
			
			var in_date_end = $("#in_date_end").val();
			if(in_date_begin.length>0){
				condition+= "and insertTime<='"+in_date_end+"' ";
			}
			
			if(filename.trim().length>0){
				condition += "and md5 like '%"+filename.trim()+"%' ";
			}
			
			if (insertMonth.trim().length>0) {
				condition += "and insertMonth='"+insertMonth.trim()+"' ";
			}
		
			$('[name="condition"]').val(condition);
			return true;
	};
	</script>
  </head>
 <body> 
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>查询</li>
                <li>银行导入查询</li>
    </ul>
</div>
 
<form id="search_form" action="/DZOMS/common/selectToList" target="result_form" onsubmit="beforeSubmit()" method="post"
      class="definewidth m20" style="width: 100%;" name="vehicleSele">
    <input type="hidden" name="url" value="/charge/file_import_search_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.charge.BankFile"/>
		<input type="hidden" name="condition" />
		<input type="hidden" name="pageSize" value="20" />
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
                            <td width="15%">操作日期</td>
                            <td width="5%">从</td>
                            <td width="15%"><input type="text" id="in_date_begin" class="input datepick" /></td>
                            <td width="5%">到</td>
                            <td width="15%"><input type="text" id="in_date_end" class="input datepick" /></td>
                        		<td width="5%"><input type="button" class="button" value="清空" onclick="$('#in_date_begin').val('');$('#in_date_end').val('');" /></td>
                            
                           <td width="5%">导入月份</td>
                            <td width="15%">
                            	<input type="text" id="insertMonth" class="datepick2 input"/>
                            </td>
														
														<td width="5%">文件名称</td>
														<td width="15%">
															<input type="text" id="filename" class="input"/>
														</td>
                        </tr>
                       </table>
                       
                </blockquote>
            </div>
        </div>
      </div>
    </div>
  </div>


</form>
<script>
$(".datepick").datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y-m-d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2100,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onClose:function(){
		$("[name='vehicleSele']").submit();
	}
});

$('.datepick2').simpleCanleder();
</script>
<div>
    <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

    </iframe>

</div>
</body>
</html>
