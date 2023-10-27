<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.ArrayList" %>
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
    String doExport = request.getParameter("doExport");
    boolean isDoExport = doExport != null && StringUtils.equals("yes", doExport);
    String department = request.getParameter("department");
    String yearString = request.getParameter("year");
    int year = toInt(yearString);
    year = Math.max(year,2020);
    String showAll = request.getParameter("showAll");
    boolean showEverything = false;

    if (showAll!=null && showAll.equalsIgnoreCase("yes")){
        showEverything = true;
    }

    String deptCondition = " ";
    if (department!=null && !department.equalsIgnoreCase("全部")){
        deptCondition = " and v.dept=:dept ";
    }

    Session hsession = HibernateSessionFactory.getSession();

    Query query = hsession.createQuery("select distinct \n" +
            "v.dept,\n" +
            "v.licenseNum,\n" +
            "mp.carframeNum,\n" +
            "(select sum(mp1.planAll) from MonthPlan mp1 where mp1.carframeNum=mp.carframeNum and year(mp1.time)<:year) as planBefore,\n" +
            "(select sum(mp1.arrear) from MonthPlan mp1 where mp1.carframeNum=mp.carframeNum and year(mp1.time)<:year) as arrearBefore,\n" +
            "sum(mp.planAll) as planOfYear,\n" +
            "sum(mp.arrear) as arrearOfYear,\n" + // 6
            "sum(case when Month(mp.time)=1 then mp.planAll else 0 end) as plan_1,\n" + // 6+1
            "sum(case when Month(mp.time)=2 then mp.planAll else 0 end) as plan_2,\n" +
            "sum(case when Month(mp.time)=3 then mp.planAll else 0 end) as plan_3,\n" +
            "sum(case when Month(mp.time)=4 then mp.planAll else 0 end) as plan_4,\n" +
            "sum(case when Month(mp.time)=5 then mp.planAll else 0 end) as plan_5,\n" +
            "sum(case when Month(mp.time)=6 then mp.planAll else 0 end) as plan_6,\n" +
            "sum(case when Month(mp.time)=7 then mp.planAll else 0 end) as plan_7,\n" +
            "sum(case when Month(mp.time)=8 then mp.planAll else 0 end) as plan_8,\n" +
            "sum(case when Month(mp.time)=9 then mp.planAll else 0 end) as plan_9,\n" +
            "sum(case when Month(mp.time)=10 then mp.planAll else 0 end) as plan10,\n" +
            "sum(case when Month(mp.time)=11 then mp.planAll else 0 end) as plan11,\n" +
            "sum(case when Month(mp.time)=12 then mp.planAll else 0 end) as plan12,\n" + // 6+12
            "sum(case when Month(mp.time)=1 then mp.arrear else 0 end) as arrear_1,\n" + // 18+1
            "sum(case when Month(mp.time)=2 then mp.arrear else 0 end) as arrear_2,\n" +
            "sum(case when Month(mp.time)=3 then mp.arrear else 0 end) as arrear_3,\n" +
            "sum(case when Month(mp.time)=4 then mp.arrear else 0 end) as arrear_4,\n" +
            "sum(case when Month(mp.time)=5 then mp.arrear else 0 end) as arrear_5,\n" +
            "sum(case when Month(mp.time)=6 then mp.arrear else 0 end) as arrear_6,\n" +
            "sum(case when Month(mp.time)=7 then mp.arrear else 0 end) as arrear_7,\n" +
            "sum(case when Month(mp.time)=8 then mp.arrear else 0 end) as arrear_8,\n" +
            "sum(case when Month(mp.time)=9 then mp.arrear else 0 end) as arrear_9,\n" +
            "sum(case when Month(mp.time)=10 then mp.arrear else 0 end) as arrear10,\n" +
            "sum(case when Month(mp.time)=11 then mp.arrear else 0 end) as arrear11,\n" +
            "sum(case when Month(mp.time)=12 then mp.arrear else 0 end) as arrear12\n" + // 18+12
            "from MonthPlan mp , Vehicle v\n" +
            "where year(mp.time)=:year and mp.carframeNum=v.carframeNum\n" + deptCondition +
            "group by mp.carframeNum\n" +
            "order by (CASE v.dept WHEN '一部' THEN 1 WHEN '二部' THEN 2 WHEN '三部' THEN 3 ELSE 4 END),v.licenseNum\n");


    if (department!=null && !department.equalsIgnoreCase("全部")){
        query.setString("dept",department);
    }
    query.setInteger("year",year);

    List<Object[]> plans = query.list();

    if (isDoExport) {
        List<String> datasrc = Arrays.asList("list");
        List datalist = new ArrayList();
        if (!showEverything){
            List<Object[]> list = new ArrayList<>();
            for (Object[] record : plans) {
                if (((Number) record[6]).doubleValue() != 0) {
                    list.add(record);
                }
            }
            datalist.add(list);
        }else {
            datalist.add(plans);
        }
        String templatePath = "charge/planMatch/match_show_by_month.xls";
        String outputName = ""+year+"年欠费统计查询";
        request.setAttribute("datasrc", datasrc);
        request.setAttribute("datalist", datalist);
        request.setAttribute("templatePath", templatePath);
        request.setAttribute("outputName", outputName);
        request.getRequestDispatcher("/common/outputExcel.action").forward(request, response);
    }
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>欠费统计查询</title>
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

        function _toExcel() {
            $('form input[name="doExport"]').val("yes");
            $('form').submit();
            $('form input[name="doExport"]').val("no");
        }

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
            <li>欠费统计查询</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" action="#" class="form-inline form-tips" style="width: 100%;">
        <input type="hidden" name="doExport" value="no">
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
                            年度(>=2020)
                        </label>
                    </div>
                    <div class="field">
                        <input name="year" value='<%=year%>'>
                    </div>
                </div>
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
                        <label>显示不欠款车辆记录</label>
                    </div>
                    <div class="field">
                        <input type="radio" name="showAll" value="yes" <%=showEverything?"checked":""%> >是
                        <input type="radio" name="showAll" value="no" <%=showEverything?"":"checked"%> >否
                    </div>
                </div>
                <input type="submit" value="查询" class="button bg-green"/>
                    <button onclick="_toExcel()" type="button"
                            class="button icon-file-excel-o text-blue"
                            style="line-height: 6px;">
                        导出为Excel
                    </button>
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
                        <th>往年计划</th>
                        <th>往年欠款</th>
                        <th>1月计划</th>
                        <th>1月欠款</th>
                        <th>2月计划</th>
                        <th>2月欠款</th>
                        <th>3月计划</th>
                        <th>3月欠款</th>
                        <th>4月计划</th>
                        <th>4月欠款</th>
                        <th>5月计划</th>
                        <th>5月欠款</th>
                        <th>6月计划</th>
                        <th>6月欠款</th>
                        <th>7月计划</th>
                        <th>7月欠款</th>
                        <th>8月计划</th>
                        <th>8月欠款</th>
                        <th>9月计划</th>
                        <th>9月欠款</th>
                        <th>10月计划</th>
                        <th>10月欠款</th>
                        <th>11月计划</th>
                        <th>11月欠款</th>
                        <th>12月计划</th>
                        <th>12月欠款</th>
                        <th>年计划总额</th>
                        <th>年欠款总额</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:540px; overflow:auto">
                <%BigDecimal bd_before_p = new BigDecimal(0.00);%>
                <%BigDecimal bd_before_a = new BigDecimal(0.00);%>
                <%BigDecimal bd_current_p = new BigDecimal(0.00);%>
                <%BigDecimal bd_current_a = new BigDecimal(0.00);%>

                <%BigDecimal bd_plan_1 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_2 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_3 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_4 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_5 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_6 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_7 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_8 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan_9 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan10 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan11 = new BigDecimal(0.00);%>
                <%BigDecimal bd_plan12 = new BigDecimal(0.00);%>

                <%BigDecimal bd_arrear_1 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_2 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_3 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_4 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_5 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_6 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_7 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_8 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear_9 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear10 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear11 = new BigDecimal(0.00);%>
                <%BigDecimal bd_arrear12 = new BigDecimal(0.00);%>

                <%int index=1;%>
                <table  id="rawTh" class="table table-bordered table-hover">
                    <%if(plans!=null)
                        for(Object[] record:plans){
                            if (!showEverything && ((Number) record[6]).doubleValue() == 0){
                                continue;
                            }
                    %>
                    <tr>
                        <td><%=index++%></td>
                        <td><%=record[0]%></td>
                        <td><%=record[1]%></td>
                        <%--<td><%=record[2]%></td>--%>
                        <td><%=record[3]==null?0:record[3]%></td>
                        <td class='<%=(record[4]!=null && ((Number)record[4]).doubleValue()!=0)?"bg-red":""%> '><%=record[4]==null?0:record[4]%></td>

                        <td><%=record[6 +1]%></td>
                        <td class='<%=(((Number)record[18+1]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+1]%></td>
                        <td><%=record[6 +2]%></td>
                        <td class='<%=(((Number)record[18+2]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+2]%></td>
                        <td><%=record[6 +3]%></td>
                        <td class='<%=(((Number)record[18+3]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+3]%></td>
                        <td><%=record[6 +4]%></td>
                        <td class='<%=(((Number)record[18+4]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+4]%></td>
                        <td><%=record[6 +5]%></td>
                        <td class='<%=(((Number)record[18+5]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+5]%></td>
                        <td><%=record[6 +6]%></td>
                        <td class='<%=(((Number)record[18+6]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+6]%></td>
                        <td><%=record[6 +7]%></td>
                        <td class='<%=(((Number)record[18+7]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+7]%></td>
                        <td><%=record[6 +8]%></td>
                        <td class='<%=(((Number)record[18+8]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+8]%></td>
                        <td><%=record[6 +9]%></td>
                        <td class='<%=(((Number)record[18+9]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+9]%></td>
                        <td><%=record[6 +10]%></td>
                        <td class='<%=(((Number)record[18+10]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+10]%></td>
                        <td><%=record[6 +11]%></td>
                        <td class='<%=(((Number)record[18+11]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+11]%></td>
                        <td><%=record[6 +12]%></td>
                        <td class='<%=(((Number)record[18+12]).doubleValue()!=0)?"bg-red":""%> '><%=record[18+12]%></td>
                        <td><%=record[5    ]%></td>
                        <td class='<%=(((Number)record[6    ]).doubleValue()!=0)?"bg-red":""%> '><%=record[6    ]%></td>
                        <td><button onclick="showDetails('<%=record[2]%>')">查看详情</button></td>

                        <%
                            if(record[3]!=null){
                                bd_before_p = bd_before_p.add(BigDecimal.valueOf(((Number) record[3]).doubleValue()));
                                bd_before_a = bd_before_a.add(BigDecimal.valueOf(((Number) record[4]).doubleValue()));
                            }
                        %>

                        <%bd_current_p = bd_current_p.add(BigDecimal.valueOf(((Number) record[5]).doubleValue()));%>
                        <%bd_current_a = bd_current_a.add(BigDecimal.valueOf(((Number) record[6]).doubleValue()));%>

                        <%bd_plan_1 = bd_plan_1.add(BigDecimal.valueOf(((Number) record[6+ 1]).doubleValue()));%>
                        <%bd_plan_2 = bd_plan_2.add(BigDecimal.valueOf(((Number) record[6+ 2]).doubleValue()));%>
                        <%bd_plan_3 = bd_plan_3.add(BigDecimal.valueOf(((Number) record[6+ 3]).doubleValue()));%>
                        <%bd_plan_4 = bd_plan_4.add(BigDecimal.valueOf(((Number) record[6+ 4]).doubleValue()));%>
                        <%bd_plan_5 = bd_plan_5.add(BigDecimal.valueOf(((Number) record[6+ 5]).doubleValue()));%>
                        <%bd_plan_6 = bd_plan_6.add(BigDecimal.valueOf(((Number) record[6+ 6]).doubleValue()));%>
                        <%bd_plan_7 = bd_plan_7.add(BigDecimal.valueOf(((Number) record[6+ 7]).doubleValue()));%>
                        <%bd_plan_8 = bd_plan_8.add(BigDecimal.valueOf(((Number) record[6+ 8]).doubleValue()));%>
                        <%bd_plan_9 = bd_plan_9.add(BigDecimal.valueOf(((Number) record[6+ 9]).doubleValue()));%>
                        <%bd_plan10 = bd_plan10.add(BigDecimal.valueOf(((Number) record[6+10]).doubleValue()));%>
                        <%bd_plan11 = bd_plan11.add(BigDecimal.valueOf(((Number) record[6+11]).doubleValue()));%>
                        <%bd_plan12 = bd_plan12.add(BigDecimal.valueOf(((Number) record[6+12]).doubleValue()));%>

                        <%bd_arrear_1 = bd_arrear_1.add(BigDecimal.valueOf(((Number) record[18+ 1]).doubleValue()));%>
                        <%bd_arrear_2 = bd_arrear_2.add(BigDecimal.valueOf(((Number) record[18+ 2]).doubleValue()));%>
                        <%bd_arrear_3 = bd_arrear_3.add(BigDecimal.valueOf(((Number) record[18+ 3]).doubleValue()));%>
                        <%bd_arrear_4 = bd_arrear_4.add(BigDecimal.valueOf(((Number) record[18+ 4]).doubleValue()));%>
                        <%bd_arrear_5 = bd_arrear_5.add(BigDecimal.valueOf(((Number) record[18+ 5]).doubleValue()));%>
                        <%bd_arrear_6 = bd_arrear_6.add(BigDecimal.valueOf(((Number) record[18+ 6]).doubleValue()));%>
                        <%bd_arrear_7 = bd_arrear_7.add(BigDecimal.valueOf(((Number) record[18+ 7]).doubleValue()));%>
                        <%bd_arrear_8 = bd_arrear_8.add(BigDecimal.valueOf(((Number) record[18+ 8]).doubleValue()));%>
                        <%bd_arrear_9 = bd_arrear_9.add(BigDecimal.valueOf(((Number) record[18+ 9]).doubleValue()));%>
                        <%bd_arrear10 = bd_arrear10.add(BigDecimal.valueOf(((Number) record[18+10]).doubleValue()));%>
                        <%bd_arrear11 = bd_arrear11.add(BigDecimal.valueOf(((Number) record[18+11]).doubleValue()));%>
                        <%bd_arrear12 = bd_arrear12.add(BigDecimal.valueOf(((Number) record[18+12]).doubleValue()));%>
                    </tr>
                    <%}%>
                    <tr>
                        <th>合计</th>
                        <th>-</th>
                        <th>-</th>
                        <th><%=bd_before_p%></th>
                        <th><%=bd_before_a%></th>

                        <th><%=bd_plan_1%></th><th><%=bd_arrear_1%></th>
                        <th><%=bd_plan_2%></th><th><%=bd_arrear_2%></th>
                        <th><%=bd_plan_3%></th><th><%=bd_arrear_3%></th>
                        <th><%=bd_plan_4%></th><th><%=bd_arrear_4%></th>
                        <th><%=bd_plan_5%></th><th><%=bd_arrear_5%></th>
                        <th><%=bd_plan_6%></th><th><%=bd_arrear_6%></th>
                        <th><%=bd_plan_7%></th><th><%=bd_arrear_7%></th>
                        <th><%=bd_plan_8%></th><th><%=bd_arrear_8%></th>
                        <th><%=bd_plan_9%></th><th><%=bd_arrear_9%></th>
                        <th><%=bd_plan10%></th><th><%=bd_arrear10%></th>
                        <th><%=bd_plan11%></th><th><%=bd_arrear11%></th>
                        <th><%=bd_plan12%></th><th><%=bd_arrear12%></th>

                        <th><%=bd_current_p%></th>
                        <th><%=bd_current_a%></th>
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