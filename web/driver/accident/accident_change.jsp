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

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <script src="/DZOMS/res/js/itemtool.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <script>
    function setVehicleByLicense(){
      var num = $("#license_num").val();
      var dat = {"vehicle.licenseNum":num};
      $.post('/DZOMS/vehicleSelectByLicenseNum',dat,function(data){
        var da = $.parseJSON(data);
        var list = da["ItemTool"];
        $("#carId").attr("value",list["carframeNum"]);
        $("#carType").attr("value",list["carMode"]);
        $("#companyBelong").attr("value",list["dept"]);
        var driverId = list["driverId"]+"";
        driverId = driverId.substring(0,driverId.length-1);
        $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":driverId},function(data){
          data = $.parseJSON(data);
          data = data["ItemTool"];
          $("#renter").attr("value",data["name"]);
        });
      });
    };
    function setVehicle(carframeNum){
      var dat = {"vehicle.carframeNum":carframeNum};
      $.post('/DZOMS/vehicle/vehicleSelectById',dat,function(data){
        var da = $.parseJSON(data);
        $("#license_num").attr("value",da["ItemTool"]["licenseNum"]);
        $("#carType").attr("value",da["ItemTool"]["carMode"]);
        $("#companyBelong").attr("value",da["ItemTool"]["dept"]);
        $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":da["ItemTool"]["driverId"]},function(data){
          $("#renter").attr("value",data["name"]);
        });
        var list = da["ItemTool"];
        var first_id = list["firstDriver"]+"";
        first_id = first_id.substring(0,first_id.length-1);
        if(first_id != undefined){
          $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":first_id},function(data){
            var name = data["name"];
            $("#正驾").remove();
            var op = '<option id="正驾" value="'+first_id+'">'+name+'</option>'
            $("#drivers").append(op);
          });
        }
        var second_id = list["secondDriver"]+"";
        second_id = second_id.substring(0,second_id.length-1);
        if(second_id != undefined){
          $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":second_id},function(data){
            var name = data["name"];
            $("#二驾").remove();
            var op = '<option id="二驾" value="'+second_id+'">'+name+'</option>'
            $("#drivers").append(op);
          });
        }
        var third_id = list["thirdDriver"]+"";
        third_id = third_id.substring(0,third_id.length-1);
        if(third_id != undefined){
          $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":third_id},function(data){
            var name = data["name"];
            $("#三驾").remove();
            var op = '<option id="三驾" value="'+third_id+'">'+name+'</option>'
            $("#drivers").append(op);
          });
        }
        var forth_id = list["forthDriver"]+"";
        forth_id = forth_id.substring(0,forth_id.length-1);
        if(forth_id != undefined){
          $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":forth_id},function(data){
            var name = data["name"];
            $("#四驾").remove();
            var op = '<option id="四驾" value="'+forth_id+'">'+name+'</option>'
            $("#drivers").append(op);
          });
        }
        var temp_id = list["tempDriver"]+"";
        temp_id = temp_id.substring(0,temp_id.length-1);
        if(temp_id != undefined){
          $.post("/DZOMS/driver/driverSelectById",{"driver.idNum":temp_id},function(data){
            var name = data["name"];
            $("#临驾").remove();
            var op = '<option id="临驾" value="'+temp_id+'">'+name+'</option>'
            $("#drivers").append(op);
          });
        }
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
        //事故id
        $("#accId").attr("value",id);
        //登记人id
        $("#registerId").attr("value",list["register"]);
        setRegister(list["register"]);
        //车架号
        $("#carId").attr("value",list["carId"]);
        $("#clause").val(list["clause"]);
        show_accuse();

        //aType
        $("#aType").val(list["aType"]);
        show_optional();
        if(list["aType"] == 0){
          $("#shiguxingzhi").val(list["shiguxingzhi"]);
          $("#shigujine").val(list["shigujine"]);
        }else{
          $("#shiguzeren").val(list["shiguzeren"]);
        }

        $("#insuCompany").attr("value",list["insuCompany"]);
        $("#location").attr("value",list["location"]);
        //
        $("#accId").attr("value",list["accId"]);
        $("#accReason").html(list["accReason"]);
        $("#time").attr("value",list["time"]["$"]);
        $("#addTime").attr("value",list["addTime"]["$"]);
        //
        setVehicle(list["carId"]);
        setTimeout(function(){
          var driverId = list["driverId"];
          $("#driverAttr").val(list["driverAttr"]);
          $("#drivers").val(driverId);
        },1000);
        //
        getListX('aClass','aClass',list["aClass"]);
        getListX('accDeal','accDeal',list["accDeal"]);
        getListX('weather','weather',list["weather"]);
        getListX('roadCondition','roadCondition',list["roadCondition"]);
        getListX('reason','reason',list["reason"]);
        getListX('happenArea','happenArea',list["happenArea"]);
        getListX('belongArea','belongArea',list["belongArea"]);
      });
    }
    function setAttr(x){
      var id = $(x).find("option:selected").attr("id");
      $("#driverAttr").val(id);
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
    $(document).ready(function func(){
      var accidentId = window.dialogArguments[0];
      setProperty(accidentId);
    });
  </script>
</head>
<body>
<form name="add_accident" action="/DZOMS/accident_AddOrUpdate" method="post">
  <input type="hidden" name="accident.accId" id="accId"/>
  <div class="container">
    <table class="table table-hover">
      <tr>
        <td class="tableleft">填报时间</td>
        <td><input class="datetimepicker input" type="text"  name="accident.addTime" id="addTime"></td>
        <td class="tableleft">事故时间</td>
        <td><input class="datetimepicker input" type="text"  name="accident.time" id="time"></td>
        <td class="tableleft">登记人</td>
        <td><input class="input" type="text"  id="register"/>
        <input type="hidden" name="accident.register" id="registerId"/></td>
      </tr>
      
      <!-- 第二行-->
      <tr>
        <td class="tableleft">车牌号</td>
        <td><input class="input" id="license_num" onblur="setVehicleByLicense();"/></td>
        
        <td class="tableleft">车架号</td>
        <td><input class="input"  name="accident.carId" id="carId" readonly="readonly"/></td>
        <td class="tableleft">车型</td>
        <td><input class="input"  id="carType" readonly="readonly"/></td>
        <td class="tableleft ">分公司归属</td>
        <td><input class="input"  id="companyBelong" readonly="readonly"/></td>
      </tr>
      <!-- 第三行-->
      <tr>
        <td class="tableleft" >承租人</td>
        <td><input class="input" type="text" id="renter" readonly="readonly" /></td>
        <td class="tableleft" >驾驶人</td>
        <td>
          <select class="input" id="drivers" name="accident.driverId" onchange="setAttr(this)">
          </select>
        </td>
        <%--<td class="tableleft">身份证</td>--%>
        <%--<td><input class="input" id="driverId" name="accident.driverId" id="driverId" readonly="readonly"/></td>--%>
        <td class="tableleft">驾驶人属性</td>
        <td><input class="input" name="accident.driverAttr" id="driverAttr" readonly="readonly"/></td>
      </tr>
      <!-- 第四行-->
      <tr>
        <td class="tableleft">事故类别</td>
        <td colspan="3">
          <select  class="input" name="accident.aClass" id="aClass">
          </select>
        </td>
        <td class="tableleft">事故类型</td>
        <td colspan="3">
          <select  class="input" style="width: 180px;" name="accident.aType" id="aType" onchange="show_optional()">
            <option></option>
            <option value="0">事故损失</option>
            <option value="1">死亡事故</option>
          </select>
        </td>
      </tr>

      <tr id="optional">
        <td><label class="op_acc" style="display: none">事故性质：</label>
          <select id="shiguxingzhi" name="accident.shiguxingzhi" class="op_acc" style="display: none">
            <option value=" "></option>
            <option value="轻微">轻微</option>
            <option value="一般">一般</option>
            <option value="重大">重大</option>
            <option value="特大">特大</option>
          </select>
        </td>
        <td><label class="op_acc" style="display: none">事故金额：</label>
          <input type="text" id="shigujine" name="accident.shigujine" class="op_acc" style="display: none">
        </td>
        <td><label class="op_dead" style="display: none">事故责任：</label>
          <select id="shiguzeren" name="accident.shiguzeren" class="op_dead" style="display: none">
            <option value=""></option>
            <option value="单方肇事">单方肇事</option>
            <option value="全责任">全责任</option>
            <option value="主要责任">主要责任</option>
            <option value="同等责任">同等责任</option>
            <option value="次要责任">次要责任</option>
            <option value="无责任">无责任</option>
          </select>
        </td>
      </tr>

      <!-- 第五行-->

      <tr>
        <td class="tableleft">条款</td>
        <td>
          <select class="input" name="accident.clause" id="clause" onchange="show_accuse()">
            <option value="14001" id="一般事故损失（交通事故损失）">14001</option>
            <option value="14101" id="发生交通死亡事故责任，负次要责任的">14101</option>
            <option value="14102" id="发生交通死亡事故责任，负同等责任的">14102</option>
            <option value="14103" id="发生交通死亡事故责任，负主要责任的">14103</option>
            <option value="14104" id="发生交通死亡事故责任，负全责任">14104</option>
            <option value="14105" id="发生交通死亡事故责任，无责任">14105</option>
          </select>
        </td>
        <td colspan="3">
          <input class="input" type="text" id="accuse_show" readonly>
        </td>
      </tr>
      <!-- 第六行-->
      <tr>
        <td class="tableleft">事故处理</td>
        <td>
          <select class="input" name="accident.accDeal" id="accDeal">
          </select>
        </td>
        <td class="tableleft">保险公司</td>
        <td><input class="input" name="accident.insuCompany" id="insuCompany"/></td>
      </tr>

      <!-- 第七行-->

      <tr>
        <td>天气状况</td>
        <td>
          <select class="input" name="accident.weather" id="weather">
          </select>
        </td>
        <td>路面状况</td>
        <td>
          <select class="input" name="accident.roadCondition" id="roadCondition">
          </select>
        </td>
        <td>出险原因</td>
        <td colspan="2">
          <select class="input" name="accident.reason" id="reason">
          </select>
        </td>
      </tr>
      <tr>
        <td>发生区域</td>
        <td>
          <select class="input" name="accident.happenArea" id="happenArea">
          </select>
        </td>
        <td>归属区域</td>
        <td>
          <select class="input" name="accident.belongArea" id="belongArea">
          </select>
        </td>
        <td class="tableleft">事故地点</td>
        <td><input class="input" name="accident.location" id="location"/></td>
      </tr>
      <tr>
        <td>事故经过</td>
        <td colspan="6">
          <textarea rows="5" class="input" placeholder="多行文本框" name="accident.accReason" id="accReason"></textarea>
        </td>
      </tr>



      <!--提交按钮-->
      <tr>
        <td colspan="6"> <div class="form-button"><button class="button bg-green" type="submit">下一页</button></div></td>
      </tr>
    </table>

  </div>
</form>
</body>
<script src="../../res/js/jquery.datetimepicker.js"></script>
<script>
  $('.datetimepicker').datetimepicker();
</script>
</html>