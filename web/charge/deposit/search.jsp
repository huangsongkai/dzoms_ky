<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.common.convertor.DateTypeConverter" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="com.dz.common.test.SpringContextListener" %>
<%@ page import="com.dz.module.charge.Deposit" %>
<%@ page import="com.dz.module.charge.DepositService" %>
<%@ page import="com.dz.module.driver.Driver" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Ghode
  Date: 2018/12/24
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    String isNull(Object s) {
        if (s == null) {
            return "-";
        } else {
            return s.toString();
        }
    }

    String isNull2(Object s) {
        if (s == null) {
            return "";
        } else {
            return s.toString();
        }
    }

    static <T> T nullIf(Object o, T nullValue, T notNullValue) {
        return o == null ? nullValue : notNullValue;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");

    String dateFormat(Date d) {
        if (d == null) {
            return "-";
        } else {
            return sdf.format(d);
        }
    }

    int toInt(String s) {
        try {
            return Integer.parseInt(s);
        } catch (Exception ex) {
            return 0;
        }
    }
%>

<%
    //    String carNo = request.getParameter("carframeNum");
//    String idNum = request.getParameter("idNum");
    try {
        String driverName = request.getParameter("driverName");
        String idNum = request.getParameter("idNum");
        String licenseNum = request.getParameter("licenseNum");
        String type = request.getParameter("type");
        String ticketId = request.getParameter("ticketId");

        String doExport = request.getParameter("doExport");
        boolean isDoExport = doExport != null && StringUtils.equals("yes", doExport);

        boolean isDespointIn = type != null && StringUtils.equals("yes", type);
        String beginDate = request.getParameter("beginDate");
        String endDate = request.getParameter("endDate");
        Date dateBegin = StringUtils.isBlank(beginDate) ? null : DateTypeConverter.dateFormat.parse(beginDate);
        Date dateEnd = StringUtils.isBlank(endDate) ? null : DateTypeConverter.dateFormat.parse(endDate);

        int currentPage = toInt(request.getParameter("currentPage"));

        ApplicationContext app = SpringContextListener.getApplicationContext();
        DepositService service = app.getBean(DepositService.class);

        List<Deposit> list;
        long counts = 0;


        System.out.println(licenseNum);
        System.out.println(driverName);
        System.out.println(idNum);
        System.out.println(ticketId);
        System.out.println(dateBegin);
        System.out.println(dateEnd);

        if (currentPage <= 0) {
            currentPage = 1;
        }

        if (isDoExport) {
            List<String> datasrc = Arrays.asList("list");
            list = service.search(licenseNum, driverName, idNum, ticketId, dateBegin, dateEnd, null, null, -100);
            List datalist = Arrays.asList(list);
            String templatePath = "charge/deposit/deposit.xls";
            String outputName = "服务保证金导出";
            request.setAttribute("datasrc", datasrc);
            request.setAttribute("datalist", datalist);
            request.setAttribute("templatePath", templatePath);
            request.setAttribute("outputName", outputName);
            request.getRequestDispatcher("/common/outputExcel.action").forward(request, response);
        }else {
            if (isDespointIn) {
                counts = service.searchCount(licenseNum, driverName, ticketId, dateBegin, dateEnd, null, null);
                list = service.search(licenseNum, driverName, idNum, ticketId, dateBegin, dateEnd, null, null, currentPage);
            } else {
                counts = service.searchCount(licenseNum, driverName, ticketId, null, null, dateBegin, dateEnd);
                list = service.search(licenseNum, driverName, idNum, ticketId, null, null, dateBegin, dateEnd, currentPage);
            }
        }


        long pages = (counts + 29) / 30;
%>

<html>
<head>
    <title>查询押金信息</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script type="text/javascript"
            src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css"/>
    <script type="text/javascript"
            src="/DZOMS/res/js/jquery.bigautocomplete.js"></script>
    <script>
        $(document).ready(function () {
            $('#driver_name').bigAutocomplete({
                url: "/DZOMS/select/driverByName",
                doubleClick: true,
                valueColumn: "idNum"
            });

            $('#driverId').bigAutocomplete({
                url: "/DZOMS/select/driverById",
                doubleClick: true
            });

            $('#license_num').bigAutocomplete({
                url: "/DZOMS/select/vehicleByLicenseNum",
                doubleClick: true,
                valueColumn: "carframeNum"
            });

            $("#page-input").blur(function () {
                $("input[name='currentPage']").val($("#page-input").val());
                $('form').submit();
            });

            $('#ticketId').bigAutocomplete({
                url: "/DZOMS/select/DepositBydepositId",
                doubleClick: true,
                valueColumn: "depositId"
            });
        });


        function toPreviousPage() {
            var currentPage = <%=currentPage%>;
            if (currentPage == 1) {
                alert("没有上一页了。");
                return;
            }
            $("input[name='currentPage']").val(currentPage - 1);
            $('form').submit();
        }

        function toNextPage() {
            var currentPage = <%=currentPage%>;
            if (currentPage ==<%=pages%>) {
                alert("没有下一页了。");
                return;
            }
            $("input[name='currentPage']").val(currentPage + 1);
            $('form').submit();
        }

        function withdraw(id, money, msg) {
            if (money <= 0) {
                return;
            }
            if (confirm(msg)) {
                $.post("/DZOMS/charge/deposit_withdraw", {
                    "deposit.id": id,
                    "deposit.backMoney": money
                }, function (data) {
                    if (data != null) {
                        if (data.isSuccess) {
                            alert("提款成功！");
                            $('form').submit();
                        } else {
                            alert("提款失败！原因是：" + data.errorMsg);
                        }
                    }
                })
            }
        }

        function _match() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }

            if ($('#deposit-' + selected_val).find("td.licenseNum").text().length > 0) {
                alert('该押金数据已有车辆！');
            } else {
                $.post("/DZOMS/charge/deposit_match", {
                    "deposit.id": selected_val
                }, function (data) {
                    if (data != null) {
                        if (data.isSuccess) {
                            alert("匹配成功！");
                            $('form').submit();
                        } else {
                            alert("匹配失败！原因是：" + data.errorMsg);
                        }
                    }
                })
            }
        }

        function _update() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }
            var newTicketId = prompt("请输入一个新票号：");
            if (newTicketId.trim().length > 0) {
                $.post("/DZOMS/charge/deposit_update_ticketId", {
                    "deposit.id": selected_val,
                    "deposit.depositId": newTicketId
                }, function (data) {
                    if (data != null) {
                        if (data.isSuccess) {
                            alert("修改成功！");
                            $('form').submit();
                        } else {
                            alert("修改失败！原因是：" + data.errorMsg);
                        }
                    }
                })
            }
        }

        function _withdraw() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }
            if ($('#deposit-' + selected_val).find("a.button").length > 0) {
                $('#deposit-' + selected_val).find("a.button").click();
            } else {
                alert('已返还的押金不可重复返还！');
            }
        }

        function _toExcel() {
            $('form input[name="doExport"]').val("yes");
            $('form').submit();
            $('form input[name="doExport"]').val("no");
        }
    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>财务管理</li>
        <li>查询押金信息</li>
    </ul>
</div>
<div class="line">
    <div class="panel  margin-small">
        <div class="panel-head">
            查询条件
        </div>
        <div class="panel-body">
            <div class="line">
                <div class="xm12 padding">
                    <form action="#" method="post"
                          class="definewidth m20 form form-inline"
                          style="width: 100%;">
                        <input type="hidden" name="currentPage"
                               value="<%=currentPage%>">
                        <input type="hidden" name="doExport" value="no">
                        <div class="form-group">
                            <div class="label">
                                <label>驾驶员姓名</label>
                            </div>
                            <div class="field">
                                <input type="text" id="driver_name"
                                       name="driverName"
                                       value="<%=isNull2(driverName)%>"
                                       class="input input-auto"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="label">
                                <label>驾驶员身份证号</label>
                            </div>
                            <div class="field">
                                <input type="text" id="driverId" name="idNum"
                                       value="<%=isNull2(idNum)%>"
                                       class="input input-auto"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="label">
                                <label>票号</label>
                            </div>
                            <div class="field">
                                <input type="text" id="ticketId" name="ticketId"
                                       value="<%=isNull2(ticketId)%>"
                                       class="input input-auto"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="label">
                                <label>车牌号</label>
                            </div>
                            <div class="field">
                                <input type="text" id="license_num"
                                       name="licenseNum"
                                       value="<%=isNull2(licenseNum)%>"
                                       class="input input-auto"/>
                                <input type="hidden" id="carframeId"
                                       name="carframeNum"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="label">
                                <label>查询类型</label>
                            </div>
                            <div class="field">
                                <div class="button-group radio">
                                    <% if (type != null && StringUtils.equals("no", type)) {
                                    %>
                                    <label class="button ">
                                        <input name="type" value="yes"
                                               type="radio"><span
                                            class="icon icon-check"></span> 收入押金
                                    </label>
                                    <label class="button active">
                                        <input name="type" value="no"
                                               type="radio"
                                               checked="checked"><span
                                            class="icon icon-times"></span> 返还押金
                                    </label>
                                    <%
                                    } else {
                                    %>
                                    <label class="button active">
                                        <input name="type" value="yes"
                                               checked="checked"
                                               type="radio"><span
                                            class="icon icon-check"></span> 收入押金
                                    </label>
                                    <label class="button">
                                        <input name="type" value="no"
                                               type="radio"><span
                                            class="icon icon-times"></span> 返还押金
                                    </label>
                                    <%
                                        }%>
                                </div>
                            </div>
                        </div>

                        <div class="form-group padding">
                            <div class="label">
                                <label>查询范围</label>
                            </div>
                            <div class="field">
                                <input type="text" name="beginDate"
                                       value="<%=isNull2(beginDate)%>"
                                       class="datetimepicker input input-auto"
                                       size="10"/>
                            </div>
                            至
                            <div class="field">
                                <input type="text" name="endDate"
                                       value="<%=isNull2(endDate)%>"
                                       class="datetimepicker input input-auto"
                                       size="10"/>
                            </div>
                        </div>


                        <div class="form-button">
                            <input type="submit" class="button" value="查询"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<table class="table table-bordered table-hover  table-striped">
    <tr>
        <th>部门</th>
        <th>收款总额</th>
        <th>付款总额</th>
        <th>累计收款总额</th>
        <th>累计付款总额</th>
        <th>累计结余</th>
    </tr>
    <%
        Session s = HibernateSessionFactory.getSession();
        Query q = s.createQuery("select (CASE WHEN d.carframeNum IS NULL THEN '其它' ELSE v.dept END),\n" +
                "sum(case when d.inDate<:beginDate then 0.0 when d.inDate>:endDate then 0.0 else d.inMoney end ),\n" +
                "sum(case when d.backDate<:beginDate then 0.0 when d.backDate>:endDate then 0.0 else d.backMoney end ),\n" +
                "sum(case when d.inDate>:endDate then 0.0 else d.inMoney end ),\n" +
                "sum(case when d.backDate>:endDate then 0.0 else d.backMoney end )\n" +
                "from Deposit d,Vehicle v \n" +
                "where d.carframeNum=v.carframeNum or (d.carframeNum is null and v.carframeNum=(select MAX(carframeNum) from Vehicle)) \n" +
                "group by (CASE WHEN d.carframeNum IS NULL THEN '其它' ELSE v.dept END)\n" +
                "order by (CASE WHEN d.carframeNum IS NULL THEN 4 WHEN v.dept='一部' THEN 1 WHEN v.dept='二部' THEN 2 ELSE 3 END)");
        q.setDate("beginDate", dateBegin == null ? new Date(100, 1, 1) : dateBegin);
        q.setDate("endDate", dateEnd == null ? new Date(200, 1, 1) : dateEnd);
        List<Object[]> results = q.list();
        BigDecimal sum0 = BigDecimal.ZERO;
        BigDecimal sum1 = BigDecimal.ZERO;
        BigDecimal sum2 = BigDecimal.ZERO;
        BigDecimal sum3 = BigDecimal.ZERO;
        BigDecimal col0 = BigDecimal.ZERO;
        BigDecimal col1 = BigDecimal.ZERO;
        BigDecimal col2 = BigDecimal.ZERO;
        BigDecimal col3 = BigDecimal.ZERO;
        for (Object[] row : results) {
    %>
    <tr>
        <td><%=row[0]%>
        </td>
        <td><% col0 = BigDecimal.valueOf(((Number) row[1]).doubleValue());
            sum0 = sum0.add(col0);%><%=col0%>
        </td>
        <td><% col1 = BigDecimal.valueOf(((Number) row[2]).doubleValue());
            sum1 = sum1.add(col1);%><%=col1%>
        </td>
        <td><% col2 = BigDecimal.valueOf(((Number) row[3]).doubleValue());
            sum2 = sum2.add(col2);%><%=col2%>
        </td>
        <td><% col3 = BigDecimal.valueOf(((Number) row[4]).doubleValue());
            sum3 = sum3.add(col3);%><%=col3%>
        </td>
        <td><%=col2.subtract(col3)%>
        </td>
    </tr>
    <%}%>
    <tr>
        <td>合计</td>
        <td><%=sum0%>
        </td>
        <td><%=sum1%>
        </td>
        <td><%=sum2%>
        </td>
        <td><%=sum3%>
        </td>
        <td><%=sum2.subtract(sum3)%>
        </td>
    </tr>
</table>
<div class="line">
    <div class="button-toolbar">
        <div class="button-group">
            <button onclick="_match()" type="button"
                    class="button icon-search text-blue"
                    style="line-height: 6px;">
                匹配车牌号
            </button>
            <button onclick="_update()" type="button"
                    class="button icon-pencil text-green"
                    style="line-height: 6px;">
                修改票号
            </button>
            <button onclick="_withdraw()" type="button"
                    class="button icon-pencil text-blue"
                    style="line-height: 6px;">
                返还押金
            </button>
            <button onclick="_toExcel()" type="button"
                    class="button icon-file-excel-o text-blue"
                    style="line-height: 6px;">
                导出为Excel
            </button>
        </div>
    </div>
</div>
<table class="table table-bordered table-hover  table-striped">
    <tr>
        <th>选择</th>
        <th>部门</th>
        <th>车牌号</th>
        <%--<th>车架号</th>--%>
        <th>驾驶员</th>
        <th>身份证号</th>
        <th>押金单号</th>
        <th>收入押金</th>
        <th>返还押金</th>
        <th>收入日期</th>
        <th>返还日期</th>
        <th>操作员1</th>
        <th>操作员2</th>
        <th>备注</th>
    </tr>
    <%
        // if (true) {//TODO (StringUtils.isNotBlank(driverName) && StringUtils.isNotBlank(licenseNum)) {
        for (Deposit deposit : list) {
            Vehicle vehicle = null;
            if (deposit.getCarframeNum() != null) {
                vehicle = ObjectAccess.getObject(Vehicle.class, deposit.getCarframeNum());
            }
            Driver driver = ObjectAccess.getObject(Driver.class, deposit.getIdNum());
    %>
    <tr id="deposit-<%=deposit.getId()%>">
        <td><input type="radio" name="cbx" value="<%=deposit.getId()%>"></td>
        <td><%=vehicle == null ? "" : vehicle.getDept()%>
        </td>
        <td class="licenseNum"><%=vehicle == null ? "" : vehicle.getLicenseNum()%>
        </td>
        <%--<td><%=deposit.getCarframeNum()%></td>--%>
        <td><%=driver.getName()%>
        </td>
        <td><%=driver.getIdNum()%>
        </td>
        <td><%=deposit.getDepositId()%>
        </td>
        <td><%=deposit.getInMoney()%>
        </td>
        <td>
            <%if (deposit.getBackMoney() == 0) {%>
            <a class="button"
               href="javascript:withdraw(<%=deposit.getId()%>,<%=deposit.getInMoney()%>,'确认返还<%=driver.getName()%>押金<%=deposit.getInMoney()%>元？')">返还押金</a>
            <%} else {%>
            <%=deposit.getBackMoney()%>
            <%}%>
        </td>
        <td><%=deposit.getInDate()%>
        </td>
        <td><%=dateFormat(deposit.getBackDate())%>
        </td>
        <td><%=deposit.getuNameIn()%>
        </td>
        <td><%=isNull(deposit.getuNameBack())%>
        </td>
        <td><%=isNull(deposit.getComment())%>
        </td>
    </tr>
    <%
        }
    %>
</table>
<div class="line padding">
    <div class="xm5-move">
        <div>
            <ul class="pagination">
                <li><a href="javascript:toPreviousPage()">上一页</a></li>
            </ul>
            <ul class="pagination pagination-group">
                <li style="border: 0px;">
                    <div class="form-group">
                        <div class="field">
                            <input class="input input-auto" size="4"
                                   value="<%=currentPage%>/<%=pages%>"
                                   id="page-input">
                        </div>
                    </div>
                </li>
            </ul>
            <ul class="pagination">
                <li><a href="javascript:toNextPage()">下一页</a></li>
            </ul>

        </div>
    </div>
</div>
<script>
    $('.datetimepicker').datetimepicker({
        lang: "ch",           //语言选择中文
        format: "Y/m/d",      //格式化日期
        timepicker: false,    //关闭时间选项
        yearStart: 2000,     //设置最小年份
        yearEnd: 2050,        //设置最大年份
        //todayButton:false    //关闭选择今天按钮
        onSelectDate: function () {
            $("#search_form").submit();
        }
    });
</script>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace(response.getWriter());
    }
%>