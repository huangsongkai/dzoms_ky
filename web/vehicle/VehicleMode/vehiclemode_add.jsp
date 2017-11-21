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
	<title>车辆型号</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
<script>
	$(document).ready(function(){
		getList1('vehicleMode.fuel','vehicleMode_fuel');
		getList1('vehicleMode.color','vehicleMode_color');
		getList1('vehicleMode.company','vehicleMode_company');
	});
</script>
<style>
	.label{
		width: 120px;
		text-align: right;
	}
	
</style>
  </head>
  
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;">
               
                <li>车辆管理</li>
                <li>新增</li>
                <li>新增车辆型号</li>
        </ul>
</div>

    <form action="/DZOMS/vehicle/vehicleModeAdd" name="vehicleModeAdd" method="post"
          class="form-inline form-tips " style="width: 100%;">
          <div class="panel  margin-small" >
          	<div class="panel-head ">
          		添加车辆型号信息
          	</div>
          	  <div class="panel-body">
         
                <div class="form-group">
            <div class="label padding">
                <label>
                    车辆型号
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.carMode" name="vehicleMode.carMode"
                       data-validate="required:请填写内容" placeholder="输入内容">
                <span style="color:red;font-size:large;">*</span>
            </div>
            </div>
            <div class="form-group">
            <div class="label padding">
                <label >
                    发证时间
                </label>
            </div>
            <div class="field">
                <input type="text" class="input datepick" maxlength="50"  id="vehicleMode.licenseDate" name="vehicleMode.licenseDate"
                       data-validate="required:请填写内容" placeholder="输入内容">
                       <span style="color:red;font-size:large;">*</span>
            </div>
        </div>
        <br/>
        <div class="form-group">
            <div class="label padding">
                <label >
                    车辆制造企业
                </label>
            </div>
            <div class="field" style="width: 220px;">
                <select class="input" style="width: 180px;" id="vehicleMode_company" name="vehicleMode.company" onfocus="getList1('vehicleMode.company','vehicleMode_company')">
                </select>
                <span style="color:red;font-size:large;">*</span>
                <a href="javascript:openItem('vehicleMode.company',' 车辆制造企业')"><span class="icon-wrench" ></span></a>
            </div>
        </div>
         <div class="form-group">
            <div class="label padding" style="width: 80px;">
                <label >
                    车身颜色
                </label>
            </div>
            <div class="field">
                <select class="input" id="vehicleMode_color" name="vehicleMode.color" onfocus="getList1('vehicleMode.color','vehicleMode_color')"></select>
                <a href="javascript:openItem('vehicleMode.color','车身颜色')"><span class="icon-wrench" ></span></a>
            </div>
        </div>

        <br/>

        <div class="form-group">
            <div class="label padding">
                <label >
                    车辆品牌
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.brand" name="vehicleMode.brand"
                       data-validate="required:请填写内容" placeholder="输入内容">
                       <span style="color:red;font-size:large;">*</span>
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    燃料种类
                </label>
            </div>
            <div class="field">
                <select class="input" maxlength="50" id="vehicleMode_fuel" name="vehicleMode.fuel" onfocus="getList1('vehicleMode.fuel','vehicleMode_fuel')"></select>
                <a href="javascript:openItem('vehicleMode.fuel','燃料种类')"><span class="icon-wrench" ></span></a>
            </div>
        </div>

        <br/>

        <div class="form-group">
            <div class="label padding">
                <label >
                    排放标准
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.emission" name="vehicleMode.emission">
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    轮胎规格
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.tire" name="vehicleMode.tire" >
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    排量和功率
                </label>
            </div>
            <div class="field">
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode,displacement" name="vehicleMode.displacement">/
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode.power" name="vehicleMode.power">
            </div>
            <div></div>
        </div>

        <br/>

        <div class="form-group">
            <div class="label padding">
                <label >
                    转向形式
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.corneringAbility" name="vehicleMode.corneringAbility" >
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    轮胎数（个）
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50"  id="vehicleMode.tireNum" name="vehicleMode.tireNum">
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    轮距（前/后）（mm）
                </label>
            </div>
            <div class="field">
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode.treadFront" name="vehicleMode.treadFront">/
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode.treadBack" name="vehicleMode.treadBack">
            </div>
        </div>

        <br/>

        <div class="form-group">
            <div class="label padding">
                <label >
                    最高车速（km/h）
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.fastest" name="vehicleMode.fastest">
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    总质量
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.wholeWeight" name="vehicleMode.wholeWeight">
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    外廓尺寸
                </label>
            </div>
            <div class="field">
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode.sizeLong" name="vehicleMode.sizeLong">/
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode.sizeWide" name="vehicleMode.sizeWide">/
                <input type="text" class="input input-auto" maxlength="50" size="5" id="vehicleMode.sizeHigh" name="vehicleMode.sizeHigh">
            </div>
        </div>

        <br/>

        <div class="form-group">
            <div class="label padding">
                <label >
                    额定载客人
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.personNum" name="vehicleMode.personNum">
            </div>
            </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    额定载质量
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.norWeight" name="vehicleMode.norWeight">
            </div>
            </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    轴距
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.wheelBase" name="vehicleMode.wheelBase">
            </div>
        </div>

        <br/>

        <div class="form-group">
            <div class="label padding">
                <label >
                    发动机型号
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.engineMode" name="vehicleMode.engineMode">
            </div>
        </div>

        <div class="form-group">
            <div class="label padding">
                <label >
                    整备质量
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50" id="vehicleMode.allWeight" name="vehicleMode.allWeight">
            </div>
            <div class="label padding">
                <label >
                    轴数
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" maxlength="50"id="vehicleMode.baseNum" name="vehicleMode.baseNum"  >
            </div>
        </div>
        <br/>
        <div class="form-group">
            <div class="label padding">
                <label >
                    使用性质
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" name="vehicleMode.useway" value="出租客运" maxlength="50"/>
            </div>
        </div>
        <div class="form-group">
            <div class="label padding">
                <label >
                               行驶区域
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" name="vehicleMode.distinct" value="中华人民共和国" maxlength="50">
            </div>
        </div>
        </br>
        <div class="form-group">
            <div class="label padding">
                <label >
                               发票金额
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" name="vehicleMode.invoiceAmount" maxlength="50">
            </div>
        </div>
          <div class="form-group">
            <div class="label padding">
                <label >
                               购置税
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" name="vehicleMode.taxAmount" maxlength="50">
            </div>
        </div>
         <div class="form-group">
            <div class="label padding">
                <label >
                                 年平均行驶里程
                </label>
            </div>
            <div class="field">
                <input type="text" class="input" name="vehicleMode.averageYearDistance" maxlength="50">
            </div>
        </div>
        </br>
        <div class="container" style="text-align:right;">
        	<input  class="button bg-green btn btn-primary submitbutton" type="button" value="提交">
						&nbsp;&nbsp;
					
					<input type="submit" style="display: none;" id="submitbutton" />
				<button type="button" class="button  btn-success" name="backid"
							id="backid" onClick="location.href='/DZOMS/vehicle/AbandonApproval/judge.jsp'">取消</button>
        </div>
               
            </div>
          </div>
    </form>
</div>

<script src="/DZOMS/res/js/DateTimeHelper.js"></script>

</body>
 <script src="/DZOMS/res/js/apps.js"></script>
 <script>
    $(document).ready(function() {
try{
 	App.init();
 }catch(e){
 	//TODO handle the exception
 }
    });
    button_bind(".submitbutton","确定提交?","$('#submitbutton').click();");

</script>
</html>
