<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib
	uri="/struts-tags" prefix="s"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@ page language="java"
	import="java.util.*,com.dz.module.user.User,com.dz.module.vehicle.*,com.dz.module.driver.*,com.dz.common.other.*,com.dz.common.global.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
		<title>证照申请</title>
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/fileUpload.js" ></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
	var licenseNum = $('[name="vehicle.licenseNum"]').val();
	if (licenseNum.length>0) {
		var condition1 = "select d.name from Driver d,Vehicle v where d.idNum = v.driverId and v.licenseNum ='" + licenseNum + "'";
	
		$.post("/DZOMS/common/doit",{"condition":condition1},function(data){
			if (data!=undefined&&data["affect"]!=undefined) {
				var name = data["affect"];
				$("#vehicleOwner").val(name);
			}
		});
	}else{
		$('[name="vehicle.licenseNum"]').val("黑A");
	}
});

function checkAll(){
	var idNum = $('[name="driver.idNum"]').val();
	var licenseNum = $("[name='vehicle.licenseNum']").val();
	
	if (idNum.trim().length>0 && licenseNum.trim().length>0) {
		document.businessApply.action = "/DZOMS/driver/driverInCar/businessApplySelect";
        document.businessApply.submit();
	}
}

var clsMap = {
	"主驾":"firstDriver",
	"副驾":"secondDriver",
	"三驾":"thirdDriver",
	"临驾":"tempDriver"
};

function checkIt(){
	var idNum = $('[name="driver.idNum"]').val();
	var licenseNum = $("[name='vehicle.licenseNum']").val();
	
	var condition1 = "select carframeNum from Vehicle where licenseNum ='" + licenseNum + "'";
	
	$.post("/DZOMS/common/doit",{"condition":condition1},function(data){
		if (data!=undefined&&data["affect"]!=undefined) {
			var carframeNum = data["affect"];
			$('input[name="driver.carframeNum"]').val(carframeNum);
			
			var driverClass = $("[name='driver.driverClass']").val().trim();
			
			var condition2 = "select "+clsMap[driverClass]+" from Vehicle where carframeNum ='" + carframeNum +"'";
			$.post("/DZOMS/common/doit",{"condition":condition2},function(result){
				if (result!=undefined&&result["affect"]!=undefined) {
					var driverId = result["affect"];
					if (driverId.trim().length>0) {
						$.post("/DZOMS/common/doit",{"condition":"from Driver where idNum ='"+driverId+"'"},function(nresult){
							if (nresult!=undefined&&nresult["affect"]!=undefined) {
								var ndriver = nresult["affect"];
//								if(ndriver["businessApplyCancelState"]==0){
									alert("该车已存在"+driverClass+" "+ndriver["name"]);
									$("[name='driver.driverClass']").val("");
//								}
							}
						});
					}
				}
			});
			
		}
	});
}

$(document).ready(function(){
	$('[name="driver.idNum"]').bigAutocomplete({
		url:"/DZOMS/select/driverById",
		condition:" status=3 and ((businessApplyCancelState=1 and businessApplyState=2) or (businessApplyCancelState=0 and businessApplyState=0) or (businessApplyState is null))",
		callback:checkAll
	});

$("[name='vehicle.licenseNum']").bigAutocomplete({
	url:"/DZOMS/select/vehicleByLicenseNum",
	callback:function(){
		var licenseNum = $("[name='vehicle.licenseNum']").val();
		var condition1 = "select d.name from Driver d,Vehicle v where d.idNum = v.driverId and v.licenseNum ='" + licenseNum + "'";
	
		$.post("/DZOMS/common/doit",{"condition":condition1},function(data){
			if (data!=undefined&&data["affect"]!=undefined) {
				var name = data["affect"];
				$("#vehicleOwner").val(name);
			}
			
		});
		
		checkAll();
	}
});
});

</script>
    <script>
        function deleheadimg(){
            $("#headimg")[0].src="/DZOMS/res/image/driverhead.png";
            $("#oldimg").val("");
        }
        
        function deleheadimg1(){
            $("#headimg1")[0].src="/DZOMS/res/image/driverhead.png";
            $("#readyimg1").val("");
        }
        
    </script>
    <style>
    	
        .label{
            width: 130px;
            text-align: right;
        }
        .field{
        	width: 200px;
        }
        .form-group{
    		width: 340px;
    	}
    </style>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>证照申请</li>
                <li>申请登记</li>
        </ul>
     </div>
</div>
<div class="margin">
<form action="/DZOMS/driver/driverInCar/businessApply" name="businessApply" method="post" 
	  style="width: 100%;"   class="form-tips form-inline" enctype="multipart/form-data">
<div class="line">
	 
        <div class="panel xm12">
	    <div class="panel-head">
	        <strong>证照申请</strong>
	    </div>
	    <div class="panel-body">
	    	<div class="line">
	    	   <div class="xm2">
			    	   	<div class="padding">
					    	<!--<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('data/driver/'+#driver.idNum+'/photo.jpg')==true}">
					    	    <img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/photo.jpg" class="radius img-responsive" style="width: 150px;height: 150px;">
					    	</s:if>
					    	<s:else>
					    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" style="width: 150px;height:150px;">
					    	</s:else>-->
					    	<strong>驾驶员照片</strong>
				        	<div>
		<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('/data/driver/'+driver.idNum+'/photo.jpg')}">
			<img src="/DZOMS/data/driver/<s:property value='%{driver.idNum}'/>/photo.jpg" class="radius img-responsive" id="headimg1"  style="width: 150px;height:150px;">
    	</s:if>
    	<s:else>
    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" id="headimg1"  style="width: 150px;height:150px;">
    	</s:else>
				        		
				        	</div>
				            <br/>
				            <div class="container">
				                <a class="button input-file input-file1">
				                    装入<input class="dz-file" id="readyimg1" name="drive_photo" data-target=".input-file1" sessuss-function="loadThePicture('#readyimg1','#headimg1');">
				                </a>
				                 <a class="button input-file delebutton2" data-width="50%" data-mask="1">清空</a>
				            </div>
				        	<strong>人车照片</strong>
				        	<div>
		<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('/data/driver/'+driver.idNum+'/drive_vehicle_photo.jpg')}">
			<img src="/DZOMS/data/driver/<s:property value='%{driver.idNum}'/>/drive_vehicle_photo.jpg" class="radius img-responsive" id="headimg"  style="width: 150px;height:150px;">
    	</s:if>
    	<s:else>
    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" id="headimg"  style="width: 150px;height:150px;">
    	</s:else>
				        	</div>
				            <br/>
				            <div class="container">
				                <a class="button input-file bg-green input-file2">
				                    装入<input class="dz-file" id="oldimg" name="drive_vehicle_photo" data-target=".input-file2" sessuss-function="loadThePicture('#oldimg','#headimg');">
				                </a>
				                 <a class="button input-file delebutton1" data-width="50%" data-mask="1">清空</a>
				            </div>
		                 </div>
	    	   	
	            </div>
	    <div class="xm8">
	    	<div class="form-group">
                <div class="label padding">
                    <label>
                        车牌号:
                    </label>
                </div>
                <div class="field" >
                	<s:textfield cssClass="input" name="vehicle.licenseNum"></s:textfield>
                	<s:hidden name="driver.carframeNum"></s:hidden>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        承租人:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield id="vehicleOwner" cssClass="input" readonly="true"/>
                </div>
            </div>
            <br>
            <div class="form-group">
                <div class="label padding">
                    <label>
                       驾驶员身份证号:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input" name="driver.idNum" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员姓名:
                    </label>
                </div>
                <div class="field" >
                	<s:textfield cssClass="input" name="driver.name" />
                </div>
            </div>
            
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员性别:
                    </label>
                </div>
                <div class="field" >
                    <s:select cssClass="input"  name="driver.sex"
                              list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.sex')"></s:select>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员电话:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.phoneNum1"  readonly="true"/>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        户口所在地:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.address"  readonly="true" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        家庭现住址:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.accountLocation" readonly="true"/>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶证档案号:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.drivingLicenseNum"  readonly="true"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶证初领日期:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.drivingLicenseDate"  readonly="true"/>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶证类型:
                    </label>
                </div>
                <div class="field" >
                    <s:select cssClass="input"  name="driver.drivingLicenseType"  list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.drivingLicenseType')" readonly="true"/>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        资格证号:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.qualificationNum"  readonly="true"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        资格证初领日期:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.qualificationDate"  readonly="true" />
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        资格证有效日期至:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.qualificationValidDate"  readonly="true"/>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员作息时间:
                    </label>
                </div>
                <div class="field" >
                    <s:select cssClass="input"  name="driver.restTime"
                              list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.restTime')"></s:select>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        	驾驶员属性:
                    </label>
                </div>
                <div class="field" >
                    <select class="input"  name="driver.driverClass" onchange="checkIt()">
                    	<option></option>
                    	<option>主驾</option>
                    	<option>副驾</option>
                    	<option>三驾</option>
                    	<option>临驾</option>
                    </select>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        申请时间:
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.businessApplyTime" ></s:textfield>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        证照申请登记人：
                    </label>
                </div>
                <div class="field" >
                    <input class="input" type="text" disabled="disabled" value="<%=((User)session.getAttribute("user")).getUname()%>" />
                    <input type="hidden" name="driver.businessApplyRegistrant" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
                </div>
            </div>  <div class="form-group">
            <div class="label padding">
                <label>
                    证照申请登记时间:
                </label>
            </div>
            <div class="field" >
                <input class="datepick input" readonly="readonly" name="driver.businessApplyRegistTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
            </div>
        </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                </div>
                <div class="field" >
                	<input type="button" class="button bg-green button-big submitbutton" value="提交" data-width="50%" data-mask="1">
                    <input type="submit" style="display: none;" id="submit-button"/>
                </div>
            </div>
            <br/>
	    	   </div>
	    		
	    	</div>
          
        </div>  
	    </div>
	
</div>
       
        
    </form>

</div>
</body>
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
	
	
//	del_but_bind('.delebutton1',deleheadimg);
//	del_but_bind('.delebutton2',deledriverfile)
	button_bind(".delebutton1","确认删除？","deleheadimg()");
	button_bind(".delebutton2","确认删除？","deleheadimg1()");
	
	/*add_but_bind('.submitbutton',function(){
		driverAdd.submit();
	});*/

	function validateWhenSubmit() {
//	    var idNum = $('[name="driver.idNum"]').val();
//	    $.post("/DZOMS/driver/driverInCar/validateBussinessApply",{
//	        "driver.idNum":idNum
//        },function (data) {
//            var validated = data && data["state"];
//            if(!validated){
//                alert(data["msg"] || "验证失败！");
//            }else {
//                $('#submit-button').click();
//            }
//        });

        $('#submit-button').click();
    }

	button_bind(".submitbutton","确定提交?","validateWhenSubmit()");
	
</script>

<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</html>