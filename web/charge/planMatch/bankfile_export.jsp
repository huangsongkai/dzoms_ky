<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.BankRecord" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.dz.module.contract.BankCard" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.dz.module.contract.BankCardOfVehicle" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="com.dz.module.driver.Driver" %>
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
            $("#limitMap").val(JSON.stringify(limitMap));
            $("#form").attr("action","/DZOMS/charge/exportBankFile2");
        }

        function check() {
            var time = $("#time").val();
            if(time == undefined || time == ""){
                alert("请指定扣款月份！");
                return false;
            }
            $("#limitMap").val(JSON.stringify(limitMap));
            // var limit = $('#upperLimit').val();
            // if (limit=='' || parseInt(limit)==0){
            //     alert("请指定扣款档位！");
            //     return false;
            // }
            return confirm('您选择的是对'+time+"进行扣款，请确认？");
        }

        function exportFile(){
            if (!check()) return false;
            $("#input_cardClass").val('哈尔滨银行');
            $("#form").attr("action","/DZOMS/charge/exportTxtNew");
        }

        function exportFile2(){
            if (!check()) return false;
            $("#input_cardClass").val('招商银行');
            if (confirm('注意，这是导出招商银行计划为txt,确认并继续？')){
                $("#form").attr("action","/DZOMS/charge/exportTxtNew");
            }else {
                return false;
            }
        }

        function doDiscount() {
            if (!check()) return false;
            $("#form").attr("action","/DZOMS/charge/requireDiscount2");
            $("#form").submit();
        }

        function chooseAll() {
            $('input[name="income_choose"]').prop('checked',true);
        }

        function deChooseAll() {
            $('input[name="income_choose"]').prop('checked',false);
        }

        function reverseChoose() {
            $('input[name="income_choose"]').each(function () {
                $(this).prop('checked',!$(this).prop('checked'));
            });
        }

        var limitMap = ${(limitMap==null || limitMap.length()<=2)?"{}":limitMap};
        function setLimit() {
            var limit = $('#upperLimit').val();
            if (limit=='' || parseInt(limit)<=0){
                alert("请指定扣款档位！");
                return false;
            }
            limit = parseFloat(limit);
            if ($('input[name="income_choose"]:checked').length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            $('input[name="income_choose"]:checked').each(function () {
                var rawValue = parseFloat($('#limit-'+this.value).attr('data-raw-value'));
                if (rawValue>limit){
                    limitMap[this.value]=limit;
                    $('#limit-'+this.value).text(limit);
                }else {
                    delete limitMap[this.value];
                    $('#limit-'+this.value).text(rawValue);
                }
            });
            $('#limit_count').text(Object.keys(limitMap).length);
        }
        function setLimit0() {
            var limit = 0;
            if ($('input[name="income_choose"]:checked').length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            $('input[name="income_choose"]:checked').each(function () {
                limitMap[this.value]=limit;
                $('#limit-'+this.value).text(limit);
            });
            $('#limit_count').text(Object.keys(limitMap).length);
        }

        function setLimit2(contractId) {
            var rawValue = parseFloat($('#limit-'+contractId).attr('data-raw-value'));
            var limit = prompt("请输入收款金额（允许＞"+rawValue+"）");
            limit = parseFloat(limit);
            if (limit>=0 && limit!=rawValue){
                limitMap[contractId]=limit;
                $('#limit-'+contractId).text(limit);
                $('#limit_count').text(Object.keys(limitMap).length);
            }
        }

        function removeLimit() {
            if ($('input[name="income_choose"]:checked').length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            $('input[name="income_choose"]:checked').each(function () {
                delete limitMap[this.value];
                $('#limit-'+this.value).text($('#limit-'+this.value).attr('data-raw-value'));
            });
            $('#limit_count').text(Object.keys(limitMap).length);
        }
        function removeAllLimit() {
            if (confirm('确认清除所有的限额设置？')){
                for(var key in limitMap){
                    delete limitMap[key];
                    $('#limit-'+key).text($('#limit-'+key).attr('data-raw-value'));
                }
                $('#limit_count').text(Object.keys(limitMap).length);
            }
        }

        function initLimit(){
            for (var key in limitMap){
                // var rawValue = parseFloat($('#limit-'+key).attr('data-raw-value'));
                var limit = limitMap[key];
                // if (rawValue>limit){
                //     limitMap[key]=limit;
                    $('#limit-'+key).text(limit);
                // }else {
                //     $('#limit-'+key).text(rawValue);
                // }
            }
            $('#limit_count').text(Object.keys(limitMap).length);
        }
    </script>
    <script>
        $(document).ready(function(){
            // $.post("/DZOMS/charge/getCurrentTime",{"department":"一部"},function(data){
            //     data = $.parseJSON(data);
            //     $("#currentMonth1").html("<strong>"+"一部:"+"</strong>"+data["ItemTool"]);
            // });
            // $.post("/DZOMS/charge/getCurrentTime",{"department":"二部"},function(data){
            //     data = $.parseJSON(data);
            //     $("#currentMonth2").html("<strong>"+"二部:"+"</strong>"+data["ItemTool"]);
            // });
            // $.post("/DZOMS/charge/getCurrentTime",{"department":"三部"},function(data){
            //     data = $.parseJSON(data);
            //     $("#currentMonth3").html("<strong>"+"三部:"+"</strong>"+data["ItemTool"]);
            // });

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

            $('input[type=radio][name="upperType"]').change(function () {
                var  upperType = $('input[type=radio][name="upperType"]:checked').val();
                switch (upperType) {
                    case 'unlimited':
                        $('#upperLimit').val(-1);
                        $('#upperLimit').prop('readonly',true);
                        break;
                    case 'limit_500':
                        $('#upperLimit').val(500);
                        $('#upperLimit').prop('readonly',true);
                        break;
                    case 'limit_1000':
                        $('#upperLimit').val(1000);
                        $('#upperLimit').prop('readonly',true);
                        break;
                    case 'limit_2000':
                        $('#upperLimit').val(2000);
                        $('#upperLimit').prop('readonly',true);
                        break;
                    case 'limit_auto':
                        $('#upperLimit').prop('readonly',false);
                        break;
                }
            });
            $('[name="upperType"]').change();

            initLimit();
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
<div class="line">
    <form method="post" id="form" action="/DZOMS/charge/exportBankFile2" class="form-inline form-tips" style="width: 100%;">
        <%--<input id="input_cardClass" type="hidden" name="cardClass" value="招商银行">--%>
        <input id="limitMap" type="hidden" name="limitMap">
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
                        <s:select id="input_cardClass" name="cardClass" list="#{'':'全部','哈尔滨银行':'哈尔滨银行','招商银行':'招商银行'}" value="%{#parameters.cardClass}"></s:select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            请输入计划年月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input datetimepicker" name="time" placeholder="年月即可" id="time" value="%{time}"/>
                    </div>
                </div>

                <input type="submit" value="查询" class="button bg-green" onclick="getResult()"/>
                <input type="submit" value="导出" class="button bg-green card_hrb" onclick="exportFile();"/>
                <input type="submit" value="导出招行" class="button bg-green card_zs" onclick="exportFile2();"/>
                <input type="button" value="自动扣款" style="display: none" class="button bg-green card_zs" onclick="doDiscount();"/>
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
        <input type="button" value="全选" onclick="chooseAll()">
        <input type="button" value="全不选" onclick="deChooseAll()">
        <input type="button" value="反选" onclick="reverseChoose()">
        <div class="form-group">
            <div class="label padding">
                <label>扣款档位</label>
            </div>
            <div class="field">
                <div class="button-group radio">
                    <label class="button active">
                        <input name="upperType" value="unlimited" checked="checked" type="radio"><span class="icon icon-male"></span> 无上限
                    </label>
                    <label class="button">
                        <input name="upperType" value="limit_500" type="radio"><span class="icon icon-female"></span> 500
                    </label>
                    <label class="button">
                        <input name="upperType" value="limit_1000" type="radio"><span class="icon icon-child"></span> 1000
                    </label>
                    <label class="button">
                        <input name="upperType" value="limit_2000" type="radio"><span class="icon icon-child"></span> 2000
                    </label>
                    <label class="button">
                        <input name="upperType" value="limit_auto" type="radio"><span class="icon icon-child"></span> 自定义
                    </label>

                    <s:textfield cssClass="input-auto" name="upperLimit"  placeholder="扣款档位" id="upperLimit"/>
                    <input type="button" value="设置扣款限额" onclick="setLimit()">
                    <input type="button" value="设置扣款限额为0" onclick="setLimit0()">
                    <input type="button" value="移除所选项扣款限额" onclick="removeLimit()">
                </div>
                <div>
                    当前已设置<span id="limit_count">0</span>条限额。
                    <input type="button" value="移除所有扣款限额" onclick="removeAllLimit()">
                </div>
            </div>
        </div>
    </div>
    <div class="panel-body" style="overflow:auto;height: 800px;">
        <table class="table table-bordered">
            <tr>
                <th>序号</th>
                <th>车牌号</th>
                <th>司机</th>
                <th>银行帐号</th>
                <th>当月计划总额</th>
                <th>已缴纳金额</th>
                <th>剩余应收款</th>
                <th>本次收款</th>
                <th>选择</th>
            </tr>
            <%BigDecimal bd = new BigDecimal(0.00);%>
            <%BigDecimal bd1 = new BigDecimal(0.00);%>
            <%BigDecimal bd2 = new BigDecimal(0.00);%>
            <%int index=1;%>
            <%for(BankRecord record:records){
                if(record.getMoney().intValue() == 0)
                    continue;
                Contract contract = ObjectAccess.getObject(Contract.class,record.getContractId());
                Driver driver = ObjectAccess.getObject(Driver.class,contract.getIdNum());
            %>
            <%bd = bd.add(BigDecimal.valueOf(record.getDerserve()));%>
            <%bd1 = bd1.add(BigDecimal.valueOf(record.getLeft()));%>
            <%bd2 = bd2.add(record.getMoney());%>
            <tr>
                <td><%=index++%></td>
                <td><%=record.getLicenseNum()%></td>
                <td><%=driver.getName()%></td>
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
                <td><%=-record.getDerserve()%></td>
                <td><%=record.getLeft()%></td>
                <td><%=String.format("%.2f",-record.getDerserve()-record.getLeft())%></td>
                <td id="limit-<%=record.getContractId()%>" data-raw-value="<%=String.format("%.2f",-record.getDerserve()-record.getLeft())%>"><%=record.getMoney()%></td>
                <td>
                    <input type="checkbox" name="income_choose" value="<%=record.getContractId()%>">
                    <input type="button" value="设置收款金额" onclick="setLimit2(<%=record.getContractId()%>)">
                </td>
            </tr>
            <%}%>
            <tr>
                <th>合计</th>
                <th> - </th>
                <th> - </th>
                <th> - </th>
                <th><%=bd.negate()%></th>
                <th><%=bd1%></th>
                <th><%=bd.negate().subtract(bd1)%></th>
                <th> - </th>
                <th> - </th>
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