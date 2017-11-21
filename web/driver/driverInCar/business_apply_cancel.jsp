<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
		<title>证照申请注销</title>
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

<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
	function addface(){
            var photo='<img  width="128" height="128" class="img-border radius-big" id="photo" />'
            var src=$("#face2").val();
           // alert("2");
            $("#face1").after(photo);
            $("#photo").attr("src",src);
    };
</script>
    <script>
        function loadpicture(files){
            if(files.length>0){
                var file = files[0];
                var reader = new FileReader();
                reader.onload = function(){

                    $("#headimg")[0].src=this.result;
                };
                reader.readAsDataURL(file);
            }
//            var txt = $(".oldimg").val();
//            alert(txt);
//            $("#headimg")[0].src=;
        }
        function deleheadimg(){
            $("#headimg")[0].src="/DZOMS/res/image/driverhead.png";
            $("#oldimg").remove();
            $(".input-file1").html('装入<input type="file" onchange="loadpicture(this.files)" id="oldimg">');
        }
        
        function refresh(){
        	document.businessApply.action = "/DZOMS/driver/driverInCar/businessApplyCancelSelect";
        	document.businessApply.submit();
        }
        
        function refresh2(){
        	if ($('[name="driver.name"]').val().trim().length==0) {
        		return false;
        	}
        	document.businessApply.action = "/DZOMS/driver/driverInCar/businessApplyCancelSelect2";
        	document.businessApply.submit();
        }
$(document).ready(function(){

$("[name='vehicle.licenseNum']").bigAutocomplete({
	url:"/DZOMS/select/vehicleByLicenseNum",
	condition:" carframeNum not in (select carframeNum from Driverincar where finished=false and operation='证照注销') ",
	callback:function(){
		refresh();
	}
});
});

$(document).ready(function(){
	var licenseNum = $('[name="vehicle.licenseNum"]').val();
	if (licenseNum.length==0) {
		$('[name="vehicle.licenseNum"]').val("黑A");
	}else{
		var condition1 = "select d.name from Driver d,Vehicle v where d.idNum = v.driverId and v.licenseNum ='" + licenseNum + "'";
	
		$.post("/DZOMS/common/doit",{"condition":condition1},function(data){
			if (data!=undefined&&data["affect"]!=undefined) {
				var name = data["affect"];
				$("#vehicleOwner").val(name);
			}
		});
	}
});
    </script>
 <style>
        .label{
            width: 100px;
            text-align: right;
        }
        .field{
        	width: 200px;
        }
    </style>
</head>
<body>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>证照申请</li>
                <li>申请注销</li>
        </ul>
        </div>
</div>
<div class="margin">
<form action="/DZOMS/driver/driverInCar/businessApplyCancel" name="businessApply"
	  style="width: 100%;"   method="post" class="form-tips form-inline">
	  
	  <div class="line">
	  	  <div class="panel xm12">
	    <div class="panel-head">
	        <strong>证照登记</strong>
	    </div>
	    <div class="panel-body">
	    	<div class="xm2">
	    		        <div class="padding">
					    	<!--<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('data/driver/'+#driver.idNum+'/photo.jpg')=true}">
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
				            
				        	<strong style="display:none">人车照片</strong>
				        	<div>
		<s:if test="%{@com.dz.common.other.FileAccessUtil@exist('/data/driver/'+driver.idNum+'/drive_vehicle_photo.jpg')}">
			<img src="/DZOMS/data/driver/<s:property value='%{driver.idNum}'/>/drive_vehicle_photo.jpg" class="radius img-responsive" id="headimg"  style="width: 150px;height:150px;display:none;">
    	</s:if>
    	<s:else>
    		<img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" id="headimg"  style="width: 150px;height:150px;display:none;">
    	</s:else>
				        	</div>
				            
		                 </div>
	    		
	    	</div>
	    	<div class="xm8">
	    	
	    	      <div class="form-group">
                <div class="label padding">
                    <label>
                        车牌号
                    </label>
                </div>
                <div class="field" >
                	<s:textfield name="vehicle.licenseNum" cssClass="input"/>
                	<s:hidden name="driver.carframeNum" value="%{vehicle.carframeNum}"></s:hidden>
                	<s:hidden name="vehicle.carframeNum" value="%{vehicle.carframeNum}"></s:hidden>
               
               </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        承租人
                    </label>
                </div>
                <div class="field" >
                	<s:set name="driverId" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',vehicle.carframeNum).driverId}"></s:set>
                    <s:textfield id="vehicleOwner" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#driverId).name}" cssClass="input"/>
                </div>
            </div>
            <br>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员姓名
                    </label>
                </div>
                <div class="field" >
                	<s:if test="%{vehicle.licenseNum!=null}">
                		<s:if test="%{driver.name==null||driver.name==''}">
                		
                		<s:set name="firstDriver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',vehicle.firstDriver)}"></s:set>
                			
                		<s:if test="%{#firstDriver==null||!#firstDriver.isInCar||#firstDriver.businessApplyCancelTime!=null}">
                			<s:set name="firstDriverName" value="%{''}"></s:set>
                		</s:if>
                		<s:else>
                			<s:set name="firstDriverName" value="%{#firstDriver.name==null?'':#firstDriver.name}"></s:set>
                		</s:else>
                		
                		
                		<s:set name="secondDriver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',vehicle.secondDriver)}"></s:set>
                			
                		<s:if test="%{#secondDriver==null||!#secondDriver.isInCar||#secondDriver.businessApplyCancelTime!=null}">
                			<s:set name="secondDriverName" value="%{''}"></s:set>
                		</s:if>
                		<s:else>
                			<s:set name="secondDriverName" value="%{#secondDriver.name==null?'':#secondDriver.name}"></s:set>
                		</s:else>
                		
                		<s:set name="thirdDriver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',vehicle.thirdDriver)}"></s:set>
                		<s:if test="%{#thirdDriver==null||!#thirdDriver.isInCar||#thirdDriver.businessApplyCancelTime!=null}">
                			<s:set name="thirdDriverName" value="%{''}"></s:set>
                		</s:if>
                		<s:else>
                			<s:set name="thirdDriverName" value="%{#thirdDriver.name==null?'':#thirdDriver.name}"></s:set>
                		</s:else>
                		
                		<s:if test="%{#secondDriver==null||!#secondDriver.isInCar||#secondDriver.businessApplyCancelTime!=null}">
                			<s:set name="secondDriverName" value="%{''}"></s:set>
                		</s:if>
                		<s:else>
                			<s:set name="secondDriverName" value="%{#secondDriver.name==null?'':#secondDriver.name}"></s:set>
                		</s:else>
                		
                		<s:select cssClass="input" list="{'',#firstDriverName,#secondDriverName,#thirdDriverName}" name="driver.name" onchange="refresh2()"></s:select>
                		</s:if>
                		<s:else>
                			<s:textfield cssClass="input"  name="driver.name" />
                		</s:else>
                	</s:if>
                	<s:else>
                		<s:textfield cssClass="input"  name="driver.name" />
                	</s:else>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员性别
                    </label>
                </div>
                <div class="field" >
                    <s:select cssClass="input"  name="driver.sex"
                              list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.sex')"></s:select>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        身份证号
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.idNum" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        联系电话
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.phoneNum1" />
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        户口所在地
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.accountLocation" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        家庭现住址
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.address" />
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶证号
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.drivingLicenseNum" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员证初领日期
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.drivingLicenseDate" />
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        驾驶员证类型
                    </label>
                </div>
                <div class="field" >
                    <s:select cssClass="input"  name="driver.drivingLicenseType"  list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.drivingLicenseType')"/>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        资格证号
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.qualificationNum" />
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        资格证初领日期
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.qualificationDate"  />
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        资格证有效日期
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.qualificationValidDate" />
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        作息时间
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
                        驾驶员属性
                    </label>
                </div>
                <div class="field" >
                    <s:select cssClass="input"  name="applyAttribute"
                              list="{'主驾','副驾','三驾','临驾'}"></s:select>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        申请时间
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input"  name="driver.businessApplyTime" readonly="readonly"></s:textfield>
                </div>
            </div>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        申请注销时间
                    </label>
                </div>
                <div class="field" >
                    <s:textfield cssClass="input datepick"  name="driver.businessApplyCancelTime" readonly="readonly"></s:textfield>
                </div>
            </div>
            <br/>
            <div class="form-group">
                <div class="label padding">
                    <label>
                        申请录入人
                    </label>
                </div>
                <div class="field" >
                    <input class="input" type="text" disabled="disabled" value="<%=((User)session.getAttribute("user")).getUname()%>" />
                    <input type="hidden" name="driver.businessApplyCancelRegistrant" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
                </div>
            </div>  <div class="form-group">
            <div class="label padding">
                <label>
                    申请时间
                </label>
            </div>
            <div class="field" >
                <input  class="datepick input" disabled="disabled" name="driver.businessApplyCancelRegistTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
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
	
	/*add_but_bind('.submitbutton',function(){
		driverAdd.submit();
	});*/
	button_bind(".submitbutton","确定提交?","$('#submit-button').click();");
	
</script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</html>