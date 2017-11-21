<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@page import="com.dz.common.other.*" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
    />
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
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <script>

    </script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
    <script>
        var actionName = '${actionName}';
        var keyword = '${keyword}';

        $(document).ready(function(){
            $("#carframe_num").bigAutocomplete({
                url:"/DZOMS/select/VehicleBycarframeNum",
                condition:function(){
                    console.info($('[name="withoutPage"]:checked').val());
                    if($('[name="withoutPage"]:checked').val()=='true'){
                        return "carframeNum not in (select carframeNum from Insurance where insuranceClass='"+$("#insuranceClass").val()+"' group by carframeNum,insuranceClass )";
                    }else
                        return "carframeNum not in (select carframeNum from Insurance where insuranceClass='"+$("#insuranceClass").val()+"' group by carframeNum,insuranceClass having max(endDate) < now() ) "
                },
                doubleClick:true,
                doubleClickDefault:'LFV',
                callback:function(){
                    $.post("/DZOMS/common/doit",{"condition":"from Vehicle where carframeNum='"+$("#carframe_num").val()+"' "},function(data){
                        if (data!=undefined &&data["affect"]!=undefined ) {
                            var vehicle = data["affect"];
                            $("#licenseNum").val(vehicle["licenseNum"]);
                        }
                    });
                }
            });

            $("#licenseNum").bigAutocomplete({
                url:"/DZOMS/select/VehicleBylicenseNum",
                condition:function(){
                    console.info($('[name="withoutPage"]:checked').val());
                    if($('[name="withoutPage"]:checked').val()=='true'){
                        return "carframeNum not in (select carframeNum from Insurance where insuranceClass='"+$("#insuranceClass").val()+"' group by carframeNum,insuranceClass )";
                    }else
                        return "carframeNum not in (select carframeNum from Insurance where insuranceClass='"+$("#insuranceClass").val()+"' group by carframeNum,insuranceClass having max(endDate) < now() ) "
                },
                doubleClick:true,
                doubleClickDefault:'黑A',
                callback:function(){
                    $.post("/DZOMS/common/doit",{"condition":"from Vehicle where licenseNum='"+$("#licenseNum").val()+"' "},function(data){
                        if (data!=undefined &&data["affect"]!=undefined ) {
                            var vehicle = data["affect"];
                            $("#carframe_num").val(vehicle["carframeNum"]);
                        }
                    });
                }
            });

            $("#insuranceCompany").bigAutocomplete({
                url:"/DZOMS/select/itemsOfinsuranceCompany",
                doubleClick:true,
                doubleClickDefault:''
            });

            $("#insuranceMoney").bigAutocomplete({
                url:"/DZOMS/select/itemsOfinsuranceMoney",
                doubleClick:true,
                doubleClickDefault:'',
                condition:function(){
//				console.info($("#insuranceClass").val());
                    if ($("#insuranceClass").val()=="商业保险单") {
                        return " key='insuranceMoneySx' ";
                    }else if ($("#insuranceClass option:eq(1)").is(":selected")){
                        return " key='insuranceMoneyJq' ";
                    }else{
                        return " key='insuranceMoneyCy' ";
                    }
                }
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

        $(document).ready(function(){
            $("#insuranceClass").change(function(){
                if ($("#insuranceClass option:eq(0)").is(":selected")) {
                    $("#insuranceNum").val('<%=sx%>');
                    itemsDefault("#insuranceMoney","insuranceMoneySx");
                    $("#insuranceNum").attr("data-validate","required:请选择,regexp#(^PDAA[A-Z0-9]{18}$):格式不正确(22位，交强险以PDZA开头，商险以PDAA开头，承运人责任险以PZDS开头)");
//  			/data-validate="required:请选择,regexp#(^P(D|Z)AA[A-Z0-9]{11}$):格式不正确(15位，交强险以PDZA开头，商险以PDAA开头)"
                } else if ($("#insuranceClass option:eq(1)").is(":selected")){
                    $("#insuranceNum").val('<%=jqx%>');
                    $("#insuranceNum").attr("data-validate","required:请选择,regexp#(^PDZA[A-Z0-9]{18}$):格式不正确(22位，交强险以PDZA开头，商险以PDAA开头，承运人责任险以PZDS开头)");
                    itemsDefault("#insuranceMoney","insuranceMoneyJq");
                }else{
                    $("#insuranceNum").val('<%=cyrx%>');
                    $("#insuranceNum").attr("data-validate","required:请选择,regexp#(^PZDS[A-Z0-9]{18}$):格式不正确(22位，交强险以PDZA开头，商险以PDAA开头，承运人责任险以PZDS开头)");
                    itemsDefault("#insuranceMoney","insuranceMoneyCy");
                }
            });

//  	alert(keyword);

            if(!actionName.contains("ObjectAccess")||keyword=='xubao'){
                $("#insuranceClass").change();
                itemsDefault("#insuranceCompany","insuranceCompany");
            }
        });

        function openTheItem(){
            if ($("#insuranceClass option:eq(0)").is(":selected")) {
                openItem('insuranceMoneySx','商险金额');
            }else if ($("#insuranceClass option:eq(1)").is(":selected")) {
                openItem('insuranceMoneyJq','交强险金额');
            }else{
                openItem('insuranceMoneyCy','承运人险金额');
            }
        }
    </script>
    <style>
        .label{
            white-space:pre-line;
        }
    </style>
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
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
    <div class="panel">

        <div class="panel-head">新增保险信息</div>
        <div class="panel-body">
            <form class="form-x" action="/DZOMS/vehicle/insurance_add" method="post">
                <s:hidden name="url" value="/vehicle/insurance/insurance_addNew.jsp"/>
                <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                    <s:hidden name="insurance.id" value="%{bean[0].id}"/>
                </s:if>
                <div class="form-group">
                    <div class="label">
                        <label>
                            保险类别
                        </label>
                    </div>
                    <div class="field">
                        <s:select cssClass="input" id="insuranceClass" name="insurance.insuranceClass" list="#{'商业保险单':'商业保险单','交强险':'交强险','承运人责任险':'承运人责任险'}" value="%{bean[0].insuranceClass}" ></s:select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            操作
                        </label>
                    </div>
                    <div class="field">
                        <s:radio name="withoutPage" list="#{'true':'新增保险','false':'车辆续保'}" listKey="key" listValue="value" value="%{withoutPage==null?true:false}"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            车架号
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input" id="carframe_num" theme="simple" name="insurance.carframeNum" value="%{bean[0].carframeNum}" data-validate="required:请选择,length#>=1:必填"></s:textfield>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <s:if test="%{bean[0].carframeNum!=null}">
                            <s:textfield cssClass="input" id="licenseNum" theme="simple" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',bean[0].carframeNum).licenseNum}" data-validate="required:请选择,length#>=1:必填"></s:textfield>
                        </s:if>
                        <s:else>
                            <s:textfield cssClass="input" id="licenseNum" theme="simple" value="黑A" data-validate="required:请选择,length#>=1:必填"></s:textfield>
                        </s:else>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            保单号
                        </label>
                    </div>
                    <div class="field">
                        <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                            <s:textfield id="insuranceNum" cssClass="input" placeholder=""
                                         name="insurance.insuranceNum" value="%{bean[0].insuranceNum}" data-validate="required:请选择,regexp#(^PD(AA|ZA|ZS)[A-Z0-9]{18}$):格式不正确(22位，交强险以PDZA开头，商险以PDAA开头，承运人责任险以PDZS开头)"/>
                        </s:if>
                        <s:else>
                            <s:textfield id="insuranceNum" cssClass="input" placeholder=""
                                         name="insurance.insuranceNum" data-validate="required:请选择,regexp#(^(PDAA|PDZA|PZDS)[A-Z0-9]{18}$):格式不正确(22位，交强险以PDZA开头，商险以PDAA开头，承运人责任险以PZDS开头)"/>
                        </s:else>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            保险公司
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                            <s:textfield  cssClass="input" name="insurance.insuranceCompany" value="%{bean[0].insuranceCompany}" id="insuranceCompany"  data-validate="required:请选择"/>
                        </s:if>
                        <s:else>
                            <s:textfield  cssClass="input" name="insurance.insuranceCompany" id="insuranceCompany"  data-validate="required:请选择"/>
                        </s:else>

                        <a class="icon icon-wrench" href="javascript:openItem('insuranceCompany','保险公司')"></a>
                    </div>

                </div>
                <div class="form-group" >
                    <div class="label">
                        <label>
                            保险金额
                        </label>
                    </div>
                    <div class="field form-inline">
                        <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                            <s:textfield  cssClass="input" name="insurance.insuranceMoney" id="insuranceMoney" value="%{bean[0].insuranceMoney}"  data-validate="required:请选择"/>
                        </s:if>
                        <s:else>
                            <s:textfield  cssClass="input" name="insurance.insuranceMoney" id="insuranceMoney" data-validate="required:请选择"/>
                        </s:else>
                        <a class="icon icon-wrench" href="javascript:openTheItem()"></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            起始时间
                        </label>
                    </div>
                    <div class="field">
                        <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                            <s:textfield  cssClass="input" placeholder="选择日期时间" name="insurance.beginDate"
                                          data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015-05-06 00:00:00" >
                                <s:param name="value">
                                    <s:date name="%{bean[0].beginDate}" format="yyyy/MM/dd HH:mm"></s:date>
                                </s:param>
                            </s:textfield>
                        </s:if>
                        <s:else>
                            <s:textfield  cssClass="input datetimepick" placeholder="选择日期时间" name="insurance.beginDate"
                                          data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015-05-06 00:00:00" />
                        </s:else>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            终止时间
                        </label>
                    </div>
                    <div class="field">
                        <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                            <s:textfield  cssClass="input"  placeholder="选择日期时间" name="insurance.endDate"
                                          data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015/05/06">
                                <s:param name="value">
                                    <s:date name="%{bean[0].endDate}" format="yyyy/MM/dd HH:mm"></s:date>
                                </s:param>
                            </s:textfield>
                        </s:if>
                        <s:else>
                            <s:textfield  cssClass="input datetimepick"  placeholder="选择日期时间" name="insurance.endDate"
                                          data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015/05/06"/>
                        </s:else>
                    </div>
                </div>
                <div class="form-group" >
                    <div class="label">
                        <label>
                            签单日期
                        </label>
                    </div>
                    <div class="field">
                        <s:if test="%{bean!=null&&bean[0]!=null&&keyword!='xubao'}">
                            <s:textfield  cssClass="input" placeholder="选择日期时间" name="insurance.signDate"
                                          data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015/05/06">
                                <s:param name="value">
                                    <s:date name="%{bean[0].signDate}" format="yyyy/MM/dd HH:mm"></s:date>
                                </s:param>
                            </s:textfield>
                        </s:if>
                        <s:else>
                            <s:textfield  cssClass="input datetimepick" placeholder="选择日期时间" name="insurance.signDate"
                                          data-validate="required:请填选择日期时间,datetime:请输入日期时间，如：2015/05/06"/>
                        </s:else>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            被保险人
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input" placeholder="输入汉字" name="insurance.driverId"
                                      value="哈尔滨大众交通运输有限责任公司"    data-validate="required:请填写姓名,chinesename:请输入汉字"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            联系电话
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input" name="insurance.phone" value="86661212"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            身份证号/组织机构代码
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input" name="insurance.enterpriseID" value="12759066-9"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            被保险人地址
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input" name="insurance.address" value="哈尔滨 南岗区征仪路311"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            登记人
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input" readonly="true" value="%{#session.user.uname}" />
                        <s:hidden name="insurance.register" value="%{#session.user.uid}"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>
                            登记时间
                        </label>
                    </div>
                    <div class="field">
                        <input class="input" readonly="readonly" name="insurance.registTime"
                               value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
                    </div>
                </div>
                <div class="xm6-move">
                    <input type="submit" class="button bg-green" value="提交">
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
        List<Insurance> list = ObjectAccess.query(Insurance.class, " state=0 ");
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
                    <td class="insuranceClass selected_able"><s:property value="%{#v.insuranceClass}"/></td>
                    <td class="insuranceNum selected_able"><s:property value="%{#v.insuranceNum}"/></td>
                    <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum}"/></td>
                    <td class="licenseNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#v.carframeNum).licenseNum}"/></td>
                    <td class="driverName selected_able"><s:property value="%{#v.driverId}"/></td>
                    <td class="insuranceCompany selected_able"><s:property value="%{#v.insuranceCompany}"/></td>
                    <td class="insuranceMoney selected_able"><s:property value="%{#v.insuranceMoney}"/></td>
                    <td class="modify selected_able"><a href="javascript:modifyV('<s:property value="%{#v.id}"/>')">修改</a></td>
                    <td class="delete selected_able"><a href="javascript:deleteV('<s:property value="%{#v.id}"/>')">删除</a></td>
                </tr>
            </s:iterator>
        </table>

        <div class="xm9-move xm2">
            <form action="/DZOMS/vehicle/insurance_relook" method="post">
                <input type="hidden" name="url" value="/vehicle/insurance/insurance_addNew.jsp"/>
                <input type="submit" value="全部通过" class="button bg-green" />
            </form>
        </div>
    </s:if>
</div>

<form action="/DZOMS/vehicle/insurance_delete" method="post">
    <input type="hidden" name="url" value="/vehicle/insurance/insurance_addNew.jsp"/>
    <input type="hidden" name="insurance.id" />
    <input type="submit" style="display: none;" id="del_but" />
</form>

<form action="/DZOMS/common/getObj" method="post">
    <input type="hidden" name="url" value="/vehicle/insurance/insurance_addNew.jsp"/>
    <input type="hidden" name="ids[0].className" value="com.dz.module.vehicle.Insurance" />
    <input type="hidden" name="ids[0].id" />
    <input type="hidden" name="ids[0].isString" value="false" />
    <input type="hidden" name="withoutPage" value="true" />
    <input type="submit" style="display: none;" id="modify_but" />
</form>
</body>
<script>
    function deleteV(cid){
        $('input[name="insurance.id"]').val(cid);
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
<script>
    $('[name="insurance.beginDate"]').datetimepicker({
        lang:"ch",           //语言选择中文
        format:"Y/m/d H:i",      //格式化日期
        timepicker:false,    //关闭时间选项
        yearStart:2000,     //设置最小年份
        yearEnd:2050,        //设置最大年份
        //todayButton:false    //关闭选择今天按钮
        onClose:function(){
            $('[name="insurance.signDate"]').val($('[name="insurance.beginDate"]').val());
            var dts = $('[name="insurance.beginDate"]').val().split(" ");
            var arr = dts[0].split("/");
            arr[0] = parseInt(arr[0])+1;
            var date = new Date();
            date.setFullYear(arr[0],arr[1]-1,arr[2]);
            date = new Date(date.getTime()-24*60*60*1000);
            $('[name="insurance.endDate"]').val(date.format("yyyy/MM/dd")+" "+dts[1]);
        }
    });
</script>

</html>