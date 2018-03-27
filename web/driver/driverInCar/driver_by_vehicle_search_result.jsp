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

        function _detail(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/driver/driverInCar/exchangeRestTime?vehicle.carframeNum="+selected_val;
            $.get(url,function (data) {
               if(data){
                   if(!data.state){
                       alert(data.msg);
                   }
                   document.vehicleSele.submit();
               }
            });
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
                                调换白夜班</button>
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

                    <th class="driverName selected_able">承租人</th>
                    <th class="driverId selected_able">身份证号</th>

                    <th class="firstDriver selected_able">主驾</th>
                    <th class="firstIdNum selected_able">身份证号</th>
                    <th class="firstRest selected_able">班次</th>

                    <th class="secondDriver selected_able">副驾</th>
                    <th class="secondIdNum selected_able">身份证号</th>
                    <th class="secondRest selected_able">班次</th>
                </tr>
                <s:if test="%{#request.vehicle!=null}">
                    <s:iterator value="%{#request.vehicle}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value="%{#v.carframeNum}"/>" state="<s:property value="%{#v.state}"/>"></td>
                            <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                            <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum }"/></td>
                            <td class="dept selected_able"><s:property value="%{#v.dept}"/></td>

                            <td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>
                            <td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>

                            <s:set name="firstDriver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.firstDriver)}"></s:set>
                            <td class="firstDriver selected_able">${firstDriver.name}</td>
                            <td class="firstIdNum selected_able">${firstDriver.idNum}</td>
                            <td class="firstRest selected_able">${firstDriver.restTime}</td>

                            <s:set name="secondDriver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.secondDriver)}"></s:set>
                            <td class="secondDriver selected_able">${secondDriver.name}</td>
                            <td class="secondIdNum selected_able">${secondDriver.idNum}</td>
                            <td class="secondRest selected_able">${secondDriver.restTime}</td>
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
                <label class="button active ">
                    <input type="checkbox" name="sbx" value="driverId" checked="checked"><span class="icon icon-check text-green"></span>身份证号
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="driverName" checked="checked"><span class="icon icon-check text-green"></span>承租人
                </label>

                <label class="button  active">
                    <input type="checkbox" name="sbx" value="firstDriver" checked="checked"><span class="icon icon-check text-green"></span>主驾
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="firstIdNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="firstRest" checked="checked"><span class="icon icon-check text-green"></span>班次
                </label>

                <label class="button active ">
                    <input type="checkbox" name="sbx" value="secondDriver" checked="checked"><span class="icon icon-check text-green"></span>副驾
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="secondIdNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号
                </label>
                <label class="button  active">
                    <input type="checkbox" name="sbx" value="secondRest" checked="checked"><span class="icon icon-check text-green"></span>班次
                </label>

            </div>

        </div>

    </div>

</div>

<form action="vehicleSele" method="post" name="vehicleSele">
    <input type="hidden" name="url" value="/driver/driverInCar/driver_by_vehicle_search_result.jsp" />
    <s:hidden name="vehicle.carframeNum" />
    <s:hidden name="vehicle.state" />
    <s:hidden name="vehicle.dept" />
    <s:hidden name="vehicle.driverId" />
    <s:hidden name="driverName" />
    <s:hidden name="vehicle.licenseNum" />
    <s:hidden name="condition" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
</body>
</html>
