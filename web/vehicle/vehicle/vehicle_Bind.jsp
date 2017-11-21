<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>承租人绑定</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>
    
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script>
		$(document).ready(function(){
			$("#idNum").bigAutocomplete({
				url:"/DZOMS/select/driverById",
				condition:" idNum in (select idNum from Contract where state=2) ",
				callback:function(){
					var idNum = $("#idNum").val();
					$.post("/DZOMS/common/getObject",
								{"className":"com.dz.module.driver.Driver","id":idNum,"isString":true},
								function(driver){
									if (driver != undefined) {
											$("#idName").val(driver["name"]);
									} 
								});
				}
			});
			$("#carframe_num").bigAutocomplete({
				url:"/DZOMS/select/vehicleById",
				condition:" state in (0,3) ",
				callback:function(){
					var carframe_num = $("#carframe_num").val();
					$.post("/DZOMS/common/getObject",
								{"className":"com.dz.module.vehicle.Vehicle","id":carframe_num,"isString":true},
								function(vehicle){
									if (vehicle != undefined) {
											$("#department").val(vehicle["dept"]);
											$("#licenseNum").val(vehicle["licenseNum"]);
									}
								});
				}
			});
			
			$("#licenseNum").bigAutocomplete({
			url:"/DZOMS/select/VehicleBylicenseNum",
			condition:" state in (0,3) ",
			doubleClick:true,
			doubleClickDefault:'黑A',
			callback:function(){
				$.post("/DZOMS/common/doit",{"condition":"from Vehicle where licenseNum='"+$("#licenseNum").val()+"' "},function(data){
					if (data!=undefined &&data["affect"]!=undefined ) {
						var vehicle = data["affect"];
						$("#department").val(vehicle["dept"]);
						$("#carframe_num").val(vehicle["carframeNum"]);
					}
				});
			}
		});
		
		if($("#licenseNum").val().trim().length<7){
			$("#licenseNum").val('黑A');
		}
		
		});
	</script>


    <style>
    	  
        .tableleft{
            text-align: right;
            width: 20%;
        }
        .form-group{
        	width: 200px;
        
        	
        }
        .label{
        	width: 90px;
        
        }
        .field{
        	width: 90px;
        }
        input{
        	width: 90px;
        }
    </style>

    <style type="text/css">
        .preview{width:300px;height:150px;border:1px solid #000;overflow:hidden;}
        
    </style>

</head>
<body>
<div>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>新增</li>
                <li>新增车辆技术信息</li>
        </ul>
</div>
	<div class="xm12">
		 <div class="panel  margin-small">
          	<div class="panel-head ">
          		<div>
          			<h4><strong class="text-black">承租人——车辆绑定</strong></h4>
          		</div>
          	</div>
          	<div class="panel-body">
            	 <form name="vehicleAdd" style="width: 100%;" action="/DZOMS/vehicle/vehicleBind" method="post" enctype="multipart/form-data"  class="form-inline">
            	 	<input type="hidden" name="url" value="/vehicle/vehicle/vehicle_search.jsp" />
            	 	<div class="line">
            	 		<div class="form-group" style="width: 500px;">
            	 		<div class="label float-left" style="width: 80px;"><label>车牌号:</label></div>
            	 		<div class="field" style="width: 400px;">
            	 			<s:textfield id="licenseNum" name="vehicle.licenseNum" cssClass="input input-auto" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	    </div>
            	 </div>
            	 <div class="line">
            	 		<div class="form-group" style="width: 500px;">
            	 		<div class="label float-left" style="width: 80px;"><label>车架号:</label></div>
            	 		<div class="field" style="width: 400px;">
            	 			<s:textfield id="carframe_num" name="vehicle.carframeNum" cssClass="input input-auto" size="25" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	    </div>
            	 </div>
            	<div class="line">
            	 	  <div class="form-group" style="width: 210px;">
            	 		<div class="label float-left" style="width: 80px;"><label>归属部门:</label></div>
            	 		<div class="field" style="width: 120px;">
            	 			<s:select  cssClass="input" name="vehicle.dept" id="department" list="{'一部','二部','三部'}"></s:select>
            	 			
            	 			<span style="color:red;">*</span>
            	 		</div>
            	 	  </div>	  
            	</div>
            	
            	<!--未加ID name-->
            	<div class="line">
            	 	    <div class="form-group" style="width: 500px;">
            	 		<div class="label float-left"><label>承租人身份证:</label></div>
            	 		<div class="field" style="width:250px;">
            	 			<s:textfield id="idNum" cssClass="input input-auto" size="20" name="vehicle.driverId" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	    </div>
            	 	 
            	</div>
            	<div class="line">
            		 <div class="form-group">
            	 		<div class="label float-left"><label>承租人</label></div>
            	 		<div class="field">
            	 			<s:textfield id="idName"  cssClass="input input-auto"  size="10" data-validate="required:必填"/>
            	 		</div>
            	 	   </div>
            	</div>
            	
            	<div class="line">
            		<div class="form-group">
            	 		<div class="label float-left"><label>登记人：</label></div>
            	 		<div class="field">
            	 			<input class="input input-auto" size="12" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>" />
            	 		</div>
            	 	</div>
            	 	<div class="form-group">
            	 		<div class="label float-left"><label>登记时间:</label></div>
            	 		<div class="field">
            	 			<input class="input input-auto" size="10" readonly="readonly" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
            	 		</div>
            	 	</div>
            	</div>
            	<div class="line margin-big-top">
            	
            		<div class="xm2 xm4-move">
            				 <input class="button bg-green submitbutton" type="button" value="提交" style="width: auto;">
            				 	<input type="submit" style="display: none;" id="submitbutton" />
                </div>
                <div class="xm2">
                    <button type="button" class="button" name="backid"
                             id="backid" onClick="location.href='/DZOMS/vehicle/vehicle/vehicle_add.jsp'">取消</button>
                </div>
            	
            	</div>

                 </form>
            </div>
       	
       </div>
   </div>
</div>
<script>
$('.datepick').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
});
</script>
<script>
	button_bind(".submitbutton","确定提交?","$('#submitbutton').click();");
	
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

</div>


</body>
</html>
