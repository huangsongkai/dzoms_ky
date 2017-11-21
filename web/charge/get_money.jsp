<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.user.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>测试</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        //上限设置
        var oilCouldGet = 0;
        var insuranceCouldGet = 0;
        var accountCouldGet = 0;
        function checkMonry(){
            var money = $("#money").val();
            var type = $("#type").val();
            money = eval(money);
            var oil = eval(oilCouldGet);
            var insurance = eval(insuranceCouldGet);
            var account = eval(accountCouldGet);
            insurance = Math.min(insurance,account);
            oil = Math.min(oil,account);
            if(money > 0){
//              if(type == "sub_insurance" && money <= insurance) return true;
//              if(type == "sub_oil" && money <= oil) return true;
                if(money <= account) return true;
            }
            alert("金额错误");
            return false;
        }
        function showMoney(){
            var licenseNum = $("#licenseNum").val();
            var time = $("#time").val();
            if(licenseNum != undefined && licenseNum != "" && time != undefined && time != ""){
                $.post("/DZOMS/charge/couldGetMoney",{'licenseNum':licenseNum,"time":time},function(data){
                    data = $.parseJSON(data);
                    data = data["list"][0]["big-decimal"];
                    $("#showAviliable").html("<blockquote class='border-main'>"+" <strong>"+"油补进账："+data[0]+"元\n"+"保险进账："+data[1]+"元\n"+"余额："+data[2]+"元"+"</strong>"+ "</blockquote>"
                    );
                    oilCouldGet = data[0];
                    insuranceCouldGet = data[1];
                    accountCouldGet = data[2];
                });
            }
        };
        function show_records(){
            var licenseNum = $("#licenseNum").val();
            var time = $("#time").val();
            if(licenseNum != undefined && licenseNum != "" && time != undefined && time != ""){
                $("#show_licenseNum").val(licenseNum);
                $("#show_time").val(time);
                $("#form1").submit();
            }
        }
        function showAll(){
            var licenseNum = $("#licenseNum").val();
            if(licenseNum != undefined && licenseNum != ""){
                $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{'vehicle.licenseNum':licenseNum},function (data){
                    data = $.parseJSON(data);
                    data = data["ItemTool"]["carframeNum"];
                    $.post("/DZOMS/selectContractByCarId",{'contract.carframeNum':data},function(dat){
                        var dept = (dat["branchFirm"]);
                        $.post("/DZOMS/charge/getCurrentTime",{"department":dept},function(data2){
                            data2 = $.parseJSON(data2);
                            $("input[name='chargePlan.time']").val(data2["ItemTool"]);
                        });
                    });
                });
            }
            showMoney();
            show_records();
        }
    </script>
    <script>
        $(document).ready(function(){
//      $.post("/DZOMS/charge/getCurrentMonth",{},function(data){
//        $("#currentMonth").html(data);
//      });
            showAll();
        });
    </script>
    <script>
        $(document).ready(function(){
            $.post("/DZOMS/charge/getCurrentTime",{"department":"一部"},function(data){
                data = $.parseJSON(data);
                $("#currentMonth1").html("<strong>"+"一部:"+"</strong>"+data["ItemTool"]);
            });
            $.post("/DZOMS/charge/getCurrentTime",{"department":"二部"},function(data){
                data = $.parseJSON(data);
                $("#currentMonth2").html("<strong>"+"二部:"+"</strong>"+data["ItemTool"]);
            });
            $.post("/DZOMS/charge/getCurrentTime",{"department":"三部"},function(data){
                data = $.parseJSON(data);
                $("#currentMonth3").html("<strong>"+"三部:"+"</strong>"+data["ItemTool"]);
            });
        });
        function carFocus(){
            $("#licenseNum").val("黑A");
        }
    </script>
    <style>
        .label{
            width: 120px;
            text-align: right;
        }
        .field{
            width: 200px;
        }
    </style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>财务管理</li>
        <li>取款</li>
    </ul>
</div>
<div class="line padding">
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <form method="post" id="form" action="/DZOMS/charge/addChargePlanByLicenseNum" onsubmit="return checkMonry();" class="form-tips form-inline" style="width: 100%">
        <div class="panel margin-small" >
            <div class="panel-head">
                取款
            </div>
            <div class="panel-body">

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"   value="%{licenseNum}" name="licenseNum" placeholder="车牌号" id="licenseNum" onfocus="carFocus()"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            年月
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input  datepick"  value="%{chargePlan.getTime()}"  id="time" onblur="showAll();"/>
                        <input type="hidden" name="chargePlan.time">
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            提现类型
                        </label>
                    </div>
                    <div class="field">

                        <select class="input" name="chargePlan.feeType" id="type">
                            <!-- <option value="sub_insurance">保险赔款转出</option> -->
                            <!-- <option value="sub_oil">油补转出</option> -->
                            <option value="sub_insurance">保险赔款转出</option>
                            <!--<option value="sub_other">油补转出</option>-->
                            <option value="sub_oil">油补转出</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            提现金额
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input " name="chargePlan.fee" placeholder="单位（元）" id="money"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label for="readme">
                            备注
                        </label>
                    </div>
                    <div class="field" style="width: 400px">
                        <input  class="input input-auto float-left" size="40" type="text"  name="chargePlan.comment"/>
                        <input type="submit" value="提交" class="button  bg-green margin-big-left"/>
                    </div>
                </div>
                <input type="hidden" value="get_money" name="visitType"/>
                <input type="hidden" name="chargePlan.register" value="<%=((User)session.getAttribute("user")).getUname()%>"/>



            </div>
        </div>
    </form>
</div>
<div class="line">

    <form id="form1" action="/DZOMS/charge/getAMonthGetMoney" method="post" target="records_show">
        <input type="hidden" name="licenseNum" id="show_licenseNum">
        <input type="hidden" name="time" id="show_time">
    </form>
    <div id="showAviliable">

    </div>

    <%Object message = request.getAttribute("message");%>
    <%if(message != null){%>
    <blockquote class="border-main">
        <strong>上次操作结果：</strong>
        <div><%=message.toString()%></div></blockquote>
    <%}%>




</div>
<div class="line">
    <div class="panel margin-small" >
        <div class="panel-head">
            本月提款记录
        </div>
        <div class="panel-body">
            <iframe name="records_show" id="records_show" width="100%"></iframe>
        </div>
    </div>

</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>

</html>