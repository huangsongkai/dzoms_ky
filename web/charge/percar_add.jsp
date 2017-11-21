<%@ page import="com.dz.module.user.User" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-15
  Time: 下午8:12
  To change this template use File | Settings | File Templates.
--%>
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
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
    <script>
        function showAll(){
            var licenseNum = $("#licenseNum").val();
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            if(licenseNum != undefined && licenseNum !="" && licenseNum.length==7 && startTime != undefined && startTime != "" && endTime!=undefined ){
                $(".licenseNum").val(licenseNum);
                $(".startTime").val(startTime);
                $(".endTime").val(endTime);
                if ($('input[name="isToEnd"]').is(":checked")) {
                    $('input[name="useContractEnd"]').val("true");
                } else{
                    $('input[name="useContractEnd"]').val("false");
                }
                $("#form1").submit();
            }
        }

        function postNext(){
            $("#form2").submit();
        }

        $(document).ready(function(){
            showAll();
        });
    </script>
    <script>
        function showdept(){
            var licenseNum = $("#licenseNum").val();
            $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{"vehicle.licenseNum":licenseNum},function(data){
                var da = $.parseJSON(data);
                var list = da["ItemTool"];
                $("#dept").val(list["dept"]);
            });
        }
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
            $("#licenseNum").bigAutocomplete({
                url:"/DZOMS/select/VehicleBylicenseNum",
                callback:function(){
                    showAll();
                    showdept();
                }
            });
        });
        function btnClk(){
            var type = $('select[name="batchPlan.feeType"]').val();
            var fee = $('input[name="batchPlan.fee"]').val();
            if(fee < 0){
                $('input[name="batchPlan.fee"]').val(-fee);
                if(type == "plan_add_insurance"){
                    $('select[name="batchPlan.feeType"]').val("plan_sub_insurance");
                }
                if(type == "plan_add_contract"){
                    $('select[name="batchPlan.feeType"]').val("plan_sub_contract");
                }
                if(type == "plan_add_other"){
                    $('select[name="batchPlan.feeType"]').val("plan_sub_other");
                }
            }
            $('#formx')[0].submit();
        }
        function carFocus(){
            $("#licenseNum").val("黑A");
        }
    </script>

</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>财务管理</li>
        <li>单车变更</li>
    </ul>
</div>
<div class="line padding">
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <form method="post" id="form" action="/DZOMS/charge/addBatchPlanPerCar" class="form-inline form-tips" style="width: 100%;">
        <div class="panel  margin-small" >
            <div class="panel-head">

            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"  name="licenseNum" placeholder="车牌号" id="licenseNum" value="%{licenseNum == null ?'黑A':licenseNum}" onblur="showdept()" onfocus="carFocus()" onchange="showAll()"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            开始日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input datetimepicker"  name="batchPlan.startTime" id="startTime" value="%{batchPlan.getStartTime()}"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            结束日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input datetimepicker"  name="batchPlan.endTime" onblur="showAll();" id="endTime" value="%{batchPlan.getEndTime()}"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            使用合同结束日期
                        </label>
                    </div>
                    <div class="field">
                        <input type="checkbox" name="isToEnd" onchange="showAll()">
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定类型
                        </label>
                    </div>
                    <div class="field">
                        <select size="1" name="batchPlan.feeType">
                            <option value="plan_add_insurance">保险费用</option>
                            <option value="plan_sub_insurance" style="display:none">保险费用下降</option>
                            <option value="plan_add_contract">合同费用</option>
                            <option value="plan_sub_contract" style="display:none">合同费用下降</option>
                            <option value="plan_add_other">其他费用</option>
                            <option value="plan_sub_other" style="display:none">其他费用下降</option>
                        </select>
                    </div>
                </div>
                <div>
                    <label>部门</label>
                    <input type="text" id="dept" readonly>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            费&nbsp;&nbsp;&nbsp;&nbsp;用
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input" name="batchPlan.fee" placeholder="单位（元）"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input input-auto" size="40" name="batchPlan.comment"/>
                    </div>
                </div>
                <input type="hidden" name="batchPlan.register" value="<%=((User)session.getAttribute("user")).getUname()%>"/>
                <input type="submit" value="提交" class="button bg-green" onclick="btnClk()"/>
            </div>
        </div>
    </form>
</div>
<%Object message = request.getAttribute("message");%>
<%if(message != null){%>
<div class="alert alert-green margin-small">
    <span class="close rotate-hover"></span><strong>操作结果：</strong><%=message.toString()%></div>
<%}%>
<div class="line">
    <div class="panel  margin-small" >
        <div class="panel-head">
            台账
        </div>
        <div class="panel-body">
            <iframe id="checkshow" name="checkshow" width="100%" onload="postNext()"></iframe>
            <form id="form1" action="/DZOMS/charge/singleCarAndMuiltyMonthCheckShow" target="checkshow" method="post">
                <input type="hidden" name="licenseNum" class="licenseNum">
                <input type="hidden" name="timePass.startTime" class="startTime">
                <input type="hidden" name="timePass.endTime" class="endTime">
                <input type="hidden" name="useContractEnd" />
            </form>
        </div>
    </div>

</div>
<div class="line">
    <div class="panel  margin-small" >
        <div class="panel-head ">
            明细
        </div>
        <div class="panel-body">
            <iframe id="detailshow" name="detailshow" width="100%"></iframe>
            <form id="form2" action="/DZOMS/charge/singleCarAndMuiltyMonthDetailShow" target="detailshow" method="post">
                <input type="hidden" name="licenseNum" class="licenseNum">
                <input type="hidden" name="timePass.startTime" class="startTime">
                <input type="hidden" name="timePass.endTime" class="endTime">
            </form>
        </div>
    </div>

</div>



</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker({
        lang:"ch",           //语言选择中文
        format:"Y/m/d",      //格式化日期
        timepicker:false,    //关闭时间选项
        yearStart:2000,     //设置最小年份
    });
</script>


</html>
