<%@page import="com.dz.common.global.Page" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    Page pg = (Page) request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>查询结果</title>

    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/window.js"></script>
    <script>
        $(document).ready(function () {
            $("#show_div").find("input").change(resetClass);
        });

        function resetClass() {
            $(".selected_able").hide();
            var selects = [];
            $("input[name='sbx']:checked").each(function () {//遍历每一个名字为interest的复选框，其中选中的执行函数
                selects.push($(this).val());//将选中的值添加到数组chk_value中
            });
            //	alert(selects);

            for (var i = 0; i < selects.length; i++) {
                $("." + selects[i]).show();
            }
        }

        function _detail() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined)
                alert('您没有选择任何一条数据');
            var url = "/DZOMS/driver/driverPreshow?driver.idNum=" + selected_val;
            window.open(url, "驾驶员明细", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _update() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined)
                alert('您没有选择任何一条数据');
            var url = "/DZOMS/driver/driverPreupdate?driver.idNum=" + selected_val;
            window.open(url, "驾驶员修改", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _toExcel() {
            document.vehicleSele2.submit();
        }

        function _toPrint() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }
            var url = "/DZOMS/driver/driverInCar/print_driver_change.jsp?id=" + selected_val;
            window.open(url, "驾驶员修改", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function toBeforePage() {
            var currentPage = parseInt($("input[name='currentPage']").val());
            if (currentPage == 1) {
                alert("没有上一页了。");
                return;
            }
            $("input[name='currentPage']").val($("input[name='currentPage']").val() - 1);
            document.vehicleSele.submit();
        }

        function toNextPage() {
            var currentPage = parseInt($("input[name='currentPage']").val());
            if (currentPage ==<%=pg.getTotalPage()%>) {
                alert("没有下一页了。");
                return;
            }
            $("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val()) + 1);
            document.vehicleSele.submit();
        }

        function toPage(pg) {

            $("input[name='currentPage']").val(pg);
            document.vehicleSele.submit();
        }

        $(document).ready(function () {
            var currentPage = parseInt($("input[name='currentPage']").val());
            $("#page-input").val(currentPage + "/<%=pg.getTotalPage()%>");

            $("#page-input").change(function () {

                var pg_num = parseInt($("#page-input").val());
                toPage(pg_num);
            });

            $("#page-input").focus(function () {
                $(this).val("");
            });
        });
    </script>
</head>
<body>
<div>
    <div class="panel  margin-small">
        <div class="panel-head">
            <div class="line">
                <div class="xm2">查询结果</div>
                <div class="xm4 xm6-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <!--<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                          查看</button>
                           <button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                                       修改</button>-->
                            <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
                                导出</button>
                            <!--<button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                                      打印</button>-->
                        </div>
                    </div>
                </div>
            </div>


        </div>


        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
                    <th>选择</th>
                    <th class="name                    selected_able">姓名</th>
                    <th class="idNum                   selected_able">身份证号</th>
                    <th class="licenseNum              selected_able">车牌号</th>
                    <th class="carframeNum             selected_able">车架号</th>
                    <th class="department              selected_able">分公司归属</th>
                    <th class="phoneNum1              selected_able">联系方式</th>
                    <th class="operation               selected_able">事项</th>
                    <th class="state               selected_able">状态</th>
                    <th class="opeTime                 selected_able">时间</th>
                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.idNum}'/>"></td>
                            <td class="name selected_able"><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNumber).name}"/></td>
                            <td class="idNum selected_able"><s:property value="%{#v.idNumber}"/></td>
                            <td class="licenseNum selected_able"><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
                            <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
                            <td class="department selected_able"><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).dept}"/></td>
                            <td class="phoneNum1 selected_able"><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNumber).phoneNum1}"/></td>
                            <td class="operation selected_able"><s:property value="%{#v.operation}"/></td>
                            <td class="state selected_able"><s:if
                                    test="%{#v.finished}">已办领</s:if><s:else>未办领</s:else></td>
                            <td class="opeTime selected_able"><s:property value="%{#v.opeTime}"/></td>
                        </tr>
                    </s:iterator>
                </s:if>
            </table>
            <s:if test="%{#request.list!=null}">
                <div class="line padding">
                    <div class="xm5-move">
                        <div>
                            <ul class="pagination">
                                <li><a href="javascript:toBeforePage()">上一页</a></li>
                            </ul>
                            <ul class="pagination pagination-group">
                                <li style="border: 0px;">
                                    <form>
                                        <div class="form-group">
                                            <div class="field">
                                                <input class="input input-auto" size="4"
                                                       value="1/<%=pg.getTotalPage()%>" id="page-input">
                                            </div>
                                        </div>
                                    </form>
                                </li>
                            </ul>
                            <ul class="pagination">
                                <li><a href="javascript:toNextPage()">下一页</a></li>
                            </ul>

                        </div>
                    </div>
                </div>
                <div class="panel-foot border-red-light bg-red-light">
                    合计：<%=pg.getTotalCount() %>条记录。
                </div>
            </s:if>
            <s:else>
                无查询结果
            </s:else>
        </div>

    </div>
    <div class="line">
        <div class="panel  margin-small">
            <div class="panel-head">

                显示项


            </div>
            <div class="panel-body">
                <div class="button-group checkbox" id="show_div">
                    <label class="button active"><input type="checkbox" name="sbx" value="name" checked="checked"><span
                            class="icon icon-check text-green"></span>姓名</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span
                            class="icon icon-check text-green"></span>身份证号</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span
                            class="icon icon-check text-green"></span>车牌号</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="carframeNum"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>车架号</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="department" checked="checked"><span
                            class="icon icon-check text-green"></span>分公司归属</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="phoneNum1"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>联系方式</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="operation"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>事项</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="state" checked="checked"><span
                            class="icon icon-check text-green"></span>状态</label>
                    <label class="button active"><input type="checkbox" name="sbx" value="opeTime"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>时间</label>

                </div>

            </div>

        </div>

        <form action="/DZOMS/driver/driverInCar/searchRecord" method="post" name="vehicleSele">
            <s:hidden name="beginDate"/>
            <s:hidden name="endDate"/>
            <s:hidden name="operation"/>
            <s:hidden name="finished"/>
            <s:hidden name="driver.idNum"/>
            <s:hidden name="isInCar"/>
            <s:hidden name="vehicle.licenseNum"/>
            <s:hidden name="vehicle.dept"/>
            <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"/>
        </form>

        <form action="/DZOMS/driver/driverInCarToExcel" method="post" name="vehicleSele2">
            <s:hidden name="beginDate"/>
            <s:hidden name="endDate"/>
            <s:hidden name="operation"/>
            <s:hidden name="finished"/>
            <s:hidden name="driver.idNum"/>
            <s:hidden name="isInCar"/>
            <s:hidden name="vehicle.licenseNum"/>
            <s:hidden name="vehicle.dept"/>
        </form>
    </div>
</div>
</body>
</html>
