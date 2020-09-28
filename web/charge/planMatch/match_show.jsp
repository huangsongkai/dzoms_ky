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
    String department = request.getParameter("department");
    String showAll = request.getParameter("showAll");
    boolean showEverything = false;

    if (showAll!=null && showAll.equalsIgnoreCase("yes")){
        showEverything = true;
    }

    String deptCondition = " ";
    if (department!=null && !department.equalsIgnoreCase("全部")){
        deptCondition = " and c1.branch_firm=:dept ";
    }

    Session hsession = HibernateSessionFactory.getSession();

    Query query = hsession.createSQLQuery("select " +
            " c1.branch_firm,c1.car_num, " +
            " sum(case when temp1.col=1 then temp1.amount else 0 end ), " +
            " sum(case when temp1.col=2 then -temp1.amount else 0 end ), " +
            " sum(case when temp1.col=3 then temp1.amount else 0 end )," +
            " c1.carframe_num " +
            " from (select c.id as cid,cp.balance as amount,1 as col " +
            " from charge_plan cp,contract c " +
            " where cp.contract_id=c.id and cp.is_disabled=0 and cp.balance>0 " +
            " union " +
            " select c.id as cid,cp.balance as amount,2 as col " +
            " from charge_plan cp,contract c " +
            " where cp.contract_id=c.id and cp.is_disabled=0 and cp.balance<0 " +
            " union select c.id as cid,mp.arrear as amount,3 as col " +
            " from month_plan mp,contract c " +
            " where mp.contract_id=c.id and mp.arrear>0) as temp1,contract c1 " +
            " where temp1.cid=c1.id " +
             deptCondition +
            " group by c1.id " +
            ( !showEverything ? (" having sum(case when temp1.col=1 then temp1.amount else 0 end )>0 " +
            "and sum( case when temp1.col!=1 then temp1.amount else 0 end )>0 ") : "") +
            " order by c1.branch_firm,c1.car_num "
    );

    if (department!=null && !department.equalsIgnoreCase("全部")){
        query.setString("dept",department);
    }

    List<Object[]> plans = query.list();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>计划-收入分配查询</title>
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

        function showDetails(contractId) {
            window.open("match_show_detail.jsp?carNum="+contractId,"_blank")
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>计划-收入分配查询</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" action="#" class="form-inline form-tips" style="width: 100%;">
        <div class="panel  margin-small" >
            <div class="panel-body">
                <%--<div class="form-group">--%>
                    <%--<div class="label padding">--%>
                        <%--<label>--%>
                            <%--车牌号--%>
                        <%--</label>--%>
                    <%--</div>--%>
                    <%--<div class="field">--%>
                        <%--<input class="input input-auto" size="9" id="licenseNum" name="licenseNum" value="黑A"  onfocus="carFocus()"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
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
                            显示无需分配的条目
                        </label>
                    </div>
                    <div class="field">
                        <input type="radio" name="showAll" value="yes" <%=showEverything?"checked":""%> >是
                        <input type="radio" name="showAll" value="no" <%=showEverything?"":"checked"%> >否
                    </div>
                </div>
                    <input type="submit" value="查询" class="button bg-green"/>
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
                        <th>部门</th>
                        <th>车牌号</th>
                        <th>欠款总额</th>
                        <th>提款总额</th>
                        <th>收入总余额</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:540px; overflow:auto">
                <%BigDecimal bd1 = new BigDecimal(0.00);%>
                <%BigDecimal bd2 = new BigDecimal(0.00);%>
                <%BigDecimal bd3 = new BigDecimal(0.00);%>
                <%int index=1;%>
                <table  id="rawTh" class="table table-bordered table-hover">
                    <%if(plans!=null)
                        for(Object[] record:plans){
                    %>
                    <tr class="<%=(((Number)record[2]).doubleValue()>0 && (((Number)record[3]).doubleValue()>0 || ((Number)record[4]).doubleValue()>0) )?"bg-red":""%> ">
                        <td><%=index++%></td>
                        <td><%=record[0]%></td>
                        <td><%=record[1]%></td>
                        <td><%=record[4]%></td>
                        <td><%=record[3]%></td>
                        <td><%=record[2]%></td>
                        <td><button onclick="showDetails('<%=record[5]%>')">查看详情</button></td>
                        <%bd1 = bd1.add(BigDecimal.valueOf(((Number) record[4]).doubleValue()));%>
                        <%bd2 = bd2.add(BigDecimal.valueOf(((Number) record[3]).doubleValue()));%>
                        <%bd3 = bd3.add(BigDecimal.valueOf(((Number) record[2]).doubleValue()));%>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th>-</th>
                        <th>-</th>
                        <th><%=bd1%></th>
                        <th><%=bd2%></th>
                        <th><%=bd3%></th>
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