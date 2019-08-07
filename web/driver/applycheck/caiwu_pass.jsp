<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-20
  Time: 上午7:31
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-20
  Time: 上午7:31
  To change this template use File | Settings | File Templates.
--%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>驾驶员</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script src="/DZOMS/res/js/itemtool.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
    <script src="/DZOMS/res/js/window.js"></script>

    <style>
        .my-selected{
            background-color: #56B4DC;
        }
        .input{
            width:60%;
        }

    </style>
    <style>
        .form-x .form-group .label{
            width: 35%;
        }
        .form-x .form-group .field{
            width: 65%;
        }
    </style>

    <script>

        $(document).ready(function(){
            $(".readonly-yes input,.readonly-yes textarea").attr("readonly","readonly");
        });



        function CheckImgExists(imgurl) {
            var ImgObj = new Image(); //判断图片是否存在
            ImgObj.src = imgurl;

            if (ImgObj.fileSize > 0 || (ImgObj.width >0 &&ImgObj.height > 0)){
                return true;
            } else {
                return false;
            }
        }
        $(document).ready(function(){
            $("input,textarea,select").attr('disabled');

            $(".selected-table tr").each(function(){
                if(!$(this).hasClass("unselected-tr")){
                    var $span = $(this).find("span");
                    var $img = $(this).find("img");

                    if(CheckImgExists($img.attr("src"))){
                        $span.removeClass("text-red");
                        $span.removeClass("icon-times");

                        $span.addClass("text-green");
                        $span.addClass("icon-check");
                    }

                }
            });
        });

        function showPic(obj){
            var $img = $(obj).find("img");
            var path = $img.attr("src");

            /*layer.open({
             type:1,
             title:false,
             closeBtn: 0,
             area: '516px',
             skin: 'layui-layer-nobg', //没有背景色
             offset:getPos(obj)-100,
             shadeClose: true,
             content:'<img src="'+path+'"></img>'
             });*/
            var ImgObj = new Image(); //判断图片是否存在
            ImgObj.src = path;

            if (ImgObj.fileSize > 0 || (ImgObj.width >0 &&ImgObj.height > 0)){
                window.open(path,"图片预览",'width='+(ImgObj.width+10)+',height='+(ImgObj.height+10)+',resizable=no,scrollbars=no');
            }else
            {alert("图片不存在！");}

        }
    </script>

<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>驾驶员</li>
            <li>聘用</li>
            <li>聘用审批</li>
        </ul>
    </div>
</div>
<div class="margin panel">
	 <blockquote class="border-main">
            <strong>财务负责人意见</strong>
            <form method="post" action="/DZOMS/driver/driverAppendCaiWu">
                <label>服务保证金</label><s:textfield name="driver.fuwubaozhengjin" readonly="true"/>
                <label style="display: none;">财务负责人意见</label><input type="hidden" name="driver.caiwufuzerenyijian">
                <label>实收金额</label><s:textfield name="deposit.inMoney"/>
                <label>收款时间</label><s:textfield readonly="true"><s:param name="value"><s:date name="%{new java.util.Date()}" format="yyyy-MM-dd"/></s:param> </s:textfield>
                <label>收款人</label><s:textfield value="%{#session.user.uname}" readonly="true"/>
                <label>收据单号</label><s:textfield name="deposit.depositId" />
                <s:hidden value="%{#session.user.uname}" name="driver.caiwufuzeren"/>
                <s:hidden value="%{driver.idNum}" name="driver.idNum"/>
                <input type="submit" class="button bg-main" value="通过">
            </form>
        </blockquote>
	<blockquote class="readonly-yes">
            <strong>
                运营部经理意见
            </strong>
            <label>分数</label><td><s:textfield value="%{driver.score}"/></td>
            <label>运营部经理意见</label><td><s:textfield value="%{driver.bangonshifuzerenyijian}"/></td>
        </blockquote>
       
    <blockquote class="readonly-yes">
        <strong>驾驶员信息</strong>
        <div class="line">

            <div class="xm2 padding">
                <img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/photo.jpg" class="radius img-responsive" id="headimg">

            </div>

            <div class="xm10">
                <form class="form-x" style="width: 100%">
                    <table class="table table-hover">
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            申请事项
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input" name="driver.applyMatter" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            申请时间
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.applyTime" readonly="readonly"></s:textfield>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            车牌号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input" name="driver.applyLicenseNum" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶员姓名
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.name" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶员性别
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  value="%{driver.sex?'男':'女'}"/>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            年龄
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.age" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding" style="width: 25%">
                                        <label>
                                            身份证
                                        </label>
                                    </div>
                                    <div class="field" style="width: 75%">
                                        <s:textfield cssClass="input input-auto" size="20"  name="driver.idNum" cssStyle="width: 100%"/>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            婚姻状况
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  value="%{driver.maritalStatus?'已婚':'未婚'}" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            民族
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input float-left" name="driver.nation" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            户口所在地
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.accountLocation" />
                                    </div>
                                </div>
                            </td>
                            <td colspan="2">
                                <div class="form-group" >
                                    <div class="label padding">
                                        <label>
                                            联系电话
                                        </label>
                                    </div>
                                    <div class="field" style="width: 250px;">

                                        <s:textfield cssClass="input float-left"  name="driver.phoneNum1" cssStyle="width:150px"  />
                                        <s:textfield cssClass="input"  name="driver.phoneNum2" cssStyle="width:100px"/>
                                    </div>
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="3">
                                <div class="form-group">
                                    <div class="label padding" style="width: auto">
                                        <label>
                                            家庭现住址
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.address" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶证号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.drivingLicenseNum" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶证初领日期
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.drivingLicenseDate" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶证类型
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.drivingLicenseType" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            资格证号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.qualificationNum" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            资格证初领日期
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input datepick"  name="driver.qualificationDate"  />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding" style="width: 28%">
                                        <label>
                                            资格证有效日期至
                                        </label>
                                    </div>
                                    <div class="field" style="width: 72%">
                                        <s:textfield cssClass="input datepick"  name="driver.qualificationValidDate" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            银行卡类别
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input float-left" id="cardClass"  name="bankCard.cardClass" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            银行卡号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input" name="bankCard.cardNumber" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶员属性
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input float-left" id="driverClass"  name="driver.driverClass" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            作息时间
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.restTime"/>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            车队
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input float-left" id="driverTeam"  name="driver.team" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            交班地点
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input float-left" id="driverShiftLocation"  name="driver.shiftLocation" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            交班时间
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input timepick"  name="driver.shiftTime"/>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            加油地点
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.fuelLocation" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            营运场站
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.operatingStation" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding" style="width: 35%">
                                        <label>
                                            是否从事过出租车营运

                                        </label>
                                    </div>
                                    <div class="field" style="width: 65%">

                                        <s:textfield cssClass="input float-left" value="%{driver.taxiExperience?'是':'否'}" />


                                        <s:textfield cssClass="input"  name="driver.taxiExperienceYears" placeholder="年" />


                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            原车牌号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.oldLicenseNum" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            原所在公司
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.oldCompany" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            驾驶员身高
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.height" placeholder="cm" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            政治面貌
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.politicalStatus" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            面部有无疤痕
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  value="%{driver.scar?'有':'无'}" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            特长
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.specialty" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            微信号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.qq" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            员工号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.employeeNum" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            指纹编号
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.fingerprintNum" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            星级
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.star" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table class="table">
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            个人简历
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textarea name="driver.resume" cssClass="input" rows="6"></s:textarea>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            兴趣爱好
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textarea name="driver.hobby" cssClass="input" rows="6"></s:textarea>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table class="table">
                        <tr>
                            <td>
                                <div class="panel">
                                    <div class="panel-head">
                                        <strong>家庭成员</strong>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table" id="tb" style="width:100%">
                                            <tr>
                                                <th style="width: 20%">家庭成员</th>
                                                <th style="width: 20%">姓名</th>
                                                <th style="width: 20%">联系电话</th>
                                                <th style="width: 40%">工作单位</th>
                                            </tr>
                                            <s:iterator value="families" var="v">
                                                <tr>
                                                    <td>
                                                        <s:property value='%{#v.role}'/>
                                                    </td>
                                                    <td>
                                                        <s:property value='%{#v.name}'/>
                                                    </td>
                                                    <td>
                                                        <s:property value='%{#v.phoneNum}'/>
                                                    </td>
                                                    <td>
                                                        <s:property value='%{#v.work}'/>
                                                    </td>
                                                </tr>
                                            </s:iterator>
                                        </table>
                                    </div>
                                </div>
                            </td>

                        </tr>
                    </table>
                    <hr class="bg-black">
                    <table class="table">
                        <tr>
                            <td style="width: 70%">
                                <div class="panel">
                                    <div class="panel-head">
                                        <strong>个人档案</strong>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table selected-table">
                                            <tr class="unselected-tr">
                                                <th style="width: 50%">文件类别</th>
                                                <th style="width: 20%">有无文件</th>
                                            </tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>身份证<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_IdCard.jpg"  style="display: none"/></td>
                                                <td><span class="icon icon-times text-red"></span></td>
                                            </tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>驾驶证<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_DriverLicense.jpg" onchange="changeyn(this.files)" style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>从业人员资格证<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_Qualification.jpg"  onchange="changeyn(this.files)" style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>户口本首页<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_Location.jpg" onchange="changeyn(this.files)"  style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>暂住证（呼兰、阿城除外）<img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_TempLocton.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>驾驶员聘用协议<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_EmployContract.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>服务质量承诺书<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_Server.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>个人免冠彩色一寸照<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_photo.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>车体照（四寸）<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_vehicle.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>驾驶员登记表<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_table.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>户口本本人页<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_personal.jpg"   style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                            <tr ondblclick="showPic(this)">
                                                <td>驾驶员表彰证书<img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/P_praise.jpg"    style="display: none"></img></td>
                                                <td><span class="icon icon-times text-red"></span></td></tr>
                                        </table>
                                    </div>
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td style="width: 70%">
                                <div class="panel">
                                    <div class="panel-head">
                                        <strong>现场验车</strong>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table selected-table">
                                            <tr class="unselected-tr">
                                                <th>文件名称</th>
                                            </tr>
                                            <s:iterator value="checkfileFileName" var="name">
                                                <tr ondblclick="showPic(this)"><td>
                                                    <s:property value="#name"/>
                                                    <img  src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/checkfiles/<s:property value="#name"/>" style="display: none"></img>
                                                </td></tr>
                                            </s:iterator>
                                        </table>
                                    </div>
                                </div>
                            </td>
                            <!--<td>
                                <input type="button" value="添加" class="button bg-green"/><br>
                                <input type="button" value="删除" class="button"/>
                            </td>-->
                        </tr>
                    </table>
                    <table class="table">
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            文化程度
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.educationDegree" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            语言表达能力
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.languageAbility" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            健康状况
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input"  name="driver.health" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-group">
                                    <div class="label padding" style="width: 30%">
                                        <label>
                                            对哈市熟悉程度
                                        </label>
                                    </div>
                                    <div class="field" style="width:70%;">
                                        <s:textfield cssClass="input"  name="driver.cityFamiliarty" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            有无前科劣迹
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input" value="%{driver.hasBadRecord?'有':'无'}" />

                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            违章记录
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input" name="driver.breakRecord" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="form-group">
                                    <div class="label padding">
                                        <label>
                                            事故记录
                                        </label>
                                    </div>
                                    <div class="field">
                                        <s:textfield cssClass="input" name="driver.accidentRecord" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </blockquote>
        


    </div>

</div>
</body>
</html>

<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@taglib prefix="s" uri="/struts-tags" %>--%>
<%--<html>--%>
<%--<head>--%>
    <%--<title>Title</title>--%>
    <%--<script src="/DZOMS/res/js/jquery.js"></script>--%>
    <%--<script>--%>
        <%--$(document).ready(function(){--%>
            <%--$("#show_form").submit();--%>
        <%--});--%>
    <%--</script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<form id="show_form" method="post" action="/DZOMS/driver/driverPreshow" target="iframe_show">--%>
    <%--<input type="hidden" name="driver.idNum" value="<s:property value="driver.idNum"/>">--%>
<%--</form>--%>
<%--<iframe id="iframe_show" name="iframe_show" style="width: 100%;height: 100%;">--%>

<%--</iframe>--%>
<%--<form method="post" action="/DZOMS/driver/driverAppendCaiWu">--%>
    <%--<label>服务保证金</label><input name="driver.fuwubaozhengjin">--%>
    <%--<label>财务负责人意见</label><input name="driver.caiwufuzerenyijian">--%>
    <%--<s:hidden value="%{#session.user.uname}" name="driver.caiwufuzeren"/>--%>
    <%--<s:hidden value="%{driver.idNum}" name="driver.idNum"/>--%>
    <%--<input type="submit">--%>
<%--</form>--%>
<%--</body>--%>
<%--</html>--%>
