<%@ page import="com.dz.common.global.Page" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    Page pg = (Page)request.getAttribute("page");
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="renderer" content="webkit"/>
    <base href="<%=basePath%>">
    <title> 例会签到 </title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script>
        function toBeforePage(){
            var currentPage = parseInt($("input[name='currentPage']").val());
            if(currentPage==1){
                alert("没有上一页了。");
                return ;
            }
            $("input[name='currentPage']").val($("input[name='currentPage']").val()-1);
            document.vehicleSele.submit();
        }

        function toNextPage(){
            var currentPage = parseInt($("input[name='currentPage']").val());
            if(currentPage==<%=pg.getTotalPage()%>){
                alert("没有下一页了。");
                return ;
            }
            $("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val())+1);
            document.vehicleSele.submit();
        }

        function toPage(pg){
            $("input[name='currentPage']").val(pg);
            document.vehicleSele.submit();
        }

        $(document).ready(function(){
            var currentPage = parseInt($("input[name='currentPage']").val());
            $("#page-input").val(currentPage + "/<%=pg.getTotalPage()%>");

            $("#page-input").change(function(){
                var pg_num = parseInt($("#page-input").val());
                toPage(pg_num);
            });

            $("#page-input").focus(function(){
                $(this).val("");
            });
        });
    </script>
    <script>
        //<%--手工签到--%>
        function add1(){
            var idNums = $("input[name='cbx']");
            var checkType = $(".dialog-win .checkType").val();
            var checkMethod = $(".dialog-win .checkClass").val();
            var checkTime = $(".dialog-win .checkTime").val();

            var count =0;
            var msgs = [];

            for (var i = 0; i < idNums.length; i++) {
                $.post('driver/meeting/manmalCheck2',{
                    checkClass:checkType,
                    idNum:idNums[i].value,
                    method:checkMethod,
                    checkTime:checkTime,
                    "meeting.id":"${param.meetingId}",
                    "meetingId":"${param.meetingId}"
                },function (data) {
                    var msg = data["msg"];
                    count ++;
                    if(msg && msg.length && msg.length>0){
                        // alert(msg);
                        msgs.push(msg);
                    }
                    if (count == idNums.length) {
                        if (msgs.length>0){
                            alert("本次执行返回以下消息：\n"+msgs.join('\n'));
                        }
                        document.vehicleSele.submit();
                    }
                });
            }

        }

        var use_tr_pos = true;

        //<%--清除签到--%>
        function clearCheck(){
            var idNums = $("input[name='cbx']");

            var count =0;

            for (var i = 0; i < idNums.length; i++) {
                $.post('driver/meeting/clearCheck',{
                    idNum:idNums[i].value,
                    "meeting.id":"${param.meetingId}",
                    "meetingId":"${param.meetingId}"
                },function (data) {
                    count++;
                    if (count==idNums.length){
                        document.vehicleSele.submit();
                    }
                });
            }
        }
    </script>
    <style>
        .label {
            width: 80px;
            text-align: right;
        }

        .form-group {
            width: 300px;
            margin-top: 5px;
        }

        .changecolor {
            background-color: #0099CC;
        }

    </style>
</head>
<body>
<%--分页记录--%>
<div class="line">
    <div class="panel  margin-small">
        <div class="panel-head">签到
            <div class="line">
                <div class="xm1 xm7-move" id="manmalCheckDiv">
                    <a class="button dialogs bg-gray margin" data-toggle="click" data-target="#mydialog"
                       data-mask="1" data-width="50%">
                        <span class="h6"><strong>手工</strong></span>
                    </a>
                </div>
                <div class="xm2">
                    <a class="button  bg-gray margin" href="javascript:clearCheck()">
                        <span class="h6"><strong>清除签到</strong></span>
                    </a>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-hover" id="meeting-time-detail">
                <tr>
                    <th>选择</th>
                    <th>车牌号</th>
                    <th>驾驶员</th>
                    <th>身份证号</th>
                    <th>分公司归属</th>
                    <th>类别</th>
                    <th>是否签到</th>
                    <th>签到方式</th>
                    <th>签到时间</th>
                    <th>分值</th>
                    <th>手动签到经手人</th>
                    <th>手动签到经手时间</th>
                </tr>
                <s:if test="%{#request.list!=null}">
                    <s:iterator value="%{#request.list}" var="v">
                        <tr ondblclick="hand_check(this)"
                            class="<s:property value="%{#v.isChecked?'bg-green-light':'bg-red-light'}" />">
                                <%--<td><input type="radio" name="cbx" value="<s:property value="%{#v.idNum}" />" <s:property value="%{#v.isChecked?'disabled=\"true\"':''}" /> /></td> --%>
                            <td><input type="checkbox" name="cbx" value="<s:property value="%{#v.idNum}" />"/></td>
                            <s:set name="t_driver"
                                   value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNum)}"/>
                            <s:set name="t_meeting"
                                   value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.meeting.Meeting',#v.meetingId)}"/>
                            <td><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#t_driver.carframeNum).licenseNum}"/></td>
                            <td><s:property value="%{#t_driver.name}"/></td>
                            <td><s:property value="%{#v.idNum}"/></td>
                            <td><s:property value="%{#t_driver.dept}"/></td>
                            <td><s:property value="%{#v.isBuhui()?'补会':'例会'}"/></td>
                            <td><s:property value="%{#v.isChecked?'是':'否'}"/></td>
                            <td><s:property value="%{#v.checkMethod}"/></td>
                            <td><s:date name="%{#v.checkTime}" format="yyyy/MM/dd HH:mm:ss"/></td>
                            <td><s:property value="%{#t_meeting.grade}"/></td>
                            <td><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.manmalCheckPerson).uname}"/></td>
                            <td><s:date name="%{#v.manmalCheckTime}" format="yyyy/MM/dd HH:mm:ss"/></td>
                        </tr>
                    </s:iterator>
                </s:if>
            </table>
            <s:if test="%{#request.list!=null}">
                <div class="line padding">
                    <div class="xm5-move">
                        <div>
                            <ul class="pagination">
                                <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                            </ul>
                            <ul class="pagination pagination-group">
                                <li style="border: 0px;">
                                    <form>
                                        <div class="form-group">
                                            <div class="field">
                                                <input class="input input-auto" size="8" value="1/<%=pg.getTotalPage()%>" id="page-input" >
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
    </div>
</div>
<div id="mydialog">
    <div class="dialog">
        <div class="dialog-head">
            <span class="close rotate-hover"></span><strong>人工签到</strong>
        </div>
        <div class="dialog-body">
            <div>
                <strong>签到类型</strong>
                <select class="input checkType">
                    <option>指纹模糊</option>
                    <option>未按规定日期参加例会</option>
                    <option>特殊情况</option>
                    <option>补会</option>
                    <option>迟到</option>
                    <option>收卡</option>
                </select>
                <strong>签到时间</strong>
                <input class="datepick input checkTime"/>
                <strong>签到方式</strong>
                <select class="input checkClass">
                    <option>手动</option>
                </select>
            </div>
        </div>
        <div class="dialog-foot">
            <button class="button dialog-close"> 取消</button>
            <button class="button bg-green" onclick="add1()">添加</button>
        </div>
    </div>
</div>
<form action="/DZOMS/common/selectToList2" class="form-inline" method="post" name="vehicleSele">
    <s:hidden name="condition"></s:hidden>
    <s:hidden name="column"></s:hidden>
    <s:hidden name="url"></s:hidden>
    <s:hidden name="dept" value="%{#parameters.dept}"></s:hidden>
    <s:hidden name="licenseNum" value="%{#parameters.licenseNum}"></s:hidden>
    <s:hidden name="meetingId" value="%{#parameters.meetingId}"></s:hidden>
    <s:hidden name="filter" value="%{#parameters.filter}"></s:hidden>
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"></script>
<script>
    $(function () {
        $showdialogs = function (e) {
            var trigger = e.attr("data-toggle");
            var getid = e.attr("data-target");
            var data = e.attr("data-url");
            var mask = e.attr("data-mask");
            var width = e.attr("data-width");
            var detail = "";
            var masklayout = $('<div class="dialog-mask"></div>');
            if (width == null) {
                width = "80%";
            }

            if (mask == "1") {
                $("body").append(masklayout);
            }
            detail = '<div class="dialog-win" style="position:fixed;width:' + width + ';z-index:11;">';
            if (getid != null) {
                detail = detail + $(getid).html();
            }
            if (data != null) {
                detail = detail + $.ajax({url: data, async: false}).responseText;
            }
            detail = detail + '</div>';

            var win = $(detail);
            win.find(".dialog").addClass("open");
            $("body").append(win);
            var x = parseInt($(window).width() - win.outerWidth()) / 2;

            if (use_tr_pos) {
                var y = parseInt($("input:checked").offset().top);
                use_tr_pos = false;
            } else {
                var y = parseInt(e.offset().top);
            }

            if (y <= 10) {
                y = "10"
            }
            win.css({"left": x, "top": y});
            win.find(".dialog-close,.close").each(function () {
                $(this).click(function () {
                    win.remove();
                    $('.dialog-mask').remove();
                });
            });
            masklayout.click(function () {
                win.remove();
                $(this).remove();
            });

            $('.datepick').datetimepicker({
                lang: "ch",           //语言选择中文
                format: "Y/m/d H:i",      //格式化日期

                yearStart: 2000,     //设置最小年份
                yearEnd: 2050,        //设置最大年份
                //todayButton:false    //关闭选择今天按钮
            });
        };
    });
</script>
</html>