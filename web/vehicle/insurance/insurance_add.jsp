<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java"
         import="com.dz.common.other.ObjectAccess,com.dz.module.vehicle.Insurance,java.util.List"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>
        添加保险
    </title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/fileUpload.js" ></script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css"/>
    <script type="text/javascript"
            src="/DZOMS/res/js/jquery.bigautocomplete.js"></script>
    <script>
        var actionName = '${actionName}';

        function updateInsuranceBase() {
            var vehicleName = $("#carframe_num").val();
            new MyRequest("/DZOMS/vehicle/insurance/insurance_base_show.jsp")
                .param("carframeNum", vehicleName)
                .openWindow("保险基础费用设置", 'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        $(document).ready(function () {
            $("#carframe_num").bigAutocomplete({
                url: "/DZOMS/select/VehicleBycarframeNum",
                condition: function () {
                    console.info($('[name="withoutPage"]:checked').val());
                    if ($('[name="withoutPage"]:checked').val() == 'true') {
                        return "carframeNum not in (select carframeNum from Insurance where insuranceClass='" + $("#insuranceClass").val() + "' group by carframeNum,insuranceClass )";
                    } else
                        return "carframeNum not in (select carframeNum from Insurance where insuranceClass='" + $("#insuranceClass").val() + "' group by carframeNum,insuranceClass having max(endDate) < now() ) "
                },
                doubleClick: true,
                doubleClickDefault: 'LFV',
                callback: function () {
                    if ($("#carframe_num").val().length >= 17)
                        $.post("/DZOMS/common/getObject", {
                            className: "com.dz.module.vehicle.Vehicle",
                            id: $("#carframe_num").val(),
                            isString: true
                        }, function (vehicle) {
                            $("#insurance_base").val(vehicle["insuranceBase"]);
                        });
                }
            });

            $("#insuranceCompany").bigAutocomplete({
                url: "/DZOMS/select/itemsOfinsuranceCompany",
                doubleClick: true,
                doubleClickDefault: ''
            });

            $("#insuranceMoney").bigAutocomplete({
                url: "/DZOMS/select/itemsOfinsuranceMoney",
                doubleClick: true,
                doubleClickDefault: '',
                condition: function () {
//				console.info($("#insuranceClass").val());
                    if ($("#insuranceClass").val() == "商业保险单") {
                        return " key='insuranceMoneySx' ";
                    } else if ($("#insuranceClass option:eq(1)").is(":selected")) {
                        return " key='insuranceMoneyJq' ";
                    } else {
                        return " key='insuranceMoneyCy' ";
                    }
                }
            });

            $("#thirdPartyLimit").bigAutocomplete({
                url: "/DZOMS/select/itemsOfinsurance_thirdPartyLimit",
                doubleClick: true,
                doubleClickDefault: ''
            });

            $("#thirdPartyAmount").bigAutocomplete({
                url: "/DZOMS/select/itemsOfinsurance_thirdPartyAmount",
                doubleClick: true,
                doubleClickDefault: ''
            });

            $("#tax").bigAutocomplete({
                url: "/DZOMS/select/itemsOfinsurance_tax",
                doubleClick: true,
                doubleClickDefault: ''
            });
        });

        <%
        Cookie[] cookies = request.getCookies();
        String jqx = "",sx="",cyrx="";
        if(cookies!=null)
        for(Cookie cookie:cookies){
            if(cookie.getName().equals("jqx")){
                jqx = cookie.getValue();
            }else if(cookie.getName().equals("sx")){
                sx = cookie.getValue();
            }else if(cookie.getName().equals("cyrx")){
                cyrx = cookie.getValue();
            }
        }
        %>

        $(document).ready(function () {
//  	alert(actionName);

            $("#insuranceClass").change(function () {
                if ($("#insuranceClass option:eq(0)").is(":selected")) {

                    $("#add-form").addClass("insurance-mode-sx");
                    $("#add-form").removeClass("insurance-mode-jqx");
                    $("#add-form").removeClass("insurance-mode-cyr");

                    $("#insuranceNum").val('<%=sx%>');
                    itemsDefault("#insuranceMoney", "insuranceMoneySx");
                    $("#insuranceNum").attr("data-validate", "required:必填");
                } else if ($("#insuranceClass option:eq(1)").is(":selected")) {
                    $("#add-form").removeClass("insurance-mode-sx");
                    $("#add-form").addClass("insurance-mode-jqx");
                    $("#add-form").removeClass("insurance-mode-cyr");

                    $("#insuranceNum").val('<%=jqx%>');
                    $("#insuranceNum").attr("data-validate", "required:必填");
                    itemsDefault("#insuranceMoney", "insuranceMoneyJq");
                } else {
                    $("#add-form").removeClass("insurance-mode-sx");
                    $("#add-form").removeClass("insurance-mode-jqx");
                    $("#add-form").addClass("insurance-mode-cyr");

                    $("#insuranceNum").val('<%=cyrx%>');
                    $("#insuranceNum").attr("data-validate", "required:必填");
                    itemsDefault("#insuranceMoney", "insuranceMoneyCy");
                }
            });

            if (!actionName.contains("ObjectAccess")) {
                $("#insuranceClass").change();
                itemsDefault("#insuranceCompany", "insuranceCompany");
            }

        });

        function openTheItem() {
            if ($("#insuranceClass option:eq(0)").is(":selected")) {
                openItem('insuranceMoneySx', '商险金额');
            } else if ($("#insuranceClass option:eq(1)").is(":selected")) {
                openItem('insuranceMoneyJq', '交强险金额');
            } else {
                openItem('insuranceMoneyCy', '承运人险金额');
            }
        }

        function beforeSubmit() {
            if ($('#insuranceClass').val()=='商业保险单') {
                if($('#insurance_base').val()==''){
                    alert("请先设置基础保费金额！");
                    return false;
                }
                $.get("/DZOMS/vehicle/checkInsuranceDivide",{
                    "vehicle.carframeNum":$('#carframe_num').val(),
                    "insurance.beginDate":$('[name="insurance.beginDate"]').val()
                },function (data) {
                    if (data.result){
                        $('input[name="insurance.state"]').val(3);
						//console.info("beforeSubmit,"+$('input[name="insurance.state"]').val);
                        $('#submit-btn').click();
                    } else {
                        if (confirm("新录保险时间范围内已有保险记录，是否仍然生成摊销？")){
                            $('input[name="insurance.state"]').val(3);
                        } else {
                            $('input[name="insurance.state"]').val(0);
                        }
						$('#submit-btn').click();
                    }
                })
            }else {
				$('#submit-btn').click();
            }
        }

        function uploadFinish() {
            var fileId = $("#file_id").val();
            window.location.href = "/DZOMS/vehicle/insurance/insurance_import_pdf.jsp?fileId="+fileId+"&url="
                +encodeURI("/vehicle/insurance/insurance_add.jsp");
        }

        function uploadFinish2() {
            var fileId = $("#file_id2").val();
            window.location.href = "/DZOMS/vehicle/insurance/insurance_import_zip.jsp?fileId="+fileId+"&url="
                +encodeURI("/vehicle/insurance/insurance_add.jsp");
        }
    </script>
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
    <style>
        .label {
            white-space: pre-line;
        }

        /* 默认情况下隐藏所有子组件 */
        .show-when-sx,
        .show-when-jqx,
        .show-when-cyr {
            display: none;
        }

        /* 在 insurance-mode-sx 模式下显示 show-when-sx 子组件 */
        .insurance-mode-sx .show-when-sx {
            display: block;
        }

        /* 在 insurance-mode-jqx 模式下显示 show-when-jqx 子组件 */
        .insurance-mode-jqx .show-when-jqx {
            display: block;
        }

        /* 在 insurance-mode-cyr 模式下显示 show-when-cyr 子组件 */
        .insurance-mode-cyr .show-when-cyr {
            display: block;
        }
    </style>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>车辆管理</li>
        <li>新增</li>
        <li>新增保险信息</li>
    </ul>
</div>
<div class="xm7 xm2-move">
    <div class="alert alert-yellow padding"><span
            class="close rotate-hover"></span><strong>注意：</strong>录入保险信息前需要录入购置税信息。
    </div>
    <div class="panel">
        <div class="panel-head">
            新增保险信息
            <a class="button input-file input-file1">
                上传pdf文件并导入<input type="text" class="dz-file" id="file_id" data-target=".input-file1"  sessuss-function="uploadFinish()" style="display: none">
            </a>
            <a class="button input-file input-file2">
                上传zip文件并导入<input type="text" class="dz-file" id="file_id2" data-target=".input-file2"  sessuss-function="uploadFinish2()" style="display: none">
            </a>
        </div>
        <div class="panel-body">
            <form id="add-form" class="form-x" action="/DZOMS/vehicle/insurance_add" method="post">
                <s:hidden name="url" value="/vehicle/insurance/insurance_add.jsp"/>
                <s:if test="%{bean!=null&&bean[0]!=null}">
                    <s:hidden name="insurance.id" value="%{bean[0].id}"/>
                </s:if>
                <s:hidden name="insurance.state" value="0" />
                <div class="form-group">
                    <div class="label">
                        <label>
                            保险类别
                        </label>
                    </div>
                    <div class="field">
                        <s:if test="%{bean==null||bean[0]==null}">
                            <s:select cssClass="input" id="insuranceClass"
                                      name="insurance.insuranceClass"
                                      list="#{'商业保险单':'商业保险单','交强险':'交强险','承运人责任险':'承运人责任险'}"
                                      value="交强险"></s:select>
                        </s:if>
                        <s:else>
                            <s:select cssClass="input" id="insuranceClass"
                                      name="insurance.insuranceClass"
                                      list="#{'商业保险单':'商业保险单','交强险':'交强险','承运人责任险':'承运人责任险'}"
                                      value="%{bean[0].insuranceClass}"></s:select>
                        </s:else>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            操作
                        </label>
                    </div>
                    <div class="field">
                        <s:radio name="withoutPage"
                                 list="#{'true':'新增保险','false':'车辆续保'}"
                                 listKey="key" listValue="value"
                                 value="%{withoutPage==null?true:false}"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            车架号
                        </label>
                    </div>
                    <div class="field">
                        <div class="input-group">
                            <s:textfield cssClass="input" cssStyle="width: 50%"
                                         id="carframe_num" theme="simple"
                                         name="insurance.carframeNum"
                                         value="%{bean[0].carframeNum}"
                                         data-validate="required:请选择,length#>=1:必填"></s:textfield>
                            <s:textfield cssClass="input" cssStyle="width: 50%" id="insurance_base" theme="simple" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',bean[0].carframeNum).insuranceBase}" readonly="true"></s:textfield>
                            <span class="addon button"><button
                                    onclick="updateInsuranceBase()"><span
                                    class="icon-edit text-blue"></span>修改基础保费</button></span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label class="insurance-show-when-jqx">
                            保单号
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield id="insuranceNum" cssClass="input"
                                     placeholder=""
                                     name="insurance.insuranceNum"
                                     value="%{bean[0].insuranceNum}"
                                     data-validate="required:必填"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            保险公司
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input"
                                     name="insurance.insuranceCompany"
                                     id="insuranceCompany"
                                     value="%{bean[0].insuranceCompany}"
                                     data-validate="required:请选择"/>
                        <a class="icon icon-wrench"
                           href="javascript:openItem('insuranceCompany','保险公司')"></a>
                    </div>
                </div>


                <div class="form-group">
                    <div class="label">
                        <label class="show-when-jqx">
                            保险金额
                        </label>
                        <label class="show-when-cyr">
                            保险金额
                        </label>
                        <label class="show-when-sx">
                            车损险
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input"
                                     name="insurance.insuranceMoney"
                                     id="insuranceMoney"
                                     value="%{bean[0].insuranceMoney}"
                                     data-validate="required:请选择"/>
                        <a class="icon icon-wrench"
                           href="javascript:openTheItem()"></a>
                    </div>
                </div>

                <div class="form-group show-when-sx">
                    <div class="label">
                        <label>
                            第三者责任保险限额
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input"
                                     name="insurance.thirdPartyLimit"
                                     id="thirdPartyLimit"
                                     value="%{bean[0].thirdPartyLimit}"
                                     data-validate="required:请选择"/>
                        <a class="icon icon-wrench"
                           href="javascript:openItem('insurance_thirdPartyLimit', '第三者责任保险限额')"></a>
                    </div>
                </div>

                <div class="form-group show-when-sx">
                    <div class="label">
                        <label>
                            第三者责任保险金额
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input"
                                     name="insurance.thirdPartyAmount"
                                     id="thirdPartyAmount"
                                     value="%{bean[0].thirdPartyAmount}"
                                     data-validate="required:请选择"/>
                        <a class="icon icon-wrench"
                           href="javascript:openItem('insurance_thirdPartyAmount', '第三者责任保险金额')"></a>
                    </div>
                </div>

                <div class="form-group show-when-jqx">
                    <div class="label">
                        <label>
                            车船税
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:textfield cssClass="input"
                                     name="insurance.tax"
                                     id="tax"
                                     value="%{bean[0].tax}"
                                     data-validate="required:请选择"/>
                        <a class="icon icon-wrench"
                           href="javascript:openItem('insurance_tax', '车船税')"></a>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label">
                        <label>
                            起始时间
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" placeholder="选择日期时间" id="beginDate"
                                     name="insurance.beginDate"
                                     data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015-05-06 00:00:00">
                            <s:param name="value">
                                <s:date name="%{bean[0].beginDate}"
                                        format="yyyy/MM/dd HH:mm"></s:date>
                            </s:param>
                        </s:textfield>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            终止时间
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" placeholder="选择日期时间"
                                     name="insurance.endDate"
                                     data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015/05/06">
                            <s:param name="value">
                                <s:date name="%{bean[0].endDate}"
                                        format="yyyy/MM/dd HH:mm"></s:date>
                            </s:param>
                        </s:textfield>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            签单日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" placeholder="选择日期时间"
                                     name="insurance.signDate"
                                     data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015/05/06">
                            <s:param name="value">
                                <s:date name="%{bean[0].signDate}"
                                        format="yyyy/MM/dd HH:mm"></s:date>
                            </s:param>
                        </s:textfield>

                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            被保险人
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" placeholder="输入汉字"
                                     name="insurance.driverId"
                                     value="哈尔滨大众交通运输有限责任公司"
                                     data-validate="required:请填写姓名,chinesename:请输入汉字"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            联系电话
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" name="insurance.phone"
                                     value="86661212"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            身份证号/组织机构代码
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input"
                                     name="insurance.enterpriseID"
                                     value="12759066-9"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            被保险人地址
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" name="insurance.address"
                                     value="哈尔滨 南岗区征仪路311"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            登记人
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" readonly="true"
                                     value="%{#session.user.uname}"/>
                        <s:hidden name="insurance.register"
                                  value="%{#session.user.uid}"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            登记时间
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly"
                               name="insurance.registTime"
                               value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
                    </div>
                </div>
                <div class="xm6-move">
                    <input type="button" class="button bg-green" value="提交" onclick="beforeSubmit()">
					<input type="submit" style="display:none;" id="submit-btn">
                </div>
            </form>
        </div>
    </div>
    <!-- <div class="form-group">
         <div class="label">
             <label>
                 联系电话
             </label>
         </div>
         <div class="field">
             <input class="input" type="text" maxlength="12" placeholder="输入手机号码/联系电话"
                    name="insurance.carframeNum" data-validate="tel:请填写手机号/电话号">
         </div>
     </div>-->
</div>

<div class="line">
    <%
        List<Insurance> list = ObjectAccess.query(Insurance.class, " state!=1 ");
        request.setAttribute("list", list);
    %>
    <s:if test="%{#request.list!=null&&#request.list.size()>0}">
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <th class="insuranceClass selected_able">保险类别</th>
                <th class="insuranceNum selected_able">保单号</th>
                <th class="carframeNum selected_able">车架号</th>
                <th class="licenseNum selected_able">车牌号</th>
                <th class="driverName selected_able">被保险人</th>
                <th class="insuranceCompany selected_able">保险人公司名称</th>
                <th class="insuranceMoney selected_able">保险费</th>
                <th class="modify selected_able">修改</th>
                <th class="delete selected_able">删除</th>
            </tr>
            <s:iterator value="%{#request.list}" var="v">
                <tr>
                    <td class="insuranceClass selected_able"><s:property
                            value="%{#v.insuranceClass}"/></td>
                    <td class="insuranceNum selected_able"><s:property
                            value="%{#v.insuranceNum}"/></td>
                    <td class="carframeNum selected_able"><s:property
                            value="%{#v.carframeNum}"/></td>
                    <td class="licenseNum selected_able"><s:property
                            value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
                    <td class="driverName selected_able"><s:property
                            value="%{#v.driverId}"/></td>
                    <td class="insuranceCompany selected_able"><s:property
                            value="%{#v.insuranceCompany}"/></td>
                    <td class="insuranceMoney selected_able"><s:property
                            value="%{#v.insuranceMoney}"/></td>
                    <td class="modify selected_able"><a
                            href="javascript:modifyV('<s:property value="%{#v.id}"/>')">修改</a>
                    </td>
                    <td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.id}"/>','<s:property value="%{#v.carframeNum}"/>')">删除</a></td>
                </tr>
            </s:iterator>
        </table>

        <div class="xm9-move xm2">
            <form action="/DZOMS/vehicle/insurance_relook" method="post">
                <input type="hidden" name="url"
                       value="/vehicle/insurance/insurance_add.jsp"/>
                <input type="submit" value="全部通过" class="button bg-green"/>
            </form>
        </div>
    </s:if>
</div>

<form action="/DZOMS/vehicle/insurance_delete" method="post">
    <input type="hidden" name="url"
           value="/vehicle/insurance/insurance_add.jsp"/>
    <input type="hidden" name="insurance.id"/>
    <input type="submit" style="display: none;" id="del_but"/>
</form>
<form action="/DZOMS/common/getObj" method="post">
    <input type="hidden" name="url"
           value="/vehicle/insurance/insurance_add.jsp"/>
    <input type="hidden" name="ids[0].className"
           value="com.dz.module.vehicle.Insurance"/>
    <input type="hidden" name="ids[0].id"/>
    <input type="hidden" name="ids[0].isString" value="false"/>
    <input type="hidden" name="withoutPage" value="true"/>
    <input type="submit" style="display: none;" id="modify_but"/>
</form>

</body>
<script>
    function deleteV(cid,vnum){
        $('input[name="insurance.id"]').val(cid);
        if (confirm("确认删除车架号为"+vnum+"的发票信息？")) {
            $("#del_but").click();
        }
    }

    function modifyV(cid) {
        $('input[name="ids[0].id"]').val(cid);
        $("#modify_but").click();
    }
</script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"></script>
<script>
    $('[name="insurance.beginDate"]').datetimepicker({
        lang: "ch",           //语言选择中文
        format: "Y/m/d H:00",      //格式化日期
        timepicker: true,    //关闭时间选项
        yearStart: 2000,     //设置最小年份
        yearEnd: 2050,        //设置最大年份
        //todayButton:false    //关闭选择今天按钮
        onClose: function () {
            $('[name="insurance.signDate"]').val($('[name="insurance.beginDate"]').val());
            var dts = $('[name="insurance.beginDate"]').val().split(" ");
            var arr = dts[0].split("/");
            arr[0] = parseInt(arr[0]) + 1;
            var date = new Date();
            date.setFullYear(arr[0], arr[1] - 1, arr[2]);
            date = new Date(date.getTime() - 24 * 60 * 60 * 1000);
            $('[name="insurance.endDate"]').val(date.format("yyyy/MM/dd") + " " + dts[1]);
        }
    });

    $('[name="insurance.endDate"],[name="insurance.signDate"]').datetimepicker({
        lang: "ch",           //语言选择中文
        format: "Y/m/d H:00",      //格式化日期
        timepicker: true,    //关闭时间选项
        yearStart: 2000,     //设置最小年份
        yearEnd: 2050,        //设置最大年份
    });
</script>

</html>