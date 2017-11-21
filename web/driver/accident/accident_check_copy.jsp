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
  </script>
</head>
<body>
<form name="add_accident" action="/DZOMS/accident_AddOrUpdate" method="post">
    <div class="container">
        <table class="table table-hover">
            <tr>
                <td class="tableleft" style="white-space: nowrap;">填报时间</td>
                <td><input class="input" type="text" id="addTime" readonly="readonly"></td>
                <td class="tableleft">事故时间</td>
                <td><input class="input" type="text" readonly="readonly" id="time"></td>
                <td class="tableleft">登记人</td>
                <td><input class="input" type="text" readonly="readonly" id="register">
                <input type="hidden" name="accident.register" value="<%=((User)session.getAttribute("user")).getUid()%>"/></td>
            </tr>
            
            <!-- 第二行-->
            <tr>
                <td class="tableleft">车牌号</td>
                <td><input class="input" readonly="readonly" id="licenseNum"/></td>
                <td class="tableleft">车架号</td>
                <td><input class="input" readonly="readonly" name="carId" id="carId"/></td>
                <td class="tableleft">车型</td>
                <td><input class="input" readonly="readonly" id="carType"/></td>
                <td class="tableleft ">分公司归属</td>
                <td><input class="input" readonly="readonly" id="companyBelong"/></td>
            </tr>
            <!-- 第三行-->
            <tr>
                <td class="tableleft" >承租人</td>
                <td><input class="input" type="text" readonly="readonly" id="renter"/></td>
                <td class="tableleft" >驾驶人</td>
                <td><input class="input" type="text" id="driverName" readonly="readonly"></td>
                <td class="tableleft">身份证</td>
                <td><input class="input" id="driverId" readonly="readonly"/></td>
                <td class="tableleft">驾驶人属性</td>
                <td><input class="input" readonly="readonly" id="driverAttr"/></td>
            </tr>
            <!-- 第四行-->
            <tr>
                <td class="tableleft">事故类别</td>
                <td><input class="input" readonly="readonly" id="aClass"/></td>
                <td class="tableleft">事故类型</td>
                <td><input class="input" readonly="readonly" id="aType"/></td>
            </tr>

            <tr id="optional">
                <td>
                    <label class="op_acc" style="display: none">事故性质</label>
                    <input type="text" id="shiguxingzhi" class="op_acc" readonly style="display: none">
                </td>
                <td>
                    <label class="op_acc" style="display: none">事故金额</label>
                    <input type="text" id="shigujine" class="op_acc" style="display: none" readonly>
                </td>
                <td>
                    <label class="op_dead" style="display: none">事故责任</label>
                    <input type="text" id="shiguzeren" class="op_dead" style="display: none">
                </td>
            </tr>

            <!-- 第五行-->

            <tr>
                <td class="tableleft">条款</td>
                <td><input class="input" readonly="readonly" id="clause"/></td>
                <td colspan="2"><input class="input" readonly="readonly" id="clause2"/></td>
            </tr>
            <!-- 第六行-->
            <tr>
                <td class="tableleft">事故处理</td>
                <td><input class="input" id="accDeal" readonly="readonly"/></td>
                <td class="tableleft">保险公司</td>
                <td><input class="input" name="accident.insuCompany" id="insuCompany" readonly="readonly"/></td>
            </tr>

            <!-- 第七行-->

            <tr>
                <td>天气状况</td>
                <td><input class="input" readonly="readonly" id="weather"/></td>
                <td>路面状况</td>
                <td><input class="input" readonly="readonly" id="roadCondition"/></td>
                <td>出险原因</td>
                <td><input class="input" readonly="readonly" id="reason"/></td>
            </tr>
            <tr>
                <td>发生区域</td>
                <td><input class="input" readonly="readonly" id="happenArea"/></td>
                <td>归属区域</td>
                <td><input class="input" readonly="readonly" id="belongArea"/></td>
                <td class="tableleft">事故地点</td>
                <td><input class="input" name="accident.location" id="location" readonly="readonly"/></td>
            </tr>
            <tr>
                <td>事故经过</td>
                <td colspan="6">
                    <textarea rows="5" class="input" placeholder="事故经过" name="accident.accReason" id="accReason" readonly="readonly"></textarea>
                </td>
            </tr>
        </table>
    </div>
</form>
<!--About accident -->
<%--事故保险部分--%>
<input type="checkbox" readonly name="com_thief" id="com_thief"><label>盗抢险</label>
<input type="checkbox" readonly name="com_car" id="com_car"><label>车损险</label>
<input type="checkbox" readonly name="com_people" id="com_people"><label>车上人员险</label>
<input type="checkbox" readonly name="com_other" id="com_other"><label>其他</label>
<input type="checkbox" readonly name="tra_doc" id="tra_doc"><label>医疗险</label>
<input type="checkbox" readonly name="tra_car" id="tra_car"><label>车损险</label>
<input type="checkbox" readonly name="tra_people" id="tra_people"><label>伤残险</label>
<input type="checkbox" readonly name="tra_other" id="tra_other"><label>其他</label><br/>
<label>事故教训</label>
<input type="text" readonly name="accidentinsurance.acc_learn" id="acc_learn"><br/>
<div id="fileHolder">

</div>

<!-- About loss-->
<form method="post" class="form-tips" action="/DZOMS/accident_UpdateLoss">
    <!--甲方损失-->
    <div class="margin-small border border-gray radius-big">

        <div class="label"><label>甲方损失：</label></div>
        <%--<div class="form-group float-left">--%>
            <%--<div class="float-left">车牌号：</div>--%>
            <%--&lt;%&ndash;<div class="float-left margin-small">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<input class="input input-auto"  type="text" size="20" id="licenseNum" readonly="readonly">&ndash;%&gt;--%>
            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
        <%--</div>--%>

        <div class="form-group float-left">
            <div class="float-left">车损失：</div>
            <div class="float-left margin-small">
                <input readonly="readonly" class="input input-auto" size="20" id="carLoss" name="loss.carLoss" onblur="addLoss()">
            </div>
        </div>
        <div class="form-group">
            <div class="float-left">车赔付：</div>
            <div class="margin-small">
                <input readonly="readonly" class="input input-auto" size="20" id="carPaid" name="loss.carPaid" onblur="addLoss()" >
            </div>
        </div>

        <div class="form-group">
            <div class="float-left">伤亡人数：</div>
            <div class="margin-small float-left">
                <div class="panel float-left" style="width: 700px;height: 150px;overflow:auto; ">
                    <table class="table table-bordered" id="table1">
                        <tr>
                            <th>伤亡</th>
                            <th>伤亡人姓名</th>
                            <th>伤亡人损失</th>
                        </tr>
                    </table>

                </div>
            </div>
            <div class="margin-small" style="height: 30px">
                <input class="dialogs button margin-small" data-toggle="click" data-target="#swrs1" data-mask="1"  data-width="40%"type="button" value="添加">
            </div>
            <div class="margin-small" style="height: 120px">
                <input type="button" class="button margin-small" onclick="delete1()" value="删除">
            </div>
        </div>
    </div>

    <!--乙方损失-->
    <div class="margin-small border border-gray radius-big">

        <div class="label"><label>乙方损失：</label></div>
        <div class="float-left">车辆损失：</div>
        <div class="panel float-left" style="width: 950px;height: 150px;overflow:auto; ">
            <table class="table table-bordered" id="table2">
                <tr>
                    <th>车牌号</th>
                    <th>车型</th>
                    <th>损失</th>
                </tr>
            </table>
        </div>

        <div class="margin-small" style="height: 30px">
            <input class="dialogs button margin-small" data-toggle="click" data-target="#clss" data-mask="1" data-width="40%" type="button" value="添加">
        </div>

        <div class="margin-small" style="height: 120px">
            <input type="button" class="button margin-small" onclick="delete2()" value="删除"></div>

        <div class="container">
            <hr class="bg-gray" />
        </div>

        <div class="float-left">伤亡人数：</div>
        <div class="panel float-left" style="width: 950px;height: 150px;overflow:auto; ">
            <table class="table table-bordered" id="table3">
                <tr>
                    <th>伤亡</th>
                    <th>伤亡人姓名</th>
                    <th>伤亡人损失</th>
                </tr>
            </table>

        </div>
        <div class="margin-small" style="height: 30px">
            <input class="dialogs button margin-small" data-toggle="click" data-target="#swrs3" data-mask="1" data-width="40%" type="button" value="添加">
        </div>
        <div class="margin-small" style="height: 120px"> <input type="button" class="button margin-small" value="删除"></div>

        <div class="margin-small float-left">财产损失：</div>
        <div class="margin-small">
            <input readonly="readonly" class="input input-auto" size="40" name="loss.peopleLoss" id="peopleLoss" onblur="addLoss();">
        </div>

    </div>
    <div class="form-group">
        <div class="margin-small">
            <div class="margin-small float-left">总损失：</div>
            <div class="margin-small">
                <input class="input input-auto margin-small" size="40" id="allLoss" readonly="readonly">
            </div>
        </div>
    </div>
</form>

<%--<div id="clss">--%>
    <%--<div class="dialog">--%>
        <%--<div class="dialog-head">--%>
            <%--<span class="close"></span>--%>
            <%--<strong>录入车辆损失信息</strong>--%>
        <%--</div>--%>
        <%--<div class="dialog-body">--%>
            <%--<div>车牌号</div>--%>
            <%--<div><input class="input cph"/></div>--%>
            <%--<div>车型</div>--%>
            <%--<div><input class="input cx"/></div>--%>
            <%--<div>损失</div>--%>
            <%--<div><input class="input ss"/></div>--%>
        <%--</div>--%>
        <%--<div class="dialog-foot">--%>
            <%--<button class="button bg-green" onclick="add2()">添加</button>--%>
            <%--<button class="button dialog-close">取消</button>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<%--<div id="swrs1">--%>
    <%--<div class="dialog">--%>
        <%--<div class="dialog-head">--%>
            <%--<span class="close"></span>--%>
            <%--<strong>录入伤亡人数信息</strong>--%>
        <%--</div>--%>
        <%--<div class="dialog-body">--%>
            <%--<div>伤亡</div>--%>
            <%--<select class="input sw">--%>
                <%--<option value="0">伤</option>--%>
                <%--<option value="1">亡</option>--%>
            <%--</select>--%>
            <%--<div>伤亡人姓名</div>--%>
            <%--<div><input class="input swrxm"/></div>--%>
            <%--<div>伤亡人损失</div>--%>
            <%--<div><input class="input swrss"/></div>--%>
        <%--</div>--%>
        <%--<div class="dialog-foot">--%>
            <%--<button class="button bg-green" onclick="add1()">添加</button>--%>
            <%--<button class="button dialog-close">取消</button>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
<%--<div id="swrs3">--%>
    <%--<div class="dialog">--%>
        <%--<div class="dialog-head">--%>
            <%--<span class="close"></span>--%>
            <%--<strong>录入伤亡人数信息</strong>--%>
        <%--</div>--%>
        <%--<div class="dialog-body">--%>
            <%--<div>伤亡</div>--%>
            <%--<div>--%>
                <%--<select class="input sw">--%>
                    <%--<option value="0">伤</option>--%>
                    <%--<option value="1">亡</option>--%>
                <%--</select>--%>
            <%--</div>--%>
            <%--<div>伤亡人姓名</div>--%>
            <%--<div><input class="input swrxm"/></div>--%>
            <%--<div>伤亡人损失</div>--%>
            <%--<div><input class="input swrss"/></div>--%>
        <%--</div>--%>
        <%--<div class="dialog-foot">--%>
            <%--<button class="button bg-green" onclick="add3()">添加</button>--%>
            <%--<button class="button dialog-close">取消</button>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>


<!--损失结束-->
<form action="/DZOMS/accident_UnChecked" method="post" id="form">
	<input type="hidden" name="accident.accId" id="accId">
    <div class="container">
        <table class="table">
            
            <tr>
                <td class="tableleft">审核人</td>
                <td><input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                <input type="hidden" name="acheck.checker" value="<%=((User)session.getAttribute("user")).getUid()%>"/></td>
                
            </tr>
            <tr>
                <td>审核时间</td>
                <td><input class="datetimepicker input" type="text" name="acheck.acTime"></td>
            </tr>
            <tr>
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
                <td colspan="6"> <div class="form-button"><button class="button bg-green" type="submit">审核</button></div></td>
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