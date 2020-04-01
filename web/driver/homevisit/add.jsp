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
<title>添加家访信息</title>
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
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
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
			var $licenseNumSelection = $('input[name="licenseNum"]');
			var $driverSelection = $('select[name="homeVisit.idNum"]');

            $("#carNum").bigAutocomplete({
                url:"/DZOMS/select/VehicleBylicenseNum",
                condition:" state=1 ",
                doubleClick:true,
                doubleClickDefault:'黑A',
                callback:function(){
                    $.post("/DZOMS/common/doit",{"condition":"from Vehicle where licenseNum='"+$("#carNum").val()+"'  order by inDate desc "},function(data){
                        if (data!=undefined &&data["affect"]!=undefined ) {
                            var vehicle = data["affect"];
//                        $("#department").val(vehicle["dept"]);
                            $("#carframe_num").val(vehicle["carframeNum"]);

//                        setDriverList(vehicle["carframeNum"]);

                            var $driverSelection = $('select[name="homeVisit.idNum"]');
                            $driverSelection.html("");
                            $driverSelection.append("<option></option>");

                            var firstDriver = vehicle["firstDriver"];
                            var secondDriver = vehicle["secondDriver"];
                            var tempDriver = vehicle["tempDriver"];

                            if(firstDriver!=undefined)
                                $.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":firstDriver,"isString":true},function(data2){
                                    var driver = data2;//$.parseJSON(data2);
                                    try{
                                        var option = '<option value="'+driver["idNum"]+'" >'+driver["name"]+'</option>';
                                        $driverSelection.append(option);
                                    }catch(e){}
                                });
                            if(secondDriver!=undefined)
                                $.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":secondDriver,"isString":true},function(data2){
                                    var driver = data2;//$.parseJSON(data2);
                                    try{
                                        var option = '<option value="'+driver["idNum"]+'">'+driver["name"]+'</option>';
                                        $driverSelection.append(option);
                                    }catch(e){}
                                });
                            if(tempDriver!=undefined)
                                $.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":tempDriver,"isString":true},function(data2){
                                    var driver = data2;//$.parseJSON(data2);
                                    try{
                                        var option = '<option value="'+driver["idNum"]+'">'+driver["name"]+'</option>';
                                        $driverSelection.append(option);
                                    }catch(e){}
                                });
                        }
                    });
                }
            });
        	
        	$driverSelection.change(function(){
        		var $selected_option = $driverSelection.find("option:selected");
        		var idNum = $selected_option.val();
        		$("[name='idNum']").val(idNum);
        		
        		$.post("/DZOMS/common/getObject",{"className":"com.dz.module.driver.Driver","id":idNum,"isString":true},function(data2){
        			var driver = data2;//$.parseJSON(data2);
        			try{
        				$("[name='location']").val(driver["address"]);
        			}catch(e){}
				});
        		//location
        	});
        });
        
    </script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <style>
						.label{
							width: 80px;
							text-align: right;
						}
						.form-group{
							width: 300px;
						}
					</style>
	<script>


	</script>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>家访</li>
                <li>添加家访</li>
        </ul>
        </div>
</div>
<form class="form-inline form-tips" name="addPraise" action="/DZOMS/driver/homevisit/addHomeVisit" method="post" enctype="multipart/form-data">
	<input id="carframe_num" type="hidden" name="homeVisit.carframeNum" />
	<input type="hidden" name="url" value="search.jsp"/>
            <div class="panel ">
							<div class="panel-head">
								<h3><strong>家访登记</strong></h3>
							</div>
							<div class="panel-boby">
								<div class="form-group margin-small">
									<div class="label">
										<label>
											家访时间</label>
									</div>
									<div class="field">
										<input class="datepick input setTimeToday" type="text" name="homeVisit.time">
									</div>
								</div>

								<br>

								<div class="form-group margin-small">
									<div class="label">
										<label>车牌号</label>
									</div>
									<div class="field">
										<input id="carNum" class="input" name="licenseNum" value="黑A">
										<%--<select class="input" name="licenseNum"></select>--%>
									</div>
								</div>
								<div class="form-group margin-small">
									<div class="label">
										<label>司机姓名</label>
									</div>
									<div class="field">
										<select class="input" name="homeVisit.idNum" ></select>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>身份证号</label>
									</div>
									<div class="field">
										<input class="input" name="idNum" ></input>
									</div>
								</div>
								
								<div class="form-group margin-small">
									<div class="label">
										<label>家庭住址</label>
									</div>
									<div class="field">
										<input class="input" name="location" ></input>
									</div>
								</div>

								<br>
								
								
								<div  style="width: 100%">
           							 <div class="float-left" style="width: 80px; text-align: right;">
           							 	<strong>添加文件</strong>
           							 </div>
            							<div class="float-left">
                							<select  id="filename" size="5" style="width: 400px;"  class="float-left"></select>
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
					
					            <div style="width: 600px;">
								
										<div class="float-left" style="width: 80px; text-align: right;">
											<strong>家访记录</strong>
										</div>
									
									<div class="field">
										<textarea style="width: 500px;" rows="5" class="input" placeholder="多行文本" name="homeVisit.record"></textarea>
									</div>
								</div>
								<div style="width: 600px;">
								
										<div class="float-left" style="width: 80px; text-align: right;">
											<strong>备注</strong>
										</div>
									
									<div class="field">
										<textarea style="width: 500px;" rows="5" class="input" placeholder="多行文本" name="homeVisit.comment"></textarea>
									</div>
								</div>
								
					<br>
					
					          <div class="form-group margin-small">
									<div class="label">
										<label>家访人</label>
									</div>
									<div class="field">
										<input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                    	<input type="hidden" name="homeVisit.register" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
									</div>
								</div>
								
							</div>
							<br>
							
								<div class="xm10-move">
								<button type="submit" class="button bg-main button-big">提交</button>
								
								</div>
							
						</div>		
    </form>
   <script src="/DZOMS/res/js/DateTimeHelper.js"></script>
</body>
</html>
