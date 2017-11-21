<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="com.dz.module.user.User,com.dz.module.vehicle.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.collections.CollectionUtils"%>
<%@page import="org.apache.commons.collections.Transformer" %>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="java.util.List" %>
<%@page import="com.dz.common.other.*" %>
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
	<title>车辆新增</title>
	
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
<script type="text/javascript" src="/DZOMS/res/js/fileUpload.js" ></script>
<script type="text/javascript">
        function deleheadimg(){
            $("#imghead")[0].src="";
            $("#imghead2")[0].src="";
            $("#readyimg1").val("");
        }
        
function deleheadimg1(){
     $("#clone-imghead")[0].src="";
     $("#clone-imghead2")[0].src="";
     $("#readyimg2").val("");
}
            
      function loadThePicture(fi,img){
      	loadTempPicture($(fi),$(img));
      }
    </script>
<script>

	function showInfo(){
		var type = $('select[name="vehicle.carMode"]').val();
		if(type.length>0){
			var $form = $('[name="vehicleAdd"]');
			var $carMode = $('input[name="vehicleMode.carMode"]');
			
			$carMode.val(type);
			
			$form.attr('action','/DZOMS/vehicle/vehicleModeShow');
			
			$("input").removeAttr("data-validate");
			
			$form.submit();
			
			//$("#info").attr("src","/DZOMS/vehicle/VehicleMode/vehicleModeShow?vehicleMode.carMode="+type);
		}
	}

$(document).ready(function(){
	if ($('[name="vehicleMode.displacement"]').val().length != 0) {
		$('[name="vehicleMode.displacement"]').val(
						$('[name="vehicleMode.displacement"]').val()+"ml/"
						+$('[name="vehicleMode.power"]').val()+"kw"
						);
	}
	
	if ($('[name="vehicleMode.sizeLong"]').val().length != 0) {
		$('[name="vehicleMode.sizeLong"]').val(
			$('[name="vehicleMode.sizeLong"]').val()+"/"
			+$('[name="vehicleMode.sizeWide"]').val()+"/"
			+$('[name="vehicleMode.sizeHigh"]').val()+"mm");
	}
	
	if ($('[name="vehicleMode.treadFront"]').val().length != 0) {
		$('[name="vehicleMode.treadFront"]').val(
						$('[name="vehicleMode.treadFront"]').val()+"/"
						+$('[name="vehicleMode.treadBack"]').val()+"mm"
						);
	}
	
	
	$("[name='vehicle.carframeNum']").change(function(){
		$("[name='vehicle.carframeNum']").val($(this).val());
	});
	
	$("[name='vehicle.engineNum']").change(function(){
		$("[name='vehicle.engineNum']").val($(this).val());
	});
	
	$("[name='vehicle.certifyNum']").change(function(){
		$("[name='vehicle.certifyNum']").val($(this).val());
	});
	
	$("#left-area [name='vehicleMode.licenseDate']").val($("#right-area [name='vehicle.pd']").val());
				
});

</script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script>
		$(document).ready(function(){
			$("#idNum").bigAutocomplete({
				url:"/DZOMS/select/driverById",
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
<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>新增</li>
                <li>新增车辆技术信息</li>
        </ul>
</div>
<div class="line">
	<div class="xm6 form-disabled" id="left-area">
		 <div class="panel  margin-small" style="height: 930px;">
          	<form class="form-inline" style="width: 100%;">
          	  <div class="panel-body">
          	  	
          	  		<!--第一行-->
          	  		<div class="line">
          	  		
          	  			<div class="form-group" style="width: 300px;">
            	 		  <div class="label float-left" style="width: 90px;"><label>合格证编号：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto"  size="26" name="vehicle.certifyNum"/>
            	 		  </div>
            	 	    </div>
            	 	    <div class="form-group">
            	 		  <div class="label float-left" style="width: 90px;"><label>发证日期：</label></div>
            	 		  <div class="field" style="width: 90px;">
            	 			<s:textfield cssClass="input input-auto"  size="12" name="vehicleMode.licenseDate"/>
            	 		  </div>
            	    	</div>
          	  		</div>
          	  		
            	 
            	 	<!--第二行-->
            	 	<div class="line">
            	 		<div class="form-group" >
            	 		  <div class="label float-left"><label>制造企业：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="45" name="vehicleMode.company" />
            	 		  </div>
            	 	  </div>
            	 	</div>
            	 	
            	 	
            	 		<!--第三行-->
            	 	<div class="line">
            	 		  <div class="form-group">
            	 		  <div class="label float-left"><label>品牌/名称：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="45" name="vehicleMode.brand"/>
            	 		  </div>
            	 	</div>
            	 	</div>
            	 	
            	 
            	 		<!--第四行-->
            	 	<div class="line">
            	 		 	<div class="form-group" style="width: 300px;">
            	 		  <div class="label float-left"><label>车辆型号：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="15" name="vehicleMode.carMode"/>
            	 		  </div>
            	 	    </div>
            	    	<div class="form-group">
            	 		  <div class="label float-left"><label>车身颜色：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="10" name="vehicleMode.color"/>
            	 		  </div>
            	    	</div>
            	 	</div>
            	 
            	 	<!--第五行-->
            	 	<div class="line">
            	 		  <div class="form-group" style="width: 300px;">
            	 		  <div class="label float-left"><label>车架号：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="23" name="vehicle.carframeNum"/>
            	 		  </div>
            	 	   </div>
            	 	</div>
            	 	
            	 	
            	 		<!--第六行-->
            	 		<div class="line">
            	 			 	<div class="form-group" style="width: 250px;">
            	 		    <div class="label float-left"><label>燃油种类：</label></div>
            	 		    <div class="field">
            	 			  <s:textfield cssClass="input input-auto" size="10" name="vehicleMode.fuel"/>
            	 		    </div>
            	 	      </div>
            	 	      <div class="form-group">
            	 		    <div class="label float-left"><label>转向形式：</label></div>
            	 		    <div class="field">
            	 			  <s:textfield cssClass="input input-auto" size="10" name="vehicleMode.corneringAbility"/>
            	 		    </div>
            	 	       </div>
            	 		</div>
            	 
            	 	<!--第七行-->
            	 	<div class="line">
            	 			<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>发动机型号：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="10" name="vehicleMode.engineMode"/>
            	 		  </div>
            	 	    </div>
            	      <div class="form-group">
            	 		  <div class="label float-left"><label>发动机号：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="10" name="vehicle.engineNum"/>
            	 		  </div>
            	     	</div>
            	 	</div>
            	 	
            	 	<!--第八行-->
            	 	<div class="line">
            	 			<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>排量和功率：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="15" name="vehicleMode.displacement"/>
            	 			<s:hidden name="vehicleMode.power"></s:hidden>
            	 		  </div>
            	 	    </div>
            	     	<div class="form-group">
            	 		  <div class="label float-left"><label>排放标准：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="15" name="vehicleMode.emission"/>
            	 		  </div>
            	     	</div>
            	 	</div>
            	 
            	 	<!--第九行-->
            	 	<div class="line">
            	 		<div class="form-group" style="width: 300px;">
            	 		  <div class="label float-left" ><label>外廓尺寸：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="20" name="vehicleMode.sizeLong"/>
            	 		  <s:hidden name="vehicleMode.sizeWide"></s:hidden>
            	 		  <s:hidden name="vehicleMode.sizeHigh"></s:hidden>
            	 		 
            	 		  </div>
            	 	</div>
            	 	<div class="form-group"style="width: 150px;" >
            	 		  <div class="label float-left"  style="width: 60px;"><label>轮胎数：</label></div>
            	 		  <div class="field" style="width: 80px;">
            	 			<s:textfield cssClass="input input-auto" size="2" name="vehicleMode.tireNum" />
            	 		  </div>
            	 	</div>
            	 	</div>
            	 	
            	 	<!--第十行-->
            	 	<div class="line">
            	 			<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>轮距(前/后)</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="15" name="vehicleMode.treadFront"/>
            	 			<s:hidden name="vehicleMode.treadBack" />
            	 			
            	 		  </div>
            	 	</div>
            	 		<div class="form-group">
            	 		  <div class="label float-left"><label>轮胎规格：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="15" name="vehicleMode.tire"/>
            	 		  </div>
            	 	</div>
            	 	</div>
            	 
            	 	<!--第十一行-->
            	 	<div class="line">
            	 			<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>轴距：</label></div>
            	 		  <div class="field" style="width: 110px;">
            	 			<s:textfield cssClass="input input-auto" size="5" name="vehicleMode.wheelBase"/><span>(mm)</span>
            	 		  </div>
            	 	</div>
            	 		<div class="form-group">
            	 		  <div class="label float-left"><label>轴数：</label></div>
            	 		  <div class="field" >
            	 			<s:textfield cssClass="input input-auto" size="5" name="vehicleMode.baseNum"/>
            	 		  </div>
            	 	</div>
            	 	</div>
            	 	
            	 	<!--第十二行-->
            	 	<div class="line">
            	 			<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>总质量：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="5" name="vehicleMode.wholeWeight"/><span>(kg)</span>
            	 		  </div>
            	 	</div>
            	 		<div class="form-group">
            	 		  <div class="label float-left"><label>整备质量：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="5" name="vehicleMode.allWeight"/><span>(kg)</span>
            	 		  </div>
            	 	</div>
            	 	</div>
            	 	
            	 	<!--第十三行-->
            	 	<div class="line">
            	 		<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>最高车速：</label></div>
            	 		  <div class="field" style="width: 110px;">
            	 			<s:textfield cssClass="input input-auto" size="5" name="vehicleMode.fastest"/><span>(km/h)</span>
            	 		  </div>
            	 	</div>
            	 		<div class="form-group">
            	 		  <div class="label float-left"><label>额定载客：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="5" name="vehicleMode.personNum"/><span>(人)</span>
            	 			
            	 		  </div>
            	 	</div>
            	 	</div>
            	 		
            	 	<!--第十四行-->
            	 	<div class="line">
            	 			<div class="form-group" style="width: 250px;">
            	 		  <div class="label float-left"><label>车辆制造日期</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="10" name="vehicle.pd"/>
            	 		  </div>
            	 	</div>
            	 		<div class="form-group">
            	 		  <div class="label float-left"><label>购入日期：</label></div>
            	 		  <div class="field">
            	 			<s:textfield cssClass="input input-auto" size="10" name="vehicle.inDate"/>
            	 		  </div>
            	 	</div>
            	 	</div>
            	 	<!--第十四行-->
            	<div class="line">
            		
            	 		<strong>车辆照片:</strong>
            	 		<div style="margin-left: 100px;">
            	 			 <div class="preview" style="border:1px solid #ddd;height: 112px;">
                                        <img id="imghead2" src="" class="img-responsive" style="height: 112px;"/>
                     </div>
                                   
            	 		</div>
            	 	
            	</div>
            	<!--第十五行-->
            	<div class="line">
            		
            	 		<strong>拓印:</strong>
            	 		<div style="margin-left: 100px;">
            	 			 <div class="preview" style="border:1px solid #ddd;height: 112px;">
                                        <img id="clone-imghead2" src="" class="img-responsive" style="height: 112px;"/>
                     </div>
                                   
            	 		</div>
            	 	
            	</div>
          	  	
          	  </div>
          	   </form>
     </div>
  </div>
	<div class="xm6" id="right-area">
		 <div class="panel  margin-small" style="height: 930px;">
          	<div class="panel-head ">
          		<div>
          			<h4><strong class="text-black">添加车辆技术信息</strong></h4>
          		</div>
          	</div>
          	<div class="panel-body">
            	 <form name="vehicleAdd" style="width: 100%;" action="/DZOMS/vehicle/vehicleAdd" method="post" enctype="multipart/form-data"  class="form-inline">
            	 	<input type="hidden" name="url" value="/vehicle/vehicle/vehicle_add.jsp" />
            	 	<input type="hidden" name="vehicleMode.carMode" />
            	 	<div class="line">
            	 		<div class="form-group" style="width: 500px;">
            	 		<div class="label float-left" style="width: 80px;"><label>车架号:</label></div>
            	 		<div class="field" style="width: 400px;">
            	 			<s:textfield  id="vehicle.carframe_num" name="vehicle.carframeNum"  cssClass="input input-auto" size="25" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	    </div>
            	 </div>
            	 <div class="line">
            	 	    <div class="form-group" style="width: 210px;">
            	 		<div class="label float-left" style="width: 80px;"><label>发动机号:</label></div>
            	 		<div class="field" style="width: 120px;">
            	 			<s:textfield  id="vehicle.engine_num" name="vehicle.engineNum" cssClass="input input-auto" size="10" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	    </div>
						</div>
						 <%! List<String> vmstr; %>
				 <%
                    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
                    VehicleModeService vms = ctx.getBean(VehicleModeService.class);
                    List<VehicleMode> vml = vms.selectAll();

                        vmstr = (List<String>)CollectionUtils.collect(vml, new Transformer(){
                            @Override
                            public Object transform(Object obj) {
                            VehicleMode vm = (VehicleMode) obj;
                            return vm.getCarMode();
                            }
                            });

                            vmstr.add(0, "");

                            request.setAttribute("vmstr",vmstr);
                            System.out.println(vmstr);
                            %>
            	 	
            	 	<div class="line">
            	 	<div class="form-group" style="width: 300px;">
            	 		<div class="label float-left" style="width: 80px;"><label>车辆型号:</label></div>
            	 		<div class="field"  style="width: 200px;">
            	 			<s:select  theme="simple" name="vehicle.carMode" list="#request.vmstr" onchange="showInfo()" cssClass="input" data-validate="required:必填"></s:select>
            	 			<!--<a class="icon icon-wrench"></a>--><span style="color:red;">*</span>
            	 		</div>
            	 	</div>
            	 	<div class="form-group"  style="width: 210px;">
            	 		<div class="label float-left"  style="width: 80px;"><label>购入日期:</label></div>
            	 		<div class="field"  style="width: 120px;">
            	 			<s:textfield  id="vehicle.in_date" cssClass="datepick input input-auto" name="vehicle.inDate" size="10" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	</div>
            	 	</div>
            	 <div class="line">
            	 	    <div class="form-group" style="width: 500px;">
            	 		<div class="label float-left" style="width: 80px;"><label>合格证编号:</label></div>
            	 		<div class="field" style="width: 400px;" >
            	 			<s:textfield  id="vehicle.certify_num" name="vehicle.certifyNum" cssClass="input input-auto" size="25" data-validate="required:必填"/><span style="color:red;">*</span>
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
            	
            	 	    <div class="form-group" style="width: 210px;">
            	 		<div class="label float-left" style="width: 90px;"><label>车辆制造日期:</label></div>
            	 		<div class="field" style="width: 110px;">
            	 			<s:textfield  id="vehicle.pd" cssClass="datepick input input-auto" name="vehicle.pd" size="10" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	    </div>
            	 	   </div>
            	 	   <div class="line">
            	 	   <div class="form-group" style="width: 210px;">
            	 		<div class="label float-left" style="width: 80px;"><label>车牌号:</label></div>
            	 		<div class="field" style="width: 120px;">
            	 			<s:textfield  id="vehicle.license_num" name="vehicle.licenseNum" cssClass="input input-auto" value="黑A" size="10" />
            	 		</div>
            	 	   </div>
            	
            	 	<div class="form-group" style="width: 250px;">
            	 		<div class="label float-left"><label>提车日期:</label></div>
            	 		<div class="field" style="width: 110px;">
            	 			<s:textfield cssClass="input input-auto datepick" size="10" name="getCarDate" data-validate="required:必填"/><span style="color:red;">*</span>
            	 		</div>
            	 	</div>
            	</div>
            	<!--未加ID name-->
            	<div class="line">
            	 	    <div class="form-group" style="width: 500px;">
            	 		<div class="label float-left"><label>承租人身份证:</label></div>
            	 		<div class="field" style="width:250px;">
            	 			<s:textfield id="idNum" cssClass="input input-auto" size="20" name="vehicle.driverId" />
            	 		</div>
            	 	    </div>
            	 	 
            	</div>
            	<div class="line">
            		 <div class="form-group">
            	 		<div class="label float-left"><label>承租人</label></div>
            	 		<div class="field">
            	 			<s:textfield id="idName"  cssClass="input input-auto"  size="10"/>
            	 		</div>
            	 	   </div>
            	</div>
            	
            	<div class="line">
            		
            	 		<strong>车辆照片:</strong>
            	 		<div style="margin-left: 110px;">
            	 			 <div class="preview" style="border:1px solid #ddd;">
                                        <img id="imghead" src="" class="img-responsive" style="width: 300px;height: 150px;"/>
                              </div>
                                    <div class="padding float-left" id="vehicleimage">
                                    	<a class="button input-file input-file1">
                                    		装入<input class="dz-file" id="readyimg1" name="photo" data-target=".input-file1" sessuss-function="loadThePicture('#readyimg1','#imghead');loadThePicture('#readyimg1','#imghead2');">
                                    	</a>
                                    </div>
                                   <div class="padding">
                                       <input type="button" class="button" onclick="deleheadimg()" value="清除" style="width: auto;">
                                   </div>
            	 		</div>
            	 	
            	</div>
            	<div class="line">
            		
            	 		<strong>拓印:</strong>
            	 		<div style="margin-left: 110px;">
            	 		            <div class="preview" style="border:1px solid #ddd;">
                                        <img id="clone-imghead" src="" class="img-responsive" style="width: 300px;height: 150px;"/>
                                    </div>
                                    <div class="padding float-left">
                                        <a class="button input-file input-file2">
                                        	装入<input class="dz-file" id="readyimg2" name="photo_tuoying" data-target=".input-file2" sessuss-function="loadThePicture('#readyimg2','#clone-imghead');loadThePicture('#readyimg2','#clone-imghead2');">
                                    		</a>
                                    </div>
                                    <div class="padding">
                                       <input type="button" class="button" onclick="deleheadimg1()" value="清除" style="width: auto;">
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

<div class="line">
<%
	List<Vehicle> list = ObjectAccess.query(Vehicle.class, " state=-1 ");
	request.setAttribute("list", list);
%>
<s:if test="%{#request.list!=null&&#request.list.size()>0}">
<table class="table table-striped table-bordered table-hover">
<tr>
    <th class="carframeNum selected_able">车架号</th>
    <th class="engineNum selected_able">发动机号</th>
    <th class="carMode selected_able">车辆型号</th>
    <th class="inDate selected_able">购入日期</th>
    <th class="certifyNum selected_able">合格证编号</th>
    <th class="dept selected_able">归属部门</th>
    <th class="pd selected_able">车辆制造日期</th>
    <th class="driverId selected_able">承租人身份证号</th>
    <th class="driverName selected_able">承租人</th>
    <th class="licenseNum selected_able">车牌号</th>
	<th class="modify selected_able">修改</th>
	<th class="delete selected_able">删除</th>
</tr>
<s:iterator value="%{#request.list}" var="v">       
<tr>
 <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum }"/></td>
 <td class="engineNum selected_able"><s:property value="%{#v.engineNum}"/></td>
 <td class="carMode selected_able"><s:property value="%{#v.carMode}"/></td>
 <td class="inDate selected_able"><s:property value="%{#v.inDate}"/></td>
 <td class="certifyNum selected_able"><s:property value="%{#v.certifyNum}"/></td>
 <td class="dept selected_able"><s:property value="%{#v.dept}"/></td>
 <td class="pd selected_able"><s:property value="%{#v.pd}"/></td>
 <td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>
 <td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>
 <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
 <td class="modify selected_able"><a href="javascript:modifyV('<s:property value="%{#v.carframeNum}"/>')">修改</a></td>
 <td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.carframeNum}"/>')">删除</a></td>
</tr>
</s:iterator>
</table>

	<div class="xm9-move xm2">
		<form action="/DZOMS/vehicle/vehicleRelook" method="post">
			<input type="hidden" name="url" value="/vehicle/vehicle/vehicle_add.jsp"/>
			<input type="submit" value="全部通过" class="button bg-green" />
		</form>
	</div>
	</s:if>
</div>

<form action="/DZOMS/vehicle/vehicleDelete" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/vehicle_add.jsp"/>
	<input type="hidden" name="vehicle.carframeNum" />
	<input type="submit" style="display: none;" id="del_but" />
</form>

<form action="/DZOMS/vehicle/vehicleShow" method="post">
	<input type="hidden" name="url" value="/vehicle/vehicle/vehicle_add.jsp"/>
	<input type="hidden" name="vehicle.carframeNum" />
	<input type="submit" style="display: none;" id="modify_but" />
</form>

<script>
$('.datepick').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onSelectDate:function(){
		$("#left-area [name='vehicle.inDate']").val($("#right-area [name='vehicle.inDate']").val());
		$("#left-area [name='vehicle.pd']").val($("#right-area [name='vehicle.pd']").val());
		$("#left-area [name='vehicleMode.licenseDate']").val($("#right-area [name='vehicle.pd']").val());
	}
});
</script>
<script>
	button_bind(".submitbutton","确定提交?","$('#submitbutton').click();");
	function deleteV(cid){
		$('input[name="vehicle.carframeNum"]').val(cid);
		if (confirm("确认删除车架号为"+cid+"的车辆？")) {
			$("#del_but").click();
		}
	}
	
	function modifyV(cid){
		$('input[name="vehicle.carframeNum"]').val(cid);
		$("#modify_but").click();
	}
</script>

</div>

</body>
</html>
