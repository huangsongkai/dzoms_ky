<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="com.dz.common.test.SpringContextListener" %>
<%@ page import="com.dz.module.charge.Deposit" %>
<%@ page import="com.dz.module.charge.DepositService" %>
<%@ page import="com.dz.module.driver.Driver" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    String driverName = request.getParameter("driverName");
    String licenseNum = request.getParameter("licenseNum");
    int currentPage = toInt(request.getParameter("currentPage"));
    if (currentPage <= 0) {
        currentPage = 1;
    }
    ApplicationContext app = SpringContextListener.getApplicationContext();
    DepositService service = app.getBean(DepositService.class);

    long counts = service.searchCount(licenseNum, driverName, null, null, null, null, null);
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
    <script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css"/>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js"></script>
    <script>
        $(document).ready(function () {
            $('#driver_name').bigAutocomplete({
                url: "/DZOMS/select/driverByName",
                doubleClick: true,
                valueColumn: "idNum",
                callback: function (name, idNum) {
                    $("#driverId").val(idNum);
                }
            });
            $('#license_num').bigAutocomplete({
                url: "/DZOMS/select/vehicleByLicenseNum",
                doubleClick: true,
                valueColumn: "carframeNum",
                callback: function (name, carframeNum) {
                    $("#carframeId").val(carframeNum);
                }
            });

            $("#page-input").blur(function () {
                $("input[name='currentPage']").val($("#page-input").val());
                $('form').submit();
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
                    <form action="#" method="post" class="definewidth m20 form form-inline" style="width: 100%;">
                        <input type="hidden" name="currentPage" value="<%=currentPage%>">

                        <div class="form-group">
                            <div class="label">
                                <label>驾驶员</label>
                            </div>
                            <div class="field">
                                <input type="text" id="driver_name" name="driverName" value="<%=isNull2(driverName)%>"
                                       class="input input-auto"/>
                                <input type="hidden" id="driverId" name="idNum"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label">
                                <label>车牌号</label>
                            </div>
                            <div class="field">
                                <input type="text" id="license_num" name="licenseNum" value="<%=isNull2(licenseNum)%>"
                                       class="input input-auto"/>
                                <input type="hidden" id="carframeId" name="carframeNum"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label">
                                <input type="submit" class="button" value="查询"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<table class="table table-bordered table-hover  table-striped">
    <tr>
        <th>车牌号</th>
        <th>车架号</th>
        <th>驾驶员</th>
        <th>押金单号</th>
        <th>收入押金</th>
        <th>返还押金</th>
        <th>收入日期</th>
        <th>返还日期</th>
        <th>操作员1</th>
        <th>操作员2</th>
    </tr>
    <%
        // if (true) {//TODO (StringUtils.isNotBlank(driverName) && StringUtils.isNotBlank(licenseNum)) {

        List<Deposit> list = service.search(licenseNum, driverName, null, null, null, null, null, currentPage);
        for (Deposit deposit : list) {
            Vehicle vehicle = ObjectAccess.getObject(Vehicle.class, deposit.getCarframeNum());
            Driver driver = ObjectAccess.getObject(Driver.class, deposit.getIdNum());
    %>
    <tr>
        <td><%=vehicle.getLicenseNum()%>
        </td>
        <td><%=vehicle.getCarframeNum()%>
        </td>
        <td><%=driver.getName()%>
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
                            <input class="input input-auto" size="4" value="<%=currentPage%>/<%=pages%>"
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
</body>
</html>
