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
    <title>审批状态查询结果</title>

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

        $(document).ready(function () {
            $(".step").each(function () {
                var status = $(this).attr("status");
                var i = 0;
                for (; i < parseInt(status) && i < 7; i++) {
                    $(this).find(".step-bar").eq(i).addClass("complete");
                }
                if (i < 7) {
                    $(this).find(".step-bar").eq(i).addClass("active");
                }
            });
        });

        $(document).ready(function () {
            //双击查看审批单详情
            $("tr[checkType='0']").dblclick(function () {//开业审批单
                new MyRequest('/DZOMS/common/getObj', '_parent')
                    .param("ids[0].className", "com.dz.module.vehicle.VehicleApproval")
                    .param("ids[0].id", $(this).attr('checkId'))
                    .param("ids[0].isString", false)
                    .param("ids[1].className", "com.dz.module.contract.Contract")
                    .param("ids[1].id", $(this).attr('cId'))
                    .param("ids[1].isString", false)
                    .param("url", "/vehicle/CreateApproval/vehicle_approval09.jsp")
                    .submit();
                // window.parent.location.href = "/DZOMS/common/getObj?url=%2fvehicle%2fCreateApproval%2fvehicle_approval09.jsp&ids[0].id="+$(this).attr('checkId')+"&ids[0].className=com.dz.module.vehicle.VehicleApproval&ids[1].className=com.dz.module.contract.Contract&ids[1].id="+$(this).attr('cId');
            });

            $("tr[checkType='1']").dblclick(function () {//废业审批单
                new MyRequest('/DZOMS/common/getObj', "_parent")
                    .param("ids[0].className", "com.dz.module.vehicle.VehicleApproval")
                    .param("ids[0].id", $(this).attr('checkId'))
                    .param("ids[0].isString", false)
                    .param("ids[1].className", "com.dz.module.contract.Contract")
                    .param("ids[1].id", $(this).attr('cId'))
                    .param("ids[1].isString", false)
                    .param("url", "/vehicle/AbandonApproval/vehicle_abandon09.jsp")
                    .submit();
                // window.parent.location.href = "/DZOMS/common/getObj?url=%2fvehicle%2fAbandonApproval%2fvehicle_abandon09.jsp&ids[0].id="+$(this).attr('checkId')+"&ids[0].className=com.dz.module.vehicle.VehicleApproval&ids[1].className=com.dz.module.contract.Contract&ids[1].id="+$(this).attr('cId');
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
                <div class="xm6 xm4-move">
                    <div class="button-toolbar">
                        <div class="button-group">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <!--<th>选择</th>-->
                    <th class="type selected_able">类型</th>
                    <th class="name selected_able">申请人姓名</th>
                    <th class="idNum selected_able">申请人身份证号</th>
                    <th class="carframeNum selected_able">车架号</th>
                    <th class="licenseNum selected_able">车牌号</th>
                    <!--<th class="state selected_able">当前状态</th>
                    -->                    </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">

                        <tr checkType="<s:property value="%{#v.checkType}"/>"
                            checkId="<s:property value="%{#v.id}"/>"
                            cId="<s:property value="%{#v.contractId}"/>">
                            <!--<td><input type="checkbox" name="cbx" value="<s:property value="%{#v.id}"/>" ></td>-->
                            <s:set name="c"
                                   value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.contract.Contract',#v.contractId)}"></s:set>
                            <td class="type selected_able"><s:property
                                    value="%{#v.checkType==0?'开业审批':'废业审批'}"/></td>
                            <td class="name selected_able"><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#c.idNum).name}"/></td>
                            <td class="idNum selected_able"><s:property
                                    value="%{#c.idNum}"/></td>
                            <td class="carframeNum selected_able"><s:property
                                    value="%{#c.carframeNum }"/></td>
                            <td class="licenseNum selected_able"><s:property
                                    value="%{#c.carNum}"/></td>
                            <!-- <td class="state selected_able"><s:property value="%{#v.state}"/></td>
--></tr>
                        <tr style='<s:property value="%{((#c.state==0||#c.state==1)#c.planMaked!=true)?'background-color: red;':''}"/>'
                            checkType="<s:property value="%{#v.checkType}"/>"
                            checkId="<s:property value="%{#v.id}"/>"
                            cId="<s:property value="%{#v.contractId}"/>">
                            <td colspan="5">
                                <s:if test="%{#v.checkType==0}">
                                    <div class="step"
                                         status='<s:property value="%{#v.state}"/>'>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.branchManagerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point ">1</span><span
                                                class="step-text">承租人申请开业</span></span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.assurerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point tips">2</span><span
                                                class="step-text">保险员审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.managerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">3</span><span
                                                class="step-text">运营管理部经理审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.managerApprovalDate}" format="yyyy/MM/dd"/></h2>">
											<span class="step-point">3
												.5</span><span
                                                class="step-text">运营管理部经理审批</span>
                                        </div>

                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.financeManagerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">4</span><span
                                                class="step-text">计财部收款</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.approvalFinanceDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">5</span><span
                                                class="step-text">计财部经理审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.approvalDirectorDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">6</span><span
                                                class="step-text">主管副总经理审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.approvalOfficeDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">7</span><span
                                                class="step-text">综合办公室审批</span>
                                        </div>
                                    </div>
                                </s:if>
                                <s:else>
                                    <div class="step"
                                         status='<s:property value="%{#v.state==1?#v.state:(#v.state-1)}"/>'>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.branchManagerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">1</span><span
                                                class="step-text">承租人申请废业</span></span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.assurerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point tips">2</span><span
                                                class="step-text">保险员审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.managerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">3</span><span
                                                class="step-text">运营管理部经理审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.approvalOfficeDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">4</span><span
                                                class="step-text">综合办公室审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.approvalFinanceDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">5</span><span
                                                class="step-text">计财部收款</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.financeManagerApprovalDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">6</span><span
                                                class="step-text">计财部经理审批</span>
                                        </div>
                                        <div class="step-bar tips"
                                             style="width: 14.28%;"
                                             data-toggle="hover"
                                             data-place="top"
                                             title="<h2><s:date name="%{#v.approvalDirectorDate}" format="yyyy/MM/dd"/></h2>">
                                            <span class="step-point">7</span><span
                                                class="step-text">主管副总经理审批</span>
                                        </div>
                                    </div>
                                </s:else>
                            </td>
                        </tr>
                    </s:iterator>
                </s:if>
            </table>


            <s:if test="%{#request.list!=null}">
                <div class="line padding">
                    <div class="xm5-move">
                        <div>
                            <ul class="pagination">
                                <li><a href="javascript:toBeforePage()">上一页</a>
                                </li>
                            </ul>
                            <ul class="pagination pagination-group">
                                <li style="border: 0px;">
                                    <form>
                                        <div class="form-group">
                                            <div class="field">
                                                <input class="input input-auto"
                                                       size="4"
                                                       value="1/<%=pg.getTotalPage()%>"
                                                       id="page-input">
                                            </div>
                                        </div>
                                    </form>
                                </li>
                            </ul>
                            <ul class="pagination">
                                <li><a href="javascript:toNextPage()">下一页</a>
                                </li>
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
                <div class="button-group checkbox bg-blue-light" id="show_div">
                    <label class="button active"><input type="checkbox"
                                                        name="sbx" value="type"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>类型</label>
                    <label class="button active"><input type="checkbox"
                                                        name="sbx" value="name"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>申请人姓名</label>
                    <label class="button active"><input type="checkbox"
                                                        name="sbx" value="idNum"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>申请人身份证号</label>
                    <label class="button active"><input type="checkbox"
                                                        name="sbx"
                                                        value="carframeNum"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>车架号</label>
                    <label class="button active"><input type="checkbox"
                                                        name="sbx"
                                                        value="licenseNum"
                                                        checked="checked"><span
                            class="icon icon-check text-green"></span>车牌号</label>
                    <!--<label class="button active"><input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>当前状态</label>
                    -->            </div>

            </div>

        </div>

    </div>
</div>
<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
    <s:hidden name="condition"/>
    <input type="hidden" name="url"
           value="/vehicle/vehicle_approval_search_result.jsp"/>
    <input type="hidden" name="className"
           value="com.dz.module.vehicle.VehicleApproval"/>
    <s:hidden name="pageSize"/>
    <s:hidden name="currentPage" value="%{#request.page.currentPage}"
              id="currentPage"></s:hidden>
</form>
</body>
</html>
