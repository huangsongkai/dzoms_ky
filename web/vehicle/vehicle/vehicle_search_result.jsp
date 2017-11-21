<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Page pg = (Page)request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>车辆查询结果</title>

    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
    <script>
        $(document).ready(function(){
            $("#show_div").find("input").change(resetClass);
            resetClass();
        });

        function resetClass(){
            $(".selected_able").hide();
            var selects = [];
            $("input[name='sbx']:checked").each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
                selects.push($(this).val());//将选中的值添加到数组chk_value中
            });
            //	alert(selects);

            for(var i = 0;i<selects.length;i++){
                $("."+selects[i]).show();
            }
        }

        function call_update(val){
            var url = "/DZOMS/vehicle/vehiclePreupdate?vehicle.carframeNum="+val;
            //alert(url);
            window.open(url,"车辆修改",'width=800,height=600,resizable=yes,scrollbars=yes');
            //$(window.top.document,"#main").attr("src",url);
        }

        function _update(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/vehiclePreupdate?vehicle.carframeNum="+selected_val;
            //	alert(url);
            //$(window.top.document,"#main").attr("src",url);
            window.open(url,"车辆修改",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _bindDriver(){
            var selected_val = $("input[name='cbx']:checked").val();
            var state=$("input[name='cbx']:checked").attr("state");
            if (state==1) {
                alert("车辆已运营，不可修改承租人。若要修改，请转包。");
                return false;
            }else if (state==2) {
                alert("车辆已报废。");
                return false;
            }else{
                var url = "/DZOMS/vehicle/vehiclePreBind?vehicle.carframeNum="+selected_val;
                window.parent.location.href=url;
            }
        }

        function _toExcel(){
            var path = $("[name='vehicleSele']").attr("action");
            var target = $("[name='vehicleSele']").attr("target");

            var url = "/DZOMS/vehicle/vehicleToExcel";
            $("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();

            $("[name='vehicleSele']").attr("action",path);
            $("[name='vehicleSele']").attr("target",target);
        }

        function _detail(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/vehiclePreshow?vehicle.carframeNum="+selected_val;
            window.open(url,"车辆查看",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

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

        function showDetail(id){
            //alert(id);
            layer.open({
                type: 2,
                title: '车辆档案',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                content: '/DZOMS/vehicle/vehicle/vehicle_photo.html?id='+id
            });
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
</head>
<body>
<div class="line">
    <div class="panel  margin-small" >
        <div class="panel-head">
            <div class="line">
                <div class="xm2">查询结果</div>
                <div class="xm5 xm5-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                                查看</button>
                            <s:if test="#session.roles.{?#this.rname=='车辆技术信息修改权限'}.size>0">
                                <button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                    修改</button>
                            </s:if>
                            <button onclick="_bindDriver()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                绑定承租人</button>
                            <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
                                导出</button>
                            <!-- <button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                                       打印</button>-->
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
                    <th class="carframeNum selected_able">车架号</th>
                    <th class="dept selected_able">归属部门</th>
                    <th class="driverId selected_able">承租人身份证号</th>
                    <th class="driverName selected_able">承租人</th>

                    <th class="engineNum selected_able">发动机号</th>
                    <th class="carMode selected_able">车辆型号</th>
                    <th class="inDate selected_able">购入日期</th>
                    <th class="certifyNum selected_able">合格证编号</th>
                    <th class="pd selected_able">车辆制造日期</th>
                    <th class="state selected_able">车辆状态</th>

                    <th class="archive selected_able">档案详情</th>
                </tr>
                <s:if test="%{#request.vehicle!=null}">

                    <s:iterator value="%{#request.vehicle}" var="v">

                        <tr onDblClick="changesinformation('<s:property value="%{#v.carframeNum}"/>')">
                            <td><input type="radio" name="cbx" value="<s:property value="%{#v.carframeNum}"/>" state="<s:property value="%{#v.state}"/>"></td>
                            <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                            <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum }"/></td>
                            <td class="dept selected_able"><s:property value="%{#v.dept}"/></td>
                            <td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>
                            <td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>

                            <td class="engineNum selected_able"><s:property value="%{#v.engineNum}"/></td>
                            <td class="carMode selected_able"><s:property value="%{#v.carMode}"/></td>
                            <td class="inDate selected_able"><s:property value="%{#v.inDate}"/></td>
                            <td class="certifyNum selected_able"><s:property value="%{#v.certifyNum}"/></td>
                            <td class="pd selected_able"><s:property value="%{#v.pd}"/></td>

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

                            <td class="archive selected_able"><a href="javascript:showDetail('${v.carframeNum}')">档案详情</a></td>
                        </tr>
                    </s:iterator>
                </s:if>
            </table>


            <s:if test="%{#request.vehicle!=null}">
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
                                                <input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>" id="page-input" >
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
    <div class="panel  margin-small" >
        <div class="panel-head">
            显示项
        </div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
                <label class="button active">
                    <input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>车架号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="dept" checked="checked"><span class="icon icon-check text-green"></span>归属部门
                </label>
                <label class="button ">
                    <input type="checkbox" name="sbx" value="driverId"><span class="icon icon-check text-green"></span>承租人身份证号
                </label>
                <label class="button ">
                    <input type="checkbox" name="sbx" value="driverName"><span class="icon icon-check text-green"></span>承租人
                </label>

                <label class="button active">
                    <input type="checkbox" name="sbx" value="engineNum" checked="checked"><span class="icon icon-check text-green"></span>发动机号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="carMode" checked="checked"><span class="icon icon-check text-green"></span>车辆型号
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="inDate" checked="checked"><span class="icon icon-check text-green"></span>购入日期
                </label>
                <label class="button">
                    <input type="checkbox" name="sbx" value="certifyNum"><span class="icon icon-check text-green"></span>合格证编号
                </label>
                <label class="button">
                    <input type="checkbox" name="sbx" value="pd" ><span class="icon icon-check text-green"></span>车辆制造日期
                </label>


                <label class="button active">
                    <input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>车辆状态
                </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="archive" checked="checked"><span class="icon icon-check text-green"></span>档案详情
                </label>
            </div>

        </div>

    </div>

</div>

<form action="vehicleSele" method="post" name="vehicleSele">
    <s:hidden name="vehicle.carframeNum" />
    <s:hidden name="vehicle.state" />
    <s:hidden name="vehicle.engineNum" />
    <s:hidden name="vehicle.carMode" />
    <s:hidden name="vehicle.inDate" />
    <s:hidden name="vehicle.certifyNum" />
    <s:hidden name="vehicle.dept" />
    <s:hidden name="vehicle.pd" />
    <s:hidden name="vehicle.driverId" />
    <s:hidden name="driverName" />
    <s:hidden name="vehicle.invoiceNumber" />
    <s:hidden name="vehicle.taxNumber" />
    <s:hidden name="vehicle.licenseNum" />
    <s:hidden name="vehicle.operateCard" />
    <s:hidden name="vehicle.businessLicenseNum" />
    <s:hidden name="condition" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
</body>
</html>
