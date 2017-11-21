<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%><!DOCTYPE html>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.dz.common.other.*" %>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>
        新增牌照
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
        function previewImage()
        {
            loadTempPicture($('[name="photo"]'),$('#imghead'));
        }

        function deleimage(){
            $("input[name='photo']").val("");
            $("#imghead").attr("src","");
        }

        var actionName = '${actionName}';

        $(document).ready(function(){
            $('input[name="vehicle.isNewLicense"]').click(function(){
                var val = $(this).val();
                if(val=='true'){
                    $("#licenseTypeLabel").text("拍卖号");
                }else{
                    $("#licenseTypeLabel").text("原车牌号");
                    $('input[name="vehicle.licensePurseNum"]').val('黑A');
                }
            });

            if(!actionName.contains("ObjectAccess")){
                $('input[name="vehicle.licensePurseNum"]').val('黑A');
            }else{
                if('true'=='${bean[0].isNewLicense}'){
                    $("#licenseTypeLabel").text("拍卖号");
                }
            }

        });
    </script>

    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
    <script>
        $(document).ready(function(){
            $("#carframe_num").bigAutocomplete({
                url:"/DZOMS/select/VehicleBycarframeNum",
                condition:"licenseRegNum is null",
                callback:function(){
                    $("#imghead").attr("src","/DZOMS/data/vehicle/"+$("#carframe_num").val()+"/license.jpg");
                }
            });
        });
    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">

        <li>车辆管理</li>
        <li>新增</li>
        <li>新增牌照信息</li>
    </ul>
</div>
<div class="alert alert-yellow padding">
    <span class="close rotate-hover"></span><strong>注意：</strong>录入牌照信息前需要录入保险信息。
</div>
<div class="panel xm10 xm1-move">

    <div class="panel-head">
        新增牌照信息
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
                                <s:textfield cssClass="input" id="carframe_num" theme="simple" name="vehicle.carframeNum" value="%{bean[0].carframeNum}" data-validate="required:必填" ></s:textfield>
                            </div>
                        </div>
                    </td>
                    <td>
                        <strong>车体照片</strong>
                    </td>
                    <td rowspan="9">
                        <div id="preview">
                            <img id="imghead" src="/DZOMS/data/vehicle/${bean[0].carframeNum}/license.jpg" width="400" height="250" />
                        </div>
                        <div class="line">
                            <div class="xm3 padding" id="vehicleimage">
                                <a class="button input-file addbtn1" href="javascript:void(0);">
                                    + 上传
                                    <input class="dz-file" name="photo" data-target=".addbtn1" sessuss-function="previewImage();">
                                </a>
                            </div>
                            <div class="xm1 padding">
                                <input type="button" class="button" onclick="deleimage()" value="清除">
                            </div>
                        </div>


                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding" style="width: 40%;">
                                <label>
                                    登记证书号
                                </label>
                            </div>
                            <div class="field" style="width: 60%;">
                                <s:textfield cssClass="input" name="vehicle.licenseRegNum" value="%{bean[0].licenseRegNum}" data-validate="required:必填"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding" style="width: 40%;">
                                <label>
                                    行驶证注册日期
                                </label>
                            </div>
                            <div class="field" style="width: 60%;">
                                <s:textfield cssClass="input datepick" name="vehicle.licenseNumRegDate" data-validate="required:必填">
                                    <s:param name="value">
                                        <s:date name="%{bean[0].licenseNumRegDate}" format="yyyy/MM/dd"></s:date>
                                    </s:param>
                                </s:textfield>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center">
                        <s:if test="%{bean==null||bean[0]==null}">
                            <s:radio name="vehicle.isNewLicense" list="#{'true':'拍卖','false':'更新'}" value="false"/>
                        </s:if>
                        <s:else>
                            <s:radio name="vehicle.isNewLicense" list="#{'true':'拍卖','false':'更新'}" value="%{bean[0].isNewLicense}"/>
                        </s:else>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <div class="label padding">
                                <label id="licenseTypeLabel">
                                    原车牌号
                                </label>
                            </div>
                            <div class="field">
                                <s:textfield cssClass="input" name="vehicle.licensePurseNum" value="%{bean[0].licensePurseNum}"  data-validate="required:必填" />
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
                                <s:if test="%{bean==null||bean[0]==null}">
                                    <s:textfield cssClass="input" name="vehicle.licenseNum" value="黑A" data-validate="required:必填"/>
                                </s:if>
                                <s:else>
                                    <s:textfield cssClass="input" name="vehicle.licenseNum" value="%{bean[0].licenseNum}" data-validate="required:必填"/>
                                </s:else>
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
                                <s:textfield cssClass="input" readonly="true" value="%{#session.user.uname}" />
                                <s:hidden name="vehicle.licenseRegister" value="%{#session.user.uid}"/>
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
                            <input class="input" readonly="readonly" name="vehicle.licenseRegistTime"
                                   value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
                        </div>
                    </div>

                    </td>
                </tr>
                <tr>
                    <td class="tableleft"></td>
                    <td colspan="2">
                        <input type="submit" class="button bg-main" value="提交">
                        <input type="button" name="backid" class="button"
                               id="backid" onclick="location.href='#'" value="取消">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<div class="line">
    <%
        List<License> list = ObjectAccess.query(License.class, " state=0 ");
        request.setAttribute("list", list);
    %>
    <s:if test="%{#request.list!=null&&#request.list.size()>0}">
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <th class="carframeNum			selected_able">车架号			</th>
                <th class="licenseRegNum		selected_able">登记证书号		</th>
                <th class="licenseNumRegDate	selected_able">行驶证注册日期	</th>
                <th class="isNewLicense			selected_able">领取方式			</th>
                <th class="licensePurseNum		selected_able">拍卖号/原车牌号	</th>
                <th class="licenseNum			selected_able">新车牌号			</th>
                <th class="licenseRegister 		selected_able">登记人			</th>
                <th class="licenseRegistTime 	selected_able">登记时间			</th>
                <th class="modify selected_able">修改</th>
                <th class="delete selected_able">删除</th>
            </tr>
            <s:iterator value="%{#request.list}" var="v">
                <tr>
                    <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
                    <td class="licenseRegNum selected_able"><s:property value="%{#v.licenseRegNum}"/></td>
                    <td class="licenseNumRegDate selected_able"><s:property value="%{#v.licenseNumRegDate}"/></td>
                    <td class="isNewLicense selected_able"><s:property value="%{#v.isNewLicense?'拍卖':'更新'}"/></td>
                    <td class="licensePurseNum selected_able"><s:property value="%{#v.licensePurseNum}"/></td>
                    <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                    <td class="licenseRegister selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.licenseRegister).uname}"/></td>
                    <td class="licenseRegistTime selected_able"><s:property value="%{#v.licenseRegistTime}"/></td>
                    <td class="modify selected_able"><a href="javascript:modifyV('<s:property value="%{#v.carframeNum}"/>')">修改</a></td>
                    <td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.carframeNum}"/>')">删除</a></td>
                </tr>
            </s:iterator>
        </table>

        <div class="xm9-move xm2">
            <form action="/DZOMS/vehicle/licence_relook" method="post">
                <input type="hidden" name="url" value="/vehicle/vehicle/licence_add.jsp"/>
                <input type="submit" value="全部通过" class="button bg-green" />
            </form>
        </div>
    </s:if>
</div>

<form action="/DZOMS/vehicle/licence_delete" method="post">
    <input type="hidden" name="url" value="/vehicle/vehicle/licence_add.jsp"/>
    <input type="hidden" name="vehicle.carframeNum" />
    <input type="submit" style="display: none;" id="del_but" />
</form>

<form action="/DZOMS/common/getObj" method="post">
    <input type="hidden" name="url" value="/vehicle/vehicle/licence_add.jsp"/>
    <input type="hidden" name="ids[0].className" value="com.dz.module.vehicle.License" />
    <input type="hidden" name="ids[0].id" />
    <input type="hidden" name="ids[0].isString" value="true" />
    <input type="submit" style="display: none;" id="modify_but" />
</form>
<script>
    function deleteV(cid){
        $('input[name="vehicle.carframeNum"]').val(cid);
        if (confirm("确认删除车架号为"+cid+"的发票信息？")) {
            $("#del_but").click();
        }
    }

    function modifyV(cid){
        $('input[name="ids[0].id"]').val(cid);
        $("#modify_but").click();
    }
</script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
</body>
</html>
