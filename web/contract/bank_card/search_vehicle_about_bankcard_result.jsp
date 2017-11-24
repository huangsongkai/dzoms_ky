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

            for (var i = 0; i < selects.length; i++) {
                $("." + selects[i]).show();
            }
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

            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id=" + bid + "&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id=" + driverId + "&url=%2fcontract%2fbank_card%2fcard_update.jsp&ids[2].className=com.dz.module.vehicle.Vehicle&ids[2].id=" + selected_val + "&ids[2].isString=true";
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

            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id=" + bid + "&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id=" + driverId + "&url=%2fcontract%2fbank_card%2fcard_show.jsp";
            window.open(url, "银行卡信息", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _add() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }

            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.vehicle.Vehicle&ids[0].id=" + selected_val + "&ids[0].isString=true&url=%2fcontract%2fbank_card%2fcard_bind.jsp";
            window.open(url,'绑定银行卡到车辆',
                'height=500, width=300, top=100, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no');
//            window.parent.location = url;
        }

        function _addAndBind() {
            var selected_val = $("input[name='cbx']:checked").val();
            if (selected_val == undefined) {
                alert('您没有选择任何一条数据');
                return;
            }

            addAndBind(selected_val);
        }

        function addAndBind(carId) {
            var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.vehicle.Vehicle&ids[0].id=" + carId + "&ids[0].isString=true&url=%2fcontract%2fbank_card%2fcard_add.jsp";
            window.parent.location = url;
        }

        function unbindCard(cardId,carNo) {
            if(confirm('确认要解除绑定？'))
            $.post('/DZOMS/contract/bank_card/unbindVehicle',{
                'bankCard.id':cardId,
                'bankCard.carNum':carNo
            },function (data) {
                if(!data.status){
                    alert(data.msg);
                }else {
                    document.vehicleSele.submit();
                }
            });
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
<div class="line">
    <div class="panel  margin-small">
        <div class="panel-head">
            <div class="line">
                <div class="xm2">查询结果</div>
                <div class="xm4 xm6-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <%--<button onclick="_detail()" type="button" class="button icon-search text-blue"--%>
                                    <%--style="line-height: 6px;">--%>
                                <%--查看--%>
                            <%--</button>--%>
                            <%--<button onclick="_update()" type="button" class="button icon-pencil text-green"--%>
                                    <%--style="line-height: 6px;">--%>
                                <%--修改--%>
                            <%--</button>--%>
                            <button onclick="_add()" type="button" class="button icon-pencil text-green"
                                    style="line-height: 6px;">
                                添加银行卡绑定
                            </button>
                                <button onclick="_addAndBind()" type="button" class="button icon-pencil text-green"
                                        style="line-height: 6px;">
                                    新增银行卡并绑定
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
                    <th class="driverName selected_able">承租人</th>
                    <th class="state selected_able">车辆状态</th>
                    <th class="cardClass selected_able">银行卡类别</th>
                    <th class="cardNumber selected_able">银行卡号</th>
                    <th class="cardOwner selected_able">所属人</th>
                    <th class="cardOwnerType selected_able">角色</th>
                    <th class="operator selected_able">登记人</th>
                    <th class="opeTime selected_able">操作时间</th>
                    <th class="operation">操作</th>
                </tr>
                <s:if test="%{#request.vehicle!=null}">
                    <%--
                        ValueStack vs = (ValueStack) request.getAttribute("struts.valueStack");
                        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
                    --%>
                    <s:set name="hs" value="%{@com.dz.common.factory.HibernateSessionFactory@getSession()}"></s:set>
                    <s:iterator value="%{#request.vehicle}" var="v_raw">
                        <s:set name="v" value="%{#hs.get('com.dz.module.vehicle.Vehicle',#v_raw.carframeNum)}"></s:set>
                        <s:if test="%{#v.bovList!=null && #v.bovList.size()!=0}">
                            <s:iterator value="%{#v.bovList}" var="bov" status="I">
                                <tr>
                                    <s:if test="%{#I.index==0}">
                                        <td rowspan="${v.bovList.size()}">
                                            <input type="radio" name="cbx" value="<s:property value='%{#v.carframeNum}'/>"
                                                   driverId="<s:property value='%{#v.driverId}'/>" />
                                        </td>
                                        <td rowspan="${v.bovList.size()}" class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                                        <td rowspan="${v.bovList.size()}" class="dept selected_able"><s:property value="%{#v.dept}"/></td>
                                        <td rowspan="${v.bovList.size()}" class="driverName selected_able">
                                            <s:property value="%{#hs.get('com.dz.module.driver.Driver',#v.driverId).name}"/>
                                        </td>
                                        <td rowspan="${v.bovList.size()}" class="state selected_able">
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
                                    </s:if>

                                    <td class="cardClass selected_able"><s:property value="%{#bov.bankCard.cardClass}"/></td>
                                    <td class="cardNumber selected_able"><s:property value="%{#bov.bankCard.cardNumber}"/></td>
                                    <td class="cardOwner selected_able">
                                        <s:property value="%{#hs.get('com.dz.module.driver.Driver',#bov.bankCard.idNumber).name}"/>
                                    </td>
                                    <td class="cardOwnerType selected_able">
                                        <s:if test="%{#bov.bankCard.idNumber eq #v.driverId}">
                                            车主
                                        </s:if>
                                        <s:elseif test="%{#bov.bankCard.idNumber eq #v.firstDriver}">
                                            主驾
                                        </s:elseif>
                                        <s:elseif test="%{#bov.bankCard.idNumber eq #v.secondDriver}">
                                            副驾
                                        </s:elseif>
                                        <s:elseif test="%{#bov.bankCard.idNumber eq #v.thirdDriver}">
                                            三驾
                                        </s:elseif>
                                        <s:elseif test="%{#bov.bankCard.idNumber eq #v.forthDriver}">
                                            四驾
                                        </s:elseif>
                                        <s:else>
                                            <span style="color: red">其它</span>
                                        </s:else>
                                    </td>
                                    <td class="operator selected_able">
                                        <s:property value="%{#hs.get('com.dz.module.user.User',#bov.bankCard.operator).uname}"/>
                                    </td>
                                    <td class="opeTime selected_able"><s:property value="%{#bov.bankCard.opeTime}"/></td>
                                    <td class="operation"><a href="#" onclick="unbindCard('${bov.bankCard.id}','${bov.vehicle.carframeNum}')">解除绑定</a></td>
                                </tr>
                            </s:iterator>
                        </s:if>
                        <s:else>
                            <tr>
                                <td >
                                    <input type="radio" name="cbx" value="<s:property value='%{#v.carframeNum}'/>"
                                           driverId="<s:property value='%{#v.driverId}'/>" />
                                </td>
                                <td  class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                                <td  class="dept selected_able"><s:property value="%{#v.dept}"/></td>
                                <td  class="driverName selected_able">
                                    <s:property value="%{#hs.get('com.dz.module.driver.Driver',#v.driverId).name}"/>
                                </td>
                                <td  class="state selected_able">
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
                                <td class="cardClass selected_able">-</td>
                                <td class="cardNumber selected_able">-</td>
                                <td class="cardOwner selected_able">-</td>
                                <td class="cardOwnerType selected_able">-</td>
                                <td class="operator selected_able">-</td>
                                <td class="opeTime selected_able">-</td>
                                <td class="operation"><a href="#" onclick="addAndBind('${v.carframeNum}')">添加银行卡并绑定</a></td>
                            </tr>
                        </s:else>
                    </s:iterator>
                    <s:property value="%{@com.dz.common.factory.HibernateSessionFactory@closeSession()}"></s:property>
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
                <label class="button active"><input type="checkbox" name="sbx" value="cardOwner" checked="checked"><span
                        class="icon icon-check text-green"></span>银行卡所属人</label>
                <label class="button active"><input type="checkbox" name="sbx" value="cardOwnerType" checked="checked"><span
                        class="icon icon-check text-green"></span>所属人类别</label>
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
    <s:hidden name="pageSize"></s:hidden>
    <s:hidden name="cardClass" value="%{#parameters.cardClass}"></s:hidden>
</form>
</body>
</html>
