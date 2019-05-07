<%@ page import="com.dz.common.convertor.DateTypeConverter" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
%>
<%
    int contractId = toInt(request.getParameter("contractId"));
    String monthString = request.getParameter("time");
    Date month = sdf.parse(monthString);
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(month);
    calendar.set(Calendar.DATE,27);
    Date endTime = calendar.getTime();
    calendar.add(Calendar.MONTH,-1);
    Date startTime = calendar.getTime();
    String hql = "from ChargePlan where feeType='add_insurance' and contractId=:contractId and time > :startTime and time < :endTime ";
    Session hsession = HibernateSessionFactory.getSession();
    Query query = hsession.createQuery(hql);
    query.setInteger("contractId",contractId);
    query.setDate("startTime",startTime);
    query.setDate("endTime",endTime);
    List<ChargePlan> plans = query.list();
    Contract contract = (Contract) hsession.get(Contract.class,contractId);
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>保险转入明细</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/admin.js"></script>

    <script>
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
            <li>保险转入明细</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" class="form-inline form-tips" style="width: 100%;">
        <div class="panel  margin-small" >
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <%=contract.getCarNum()%>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门
                        </label>
                    </div>
                    <div class="field">
                        <%=contract.getBranchFirm()%>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            月份
                        </label>
                    </div>
                    <div class="field">
                        <%=monthString%>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>明细</strong>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr id="newTh">
                        <th>序号</th>
                        <th>车牌号</th>
                        <th>金额</th>
                        <th>转入时间</th>
                        <th>转入方式</th>
                        <th>备注</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:540px; overflow:auto">
                <%BigDecimal bd5 = new BigDecimal(0.00);%>
                <%int index=1;%>
                <table  id="rawTh" class="table table-bordered table-hover table-striped">
                    <%if(plans!=null)
                        for(ChargePlan record:plans){
                            if(record.getFee().compareTo(BigDecimal.ZERO)==0){
                                continue;
                            }
                    %>
                    <tr>
                        <td><%=index++%></td>
                        <td><%=contract.getCarNum()%></td>
                        <td><%=record.getFee()%></td>
                        <td><%=DateTypeConverter.dateFormat20.format(record.getInTime())%></td>
                        <td><%=record.getComment().contains("，哈尔滨大众")?"自动回款":"人工导入"%></td>
                        <td><%=record.getComment()%></td>
                        <%bd5 = bd5.add(record.getFee());%>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th>-</th>
                        <th><%=bd5%></th>
                        <th>-</th>
                        <th>-</th>
                        <th>-</th>
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