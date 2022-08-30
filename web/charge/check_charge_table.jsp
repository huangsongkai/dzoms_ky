<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.module.charge.CheckChargeTable" %>
<%@ page import="com.dz.module.charge.MonthPlan" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
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
    <title>单月对账表</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        function show(){
            $("#form").attr("action","/DZOMS/charge/getCheckChargeTable");
            $("#form").submit();
        }
        function exp(){
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
            <li>财务对账表</li>
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
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            类型
                        </label>
                    </div>
                    <div class="field">
                        <s:select cssClass="input input-auto"  name="status" id="status" list="#{0:'欠费',1:'正常',2:'银行未交',3:'银行已交',4:'全部'}">
                        </s:select>
                    </div>
                </div>


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
                        <th>车牌号</th>
                        <th>司机</th>
                        <th>部门</th>
                        <th>计划总额</th>
                        <th>现金收入</th>
                        <th>哈尔滨银行</th>
                        <th>招商银行</th>
                        <th>银行收入</th>
                        <th>油补转入</th>
                        <th>保险转入</th>
                        <th>其它收入</th>
                        <th>收入合计</th>
                        <th style="display:none;">本月存款</th>
                        <th>上月存款</th>
                        <th>本月存款</th>
                        <th>本月累计存款</th>
                        <th>本月计划已分配</th>
                        <th>本月计划未分配</th>
                        <th>本月收入已分配</th>
                        <th>本月收入未分配</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:540px; overflow:auto">
                <%BigDecimal bd1 = new BigDecimal(0.00);%>
                <%BigDecimal bd2 = new BigDecimal(0.00);%>
                <%BigDecimal bd3 = new BigDecimal(0.00);%>
                <%BigDecimal bd4 = new BigDecimal(0.00);%>
                <%BigDecimal bd5 = new BigDecimal(0.00);%>
                <%BigDecimal bd_other = new BigDecimal(0.00);%>
                <%BigDecimal bd6 = new BigDecimal(0.00);%>
                <%BigDecimal bd7 = new BigDecimal(0.00);%>
                <%BigDecimal bd8 = new BigDecimal(0.00);%>
                <%BigDecimal bd9 = new BigDecimal(0.00);%>
                <%BigDecimal bd10 = new BigDecimal(0.00);%>
                <%BigDecimal bd_hrb = new BigDecimal(0.00);%>
                <%BigDecimal bd_zs = new BigDecimal(0.00);%>
                <%BigDecimal bd11 = new BigDecimal(0.00);%>
                <%BigDecimal bd12 = new BigDecimal(0.00);%>
                <%BigDecimal bd13 = new BigDecimal(0.00);%>
                <%BigDecimal bd14 = new BigDecimal(0.00);%>
                <%int index=1;%>
                <table  id="rawTh" class="table table-bordered table-hover table-striped">
                    <%List<CheckChargeTable> tables = (List<CheckChargeTable>)request.getAttribute("tables");%>
                    <%
                        Session s = HibernateSessionFactory.getSession();
                        Query query = s.createQuery("select mp from MonthPlan mp,Vehicle v where mp.carframeNum=v.carframeNum " +
                                "and v.licenseNum=:carId and year(mp.time)=year(:time) and month(mp.time)=month(:time)");
                        Query query1 = s.createQuery("select sum(cp.fee)-sum(cp.balance),sum(cp.balance) from ChargePlan cp,Contract c " +
                                "where cp.contractId=c.id and cp.isDisabled=false and cp.feeType like 'add%' " +
                                "and c.carNum=:carId and year(cp.time)=year(:time) and month(cp.time)=month(:time) ");
                        query.setMaxResults(1);
                        query1.setMaxResults(1);
                        for(CheckChargeTable record:tables){
                            query.setString("carId",record.getCarNumber());
                            query.setDate("time",record.getTime());
                            query1.setString("carId",record.getCarNumber());
                            query1.setDate("time",record.getTime());
                            MonthPlan monthPlan = (MonthPlan) query.uniqueResult();
                            Object[] planSum = (Object[]) query1.uniqueResult();
                            Number p1 = (Number) planSum[0];
                            Number p2 = (Number) planSum[1];
                            BigDecimal pv1 = p1==null? BigDecimal.ZERO:BigDecimal.valueOf(p1.doubleValue());
                            BigDecimal pv2 = p2==null? BigDecimal.ZERO:BigDecimal.valueOf(p2.doubleValue());
                    %>
                    <tr>
                        <td><%=index++%></td>
                        <td><%=record.getCarNumber()%></td>
                        <td><%=record.getDriverName()%></td>
                        <td><%=record.getDept()%></td>
                        <td><%=record.getPlanAll()%></td>
                        <%bd1 = bd1.add(record.getPlanAll());%>
                        <td><%=record.getCash()%></td>
                        <%bd2 = bd2.add(record.getCash());%>
                        <td><%=record.getBank1()%></td>
                        <%bd_hrb = bd_hrb.add(record.getBank1());%>
                        <td><%=record.getBank2()%></td>
                        <%bd_zs = bd_zs.add(record.getBank2());%>
                        <td><%=record.getBank()%></td>
                        <%bd3 = bd3.add(record.getBank());%>
                        <td><%=record.getOilAdd()%></td>
                        <%bd4 = bd4.add(record.getOilAdd());%>
                        <td><%=record.getInsurance()%></td>
                        <%bd5 = bd5.add(record.getInsurance());%>
                        <td><%=record.getOther()%></td>
                        <%bd_other = bd_other.add(record.getOther());%>
                        <td><%=record.getTotal()%></td>
                        <%bd6 = bd6.add(record.getTotal());%>
                        <td style="display:none;"><%=record.getThisMonthOwe()%></td>
                        <%bd7 = bd7.add(record.getThisMonthOwe());%>
                        <td><%=record.getLastMonthOwe()%></td>
                        <%bd8 = bd8.add(record.getLastMonthOwe());%>
                        <td><%=record.getThisMonthLeft()%></td>
                        <%bd9 = bd9.add(record.getThisMonthLeft());%>
                        <td><%=record.getThisMonthTotalOwe()%></td>
                        <%bd10 = bd10.add(record.getThisMonthTotalOwe());%>
                        <% if(monthPlan==null){%>
                        <td> - </td>
                        <td> - </td>
                        <%}else {%>
                        <td><%=monthPlan.getPlanAll().subtract(monthPlan.getArrear())%></td>
                        <%bd11 = bd11.add(monthPlan.getPlanAll().subtract(monthPlan.getArrear()));%>
                        <td><%=(monthPlan.getArrear())%></td>
                        <%bd12 = bd12.add(monthPlan.getArrear());%>
                        <%}%>
                        <td><%=pv1%></td>
                        <td><%=pv2%></td>
                        <%
                            bd13 = bd13.add(pv1);
                            bd14 = bd14.add(pv2);
                        %>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th>-</th>
                        <th>-</th>
                        <th>-</th>
                        <th><%=bd1%></th>
                        <th><%=bd2%></th>
                        <th><%=bd_hrb%></th>
                        <th><%=bd_zs%></th>
                        <th><%=bd3%></th>
                        <th><%=bd4%></th>
                        <th><%=bd5%></th>
                        <th><%=bd_other%></th>
                        <th><%=bd6%></th>
                        <th style="display:none;"><%=bd7%></th>
                        <th><%=bd8%></th>
                        <th><%=bd9%></th>
                        <th><%=bd10%></th>
                        <th><%=bd11%></th>
                        <th><%=bd12%></th>
                        <th><%=bd13%></th>
                        <th><%=bd14%></th>
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