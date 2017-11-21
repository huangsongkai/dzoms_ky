<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.vehicle.VehicleApproval,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%><!doctype html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>添加表扬信息</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>

<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<script src="/DZOMS/res/js/itemtool.js"></script>

<script>
        var i =0;
        function addfilename(){
           // alert($(".addFile:first").val());
            var txt='<option >'+$(".addFile:first").val()+'</option>';
            $("#filename").append(txt);
           // alert("4");
           // alert($(".filename").val());
        }
        function addfile(){
            var txt='<input size="100" type="file" class="addFile" name="fileUploads" onchange="addfilename()" style="display:none"/>';
            $(add).after(txt);
            $(".addFile:first").click();
            i=i+1;
        }
        function delefile(){
			var $selected_option = $("#filename").find("option:selected");
            for(j=0;j<i;j++){
				//alert($("input.addFile").eq(j).val());
                if( $selected_option.val()==$("input.addFile").eq(j).val()){
                    $selected_option.remove();
                    $("input.addFile").eq(j).remove();
                    i--;
					return;
                }
            }
        }
        
        $(document).ready(function(){
        	getJsonList("/DZOMS/driver/praise.json",["praise.praiseClass","praise.praisePersonSex"]);

        	getTableList("praise.praiseObject",["praiseObject2","praise.praiseObject"]);//表扬项目
        	getSingleList("praise.praiseFromIn","praise.praiseFromIn",["praiseFromIn3","praiseFromIn2"]);

			var $licenseNumSelection = $('select[name="licenseNum"]');
			var $driverSelection = $('select[name="praise.idNum"]');
        	
        	$licenseNumSelection.html("");
        	$.post("/DZOMS/vehicle/vehicleSearch",{"vehicle.state":1},function(data){
        		$licenseNumSelection.append("<option></option>");
        		for(var i=0;i<data.length;i++){
        			var option = '<option value="'+data[i]["carframeNum"]+'">'+data[i]["licenseNum"]+'</option>';
        			$licenseNumSelection.append(option);
        		}
        	});
        	
        	
        	$licenseNumSelection.change(function(){
        		var $selected_option = $licenseNumSelection.find("option:selected");
        		var carframeNum = $selected_option.val();
        		$.post("/DZOMS/common/getObject",{"className":"com.dz.module.vehicle.Vehicle","id":carframeNum,"isString":true},function(data){
        			var vehicle = data;//$.parseJSON(data);
        			
        			/*var driverId = vehicle["driverId"];
        			$.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":driverId,"isString":true},function(data2){
        				var driver = data2;//$.parseJSON(data2);
        				
        				var option = '<option value="'+driver["idNum"]+'" phoneNum1="'+driver["phoneNum1"]+'">'+driver["name"]+'</option>';
        				$driverSelection.append(option);
					});*/
					$driverSelection.append("<option></option>");
					
					var firstDriver = vehicle["firstDriver"];
					var secondDriver = vehicle["secondDriver"];
					var tempDriver = vehicle["tempDriver"];
					
					if(firstDriver!=undefined)
					$.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":firstDriver,"isString":true},function(data2){
        				var driver = data2;//$.parseJSON(data2);
        				try{
        					var option = '<option value="'+driver["idNum"]+'" phoneNum1="'+driver["phoneNum1"]+'">'+driver["name"]+'</option>';
        					$driverSelection.append(option);
        				}catch(e){}
					});
					if(secondDriver!=undefined)
					$.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":secondDriver,"isString":true},function(data2){
        				var driver = data2;//$.parseJSON(data2);
        				try{
        				var option = '<option value="'+driver["idNum"]+'" phoneNum1="'+driver["phoneNum1"]+'">'+driver["name"]+'</option>';
        				$driverSelection.append(option);
        				}catch(e){}
					});
					if(tempDriver!=undefined)
					$.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":tempDriver,"isString":true},function(data2){
        				var driver = data2;//$.parseJSON(data2);
        				try{
        				var option = '<option value="'+driver["idNum"]+'" phoneNum1="'+driver["phoneNum1"]+'">'+driver["name"]+'</option>';
        				$driverSelection.append(option);
        				}catch(e){}
					});
					
					$('input[name="company"]').val(vehicle["dept"]);		
        		});
        		
        	});
        	
        	$driverSelection.change(function(){
        		var $selected_option = $driverSelection.find("option:selected");
        		$('input[name="telephone"]').val($selected_option.attr("phoneNum1"));
        	});
        });
        
        $(document).ready(function(){
        	getTableList("praise.praiseType", ["praiseType", "praise.praiseClass"]); //投诉项目
        });
        
        function beforeSubmit(){
        	$("input[name='praise.praiseFromOther']").val($("#praiseFromOther1").val()+","+$("#praiseFromOther2").val()+","+$("#praiseFromOther3").val());
        }
    </script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <style>
						.label{
							width: 80px;
							text-align: right;
						}
						/*.form-group{
							width: 300px;
						}*/
					</style>
	
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>表扬</li>
                <li>表扬添加</li>
              
        </ul>
        </div>
</div>
<form class="form-inline form-tips" style="width: 100%;" name="addPraise" action="/DZOMS/driver/praise/addPraise" method="post" enctype="multipart/form-data" onsubmit="return beforeSubmit()">

            <div class="panel bored-main">
							<div class="panel-head">
								表扬登记
							</div>
							<div class="panel-boby">
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>
											表扬时间:
										</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="datepick input setTimeToday" style="width: 120px;" type="text" name="praise.praiseTime" data-validate="required:必填">
									</div>
								</div>
								<div class="form-group"  style="width: 200px;">
									<div class="label float-left"  style="width: 80px;">
										<label>表扬类型:</label>
									</div>
									<div class="field"  style="width: 120px;">
										<select class="input" name="praiseType"  style="width: 120px;" data-validate="required:必填"></select>
									</div>
								</div>
								
								<br>
								
								<div class="form-group" style="width: 620px;">
									<div class="label float-left"  style="width: 80px;">
										<label>表扬类别:</label>
									</div>
									<div class="field">
										<select class="input" name="praise.praiseClass" style="width: 500px;"></select>
										
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>分值:</label>
									</div>
									<div class="field" style="width: 80px;">
										<input class="input" name="praise.grade" style="width: 80px;"/>
									</div>
								</div>

								<br>
									
								<div class="form-group" style="width: 500px;">
									<div class="label float-left" style="width: 80px;">
										<label>表扬来源:</label>
									</div>
									<div class="field" style="width: 400px;">
										<input type="hidden" name="praise.praiseFromOther" />
										<select id="praiseFromOther1" class="input itemtool" item-key="praiseFromOther1" style="width: 100px;"></select>
										<a class="icon icon-wrench" href="javascript:openItem('praiseFromOther1','表扬来源')"></a>
										<select id="praiseFromOther2" class="input itemtool" item-key="praiseFromOther2" style="width: 100px;"></select>
										<a class="icon icon-wrench" href="javascript:openItem('praiseFromOther2','表扬来源')"></a>
										<select id="praiseFromOther3" class="input itemtool" item-key="praiseFromOther3" style="width: 100px;"></select>
										<a class="icon icon-wrench" href="javascript:openItem('praiseFromOther3','表扬来源')"></a>
									</div>
								</div>
								
								
								<br>


								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>信息来源:</label>
									</div>
									<div class="field" style="width: 120px;">
										<select class="input" style="width: 100px;" name="praise.praiseFromOut" id="praiseFromOut" onfocus="getList1('praiseFromOut','praiseFromOut')" data-validate="required:必填"></select>
										<a class="icon icon-wrench" href="javascript:openItem('praiseFromOut','信息来源')"></a>
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>姓名:</label>
									</div>
									<div class="field" style="width: 120px;">
										<select class="input" name="praise.praiseFromIn" style="width: 100px;"></select>
										<a class="icon icon-wrench" href="javascript:setSingleList('praise.praiseFromIn',['praise.praiseFromIn','praiseFromIn3','praiseFromIn2'],['姓名','手机','电话'])"></a>
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>电话:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input" name="praiseFromIn2" style="width: 120px;" />
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>手机:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input" name="praiseFromIn3" style="width: 120px;"/>
									</div>
								</div>
								
								<br>
								
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>车牌号</label>
									</div>
									<div class="field" style="width: 120px;">
										<select class="input" name="licenseNum" style="width: 120px;"></select>
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>司机姓名:</label>
									</div>
									<div class="field" style="width: 120px;">
										<select class="input" name="praise.idNum" style="width: 120px;" ></select>
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>电话:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input" name="telephone" style="width: 120px;" />
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>分公司归属:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input" name="company" style="width: 120px;" />
									</div>
								</div>
								
								<br>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>表扬人姓名:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input hidden_input" name="praise.praisePersonName" style="width: 120px;" />
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>表扬人电话:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input hidden_input" style="width:120px;" name="praise.praisePersonPhone" />
									</div>
								</div>
								<div class="form-group" style="width: 200px;">
									<div class="label float-left" style="width: 80px;">
										<label>发票号:</label>
									</div>
									<div class="field" style="width: 120px;">
										<input class="input" name="praise.ticketNumber" style="width: 120px;" />
									</div>
								</div>
								
								<br>
								
								<div  style="width: 100%">
           							 <div class="float-left" style="width: 80px; text-align: right;">
           							 	<strong>添加文件:</strong>
           							 </div>
            							<div class="float-left">
                							<select  id="filename" size="5" style="width: 400px;border: 1px solid rgb(221, 221, 221); border-image: none;"  class="float-left"></select>
                						</div>
                	
            					</div>
        							
		                      <div class="form-group margin-small" style="height: 100px;">
                                   <div class="margin-small">
                                         <a id="add" class="button input-file bg-green" href="javascript:addfile();">添加</a>
                                    </div>
                                    <div class="margin-small">
                                           <a  class="button input-file bg-blue" href="javascript:void(0);" onclick="delefile()">删除</a>
                                     </div>
                              </div>
        
								<br>
					          <div class="line margin-small">
					          	<div style="width: 600px;">
								
										<div class="float-left" style="width: 80px; text-align: right;">
											<strong>表扬内容:</strong>
										</div>
									
									<div class="field">
										<textarea style="width: 500px;" rows="5" class="input" placeholder="多行文本" name="praise.praiseContext"></textarea>
									</div>
								</div>
					          </div>
					            
								
					<br>
					
					          <div class="form-group margin-small">
									<div class="label">
										<label>登记人:</label>
									</div>
									<div class="field">
										<input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                    	<input type="hidden" name="praise.register" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>登记时间:</label>
									</div>
									<div class="field">
										<input class="input" name="praise.registTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
									</div>
								</div>
							</div>
							<br>
							<div class="panel-foot">
								<div class="xm10-move">
								<input type="submit" class="button bg-main" value="提交"></input>
								
								</div>
							</div>
						</div>		
    </form>
   <script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</body>
</html>
