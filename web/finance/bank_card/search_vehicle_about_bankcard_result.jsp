<%@page import="com.dz.common.global.Page" %>
<%@page import="com.dz.module.contract.BankCard" %>
<%@page import="com.dz.module.contract.BankCardService" %>
<%@page import="com.dz.module.vehicle.Vehicle" %>
<%@page import="com.opensymphony.xwork2.util.ValueStack" %>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
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
    <title>车辆查询结果</title>

    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script>
        $(document).ready(function () {
            $("#show_div").find("input").change(resetClass);
            resetClass();
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

        function call_update(val) {
            var url = "/DZOMS/vehicle/vehiclePreupdate?vehicle.carframeNum=" + val;
            //alert(url);
            window.open(url, "车辆修改", 'width=800,height=600,resizable=yes,scrollbars=yes');
            //$(window.top.document,"#main").attr("src",url);
        }

        function _update() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }

            var driverId = $("input[name='cbx']:checked").attr("driverId");
            var bid = $("input[name='cbx']:checked").attr("bid");

            if (bid.length == 0) {
                alert('该车无银行卡，请先添加银行卡！');
                return;
            }

            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id=" + bid + "&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id=" + driverId + "&url=%2ffinance%2fbank_card%2fcard_update.jsp&ids[2].className=com.dz.module.vehicle.Vehicle&ids[2].id=" + selected_val + "&ids[2].isString=true";
            window.open(url, "银行卡修改", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _detail() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }

            var driverId = $("input[name='cbx']:checked").attr("driverId");
            var bid = $("input[name='cbx']:checked").attr("bid");

            if (bid.length == 0) {
                alert('该车无银行卡，请先添加银行卡！');
                return;
            }

            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id=" + bid + "&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id=" + driverId + "&url=%2ffinance%2fbank_card%2fcard_show.jsp";
            window.open(url, "银行卡信息", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _add() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }

            var driverId = $("input[name='cbx']:checked").attr("driverId");
            var bid = $("input[name='cbx']:checked").attr("bid");
            var isSameDriver = $("input[name='cbx']:checked").attr("isSameDriver");

            if (bid.length != 0 && isSameDriver == 'true') {
                alert('该车已有银行卡！');
                return;
            }

            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.vehicle.Vehicle&ids[0].id=" + selected_val + "&ids[0].isString=true&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id=" + driverId + "&url=%2ffinance%2fbank_card%2fcard_add.jsp";
            window.parent.location = url;

        }

        //      function _delete(){
        //      	var selected_val = $("input[name='cbx']:checked").val();
        //      	if(selected_val==undefined){
        //						alert('您没有选择任何一条数据');
        //						return;
        //					}
        //
        //      	var driverId = $("input[name='cbx']:checked").attr("driverId");
        //      	var bid = $("input[name='cbx']:checked").attr("bid");
        //
        //      	if (bid.length==0) {
        //      		alert('该车无银行卡，不需清空！');
        //      		return;
        //      	}
        //
        //      	var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.vehicle.Vehicle&ids[0].id="+selected_val+"&ids[0].isString=true&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id="+driverId+"&url=%2ffinance%2fbank_card%2fcard_add.jsp";
        //
        //      	//此处发出请求
        //      	$.post("",{}，function(){
        //      		alert("清除成功！");
        //      		document.vehicleSele.submit();
        //      	});
        //
        //
        //      }

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
<div class="line">
    <div class="panel  margin-small">
        <div class="panel-head">
            <div class="line">
                <div class="xm2">查询结果</div>
                <div class="xm4 xm6-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <button onclick="_detail()" type="button" class="button icon-search text-blue"
                                    style="line-height: 6px;">
                                查看
                            </button>
                            <button onclick="_update()" type="button" class="button icon-pencil text-green"
                                    style="line-height: 6px;">
                                修改
                            </button>
                            <button onclick="_add()" type="button" class="button icon-pencil text-green"
                                    style="line-height: 6px;">
                                新增
                            </button>
                            <!--<button onclick="_delete()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                     删除                     </button>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <th>选择</th>
                    <th class="licenseNum selected_able">车牌号</th>
                    <th class="dept selected_able">归属部门</th>
                    <th class="driverId selected_able">承租人身份证号</th>
                    <th class="driverName selected_able">承租人</th>
                    <th class="state selected_able">车辆状态</th>
                    <th class="cardClass selected_able">银行卡类别</th>
                    <th class="cardNumber selected_able">银行卡号</th>
                    <th class="operator selected_able">登记人</th>
                    <th class="opeTime selected_able">操作时间</th>
                </tr>
                <s:if test="%{#request.vehicle!=null}">
                    <%
                        ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");

                        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());

                        BankCardService bcs = ctx.getBean(BankCardService.class);
                    %>
                    <s:iterator value="%{#request.vehicle}" var="v">
                        <%
                            Vehicle v = (Vehicle) vs.findValue("v");
                            BankCard card = bcs.getBankCardForPayByDriverId(v.getDriverId(), v.getCarframeNum());
                            request.setAttribute("b", card);
                            if (card != null)
                                request.setAttribute("isSameDriver", org.apache.commons.lang3.StringUtils.equals(v.getDriverId(), card.getIdNumber()));
                            else
                                request.setAttribute("isSameDriver", true);
                        %>

                        <tr style='<s:property value="%{#request.isSameDriver!=true?'background-color: red;':''}"/>'>

                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.carframeNum}'/>"
                                       driverId="<s:property value='%{#v.driverId}'/>"
                                       bid='<s:property value="%{#request.b.id}" />'
                                       isSameDriver='<s:property value="%{#request.isSameDriver?'true':'false'}" />'>
                            </td>
                            <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                            <td class="dept selected_able"><s:property value="%{#v.dept}"/></td>
                            <td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>
                            <td class="driverName selected_able"><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#request.b.idNumber).name}"/></td>
                            <td class="state selected_able">
                                <s:if test="%{#v.state==0}">
                                    新车待开业
                                </s:if>
                                <s:if test="%{#v.state==1}">
                                    运营中
                                </s:if>
                                <s:if test="%{#v.state==2}">
                                    已报废
                                </s:if>
                                <s:if test="%{#v.state==3}">
                                    二手车待开业
                                </s:if>
                            </td>


                            <s:if test="%{#request.b==null}">
                                <td class="cardClass selected_able">&nbsp;</td>
                                <td class="cardNumber selected_able">&nbsp;</td>
                                <td class="operator selected_able">&nbsp;</td>
                                <td class="opeTime selected_able">&nbsp;</td>
                            </s:if>
                            <s:else>
                                <td class="cardClass selected_able"><s:property value="%{#request.b.cardClass}"/></td>
                                <td class="cardNumber selected_able"><s:property value="%{#request.b.cardNumber}"/></td>
                                <td class="operator selected_able"><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#request.b.operator).uname}"/></td>
                                <td class="opeTime selected_able"><s:property value="%{#request.b.opeTime}"/></td>
                            </s:else>

                        </tr>
                    </s:iterator>
                </s:if>
            </table>


            <s:if test="%{#request.vehicle!=null}">
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
            </s:if>
            <s:else>
                无查询结果
            </s:else>

        </div>
        <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
        </div>
    </div>
</div>
<div class="line">
    <div class="panel  margin-small">
        <div class="panel-head">
            显示项
        </div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
                <label class="button active">
                    <input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span
                        class="icon icon-check text-green"></span>车牌号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="dept" checked="checked"><span
                        class="icon icon-check text-green"></span>归属部门
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="driverId" checked="checked"><span
                        class="icon icon-check text-green"></span>承租人身份证号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="driverName" checked="checked"><span
                        class="icon icon-check text-green"></span>承租人
                </label>

                <label class="button active">
                    <input type="checkbox" name="sbx" value="state" checked="checked"><span
                        class="icon icon-check text-green"></span>车辆状态
                </label>

                <label class="button active"><input type="checkbox" name="sbx" value="cardClass" checked="checked"><span
                        class="icon icon-check text-green"></span>银行卡类别</label>
                <label class="button active"><input type="checkbox" name="sbx" value="cardNumber"
                                                    checked="checked"><span class="icon icon-check text-green"></span>银行卡号</label>
                <label class="button active"><input type="checkbox" name="sbx" value="operator" checked="checked"><span
                        class="icon icon-check text-green"></span>登记人</label>
                <label class="button active"><input type="checkbox" name="sbx" value="opeTime" checked="checked"><span
                        class="icon icon-check text-green"></span>操作时间</label>

            </div>

        </div>

    </div>

</div>

<form action="vehicleSele" method="post" name="vehicleSele">
    <s:hidden name="url"></s:hidden>
    <s:hidden name="vehicle.carframeNum"/>
    <s:hidden name="vehicle.engineNum"/>
    <s:hidden name="vehicle.carMode"/>
    <s:hidden name="vehicle.inDate"/>
    <s:hidden name="vehicle.certifyNum"/>
    <s:hidden name="vehicle.dept"/>
    <s:hidden name="vehicle.pd"/>
    <s:hidden name="vehicle.driverId"/>
    <s:hidden name="driverName"/>
    <s:hidden name="vehicle.invoiceNumber"/>
    <s:hidden name="vehicle.taxNumber"/>
    <s:hidden name="vehicle.licenseNum"/>
    <s:hidden name="vehicle.operateCard"/>
    <s:hidden name="vehicle.businessLicenseNum"/>
    <s:hidden name="condition"/>
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
</body>
<script src="/DZOMS/res/js/apps.js"></script>
<script>
    $(document).ready(function () {
        try {
            App.init();
        } catch (e) {
            //TODO handle the exception
        }


        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

    });
</script>
</html>
