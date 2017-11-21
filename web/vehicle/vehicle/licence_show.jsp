<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>

<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>
        查看牌照
    </title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>


    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.datetimepicker.js" ></script>
    <script src="/DZOMS/res/js/fileUpload.js"></script>
    <style>
        .label{
            text-align: right;
        }
    </style>

    <style type="text/css">
        #preview{width:400px;height:250px;border:1px solid #000;overflow:hidden;}
        #imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $('input[name="vehicle.isNewLicense"]').click(function(){
                var val = $(this).val();
                if(val=='true'){
                    $("#licenseTypeLabel").text("拍卖号");
                }else{
                    $("#licenseTypeLabel").text("原车牌号");
                }
            });
        });
    </script>

    <jsp:include page="/common/msg_info.jsp"></jsp:include>

</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">

        <li>车辆管理</li>
        <li>查看</li>
        <li>查看牌照信息</li>
    </ul>
</div>
<div class="panel">
    <div class="panel-head">
        查看牌照信息
    </div>
    <div class="panel-body">
        <form class="form-x" method="post" action="/DZOMS/vehicle/licence_add">
            <input type="hidden" name="url" value="/vehicle/vehicle/licence_add.jsp" />
            <table class="table">
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    车架号
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" id="carframe_num" theme="simple" name="vehicle.carframeNum" ></s:textfield>
                            </div>
                        </div>
                    </td>
                    <td>
                        <strong>车体照片</strong>
                    </td>
                    <td rowspan="9">
                        <div id="preview">
                            <img id="imghead" src="/DZOMS/data/vehicle/<s:property value="vehicle.carframeNum"/>/license.jpg" width="400" height="250" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    登记证书号
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" name="vehicle.licenseRegNum" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    行驶证注册日期
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" name="vehicle.licenseNumRegDate" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <s:radio name="vehicle.isNewLicense" list="#{'true':'拍卖','false':'更新'}"/>

                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label id="licenseTypeLabel">
                                    拍卖号
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" name="vehicle.licensePurseNum"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <!--<tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    旧车牌号
                                </label>
                            </div>
                            <div class="field">
                                <input class="input" name="vehicle.">
                            </div>
                        </div>
                    </td>
                </tr>-->
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    新车牌号
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" name="vehicle.licenseNum" />
                            </div>
                        </div>
                    </td>
                </tr>
                <!--<tr>
                    <td style="text-align: center">
                        <input type="radio" name="dy">抵押
                        <input type="radio" name="dy">不抵押
                    </td>
                </tr>-->
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label>
                                    登记人
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',vehicle.licenseRegister).uname}" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td> <div class="form-group">
                        <div class="label padding">
                            <label>
                                登记时间
                            </label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input" readonly="true" name="vehicle.licenseRegistTime" />
                        </div>
                    </div>

                    </td>
                </tr>

            </table>
        </form>
    </div>
</div>

<div>
    <script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</div>


</body>
</html>
