<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.user.User" %>
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
    <title>单车收款</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        //    $(document).ready(function(){
        //      $.post("/DZOMS/charge/getCurrentMonth",{},function(data){
        //        $("#currentMonth").html(data);
        //      });
        //    });

        var chargeId = undefined;
        <s:if test="%{#request.chargePlan!=null}">
        chargeId = ${requestScope.chargePlan.id};
        </s:if>

        $(document).ready(function(){
            if(chargeId!=undefined){
                new MyRequest('/DZOMS/common/getObj')
                    .param("ids[0].className","com.dz.module.charge.ChargePlan")
                    .param("ids[0].id",chargeId)
                    .param("ids[0].isString",false)
                    .param("url","/charge/cash_print.jsp")
                    .param("title","财务收款打印")
                    .submit();

                // $("<form  action='/DZOMS/common/getObj' method='post' target='_blank' style='display: none;' />")
                //     .append($('<input />').attr("name","ids[0].className").val("com.dz.module.charge.ChargePlan"))
                //     .append($('<input />').attr("name","ids[0].id").val(chargeId))
                //     .append($('<input />').attr("name","ids[0].isString").val(false))
                //     .append($('<input />').attr("name","url").val("/charge/cash_print.jsp"))
                //     .append($('<input />').attr("name","title").val("财务收款打印"))
                //     .appendTo($('body'))
                //     .submit();

                // var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.charge.ChargePlan&ids[0].id="+chargeId+"&ids[0].isString=false&url=%2fcharge%2fcash_print.jsp";
                // window.open(url,"财务收款打印");
            }
        });

        function refreshTable(){
            $("#container").html("");
            //append Header
            $("#container").append("<tr> <th>类型</th> <th>金额</th> <th>记录时间</th> <th>记录人</th> </tr>");
            var licenseNum = $("#licenseNum").val();
            var time = $("#time").val();
            if(licenseNum != undefined && licenseNum != "" && time != undefined && time != ""){
                $.post("/DZOMS/charge/getAMonthRecords",{"licenseNum":licenseNum,"time":time},function(dat){
                    dat = $.parseJSON(dat);
                    dat = dat["list"][0]["com.dz.module.charge.ChargePlan"];
                    if(dat.length == undefined){
                        dat = [dat];
                    }
                    var add = 0;
                    for(var i = 0;i < dat.length;++i){
                        tmp = dat[i];
                        var type = tmp["feeType"];
                        var money = tmp["fee"];
                        var inTime = tmp["inTime"]["$"];
                        var register = tmp["register"];
                        add += eval(money);
                        if(type == "add_bank"){
                            type = "哈尔滨银行回款";
                        }else if(type == "add_bank2"){
                            type = "招商银行回款";
                        }else if(type == "add_insurance"){
                            type = "保险回款";
                        }else if(type == "add_cash"){
                            type = "现金";
                        }else if(type == "add_oil"){
                            type = "油补";
                        }else if(type == "add_other"){
                            type = "其他";
                        }//else if(type == "sub_oil"){
//              type = "油补取出";
//            }else if(type == "sub_insurance"){
//              type = "保险取出";
                        //}
                        else{
                            add -= eval(money);
                            continue;
                        }
                        $("#container").append("<tr> " +
                            "<td>"+type+"</td> " +
                            "<td>"+money+"</td> " +
                            "<td>"+inTime+"</td> " +
                            "<td>"+register+"</td> " +
                            "</tr>");
                    }
                    $("#container").append("<tr> " +
                        "<td>合计</td> " +
                        "<td>"+add+"</td> " +
                        "<td>-</td> " +
                        "<td>-</td> " +
                        "</tr>");
                });
            }
        };

        function checkTable(){
            var licenseNum = $("#licenseNum").val();
            var time = $("#time").val();
            if(licenseNum != undefined && licenseNum != "" && time != undefined && time != ""){
                $("#show_licenseNum").val(licenseNum);
                $("#show_time").val(time);
                $("#form1").submit();
            }
        };
        function setOwe(){
            var licenseNum = $("#licenseNum").val();
            var time = $("#time").val();
            if(licenseNum != undefined && licenseNum != "" && time != undefined && time != ""){
                $.post("/DZOMS/charge/getOweByLicenseNumAndMonth",{"licenseNum":licenseNum,"time":time},function(data){
                    data = $.parseJSON(data);
                    $("#owe").val((data["ItemTool"]["thisMonthOwe"]));
                });
            }
        }
        function showAll(){
            refreshTable();
            checkTable();
            setOwe();
        }
        function setDept(){
            var licenseNum = $("#licenseNum").val();
            if(licenseNum != undefined && licenseNum != ""){
                $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{'vehicle.licenseNum':licenseNum},function (data){
                    data = $.parseJSON(data);
                    data = data["ItemTool"]["carframeNum"];
                    $.post("/DZOMS/selectContractByCarId",{'contract.carframeNum':data},function(dat){
                        $("#dept").val(dat["branchFirm"]);
                    });
                });
            }

            if ($("#time").val().length!=0) {
                showAll();
            }
        }
        $(document).ready(function (){
            showAll();
            setDept();
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
            width: 90px;
            text-align: right;
        }
        .field{
            width: 150px;
        }
    </style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>财务管理</li>
        <li>单车收款</li>
    </ul>
</div>
<div class="line padding">
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <form method="post" id="form" action="/DZOMS/charge/addChargePlanByLicenseNum" class="form-inline form-tips" style="width: 100%;">
        <div class="panel margin-small" >
            <div class="panel-head">
                查询条件
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield value="%{licenseNum}" cssClass="input"   name="licenseNum" placeholder="车牌号" id="licenseNum" onblur="setDept();" onfocus="carFocus()"/>
                    </div>
                </div>


                <div class="form-group">
                    <div class="label padding">
                        <label>
                            年月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield value="%{chargePlan.getTime()}" cssClass="input datetimepicker"  name="chargePlan.time"  id="time" onblur="showAll();" onchange="showAll();"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门：
                        </label>
                    </div>
                    <div class="field">
                        <input id="dept" readonly="readonly" class="input"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            欠款：
                        </label>
                    </div>
                    <div class="field">
                        <input id="owe" readonly="readonly" class="input"/>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            收入类型：
                        </label>
                    </div>
                    <div class="field">
                        <select size="1" name="chargePlan.feeType" class="input">
                            <option value="add_cash">现金转入</option>
                            <option value="add_insurance">保险转入</option>
                            <option value="add_oil">油补转入</option>
                            <option value="add_bank">哈尔滨银行转入</option>
                            <option value="add_bank2">招商银行转入</option>
                            <option value="add_other">其他转入</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            转入金额：
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input " name="chargePlan.fee" placeholder="单位（元）"/>

                    </div>
                </div>
                <br>
                <div class="form-group">
                    <div style="text-align: right;width: 100px;" class="float-left">
                        <strong>备注：</strong>
                    </div>
                    <div class="field" style="width: 400px">

                        <textarea  class="input" rows="3" name="chargePlan.comment" style="width: 400px"></textarea>
                    </div>
                </div>
                <br>
                <div class="xm6-move">
                    <input type="submit" value="提交" class="button bg-green"/>
                </div>


            </div>
        </div>

        <input type="hidden" name="chargePlan.register" value="<%=((User)session.getAttribute("user")).getUname()%>"/>
        <input type="hidden" value="charge_add" name="visitType"/>
    </form>


</div>


<%Object message = request.getAttribute("message");%>
<%if(message != null){%>
<blockquote class="border-main">
    <strong>上次操作结果：</strong>
    <div><%=message.toString()%></div></blockquote>
<%}%>


<div class="line padding">
    <div class="panel">
        <div class="panel-head">查看</div>
        <div class="panel-body">
            <div class="tab">
                <div class="tab-head">
                    <ul class="tab-nav">
                        <li class="active"><a href="#tab-start2">台账</a> </li>
                        <li><a href="#tab-css2">本月收费记录</a> </li>
                    </ul>
                </div>
                <div class="tab-body tab-body-bordered">
                    <div class="tab-panel active" id="tab-start2">

                        <iframe name="records_show" id="records_show" width="100%"></iframe>

                    </div>

                    <div class="tab-panel" id="tab-css2">
                        <form id="form1" action="/DZOMS/charge/getACarAndAMonthCheckTable" method="post" target="records_show">
                            <input type="hidden" name="licenseNum" id="show_licenseNum">
                            <input type="hidden" name="time" id="show_time" >
                        </form>

                        <table id="container" class="table table-bordered table-striped table-hover">
                        </table>


                    </div>

                </div>
            </div>
        </div>
    </div>

</div>



</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>
</html>