<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@page language="java" import="java.util.*" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
    <meta charset="utf-8">

    <!-- DNS prefetch -->

    <!-- Use the .htaccess and remove these lines to avoid edge case issues.
   More info: h5bp.com/b/378 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>Table :: Grape - Professional &amp; Flexible Admin Template</title>
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Mobile viewport optimized: j.mp/bplateviewport -->
    <meta name="viewport" content="width=device-width,initial-scale=1">

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory: mathiasbynens.be/notes/touch-icons -->

    <!-- CSS: implied media=all -->
    <!-- CSS concatenated and minified via ant build script-->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/style.css">
    <!-- Generic style (Boilerplate) -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/960.fluid.css">
    <!-- 960.gs Grid System -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/main.css">
    <!-- Complete Layout and main styles -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/buttons.css">
    <!-- Buttons, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/lists.css">
    <!-- Lists, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/icons.css">
    <!-- Icons, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/notifications.css">
    <!-- Notifications, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/typography.css">
    <!-- Typography -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/forms.css">
    <!-- Forms, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/tables.css">
    <!-- Tables, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/charts.css">
    <!-- Charts, optional -->
    <link rel="stylesheet" href="/DZOMS/res/mainPage/css/jquery-ui-1.8.15.custom.css">
    <!-- jQuery UI, optional -->
    <!-- end CSS-->

    <!-- Fonts -->

    <!-- end Fonts-->

    <!-- More ideas for your <head> here: h5bp.com/d/head-Tips -->

    <!-- All JavaScript at the bottom, except for Modernizr / Respond.
   Modernizr enables HTML5 elements & feature detects; Respond is a polyfill for min/max-width CSS3 Media Queries
   For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->
    <script src="/DZOMS/res/mainPage/js/libs/modernizr-2.0.6.min.js"></script>
    <style type="text/css">
        #CalendarMain {
            width: 300px;
            height: 300px;
            border: 1px solid #ccc;
            margin: 0 auto;
            margin-top: 100px;
        }

        #title {
            width: 100%;
            height: 30px;
            background-color: #b9121b;
        }

        .selectBtn {
            font-weight: 900;
            font-size: 15px;
            color: #fff;
            cursor: pointer;
            text-decoration: none;
            padding: 7px 10px 6px 10px;
        }

        .selectBtn:hover {
            background-color: #1d953f;
        }

        .selectYear {
            float: left;
            margin-left: 50px;
            position: absolute;
        }

        .selectMonth {
            float: left;
            margin-left: 120px;
            position: absolute;
        }

        .month {
            float: left;
            position: absolute;
        }

        .nextMonth {
            float: right;
        }

        .currentDay {
            float: right;
        }

        #context {
            background-color: #fff;
            width: 100%;
        }

        .week {
            width: 100%;
            height: 30px;
        }

        .week > h3 {
            float: left;
            color: #808080;
            text-align: center;
            margin: 0;
            padding: 0;
            margin-top: 5px;
            font-size: 16px;
        }

        .dayItem {
            float: left;
        }

        .lastItem {
            color: #d1c7b7 !important;
        }

        .item {
            color: #333;
            float: left;
            text-align: center;
            cursor: pointer;
            margin: 0;
            font-family: "微软雅黑";
            font-size: 13px;
        }

        .item:hover {
            color: #b9121b;
        }

        .currentItem > a {
            background-color: #b9121b;
            width: 25px;
            line-height: 25px;
            float: left;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            color: #fff;
        }

        #foots {
            width: 100%;
            height: 35px;
            background-color: #fff;
            border-top: 1px solid #ccc;
            margin-top: -1px;
        }

        #footNow {
            float: right;
            margin: 6px 15px 0 0;
            color: #009ad6;
            font-family: "微软雅黑";
        }

        #Container {
            overflow: hidden;
            float: left;
        }

        #center {
            width: 100%;
            overflow: hidden;
        }

        #centerMain {
            width: 300%;
            margin-left: -100%;
        }

        #selectYearDiv {
            float: left;
            background-color: #fff;
        }

        #selectYearDiv > div {
            float: left;
            text-align: center;
            font-family: "微软雅黑";
            font-size: 16px;
            border: 1px solid #ccc;
            margin-left: -1px;
            margin-top: -1px;
            cursor: pointer;
            color: #909090;
        }

        .currentYearSd,
        .currentMontSd {
            color: #ff4400 !important;
        }

        #selectMonthDiv {
            float: left;
            background-color: #fff;
        }

        #selectMonthDiv > div {
            color: #909090;
            float: left;
            text-align: center;
            font-family: "微软雅黑";
            font-size: 16px;
            border: 1px solid #ccc;
            margin-left: -1px;
            margin-top: -1px;
            cursor: pointer;
        }

        #selectYearDiv > div:hover,
        #selectMonthDiv > div:hover {
            background-color: #efefef;
        }

        #centerCalendarMain {
            float: left;
        }
    </style>
    <script type="text/javascript">
        function startTime() {
            var today = new Date()
            var y = today.getYear() + 1900;
            var mon = today.getMonth() + 1;
            var d = today.getDate();
            var h = today.getHours()
            var m = today.getMinutes()
            var s = today.getSeconds()
            var myweekday = today.getDay();
            if (myweekday == 0)
                weekday = " 星期日 ";
            else if (myweekday == 1)
                weekday = " 星期一 ";
            else if (myweekday == 2)
                weekday = " 星期二 ";
            else if (myweekday == 3)
                weekday = " 星期三 ";
            else if (myweekday == 4)
                weekday = " 星期四 ";
            else if (myweekday == 5)
                weekday = " 星期五 ";
            else if (myweekday == 6)
                weekday = " 星期六 ";
            // add a zero in front of numbers<10
            m = checkTime(m)
            s = checkTime(s)
            document.getElementById('time').innerHTML = "时间：" + h + ":" + m + ":" + s
            document.getElementById('data').innerHTML = "日期：" + y + "年" + mon + "月" + d + "日   " + weekday;
            t = setTimeout('startTime()', 500)
        }

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i
            }
            return i
        }
    </script>
</head>

<body id="top" onload="startTime()">

<!-- Begin of #container -->
<div id="container">

    <div class="container_12">
        <div class="grid_3">
            <!--公共信息-->
            <div class="block-border">
                <div class="block-header">
                    <h1>公共信息</h1>
                </div>
                <div class="block-content">
                    <table class="table" style="font-size: larger;">
                        <tr>
                            <td id="data"></td>
                        </tr>
                        <tr>
                            <td id="time">时间：</td>
                        </tr>
                        <tr>
                            <td id="weather">天气：</td>
                        </tr>
                        <tr>
                            <td id="temperature">温度：</td>
                        </tr>

                    </table>
                </div>

            </div>
            <!--个人信息-->
            <div class="block-border">
                <div class="block-header">
                    <h1>个人信息</h1>
                </div>
                <div class="block-content">
                    <table class="table" style="font-size: larger;">
                        <tr>
                            <td>姓名：<s:property value="%{#session.user.uname}"/></td>
                        </tr>
                        <tr>
                            <td>部门：<s:property value="%{#session.user.department}"/></td>
                        </tr>
                        <tr>
                            <td>职务：<s:property value="%{#session.user.position}"/></td>
                        </tr>


                        <tr>
                            <td><a href="data/interiorPhone.html">管理员通讯录</a></td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--系统信息-->
            <div class="block-border">
                <div class="block-header">
                    <h1>系统信息</h1>
                </div>
                <div class="block-content">
                    <table class="table" style="font-size: larger;">
                        <tr>
                            <td>系统更新时间：</td>
                            <td>2018年11月2日</td>
                        </tr>
                        <tr>
                            <td>系统版本号：</td>
                            <td>1.5.Final</td>
                        </tr>
                        <tr>
                            <td><a href="data/changelog.html" target="_blank">系统说明文档</a></td>
                            <td></td>
                        </tr>

                        </tr>
                    </table>

                </div>
            </div>
        </div>
        <div class="grid_6">

            <div class="grid_5">
                <div class="block-border">
                    <div class="block-header">
                        <h1>流程审批</h1>
                    </div>
                    <div class="block-content">
                        <table class="table" id="wait_deal" style="font-size: larger;">

                            <tr>
                                <td>新车办理</td>
                                <%
                                    request.setAttribute("new_car_approve_hql", "select count(*) from VehicleApproval where checkType=0 and contractId in (select id from Contract where contractFrom is null) and state!=8 ");
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.new_car_approve_hql)}"/></td>
                            </tr>

                            <tr>
                                <td>转包办理</td>
                                <%
                                    request.setAttribute("re_car_approve_hql", "select count(*) from VehicleApproval where checkType=0 and contractId in (select id from Contract where contractFrom is not null) and state!=8 ");
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.re_car_approve_hql)}"/></td>
                            </tr>
                            <tr>
                                <td>废业办理</td>
                                <%
                                    request.setAttribute("dis_car_approve_hql", "select count(*) from VehicleApproval where checkType=1 and state!=8 ");
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.dis_car_approve_hql)}"/></td>

                            </tr>

                        </table>
                    </div>
                </div>
            </div>

            <!--待办事项-->
            <div class="grid_7">
                <div class="block-border">
                    <div class="block-header">
                        <h1>待办事项</h1>
                    </div>
                    <div class="block-content">
                        <table class="table" id="wait_deal" style="font-size: larger;">

                            <tr>
                                <td>合同到期</td>
                                <%
                                    Date now = new Date();
                                    int year = now.getYear() + 1900;
                                    int month = now.getMonth() + 1;
                                    int date = now.getDate();
                                    String abandoned_car_a_month_hql = "select count(*) from Contract where state in (0,-1) and ( (abandonedTime is null and contractEndDate >= STR_TO_DATE('" + year + "-" + month + "-01','%Y-%m-%d') " +
                                            " and contractEndDate < STR_TO_DATE('" + year + "-" + (month + 1) + "-01','%Y-%m-%d') )" +
                                            " or ( abandonedTime is not null " +
                                            " and abandonedTime >= STR_TO_DATE('" + year + "-" + month + "-01','%Y-%m-%d') " +
                                            " and abandonedTime < STR_TO_DATE('" + year + "-" + (month + 1) + "-01','%Y-%m-%d') ) )";
                                    request.setAttribute("abandoned_car_a_month_hql", abandoned_car_a_month_hql);
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.abandoned_car_a_month_hql)}"/></td>
                                <td>待处理</td>
                                <%
                                    String abandoned_car_a_month_wait_deal_hql = abandoned_car_a_month_hql + " and id not in (select contractId from VehicleApproval where checkType=1)";
                                    request.setAttribute("abandoned_car_a_month_wait_deal_hql", abandoned_car_a_month_wait_deal_hql);
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.abandoned_car_a_month_wait_deal_hql)}"/></td>
                            </tr>
                            <tr>
                                <td>服务投诉</td>
                                <%
                                    String complain_count_hql = "select count(*) from Complain ";
                                    request.setAttribute("complain_count_hql", complain_count_hql);
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.complain_count_hql)}"/></td>
                                <td>待处理</td>
                                <%
                                    String complain_count_wait_deal_hql = "select count(*) from Complain where state not in (-1,4) ";
                                    request.setAttribute("complain_count_wait_deal_hql", complain_count_wait_deal_hql);
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.complain_count_wait_deal_hql)}"/></td>
                            </tr>
                            <tr>
                                <td>交通事故</td>
                                <%
                                    String accident_count_hql = "select count(*) from Accident ";
                                    request.setAttribute("accident_count_hql", accident_count_hql);
                                %>
                                <td><s:property
                                        value="%{@com.dz.common.other.ObjectAccess@execute(#request.accident_count_hql)}"/></td>
										<%--<%--%>
											<%--String electric_count_hql = "select count(*) from ElectricHistory ";--%>
											<%--request.setAttribute("electric_count_hql",electric_count_hql);--%>
										 <%--%>--%>
										<%--<td><s:property value="%{@com.dz.common.other.ObjectAccess@execute(#request.electric_count_hql)}"/></td>--%>
                            </tr>
									</tr>

                            <!-- <tr>
                                <td>电子违章</td>
                                <td>5</td>
                                <td>待处理</td>
                                <td>3</td>
                            </tr>  -->

                        </table>
                    </div>
                </div>
            </div>

            <div class="grid_12">
                <!--数据分析-->
                <div class="block-border" id="tab-graph">
                    <div class="block-header">
                        <h1>统计分析</h1>
                        <ul class="tabs">
                            <li><a href="#tab-line">条形图</a></li>
                            <li><a href="#tab-area">面积图</a></li>
                            <li><a href="#tab-pie">饼状图</a></li>
                            <li><a href="#tab-bar">柱形图</a></li>
                        </ul>
                    </div>
                    <div class="block-content tab-container">
                        <table id="graph-data" class="graph">
                            <caption>2018电子违章走势</caption>
                            <thead>
                            <tr>
                                <td></td>
                                <th scope="col">1月</th>
                                <th scope="col">2月</th>
                                <th scope="col">3月</th>
                                <th scope="col">4月</th>
                                <th scope="col">5月</th>
                                <th scope="col">6月</th>
                                <th scope="col">7月</th>
                                <th scope="col">8月</th>
                                <th scope="col">9月</th>
                                <th scope="col">10月</th>
                                <th scope="col">11月</th>
                                <th scope="col">12月</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">一部</th>
                                <td>155</td>
                                <td>92</td>
                                <td>89</td>
                                <td>67</td>
                                <td>45</td>
                                <td>71</td>
                                <td>85</td>
                                <td>78</td>
                                <td>89</td>
                                <td>81</td>
                            </tr>
                            <tr>
                                <th scope="row">二部</th>
                                <td>131</td>
                                <td>99</td>
                                <td>91</td>
                                <td>49</td>
                                <td>45</td>
                                <td>53</td>
                                <td>77</td>
                                <td>110</td>
                                <td>122</td>
                                <td>67</td>
                            </tr>
                            <tr>
                                <th scope="row">三部</th>
                                <td>137</td>
                                <td>94</td>
                                <td>87</td>
                                <td>40</td>
                                <td>47</td>
                                <td>60</td>
                                <td>86</td>
                                <td>65</td>
                                <td>99</td>
                                <td>74</td>
                            </tr>

                            <!--<tr>
                                <th scope="row">Kate</th>
                                <td>40</td>
                                <td>80</td>
                                <td>90</td>
                                <td>25</td>
                                <td>15</td>
                                <td>119</td>
                            </tr>-->
                            </tbody>
                        </table>

                        <div id="tab-line" class="tab-content"></div>
                        <div id="tab-area" class="tab-content"></div>
                        <div id="tab-pie" class="tab-content"></div>
                        <div id="tab-bar" class="tab-content"></div>

                    </div>
                </div>
            </div>
        </div>

        <div class="grid_3">
            <!--运营数据-->
            <div class="block-border">
                <div class="block-header">
                    <h1>运营数据</h1>
                </div>
                <div class="block-content">
                    <table class="table" id="wait_deal" style="font-size: larger;">

                        <tr>
                            <td>单车平均行驶里程</td>
                            <td>405公里</td>

                        </tr>
                        <tr>
                            <td>单车平均运营收益</td>
                            <td>405元</td>

                        </tr>
                        <tr>
                            <td>单车平均运营单次</td>
                            <td>40单</td>
                        </tr>
                        <tr>
                            <td>单车平均运营单次</td>
                            <td>40单</td>
                        </tr>

                    </table>
                </div>
            </div>
            <!--基础信息-->
            <div class="block-border">
                <div class="block-header">
                    <h1>基础信息</h1>
                </div>
                <div class="block-content">
                    <table class="table" id="wait_deal" style="font-size: larger;">

                        <tr>
                            <td>在籍车辆</td>
                            <%
                                String vehicle_count_hql = "select count(*) from Vehicle where state=1 or state=3 ";
                                request.setAttribute("vehicle_count_hql", vehicle_count_hql);
                            %>
                            <td><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@execute(#request.vehicle_count_hql)}"/></td>
                        </tr>
                        <tr>
                            <td>报废车辆</td>
                            <%
                                String unVehicle_count_hql = "select count(*) from Vehicle where state=2";
                                request.setAttribute("unVehicle_count_hql", unVehicle_count_hql);
                            %>
                            <td><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@execute(#request.unVehicle_count_hql)}"/></td>
                        </tr>
                        <tr>
                            <td>在籍驾驶员</td>
                            <%
                                String driver_count_hql = "select count(*) from Driver where isInCar=true ";
                                request.setAttribute("driver_count_hql", driver_count_hql);
                            %>
                            <td><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@execute(#request.driver_count_hql)}"/></td>
                        </tr>
                        <tr>
                            <td>离职驾驶员</td>
                            <%
                                String unDriver_count_hql = "select count(*) from Driver where isInCar=false ";
                                request.setAttribute("unDriver_count_hql", unDriver_count_hql);
                            %>
                            <td><s:property
                                    value="%{@com.dz.common.other.ObjectAccess@execute(#request.unDriver_count_hql)}"/></td>

                    </table>
                </div>
            </div>

            <!--个人效绩-->
            <div class="grid_12">
                <div class="block-border">
                    <div class="block-header">
                        <h1>个人效绩</h1>
                    </div>
                    <div class="block-content">
                        <table class="table" id="wait_deal" style="font-size: larger;">


                            <tr>
                                <td> <a href="ky/duty/TZListHistory">个人绩效考评</a></td>
                            </tr>
                            <tr>
                                <td> <a href="ky/duty/listduty">个人工作职责</a></td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
            <!--<p><a href="javascript:void(0);" id="notification-information" class="button" style="width: 150px; text-align: center;">Information Notification</a></p>-->
            <!--日历-->
            <!--<div class="block-border">
            <div class="block-header">
                <h1>日历</h1><span></span>
            </div>
            <div class="block-content">
                 <div id="Demo">
          <div id="CalendarMain" style="margin-top: 0px;">
              <div id="title"> <a class="selectBtn month" href="javascript:" onClick="CalendarHandler.CalculateLastMonthDays();"><</a><a class="selectBtn selectYear" href="javascript:" onClick="CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart);">2014年</a><a class="selectBtn selectMonth" onClick="CalendarHandler.CreateSelectMonth()">6月</a> <a class="selectBtn nextMonth" href="javascript:" onClick="CalendarHandler.CalculateNextMonthDays();">></a><a class="selectBtn currentDay" href="javascript:" onClick="CalendarHandler.CreateCurrentCalendar(0,0,0);">今天</a></div>
                   <div id="context">
                       <div class="week">
                             <h3> 一 </h3>
                             <h3> 二 </h3>
                             <h3> 三 </h3>
                             <h3> 四 </h3>
                             <h3> 五 </h3>
                             <h3> 六 </h3>
                             <h3> 日 </h3>
                        </div>
                        <div id="center">
                            <div id="centerMain">
                                 <div id="selectYearDiv"></div>
                                 <div id="centerCalendarMain">
                                          <div id="Container"></div>
                                 </div>
                                 <div id="selectMonthDiv"></div>
                            </div>
                        </div>
                        <div id="foots"><a id="footNow">19:14:34</a></div>
                    </div>
          </div>
            </div>
        </div>
    </div>-->
        </div>

        <!--<div class="grid_12">

        <div class="block-border" id="tab-graph1">
            <div class="block-header">
                <h1>统计分析</h1>
                <ul class="tabs">
                    <li><a href="#tab-line1">条形图</a></li>
                    <li><a href="#tab-area1">面积图</a></li>
                    <li><a href="#tab-pie1">饼状图</a></li>
                    <li><a href="#tab-bar1">柱形图</a></li>
                </ul>
            </div>
            <div class="block-content tab-container">
                <table id="graph-data1" class="graph">
                        <caption>2015XX分析</caption>
                        <thead>
                            <tr>
                                <td></td>
                                <th scope="col">一月</th>
                                <th scope="col">二月</th>
                                <th scope="col">三月</th>
                                <th scope="col">四月</th>
                                <th scope="col">五月</th>
                                <th scope="col">六月</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">Mary</th>
                                <td>190</td>
                                <td>160</td>
                                <td>40</td>
                                <td>120</td>
                                <td>30</td>
                                <td>70</td>
                            </tr>
                            <tr>
                                <th scope="row">Tom</th>
                                <td>3</td>
                                <td>40</td>
                                <td>30</td>
                                <td>45</td>
                                <td>35</td>
                                <td>49</td>
                            </tr>
                            <tr>
                                <th scope="row">Brad</th>
                                <td>10</td>
                                <td>180</td>
                                <td>10</td>
                                <td>85</td>
                                <td>25</td>
                                <td>79</td>
                            </tr>
                            <tr>
                                <th scope="row">Kate</th>
                                <td>40</td>
                                <td>80</td>
                                <td>90</td>
                                <td>25</td>
                                <td>15</td>
                                <td>119</td>
                            </tr>
                        </tbody>
                    </table>

                <div id="tab-line1" class="tab-content"></div>
                <div id="tab-area1" class="tab-content"></div>
                <div id="tab-pie1" class="tab-content"></div>
                <div id="tab-bar1" class="tab-content"></div>


            </div>
        </div>
    </div>-->

    </div>

</div>
<!--! end of #container -->

<!--消息提示-->

<!-- JavaScript at the bottom for fast page loading -->

<!-- Grab Google CDN's jQuery, with a protocol relative URL; fall back to local if offline -->

<!--<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>-->
<script src="/DZOMS/res/mainPage/js/libs/jquery-1.6.2.min.js"></script>
<!-- scripts concatenated and minified via ant build script-->
<script defer src="/DZOMS/res/mainPage/js/plugins.js"></script>
<!-- lightweight wrapper for consolelog, optional -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery-ui-1.8.15.custom.min.js"></script>
<!-- jQuery UI -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.notifications.js"></script>
<!-- Notifications  -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.uniform.min.js"></script>
<!-- Uniform (Look & Feel from forms) -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.validate.min.js"></script>
<!-- Validation from forms -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.dataTables.min.js"></script>
<!-- Tables -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.tipsy.js"></script>
<!-- Tooltips -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/excanvas.js"></script>
<!-- Charts -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.visualize.js"></script>
<!-- Charts -->
<script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.slidernav.min.js"></script>
<!-- Contact List -->
<script defer src="/DZOMS/res/mainPage/js/common.js"></script>
<!-- Generic functions -->
<script defer src="/DZOMS/res/mainPage/js/script.js"></script>
<!-- Generic scripts -->
<script type="text/javascript">
    $().ready(function () {

        /*
         * Charts
         */
        $('#graph-data').visualize({
            type: 'line',
            height: 215
        }).appendTo('#tab-line').trigger('visualizeRefresh');
        $('#graph-data').visualize({
            type: 'area',
            height: 215
        }).appendTo('#tab-area').trigger('visualizeRefresh');
        $('#graph-data').visualize({
            type: 'pie',
            height: 215
        }).appendTo('#tab-pie').trigger('visualizeRefresh');
        $('#graph-data').visualize({
            type: 'bar',
            height: 215
        }).appendTo('#tab-bar').trigger('visualizeRefresh');

        /*
         * Tabs
         */
        $("#specify-a-unique-tab-name").createTabs();
        $("#tab-graph").createTabs();

    });
</script>
<script type="text/javascript">
    $().ready(function () {

        /*
         * Charts
         */
        $('#graph-data1').visualize({
            type: 'line',
            height: 215
        }).appendTo('#tab-line1').trigger('visualizeRefresh');
        $('#graph-data1').visualize({
            type: 'area',
            height: 215
        }).appendTo('#tab-area1').trigger('visualizeRefresh');
        $('#graph-data1').visualize({
            type: 'pie',
            height: 215
        }).appendTo('#tab-pie1').trigger('visualizeRefresh');
        $('#graph-data1').visualize({
            type: 'bar',
            height: 215
        }).appendTo('#tab-bar1').trigger('visualizeRefresh');

        /*
         * Tabs
         */
        $("#specify-a-unique-tab-name").createTabs();
        $("#tab-graph1").createTabs();

    });
</script>

<!-- end scripts-->

<!-- Prompt IE 6 users to install Chrome Frame. Remove this if you want to support IE 6.
chromium.org/developers/how-tos/chrome-frame-getting-started -->
<!--[if lt IE 7 ]>
<script src="/DZOMS/res/mainPage///ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
<script>window.attachEvent('onload', function () {
    CFInstall.check({mode: 'overlay'})
})</script>
<![endif]-->

</body>
<script type="text/javascript">
    $(document).ready(function (e) {
        CalendarHandler.initialize();
    });

    var CalendarHandler = {
        currentYear: 0,
        currentMonth: 0,
        isRunning: false,
        showYearStart: 2009,
        tag: 0,
        initialize: function () {
            $calendarItem = this.CreateCalendar(0, 0, 0);
            $("#Container").append($calendarItem);

            $("#context").css("height", $("#CalendarMain").height() - 65 + "px");
            $("#center").css("height", $("#context").height() - 30 + "px");
            $("#selectYearDiv").css("height", $("#context").height() - 30 + "px").css("width", $("#context").width() + "px");
            $("#selectMonthDiv").css("height", $("#context").height() - 30 + "px").css("width", $("#context").width() + "px");
            $("#centerCalendarMain").css("height", $("#context").height() - 30 + "px").css("width", $("#context").width() + "px");

            $calendarItem.css("height", $("#context").height() - 30 + "px"); //.css("visibility","hidden");
            $("#Container").css("height", "0px").css("width", "0px").css("margin-left", $("#context").width() / 2 + "px").css("margin-top", ($("#context").height() - 30) / 2 + "px");
            $("#Container").animate({
                width: $("#context").width() + "px",
                height: ($("#context").height() - 30) * 2 + "px",
                marginLeft: "0px",
                marginTop: "0px"
            }, 300, function () {
                $calendarItem.css("visibility", "visible");
            });
            $(".dayItem").css("width", $("#context").width() + "px");
            var itemPaddintTop = $(".dayItem").height() / 6;
            $(".item").css({
                "width": $(".week").width() / 7 + "px",
                "line-height": itemPaddintTop + "px",
                "height": itemPaddintTop + "px"
            });
            $(".currentItem>a").css("margin-left", ($(".item").width() - 25) / 2 + "px").css("margin-top", ($(".item").height() - 25) / 2 + "px");
            $(".week>h3").css("width", $(".week").width() / 7 + "px");
            this.RunningTime();
        },
        CreateSelectYear: function (showYearStart) {
            CalendarHandler.showYearStart = showYearStart;
            $(".currentDay").show();
            $("#selectYearDiv").children().remove();
            var yearindex = 0;
            for (var i = showYearStart; i < showYearStart + 12; i++) {
                yearindex++;
                if (i == showYearStart) {
                    $last = $("<div>往前</div>");
                    $("#selectYearDiv").append($last);
                    $last.click(function () {
                        CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart - 10);
                    });
                    continue;
                }
                if (i == showYearStart + 11) {
                    $next = $("<div>往后</div>");
                    $("#selectYearDiv").append($next);
                    $next.click(function () {
                        CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart + 10);
                    });
                    continue;
                }

                if (i == this.currentYear) {
                    $yearItem = $("<div class=\"currentYearSd\" id=\"" + yearindex + "\">" + i + "</div>")

                } else {
                    $yearItem = $("<div id=\"" + yearindex + "\">" + i + "</div>");
                }
                $("#selectYearDiv").append($yearItem);
                $yearItem.click(function () {
                    $calendarItem = CalendarHandler.CreateCalendar(Number($(this).html()), 1, 1);
                    $("#Container").append($calendarItem);
                    CalendarHandler.CSS()
                    CalendarHandler.isRunning = true;
                    $($("#Container").find(".dayItem")[0]).animate({
                        height: "0px"
                    }, 300, function () {
                        $(this).remove();
                        CalendarHandler.isRunning = false;
                    });
                    $("#centerMain").animate({
                        marginLeft: -$("#center").width() + "px"
                    }, 500);
                });
                if (yearindex == 1 || yearindex == 5 || yearindex == 9) $("#selectYearDiv").find("#" + yearindex).css("border-left-color", "#fff");
                if (yearindex == 4 || yearindex == 8 || yearindex == 12) $("#selectYearDiv").find("#" + yearindex).css("border-right-color", "#fff");

            }
            $("#selectYearDiv>div").css("width", ($("#center").width() - 4) / 4 + "px").css("line-height", ($("#center").height() - 4) / 3 + "px");
            $("#centerMain").animate({
                marginLeft: "0px"
            }, 300);
        },
        CreateSelectMonth: function () {
            $(".currentDay").show();
            $("#selectMonthDiv").children().remove();
            for (var i = 1; i < 13; i++) {
                if (i == this.currentMonth) $monthItem = $("<div class=\"currentMontSd\" id=\"" + i + "\">" + i + "月</div>");
                else $monthItem = $("<div id=\"" + i + "\">" + i + "月</div>");
                $("#selectMonthDiv").append($monthItem);
                $monthItem.click(function () {
                    $calendarItem = CalendarHandler.CreateCalendar(CalendarHandler.currentYear, Number($(this).attr("id")), 1);
                    $("#Container").append($calendarItem);
                    CalendarHandler.CSS()
                    CalendarHandler.isRunning = true;
                    $($("#Container").find(".dayItem")[0]).animate({
                        height: "0px"
                    }, 300, function () {
                        $(this).remove();
                        CalendarHandler.isRunning = false;
                    });
                    $("#centerMain").animate({
                        marginLeft: -$("#center").width() + "px"
                    }, 500);
                });
                if (i == 1 || i == 5 || i == 9) $("#selectMonthDiv").find("#" + i).css("border-left-color", "#fff");
                if (i == 4 || i == 8 || i == 12) $("#selectMonthDiv").find("#" + i).css("border-right-color", "#fff");
            }
            $("#selectMonthDiv>div").css("width", ($("#center").width() - 4) / 4 + "px").css("line-height", ($("#center").height() - 4) / 3 + "px");
            $("#centerMain").animate({
                marginLeft: -$("#center").width() * 2 + "px"
            }, 300);
        },
        IsRuiYear: function (aDate) {
            return (0 == aDate % 4 && (aDate % 100 != 0 || aDate % 400 == 0));
        },
        CalculateWeek: function (y, m, d) {
            var arr = "7123456".split("");
            with (document.all) {
                var vYear = parseInt(y, 10);
                var vMonth = parseInt(m, 10);
                var vDay = parseInt(d, 10);
            }
            var week = arr[new Date(y, m - 1, vDay).getDay()];
            return week;
        },
        CalculateMonthDays: function (m, y) {
            var mDay = 0;
            if (m == 0 || m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
                mDay = 31;
            } else {
                if (m == 2) {
                    //判断是否为芮年
                    var isRn = this.IsRuiYear(y);
                    if (isRn == true) {
                        mDay = 29;
                    } else {
                        mDay = 28;
                    }
                } else {
                    mDay = 30;
                }
            }
            return mDay;
        },
        CreateCalendar: function (y, m, d) {
            $dayItem = $("<div class=\"dayItem\"></div>");
            //获取当前月份的天数
            var nowDate = new Date();
            if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1 || (y == 0 && m == 0))
                $(".currentDay").hide();
            var nowYear = y == 0 ? nowDate.getFullYear() : y;
            this.currentYear = nowYear;
            var nowMonth = m == 0 ? nowDate.getMonth() + 1 : m;
            this.currentMonth = nowMonth;
            var nowDay = d == 0 ? nowDate.getDate() : d;
            $(".selectYear").html(nowYear + "年");
            $(".selectMonth").html(nowMonth + "月");
            var nowDaysNub = this.CalculateMonthDays(nowMonth, nowYear);
            //获取当月第一天是星期几
            //var weekDate = new Date(nowYear+"-"+nowMonth+"-"+1);
            //alert(weekDate.getDay());
            var nowWeek = parseInt(this.CalculateWeek(nowYear, nowMonth, 1));
            //nowWeek=weekDate.getDay()==0?7:weekDate.getDay();
            //var nowWeek=weekDate.getDay();
            //获取上个月的天数
            var lastMonthDaysNub = this.CalculateMonthDays((nowMonth - 1), nowYear);

            if (nowWeek != 0) {
                //生成上月剩下的日期
                for (var i = (lastMonthDaysNub - (nowWeek - 1)); i < lastMonthDaysNub; i++) {
                    $dayItem.append("<div class=\"item lastItem\"><a>" + (i + 1) + "</a></div>");
                }
            }

            //生成当月的日期
            for (var i = 0; i < nowDaysNub; i++) {
                if (i == (nowDay - 1)) $dayItem.append("<div class=\"item currentItem\"><a>" + (i + 1) + "</a></div>");
                else $dayItem.append("<div class=\"item\"><a>" + (i + 1) + "</a></div>");
            }

            //获取总共已经生成的天数
            var hasCreateDaysNub = nowWeek + nowDaysNub;
            //如果小于42，往下个月推算
            if (hasCreateDaysNub < 42) {
                for (var i = 0; i <= (42 - hasCreateDaysNub); i++) {
                    $dayItem.append("<div class=\"item lastItem\"><a>" + (i + 1) + "</a></div>");
                }
            }

            return $dayItem;
        },
        CSS: function () {
            var itemPaddintTop = $(".dayItem").height() / 6;
            $(".item").css({
                "width": $(".week").width() / 7 + "px",
                "line-height": itemPaddintTop + "px",
                "height": itemPaddintTop + "px"
            });
            $(".currentItem>a").css("margin-left", ($(".item").width() - 25) / 2 + "px").css("margin-top", ($(".item").height() - 25) / 2 + "px");
        },
        CalculateNextMonthDays: function () {
            if (this.isRunning == false) {
                $(".currentDay").show();
                var m = this.currentMonth == 12 ? 1 : this.currentMonth + 1;
                var y = this.currentMonth == 12 ? (this.currentYear + 1) : this.currentYear;
                var d = 0;
                var nowDate = new Date();
                if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1) d = nowDate.getDate();
                else d = 1;
                $calendarItem = this.CreateCalendar(y, m, d);
                $("#Container").append($calendarItem);

                this.CSS();
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
            }
        },
        CalculateLastMonthDays: function () {
            if (this.isRunning == false) {
                $(".currentDay").show();
                var nowDate = new Date();
                var m = this.currentMonth == 1 ? 12 : this.currentMonth - 1;
                var y = this.currentMonth == 1 ? (this.currentYear - 1) : this.currentYear;
                var d = 0;

                if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1) d = nowDate.getDate();
                else d = 1;
                $calendarItem = this.CreateCalendar(y, m, d);
                $("#Container").append($calendarItem);
                var itemPaddintTop = $(".dayItem").height() / 6;
                this.CSS();
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
            }
        },
        CreateCurrentCalendar: function () {
            if (this.isRunning == false) {
                $(".currentDay").hide();
                $calendarItem = this.CreateCalendar(0, 0, 0);
                $("#Container").append($calendarItem);
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
                this.CSS();
                $("#centerMain").animate({
                    marginLeft: -$("#center").width() + "px"
                }, 500);
            }
        },
        RunningTime: function () {
            var mTiming = setInterval(function () {
                var nowDate = new Date();
                var h = nowDate.getHours() < 10 ? "0" + nowDate.getHours() : nowDate.getHours();
                var m = nowDate.getMinutes() < 10 ? "0" + nowDate.getMinutes() : nowDate.getMinutes();
                var s = nowDate.getSeconds() < 10 ? "0" + nowDate.getSeconds() : nowDate.getSeconds();
                var nowTime = h + ":" + m + ":" + s;
                $("#footNow").html("本地时间 " + nowTime);
            }, 1000);

        }
    }
</script>

<script>
    $(document).ready(function () {
        $.get("http://wthrcdn.etouch.cn/WeatherApi?city=%E5%93%88%E5%B0%94%E6%BB%A8", {}, function (data) {
            //alert(data);
            var $first = $(data).find("forecast weather:first");

            //alert($first.html());

            var dayWeather = $first.find("day type").text() + ' ' + $first.find("day fengxiang").text() + ' ' + $first.find("day fengli").text();

            //alert(dayWeather);

            $("#weather").text("天气： " + dayWeather);

            var high = $first.find("high").text();
            if (high.startsWith("高温")) {
                high = high.substr(2);
            }

            var low = $first.find("low").text();
            if (low.startsWith("低温")) {
                low = low.substr(2);
            }
            var temperature = low + "~" + high;

            $("#temperature").text("温度：" + temperature);
        }, "xml");


    });
</script>

<!--[if IE 7]>
<style type="text/css">
    .menuItem {
        margin-left: -130px;
    }
</style>
<![endif]-->
<script type="text/javascript">

    var msgCount = 0, approvalCount = 0;

    function refreshMsgCount() {
        $.post("/DZOMS/userMessageCount", {}, function (data) {
            try {
                msgCount = parseInt(data);
            } catch (e) {
                msgCount = 0;
            }
//		$('#notification-information').click(function() {
            if (msgCount != 0) {
                $.jGrowl("<a href='/DZOMS/message.jsp' style='color:white' >你好！ 你有 <strong style='color:red'>" + msgCount + "条</strong>信息未阅读！. :-)<br>请尽快查看！</a>", {theme: 'information'});
            }

//		});
        });
    }

    var ck = 0, ct = 0;
    function setApprovalCount() {
        if (ck >= 2 && ct > 0) {
//		$("#approval_count").text(ct);
            $.jGrowl("<a href='/DZOMS/apply_manage/' style='color:white'>你好！ 你有 <strong style='color:red'>" + ct + "条</strong>审批未处理！. :-)<br>请尽快处理！</a>", {theme: 'information'});
        }
    }

    function refreshApprovalCount() {
        ck = 0;
        ct = 0;
        $.post("/DZOMS/common/getWaitDealCount", {waitType: '废业审批'}, function (data) {
            try {
                var c = parseInt(data);
                ct += c;
            } catch (e) {

            }
            ck++;
            setApprovalCount();
        });
        $.post("/DZOMS/common/getWaitDealCount", {waitType: '开业审批'}, function (data) {
            try {
                var c = parseInt(data);
                ct += c;
            } catch (e) {

            }
            ck++;
            setApprovalCount();
        });
    }


    $(document).ready(function () {
        refreshMsgCount();
        refreshApprovalCount();
    });
</script>

</html>