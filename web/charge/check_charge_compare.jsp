<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.dz.module.charge.ChargePlanCompareCheck" %>
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
    <title>租金计划比对</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <style>
        #rawTh td.alert-danger{
            background-color: #ea2f10;
        }
    </style>
    <script>
        function show(){
            $("#form").attr("action","/DZOMS/charge/getChargePlanCompareCheck");
            $("#form").submit();
        }
        function exp(){
            alert("正在制作中……");
            return;
            $("#form").attr("action","/DZOMS/charge/getCheckChargeTableToExcel");
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
        });

        $(document).ready(function(){
            $("#rawTh tr:eq(0) td").each(function(index){
                $("#newTh th").eq(index).width($(this).width());
            });
        });
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>租金计划比对</li>
        </ul>
    </div>
</div>
<div class="line padding">
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <form method="post" id="form" action="/DZOMS/charge/getCheckChargeTable" class="form-inline form-tips" style="width: 100%;">
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
                            请输入年月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input input-auto datetimepicker" size="20"  name="time" placeholder="年月即可" id="time">
                            <s:param name="value">
                                <s:date name="%{time}" format="yyyy/MM"></s:date>
                            </s:param>
                        </s:textfield>
                    </div>
                </div>
                <%--<div class="form-group">--%>
                    <%--<div class="label padding">--%>
                        <%--<label>--%>
                            <%--类型--%>
                        <%--</label>--%>
                    <%--</div>--%>
                    <%--<div class="field">--%>
                        <%--<s:select cssClass="input input-auto"  name="status" id="status" list="#{0:'欠费',1:'正常',2:'银行未交',3:'银行已交',4:'全部'}">--%>
                        <%--</s:select>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <input type="hidden" value="4" name="status">

                <input type="button" value="查询" class="button bg-green" onclick="show()"/>
                <input type="button" value="导出" class="button bg-green" onclick="exp()"/>
            </div>
        </div>
    </form>

</div>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>查询结果</strong>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr id="newTh">
                        <th>序号</th>
                        <th>部门</th>
                        <th>车牌号</th>
                        <th>本月计划金额</th>

                        <th>对比月计划金额</th>
                        <th>差额1</th>

                        <th>合同计划金额</th>
                        <th>财务基础约定金额</th>
                        <th>差额2</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:540px; overflow:auto">
                <%BigDecimal bd1 = new BigDecimal(0.00);%>
                <%BigDecimal bd2 = new BigDecimal(0.00);%>
                <%BigDecimal bd3 = new BigDecimal(0.00);%>
                <%BigDecimal bd4 = new BigDecimal(0.00);%>
                <%BigDecimal bd5 = new BigDecimal(0.00);%>
                <%BigDecimal bd6 = new BigDecimal(0.00);%>
                <%int index=1;%>
                <table  id="rawTh" class="table table-bordered table-hover table-striped">
                    <%List<ChargePlanCompareCheck> tables = (List<ChargePlanCompareCheck>)request.getAttribute("tables");%>
                    <%
                        if (tables != null)
                        for(ChargePlanCompareCheck record:tables){%>
                    <tr>
                        <td><%=index++%></td>
                        <td><%=record.getCurrent()==null?record.getCompareTo().getDept():record.getCurrent().getDept()%></td>
                        <td><%=record.getCurrent()==null?record.getCompareTo().getCarNumber():record.getCurrent().getCarNumber()%></td>

                        <td>
                            <%BigDecimal planAll = record.getCurrent()==null?BigDecimal.ZERO:record.getCurrent().getPlanAll();%>
                            <%=planAll.setScale(2, BigDecimal.ROUND_HALF_UP)%>
                            <%bd1 = bd1.add(planAll);%>
                        </td>
                        <td>
                            <%BigDecimal planCompareAll = record.getCompareTo()==null?BigDecimal.ZERO:record.getCompareTo().getPlanAll();%>
                            <%=planCompareAll.setScale(2, BigDecimal.ROUND_HALF_UP)%>
                            <%bd2 = bd2.add(planCompareAll);%>
                        </td>
                        
                        <%BigDecimal planAllDiscount = planAll.subtract(planCompareAll).setScale(2, BigDecimal.ROUND_HALF_UP);%>
                        <td <%if (planAllDiscount.compareTo(BigDecimal.ZERO)!=0) {%> class="alert-danger" <%}%> >
                            <%=planAllDiscount%>
                            <%bd3 = bd3.add(planAllDiscount);%>
                        </td>

                        <td>
                            <%BigDecimal contractPlan = record.getContractPlanAmount()==null?BigDecimal.ZERO:record.getContractPlanAmount();%>
                            <%=contractPlan.setScale(2, BigDecimal.ROUND_HALF_UP)%>
                            <%bd4 = bd4.add(contractPlan);%>
                        </td>
                        <td>
                            <%BigDecimal rentPlan = record.getBaseChargeAmount()==null?BigDecimal.ZERO:record.getBaseChargeAmount();%>
                            <%=rentPlan.setScale(2, BigDecimal.ROUND_HALF_UP)%>
                            <%bd5 = bd5.add(rentPlan);%>
                        </td>
                        <%BigDecimal planRentDiscount = planAll.subtract(contractPlan).add(rentPlan).setScale(2, BigDecimal.ROUND_HALF_UP);%>
                        <td <%if (planRentDiscount.compareTo(BigDecimal.ZERO)!=0) {%> class="alert-danger" <%}%> >
                            <%=planRentDiscount%>
                            <%bd6 = bd6.add(planRentDiscount);%>
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th>-</th>
                        <th>-</th>
                        <th><%=bd1.setScale(2, BigDecimal.ROUND_HALF_UP)%></th>
                        <th><%=bd2.setScale(2, BigDecimal.ROUND_HALF_UP)%></th>
                        <th><%=bd3.setScale(2, BigDecimal.ROUND_HALF_UP)%></th>
                        <th><%=bd4.setScale(2, BigDecimal.ROUND_HALF_UP)%></th>
                        <th><%=bd5.setScale(2, BigDecimal.ROUND_HALF_UP)%></th>
                        <th><%=bd6.setScale(2, BigDecimal.ROUND_HALF_UP)%></th>
                    </tr>
                </table>
            </div>
        </div>

    </div>

</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>

</html>