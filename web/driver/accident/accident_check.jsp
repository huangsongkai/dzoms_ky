<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page import="com.dz.module.user.User" %>
<%@ page import="com.dz.module.driver.accident.Accident" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-10-11
  Time: 上午11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="../../res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="../../res/css/jquery.datetimepicker.css"/>

    <script src="../../res/js/jquery.js"></script>
    <script src="../../res/js/pintuer.js"></script>
    <script src="../../res/js/respond.js"></script>
    <link rel="stylesheet" href="../../res/css/admin.css">
  <script src="../../res/js/jquery.js"></script>
  <script>
      function addLoss(){
          var sum = 0;
          sum += eval($("#carLoss").val());
          sum += eval($("#carPaid").val());
          sum += eval($("#peopleLoss").val());
          $("#allLoss").val(sum);
      };
      function setVehicle(carframeNum){
          var dat = {"vehicle.carframeNum":carframeNum};
          $.post('/DZOMS/vehicle/vehicleSelectById',dat,function(data){
              da = $.parseJSON(data);
              $("#licenseNum").attr("value",da["ItemTool"]["licenseNum"]);
              $("#ln").val(da["ItemTool"]["licenseNum"]);
              $("#carType").attr("value",da["ItemTool"]["carMode"]);
              $("#companyBelong").attr("value",da["ItemTool"]["dept"]);
              $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":da["ItemTool"]["driverId"]},function(data){
                  $("#renter").attr("value",data["name"]);
              });
          });
      };
      function setRegister(userId){
          var dat = {"className":"com.dz.module.user.User","id":userId,"isString":false};
          $.post('/DZOMS/common/getObject',dat,function(data){
              $("#register").attr("value",data["uname"]);
          });
      };
      function setProperty(id){
          dat = {'accident.accId':id};
          $.post('/DZOMS/accident_SelectById',dat,function(data){
              var da = $.parseJSON(data);
              var list = da['ItemTool'];
              $("#carId").attr("value",list["carId"]);
              $("#aClass").attr("value",list["aClass"]);
              $("#clause").attr("value",list["clause"]);
              $("#accDeal").attr("value",list["accDeal"]);
              $("#insuCompany").attr("value",list["insuCompany"]);
              $("#weather").attr("value",list["weather"]);
              $("#roadCondition").attr("value",list["roadCondition"]);
              $("#reason").attr("value",list["reason"]);
              $("#happenArea").attr("value",list["happenArea"]);
              $("#belongArea").attr("value",list["belongArea"]);
              $("#location").attr("value",list["location"]);

              //
              
              if(list["aType"] == 0){
//            	alert(list["shiguxingzhi"]);
                  $("#aType").attr("value",'事故损失');
                  $(".op_acc").show();
                  $("#shiguxingzhi").val(list["shiguxingzhi"]);
                  $("#shigujine").val(list["shigujine"]);
              }else if(list["aType"] == 1){
                  $("#aType").attr("value",'死亡事故');
                  $(".op_dead").show();
                  $("#shiguzeren").val(list["shiguzeren"]);
              }
              var x = "x";
              if(list["clause"] == 14001){
                  x = "一般事故损失（交通事故损失）";
              }else if(list["clause"] == 14101){
                  x = "发生交通死亡事故责任，负次要责任的";
              }else if(list["clause"] == 14102){
                  x = "发生交通死亡事故责任，负同等责任的";
              }else if(list["clause"] == 14103){
                  x = "发生交通死亡事故责任，负主要责任的";
              }else if(list["clause"] == 14104){
                  x = "发生交通死亡事故责任，负全责任";
              }else{
                  x = "发生交通死亡事故责任，无责任";
              }
              $("#clause2").val(x);


              //
              $("#accId").attr("value",list["accId"]);
              $("#carLoss").attr("value",list["carLoss"]);
              $("#carPaid").attr("value",list["carPaid"]);
              $("#peopleLoss").attr("value",list["peopleLoss"]);
              $("#accReason").html(list["accReason"]);

              //
              var driverId = list["driverId"];
              $("#driverAttr").val(list["driverAttr"]);
              $("#driverId").val(driverId);
              $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":driverId},function(data){
                  $("#driverName").attr("value",data["name"]);
              });

              addLoss();
              setRegister(list["register"]);
              setVehicle(list["carId"]);
              $("#time").attr("value",list["time"]["$"]);
              $("#addTime").attr("value",list["addTime"]["$"]);
          });
      }
    $(document).ready(function func(){
      var accidentId = window.dialogArguments[0];
      <%--var accidentId = "<s:property value="%{#parameters.accidentId}"/>";--%>
        setProperty(accidentId);
        load1(accidentId);
        load2(accidentId);
        load3(accidentId);
        loadX(accidentId);
    });
      function load1(accidentId){
          var dat = {'accident.accId':accidentId};
          $.post('/DZOMS/apl_search_0',dat,function(data){
              data = $.parseJSON(data);
              data = data["list"][0]["com.dz.module.driver.accident.PeopleLoss"];
              if(data.length == undefined){
                  data = [data];
              }
              for(var i = 0;i < data.length;++i){
                  var cur = data[i];
                  var hdstr = cur["hd"] == 0?"伤":"亡";
                  var txt =
                          '<tr id="1t'+cur["plId"]+'">'
                          +'<td>'+hdstr+'</td>'
                          +'<td>'+cur["name"]+'</td>'
                          +'<td>'+cur["loss"]+'</td>'+
                          '</tr>';
                  $("#table1").append(txt);
              }
          });
      };
      function load2(accidentId){
          var dat = {'accident.accId':accidentId};
          $.post('/DZOMS/acl_search_1',dat,function(data){
              data = $.parseJSON(data);
              data = data["list"][0]["com.dz.module.driver.accident.CarLoss"];
              if(data.length == undefined){
                  data = [data];
              }
              for(var i = 0;i < data.length;++i){
                  var cur = data[i];
                  var txt =
                          '<tr id="2t'+cur["clId"]+'">'
                          +'<td>'+cur["carId"]+'</td>'
                          +'<td>'+cur["carType"]+'</td>'
                          +'<td>'+cur["carLoss"]+'</td>'+
                          '</tr>';
                  $("#table2").append(txt);
              }
          });
      };
      function load3(accidentId){
          var dat = {'accident.accId':accidentId};
          $.post('/DZOMS/apl_search_1',dat,function(data){
              data = $.parseJSON(data);
              data = data["list"][0]["com.dz.module.driver.accident.PeopleLoss"];
              if(data.length == undefined){
                  data = [data];
              }
              for(var i = 0;i < data.length;++i){
                  var cur = data[i];
                  var hdstr = cur["hd"] == 0?"伤":"亡";
                  var txt =
                          '<tr id="3t'+cur["plId"]+'">'
                          +'<td>'+hdstr+'</td>'
                          +'<td>'+cur["name"]+'</td>'
                          +'<td>'+cur["loss"]+'</td>'+
                          '</tr>';
                  $("#table3").append(txt);
              }
          });
      };
      function loadX(accidentId){
          $.post("/DZOMS/accident_InsuranceGet", {"accident.accId":accidentId},function(data){
              data = $.parseJSON(data);
              data = data["ItemTool"];
              if(data["com_thief"] == true){
                  $("#com_thief").attr("checked","checked");
              }
              if(data["com_car"] == true){
                  $("#com_car").attr("checked","checked");
              }
              if(data["com_people"] == true){
                  $("#com_people").attr("checked","checked");
              }
              if(data["com_other"] == true){
                  $("#com_other").attr("checked","checked");
              }
              if(data["tra_doc"] == true){
                  $("#tra_doc").attr("checked","checked");
              }
              if(data["tra_car"] == true){
                  $("#tra_car").attr("checked","checked");
              }
              if(data["tra_people"] == true){
                  $("#tra_people").attr("checked","checked");
              }
              if(data["tra_other"] == true){
                  $("#tra_other").attr("checked","checked");
              }
              $("#acc_learn").val(data["acc_learn"]);
              var filePaths = data["filePaths"][0]["string"];
              if(typeof filePaths == 'string')
                      filePaths = [filePaths];
              for(var each in filePaths){
                  var filePath = filePaths[each];
                  var nameArray = filePath.toString().split("/");
                  var fileName = nameArray[nameArray.length - 1];
                  var oneRow = "<input type='text' value='"+fileName+"' readonly><a href='/DZOMS/download?filePath="+filePath+"'>查看</a><br/>"
                  $("#fileHolder").append(oneRow);
              }
          });
      }
      function dochecked(){
          $("#form").attr("action","/DZOMS/accident_Checked");
      };
      function dounchecked(){
          $("#form").attr("action","/DZOMS/accident_UnChecked");
      };
      function dosubmit() {
          var acTime = $("#acTime").val();
          if(acTime == undefined || acTime=="" || acTime==" "){
              alert("时间必填");
              return false;
          }
          $("#form").submit();
      }
  </script>
   <style>
        .label{
            width: 100px;
            text-align: right;
        }
        .form-group{
        	width: 300px;
        }
    </style>
</head>
<body>
	<div class="line">
		<blockquote>
			<strong>基本信息</strong>
			   <form name="add_accident" action="/DZOMS/accident_AddOrUpdate" method="post" class="form-inline">
		 	       <div class="form-group">
                    <div class="label padding">
                        <label>
                            报表时间
                        </label>
                    </div>
                    <div class="field">
                       <input class="input" type="text" id="addTime" readonly="readonly">
                    </div>
              </div>
              <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故时间
                        </label>
                    </div>
                    <div class="field">
                      <input class="input" type="text" readonly="readonly" id="time">
                    </div>
              </div>
              <div class="form-group">
                    <div class="label padding">
                        <label>
                            登记人
                        </label>
                    </div>
                    <div class="field">
                       <input class="input" type="text" readonly="readonly" id="register">
                       <input type="hidden" name="accident.register" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
                    </div>
              </div>
              <br/>
              <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="licenseNum"/>
                    </div>
              </div>
               <div class="form-group">
                    <div class="label padding">
                        <label>
                            车架号
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" name="carId" id="carId"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车型
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="carType"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            分公司归属
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="companyBelong"/>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            承租人
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" type="text" readonly="readonly" id="renter"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            驾驶人
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" type="text" id="driverName" readonly="readonly">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            驾驶人属性
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="driverAttr"/>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故类别
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="aClass"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故类型
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="aType"/>
                    </div>
                </div>
                <br/>
                <div id="optional">
                	 <div  class="form-group op_acc" style="display: none;">
		                	<div class="label">
		                		<label>事故性质：</label>
		                	</div>
		                	<div class="field">
		                		 <input type="text" id="shiguxingzhi" class="input" readonly>
		                	</div>
                    </div>
                    <div class="form-group op_acc" style="display: none;">
                    	<div class="label">
                    		<label>事故金额：</label>
                    	</div>
                    	<div class="field">
                    		<input type="text" id="shigujine" class="input" readonly>
                    	</div>
                    </div>
                    <div class="form-group op_dead" style="display: none;">
                    	<div class="label">
                    		<label>事故责任：</label>
                    	</div>
                    	<div class="field">
                    		 <input type="text" id="shiguzeren" class="input">
                    	</div>
                    </div>
                </div>
                <br>
                <div class="form-group" style="width: 600px;">
                    <div class="label padding">
                        <label>
                            条款：
                        </label>
                    </div>
                    <div class="field" style="width: 500px;">
                        <input class="input" readonly="readonly" id="clause"/>
                        <input class="input" readonly="readonly" id="clause2"/>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故处理：
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" id="accDeal" readonly="readonly"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            保险公司
                        </label>
                    </div>
                    <div class="field">
                       <input class="input" name="accident.insuCompany" id="insuCompany" readonly="readonly"/>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            天气情况
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="weather"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            路面情况
                        </label>
                    </div>
                    <div class="field">
                       <input class="input" readonly="readonly" id="roadCondition"/>
                    </div>
                </div>
                 <div class="form-group">
                    <div class="label padding">
                        <label>
                            出险原因
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="reason"/>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            发生区域
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" id="happenArea"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            归属区域
                        </label>
                    </div>
                    <div class="field">
                       <input class="input" readonly="readonly" id="belongArea"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故地点
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" name="accident.location" id="location" readonly="readonly"/>
                    </div>
                </div>
                <br>
                <div class="form-group" style="width: 500px;">
                    <div class="padding" style="width: 100px;float: left;">
                        
                            事故经过:
                        
                    </div>
                    <div class="field">
                        <textarea rows="5" class="input" style="width: 300px;" placeholder="事故经过" name="accident.accReason" id="accReason" readonly="readonly"></textarea>
                       
                    </div>
                </div>
		 </form>
		</blockquote>
</div>
<div class="line">
    		 		  	<blockquote class="xm6">
			    		 		<strong>商业险</strong>
			    		 		<input type="checkbox" disabled="disabled" name="com_thief" id="com_thief"><label>盗抢险</label>
					        <input type="checkbox" disabled="disabled"  name="com_car" id="com_car"><label>车损险</label>
					        <input type="checkbox"  disabled="disabled" name="com_people" id="com_people"><label>车上人员险</label>
					        <input type="checkbox" disabled="disabled"  name="com_other" id="com_other"><label>其他</label>
			    		 	</blockquote>
			    		 	<blockquote class="xm6">
			    		 		 <strong>交强险</strong>
			    		 		 <input type="checkbox" disabled="disabled"  name="tra_doc" id="tra_doc"><label>医疗险</label>
					        <input type="checkbox" disabled="disabled"  name="tra_car" id="tra_car"><label>车损险</label>
					        <input type="checkbox" disabled="disabled"  name="tra_people" id="tra_people"><label>伤残险</label>
					        <input type="checkbox" disabled="disabled"  name="tra_other" id="tra_other"><label>其他</label>
			    		 	</blockquote>
</div>
	<!--教训-->
<div class="line">
    		  	<blockquote>
    		  		<div class="form-group margin">
    		  	   	   <div style="width: 100px; float: left;">
    		  	   	   	<strong>事故教训:</strong>
    		  	   	   </div>
    		  	   	   <div class="field">
    		  	   	   	<textarea rows="5" readonly style="width: 500px;" type="text" name="accidentinsurance.acc_learn" id="acc_learn" class="input"></textarea>
    		  	   	   </div>
    		  	   </div>
    		  	</blockquote>
</div>
 <!--文件-->
<div class="line">
    		  	<blockquote>
    		  		<div class="form-group margin">
    		  	   	   <div style="width: 100px; float: left;">
    		  	   	   	<strong>文件:</strong>
    		  	   	   </div>
    		  	   	   <div class="field">
    		  	   	   	<div id="fileHolder"></div>
    		  	   	   </div>
    		  	   </div>
    		  	</blockquote>
</div>
 <!--甲方-->
<form method="post" class="form-tips form-inline" action="/DZOMS/accident_UpdateLoss">
<div class="line">
    		  	<blockquote>
    		  		<strong>甲方损失:</strong>
    		  	    <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto"  type="text" size="20" id="ln" readonly="readonly">
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车损失
                        </label>
                    </div>
                    <div class="field">
                        <input readonly="readonly" class="input input-auto" size="20" id="carLoss" name="loss.carLoss" onblur="addLoss()">
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车赔付
                        </label>
                    </div>
                    <div class="field">
                        <input readonly="readonly" class="input input-auto" size="20" id="carPaid" name="loss.carPaid" onblur="addLoss()" >
                    </div>
                </div>

                <div class="form-group">
                    <div class="float-left" style="width: 100px;">伤亡人数：</div>
                    <div class="float-left">
                        <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
                            <table class="table table-bordered table-striped" id="table1">
                                <tr>
                                    <th>伤亡</th>
                                    <th>伤亡人姓名</th>
                                    <th>伤亡人损失</th>
                                </tr>
                            </table>
                        </div>
                        
                    </div>
                </div>	 
    		  	   	   
    		  	   
    		  	</blockquote>
 </div>
 <div class="line">
    		  	<blockquote>
    		  		   <strong>乙方损失</strong>
    		  		   <div class="line">
    		  		   	   <div class="float-left">车辆损失：</div>
			                <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
			                    <table class="table table-bordered table-striped" id="table2">
			                        <tr>
			                            <th>车牌号</th>
			                            <th>车型</th>
			                            <th>损失</th>
			                        </tr>
			                    </table>
			                </div>

                
                    
    		  		   </div>
    		  		    <div class="line">
											   <div class="float-left">伤亡人数：</div>
											                <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
											                    <table class="table table-bordered table-striped" id="table3">
											                        <tr>
											                            <th>伤亡</th>
											                            <th>伤亡人姓名</th>
											                            <th>伤亡人损失</th>
											                        </tr>
											                    </table>
											
											                </div>
											                
											            
    		  		    	
    		  		    </div>
									<div class="line">
										  <div class="form-group">
										  	<div class="label">
										  		<label>财产损失：</label>
										  	</div>
										  	<div class="field">
										  		  <input readonly="readonly" class="input input-auto"  name="loss.peopleLoss" id="peopleLoss" onblur="addLoss();">
										  	</div>
										  	
										  </div>
									</div>		
    		  		</blockquote>
</div>
<!--总损失-->
<div class="line">
		             <div class="form-group">
					            <div class="label">
					                <label>
					                    总损失：
					                </label>
					            </div>
			            <div class="field">
			                <input class="input input-auto margin-small"  id="allLoss" readonly="readonly">
			            </div>
                  </div>
                  
		    		  	 	
</div>
</form>



<!--损失结束-->
<form action="/DZOMS/accident_UnChecked" method="post" id="form">
	<blockquote class="border-main">
		<strong>审核</strong>
		   <input type="hidden" name="accident.accId" id="accId">
    <div class="container">
        <table class="table">
            
            <tr>
                <td class="tableleft">审核人</td>
                <td><input class="input input-auto" size="6" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                <input type="hidden" name="acheck.checker" value="<%=((User)session.getAttribute("user")).getUid()%>"/></td>
                <td>审核时间</td>
                <td><input class="datetimepicker input input-auto" size="15" type="text" name="acheck.acTime" id="acTime"></td>
                <td>是否通过</td>
                <!--<td><input type="checkbox" onChange="chooseAction();" id="isPass"/>通过</td>-->
                <td>
                    <div class="button-group radio">
                        <label class="button"><input name="pintuer" type="radio" id="passed" onclick="dochecked();"><span class="icon icon-check text-green"></span> 通过</label>
                        <label class="button active"><input name="pintuer" id="unpassed" checked="checked" type="radio" onclick="dounchecked()"><span class="icon icon-times text-red"></span> 未通过</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>原因</td>
                <td colspan="6">
                    <textarea rows="5" class="input" placeholder="原因" name="acheck.reason"></textarea>
                </td>
            </tr>
            <!--提交按钮-->
            <tr>
                <td colspan="6"> <div class="form-button"><input class="button bg-green" type="button" value="审核" onclick="dosubmit()"></input></div></td>
            </tr>
        </table>
    </div>
	</blockquote>
	

</form>
</body>

<script src="../../res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker();
</script>

</html>