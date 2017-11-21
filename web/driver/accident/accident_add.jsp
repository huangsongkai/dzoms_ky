<%@ page import="com.dz.module.user.User" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!--<%@ page language="java" pageEncoding="UTF-8"%>-->
        <!DOCTYPE html>
        <html>
        <head lang="en">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta name="renderer" content="webkit">
        <title>事故登记</title>
        <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
        <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
            <link rel="stylesheet" href="/DZOMS/res/css/admin.css">

        <script src="/DZOMS/res/js/jquery.js"></script>
        <script src="/DZOMS/res/js/pintuer.js"></script>
        <script src="/DZOMS/res/js/respond.js"></script>
        
            <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
            <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
            <script src="/DZOMS/res/js/itemtool.js"></script>
            <script>
               function setVehicle(){
                   var num = $("#license_num").val();
                   var dat = {"vehicle.licenseNum":num};
                   $.post('/DZOMS/vehicle/vehicleSelectByLicenseNum',dat,function(dataxy){
                       var da = $.parseJSON(dataxy);
                       var list = da["ItemTool"];
                       $("#carId").attr("value",list["carframeNum"]);
                       $("#carType").attr("value",list["carMode"]);
                       $("#companyBelong").attr("value",list["dept"]);
                       var driverId = list["driverId"]+"";
                       driverId = driverId.substring(0,driverId.length-1);
                       $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":driverId},function(data){
                           $("#renter").attr("value",data["name"]);
                       });
                       var first_id = list["firstDriver"]+"";
                       first_id = first_id.substring(0,first_id.length-1);
                       if(first_id != undefined){
                           $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":first_id},function(data){
                               var name = data["name"];
                               $("#正驾").remove();
                               var op = '<option id="正驾" value="'+first_id+'">'+name+'</option>'
                              
                                if(name!=""){
                               	  $("#drivers").append(op);
                               }
                           });
                       }
                       var second_id = list["secondDriver"]+"";
                       second_id = second_id.substring(0,second_id.length-1);
                       if(second_id != undefined){
                           $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":second_id},function(data){
                               var name = data["name"];
                               $("#二驾").remove();
                               var op = '<option id="二驾" value="'+second_id+'">'+name+'</option>'
                                 if(name!=""){
                               	  $("#drivers").append(op);
                               }
                           });
                       }
                       var third_id = list["thirdDriver"]+"";
                       third_id = third_id.substring(0,third_id.length-1);
                       if(third_id != undefined){
                           $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":third_id},function(data){
                               var name = data["name"];
                               $("#三驾").remove();
                               var op = '<option id="三驾" value="'+third_id+'">'+name+'</option>'
                                 if(name!=""){
                               	  $("#drivers").append(op);
                               }
                           });
                       }
                       var forth_id = list["forthDriver"]+"";
                       forth_id = forth_id.substring(0,forth_id.length-1);
                       if(forth_id != undefined){
                           $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":forth_id},function(data){
                               var name = data["name"];
                               $("#四驾").remove();
                               var op = '<option id="四驾" value="'+forth_id+'">'+name+'</option>'
                                if(name!=""){
                               	  $("#drivers").append(op);
                               }
                           });
                       }
                       var temp_id = list["tempDriver"]+"";
                       temp_id = temp_id.substring(0,temp_id.length-1);
                       if(temp_id != undefined){
                           $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":temp_id},function(data){
                               var name = data["name"];
                               $("#临驾").remove();
                               var op = '<option id="临驾" value="'+temp_id+'">'+name+'</option>'
                               if(name!=""){
                               	  $("#drivers").append(op);
                               }
                             
                           });
                       }
                   });
                };
               function setAttr(x){
                   var id = $(x).find("option:selected").attr("id");
                   $("#dattr").val(id);
               }
               function loadList(){
                   getList1('aClass','aClass');
                   getList1('accDeal','accDeal');
                   getList1('weather','weather');
                   getList1('roadCondition','roadCondition');
                   getList1('reason','reason');
                   getList1('happenArea','happenArea');
                   getList1('belongArea','belongArea');
               };
               $(document).ready(function(){
                   loadList();
                   setTimeout(function(){
                       $("#license_num").bigAutocomplete({
                           url:"/DZOMS/select/VehicleBylicenseNum",
                           callback:function(){
                           	setVehicle();
                           }
                       });
                   },1000);
               });

               function validate(){
               	  
                   var licenseNum = $("#license_num").val();
                   var driverId = $("#drivers").val();
                   var addTime = $("#addTime").val();
                   var time = $("#time").val();
                   if(licenseNum == "" || licenseNum == undefined){
                       alert("请输入车牌号");
                       return false;
                   }
                   if(driverId ==""||driverId==undefined||driverId==" "){
                       alert("请选择驾驶人");
                       return false;
                   }
                   if(addTime ==""||addTime==undefined||addTime==" "){
                       alert("报表时间必填");
                       return false;
                   }
                   if(time ==""||time==undefined||time==" "){
                       alert("事故时间必填");
                       return false;
                   }
                   $("#base_form").submit();
               }

               function show_accuse(){
                   $("#accuse_show").val($("#clause option:selected").attr("id"));
               }
                function show_optional(){
                    //acc should be add here
                    if($("#aType").val() == 0){
                        $(".op_dead").hide();
                        $(".op_acc").show();
                    }
                    //dead should be add here
                    else if($("#aType").val() == 1){
                        $(".op_dead").show();
                        $(".op_acc").hide();
                    }
                    else{
                        $(".op_dead").hide();
                        $(".op_acc").hide();
                    }
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
<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>事故</li>
                <li>事故登记</li>
        </ul>
</div>
</div>
<div class="line">
    <form name="add_accident" style="width: 100%;" action="/DZOMS/accident_AddOrUpdate" method="post" class="form-inline form-tips" target="subs" id="base_form">

        <div class="panel">
            <div class="panel-head">
                <strong>基本信息</strong>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            报表时间
                        </label>
                    </div>
                    <div class="field">
                        <input class="datepick input" type="text"  name="accident.addTime" id="addTime">
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故时间
                        </label>
                    </div>
                    <div class="field">
                        <input class="datepick input" type="text"  name="accident.time" id="time">
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            登记人
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
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
                        <input class="input" id="license_num" onblur="setVehicle();" value="黑A"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车架号
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" name="accident.carId" id="carId"/>
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
                        <select class="input" id="drivers" onchange="setAttr(this)" name="accident.driverId">
                            <option></option>
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
                        <input name="accident.driverAttr" class="input" readonly="readonly" id="dattr"/>
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
                        <select  class="input" style="width: 180px;" name="accident.aClass" id="aClass" onfocus="getList1('aClass','aClass')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('aClass','事故类别')"></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故类型
                        </label>
                    </div>
                    <div class="field">
                        <select  class="input" style="width: 180px;" name="accident.aType" id="aType" onchange="show_optional()">
                            <option></option>
                            <option value="0">事故损失</option>
                            <option value="1">死亡事故</option>
                        </select>
                    </div>
                </div>
                <br/>
                <div id="optional">
                	 <div  class="form-group op_acc" style="display: none;">
		                	<div class="label">
		                		<label>事故性质：</label>
		                	</div>
		                	<div class="field">
		                		<select name="accident.shiguxingzhi" class="input">
		                        <option value=""></option>
		                        <option value="轻微">轻微</option>
		                        <option value="一般">一般</option>
		                        <option value="重大">重大</option>
		                        <option value="特大">特大</option>
		                    </select>
		                	</div>
                    </div>
                    <div class="form-group op_acc" style="display: none;">
                    	<div class="label">
                    		<label>事故金额：</label>
                    	</div>
                    	<div class="field">
                    		 <input type="text" name="accident.shigujine" class="input">
                    	</div>
                    </div>
                    <div class="form-group op_dead" style="display: none;">
                    	<div class="label">
                    		<label>事故责任：</label>
                    	</div>
                    	<div class="field">
                    		<select name="accident.shiguzeren" class="input">
		                        <option value=""></option>
		                        <option value="单方肇事">单方肇事</option>
		                        <option value="全责任">全责任</option>
		                        <option value="主要责任">主要责任</option>
		                        <option value="同等责任">同等责任</option>
		                        <option value="次要责任">次要责任</option>
		                        <option value="无责任">无责任</option>
		                    </select>
                    	</div>
                    </div>
                </div>
                <br>
                <div class="form-group" style="width: 700px;">
                    <div class="label padding">
                        <label>
                            条款：
                        </label>
                    </div>
                    <div class="field" style="width: 500px;">
                        <select class="input" name="accident.clause" id="clause" onchange="show_accuse()">
                            <option value="14001" id="一般事故损失（交通事故损失）">14001</option>
                            <option value="14101" id="发生交通死亡事故责任，负次要责任的">14101</option>
                            <option value="14102" id="发生交通死亡事故责任，负同等责任的">14102</option>
                            <option value="14103" id="发生交通死亡事故责任，负主要责任的">14103</option>
                            <option value="14104" id="发生交通死亡事故责任，负全责任">14104</option>
                            <option value="14105" id="发生交通死亡事故责任，无责任">14105</option>
                        </select>
                        <input type="text" class="input input-auto" size="40" id="accuse_show" value="一般事故损失（交通事故损失）">
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
                        <select class="input" style="width: 180px;" name="accident.accDeal" id="accDeal" onfocus="getList1('accDeal','accDeal')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('accDeal','事故处理')"></a>
                    </div>
                </div>
                <div class="form-group" style="width: 340px;">
                    <div class="label padding">
                        <label>
                            保险公司
                        </label>
                    </div>
                    <div class="field">
                    	<select  class="input itemtool" style="width: 180px;" name="accident.insuCompany" id="insuranceCompany" item-key="insuranceCompany">
                </select>
                <a class="icon icon-wrench" href="javascript:openItem('insuranceCompany','保险公司')"></a>
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
                        <select class="input" style="width: 100px;" name="accident.weather" id="weather" onfocus="getList1('weather','weather')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('weather','天气状况')"></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            路面情况
                        </label>
                    </div>
                    <div class="field">
                        <select class="input" style="width: 100px;" name="accident.roadCondition" id="roadCondition" onfocus="getList1('roadCondition','roadCondition')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('roadCondition','路面状况')"></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            出险原因
                        </label>
                    </div>
                    <div class="field">
                        <select class="input" style="width: 180px;" name="accident.reason" id="reason" onfocus="getList1('reason','reason')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('reason','出险原因')"></a>
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
                        <select class="input" style="width: 180px;" name="accident.happenArea" id="happenArea" onfocus="getList1('happenArea','happenArea')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('happenArea','发生区域')"></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            归属区域
                        </label>
                    </div>
                    <div class="field">
                        <select class="input" style="width: 180px;" name="accident.belongArea" id="belongArea" onfocus="getList1('belongArea','belongArea')">
                        </select><a class="icon icon-wrench" href="javascript:openItem('belongArea','归属区域')"></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            事故地点
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" name="accident.location"/>
                    </div>
                </div>
                <br>
                <div class="form-group" style="width: 500px;">
                    <div class="padding" style="width: 100px;float: left;">
                        <strong>
                            事故经过:
                        </strong>
                    </div>
                    <div class="field">
                        <textarea  class="input" rows="5" placeholder="多行文本框" name="accident.accReason" style="width: 300px;"></textarea>
                       
                    </div>
                </div>
                <br>
                <div class="form-group" style="width: 800px">
                	<div class="label" style="width: 700px">
                		
                	</div>
                	<div class="field">
                		<input type="button" class="button bg-main" onclick="validate()" value="保存" id="saver" />
                	</div>
                	
                </div>
            </div>

        </div>
    </form>
   
  
    <iframe name="subs" style="width: 100%; min-height:1000px;"></iframe>

    <iframe name="hidefucker" style="display: none"></iframe>

</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</html>