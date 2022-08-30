<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.BankRecord" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.dz.module.contract.BankCard" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.dz.module.contract.BankCardOfVehicle" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
        //        $(document).ready(function(){
        //            $.post("/DZOMS/charge/getCurrentMonth",{},function(data){
        //                $("#currentMonth").html(data);
        //            });
        //        });
        function getResult(){
            $("#form").attr("action","/DZOMS/charge/exportBankFile");
        }
        function exportFile(){
            var time = $("#time").val();
            if(time == undefined || time == ""){
                alert("请输入时间！");
                return false;
            }
            $("#form").attr("action","/DZOMS/charge/exportTxt");
        }

        function exportFile2(){
            var time = $("#time").val();
            if(time == undefined || time == ""){
                alert("请输入时间！");
                return false;
            }
            if (confirm('注意，这是导出招商银行计划为txt,确认并继续？')){
                $("#form").attr("action","/DZOMS/charge/exportTxt2");
            }else {
                return false;
            }
        }

        function exportFile3(){
            var time = $("#time").val();
            if(time == undefined || time == ""){
                alert("请输入时间！");
                return false;
            }
            if (confirm('注意，这是导出全部的银行计划为txt,确认并继续？')){
                $("#form").attr("action","/DZOMS/charge/exportTxt3");
            }else {
                return false;
            }
        }

        function doDiscount() {
            var time = $("#time").val();
            if(time == undefined || time == ""){
                alert("请输入时间！");
                return false;
            }
            $("#form").attr("action","/DZOMS/charge/requireDiscount");
            $("#form").submit();
        }
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

            $('[name="cardClass"]').change(function () {
                var cardClass = $('[name="cardClass"]').val();
                if(cardClass=='哈尔滨银行'){
//                $('option').hide();
                    $('.card_hrb').prop('selected',true);
                    $('.card_zs').hide();
                    $('.card_hrb').show();
                }else if(cardClass=='招商银行'){
//                $('option').hide();
                    $('.card_zs').prop('selected',true);
                    $('.card_hrb').hide();
                    $('.card_zs').show();

                }else{
                    $('option').show();
                }
            });
            $('[name="cardClass"]').change();

        });
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>银行计划</li>
        </ul>
    </div>
</div>
<div class="line margin-small">
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <form method="post" id="form" action="/DZOMS/charge/exportBankFile" class="form-inline form-tips" style="width: 100%;">
        <div class="panel  margin-small" >
            <div class="panel-head">
                查询条件
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门
                        </label>
                    </div>
                    <div class="field">
                        <s:select name="department" list="#{'全部':'全部','一部':'一部','二部':'二部','三部':'三部'}" value="%{department}"></s:select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            类别
                        </label>
                    </div>
                    <div class="field">
                        <s:select name="cardClass" list="#{'':'全部','哈尔滨银行':'哈尔滨银行','招商银行':'招商银行'}" value="%{#parameters.cardClass}"></s:select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            请输入年月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input datetimepicker" name="time" placeholder="年月即可" id="time" value="%{time}"/>
                    </div>
                </div>

                <input type="submit" value="查询" class="button bg-green" onclick="getResult()"/>
                <input type="submit" value="导出" class="button bg-green card_hrb" onclick="exportFile();"/>
                <input type="submit" value="导出招行" class="button bg-green card_hrb" onclick="exportFile2();"/>
                <input type="submit" value="导出全部" class="button bg-green card_hrb" onclick="exportFile3();"/>
                <input type="button" value="扣款" style="display: none" class="button bg-green card_zs" onclick="doDiscount();"/>
            </div>
        </div>
    </form>
</div>


<%List<BankRecord> records = (List<BankRecord>)request.getAttribute("bankRecords");
    int space=0;%>
<%if(records != null){%>
<div class="panel">
    <div class="panel-head">
        <strong>查询结果</strong><span style="color:red" id="tip">(有<%=space%>条无银行卡！)</span>
    </div>
    <div class="panel-body" style="overflow:auto;height: 800px;">
        <table class="table table-bordered">
            <tr>
                <th>序号</th>
                <th>车牌号</th>
                <th>司机</th>
                <th>银行帐号</th>
                <th>应收款</th>
            </tr>
            <%BigDecimal bd = new BigDecimal(0.00);%>
            <%int index=1;%>
            <%for(BankRecord record:records){
                if(record.getMoney().intValue() == 0)
                    continue;
            %>
            <%bd = bd.add(record.getMoney());%>
            <tr>
                <td><%=index++%></td>
                <td><%=record.getLicenseNum()%></td>
                <td><%=record.getDriverName()%></td>
                <%List<BankCardOfVehicle> bcs = record.getBankCards();%>
                <td>
                    <select>
                        <%if(bcs!=null&&bcs.size()>0){
                            for (BankCardOfVehicle bv : bcs){%>
                        <option class="<%=bv.getBankCard().getCardClass().equals("哈尔滨银行")?"card_hrb":"card_zs"%>"
                                value="<%=bv.getBankCard().getCardNumber()%>">
                            <%=bv.getBankCard().getCardClass()%>:<%=bv.getBankCard().getCardNumber()%>
                        </option>
                        <%}%>
                        <%}else {
                            space ++ ;
                        }%>
                    </select>
                </td>
                <td><%=record.getMoney()%></td>
            </tr>
            <%}%>
            <tr>
                <th>合计</th>
                <th> - </th>
                <th> - </th>
                <th> - </th>
                <th><%=bd%></th>
            </tr>
        </table>

    </div>
    <!-- <div class="line">
         <div class="xm4 xm4-move">
             <a href="javascript:void beforePage();" class="button">上一页</a>
             <input type="text" id="ps" onblur="toPage();" class="input input-auto" size="3">
             <a href="javascript:void nextPage();" class="button">下一页</a>
         </div>

     </div>-->
</div>
<%}%>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $(document).ready(function(){
        $("#tip").text("(有<%=space%>条无银行卡！)");
    });
</script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>

</html>