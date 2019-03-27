<%@page import="java.text.SimpleDateFormat"%>
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

        function _addNew(){
            var selected_val = $("input[name='cbx']:checked").val();
            var hasJiaoqiang=$("input[name='cbx']:checked").attr("hasJiaoqiang");
            var hasShangxian=$("input[name='cbx']:checked").attr("hasShangxian");
            var hasChengyunxian = $("input[name='cbx']:checked").attr("hasChengyunxian");

            var myRequest =  new MyRequest('/DZOMS/common/getObj',"_parent")
                .param("withoutPage",false)
                .param("keyword","xubao")
                .param("ids[0].className","com.dz.module.vehicle.Insurance")
                .param("ids[0].isString",false)
                .param("url","/vehicle/insurance/insurance_addNew.jsp");
            if (hasJiaoqiang.trim().length>0) {
                myRequest
                    .param("ids[0].id",hasJiaoqiang)
                    .submit();
                // var url= "/DZOMS/common/getObj?withoutPage=false&keyword=xubao&url=%2fvehicle%2finsurance%2finsurance_addNew.jsp&ids[0].className=com.dz.module.vehicle.Insurance&ids[0].id="+hasJiaoqiang;
                // window.parent.location.href=url;
            }else if (hasShangxian.trim().length>0) {
                myRequest
                    .param("ids[0].id",hasShangxian)
                    .submit();
                // var url= "/DZOMS/common/getObj?withoutPage=false&keyword=xubao&url=%2fvehicle%2finsurance%2finsurance_addNew.jsp&ids[0].className=com.dz.module.vehicle.Insurance&ids[0].id="+hasShangxian;
                // window.parent.location.href=url;
            }else if (hasChengyunxian.trim().length>0) {
                myRequest
                    .param("ids[0].id",hasChengyunxian)
                    .submit();
                // var url= "/DZOMS/common/getObj?withoutPage=false&keyword=xubao&url=%2fvehicle%2finsurance%2finsurance_addNew.jsp&ids[0].className=com.dz.module.vehicle.Insurance&ids[0].id="+hasChengyunxian;
                // window.parent.location.href=url;
            }else{
                var url= "/DZOMS/vehicle/insurance/insurance_addNew.jsp";
                window.parent.location.href=url;
            }
        }

        function _detail(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/vehiclePreshow?vehicle.carframeNum="+selected_val;
            window.open(url,"车辆查看",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _toExcel(){
            var path = $("[name='vehicleSele']").attr("action");
            var target = $("[name='vehicleSele']").attr("target");

            var url = "/DZOMS/vehicle/vehicleToExcel?templatePath=vehicle%2finsurance%2finsurance_plan_export.xls&withInsurance=true";
            $("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();

            $("[name='vehicleSele']").attr("action",path);
            $("[name='vehicleSele']").attr("target",target);
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
                            <!--<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                          查看</button>-->
                            <%--<s:if test="#session.roles.{?#this.rname=='车辆技术信息修改权限'}.size>0">
                             <button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                                         修改</button>
                           </s:if> --%>
                            <s:if test="#session.roles.{?#this.rname=='保险续保'}.size>0">
                                <button onclick="_addNew()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                    续保</button>
                            </s:if>
                            <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
                                导出</button>
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
                    <th class="state selected_able">车辆状态</th>
                    <th class="jiaoqiang selected_able">交强险起始日期</th>
                    <th class="jiaoqiang selected_able">交强险截至日期</th>
                    <th class="shangxian selected_able">商险起始日期</th>
                    <th class="shangxian selected_able">商险截至日期</th>
                    <th class="chengyunxian selected_able">承运人责任险起始日期</th>
                    <th class="chengyunxian selected_able">承运人责任险截至日期</th>
                </tr>
                <%request.setAttribute("qt","'");
                    String ndt = request.getParameter("insurance_end_date");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date dt = sdf.parse(ndt);
//       	Calendar cl = Calendar.getInstance();
//       	cl.add(Calendar.MONTH, 1);
//       	request.setAttribute("ndt",cl.getTime());
                    request.setAttribute("ndt",dt);
                %>
                <s:if test="%{#request.vehicle!=null}">

                    <s:iterator value="%{#request.vehicle}" var="v">
                        <s:set name="jiaoqiang_id" value="%{@com.dz.common.other.ObjectAccess@execute('select max(id) from Insurance where insuranceClass like '+#request.qt+'%强%'+#request.qt+' and carframeNum='+#request.qt+#v.carframeNum+#request.qt)}"></s:set>
                        <s:set name="jiaoqiang" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Insurance',#jiaoqiang_id)}"></s:set>
                        <s:set name="shangxian_id" value="%{@com.dz.common.other.ObjectAccess@execute('select max(id) from Insurance where insuranceClass like '+#request.qt+'%商%'+#request.qt+' and carframeNum='+#request.qt+#v.carframeNum+#request.qt)}"></s:set>
                        <s:set name="shangxian" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Insurance',#shangxian_id)}"></s:set>
                        <s:set name="chengyunxian_id" value="%{@com.dz.common.other.ObjectAccess@execute('select max(id) from Insurance where insuranceClass like '+#request.qt+'%承运%'+#request.qt+' and carframeNum='+#request.qt+#v.carframeNum+#request.qt)}"></s:set>
                        <s:set name="chengyunxian" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Insurance',#chengyunxian_id)}"></s:set>
                        <tr>
                            <td>
                                <input type="radio" name="cbx" value="<s:property value="%{#v.carframeNum}"/>" state="<s:property value="%{#v.state}"/>"
                                       hasJiaoqiang="<s:if test="%{#jiaoqiang.endDate.before(#request.ndt)}"><s:property value="%{#jiaoqiang.id}"/></s:if>"
                                       hasShangxian="<s:if test="%{#shangxian.endDate.before(#request.ndt)}"><s:property value="%{#shangxian.id}"/></s:if>"
                                       hasChengyunxian="<s:if test="%{#chengyunxian.endDate.before(#request.ndt)}"><s:property value="%{#chengyunxian.id}"/></s:if>"
                                ></td>
                            <td class="licenseNum selected_able"><s:property value="%{#v.licenseNum}"/></td>
                            <td class="carframeNum selected_able"><s:property value="%{#v.carframeNum }"/></td>
                            <td class="dept selected_able"><s:property value="%{#v.dept}"/></td>
                            <td class="driverId selected_able"><s:property value="%{#v.driverId}"/></td>
                            <td class="driverName selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.driverId).name}"/></td>
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
                            <td class="jiaoqiang selected_able">
                                <s:date name="%{#jiaoqiang.beginDate}" format="yyyy/MM/dd HH:mm"/>
                            </td>
                            <td class="jiaoqiang selected_able">
                                <s:date name="%{#jiaoqiang.endDate}" format="yyyy/MM/dd HH:mm"/>
                            </td>
                            <td class="shangxian selected_able">
                                <s:date name="%{#shangxian.beginDate}" format="yyyy/MM/dd HH:mm"/>
                            </td>
                            <td class="shangxian selected_able">
                                <s:date name="%{#shangxian.endDate}" format="yyyy/MM/dd HH:mm"/>
                            </td>
                            <td class="chengyunxian selected_able">
                                <s:date name="%{#chengyunxian.beginDate}" format="yyyy/MM/dd HH:mm"/>
                            </td>
                            <td class="chengyunxian selected_able">
                                <s:date name="%{#chengyunxian.endDate}" format="yyyy/MM/dd HH:mm"/>
                            </td>

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
<s:property value="#parameters.insuranceClass"></s:property>
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
                    <input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>车辆状态
                </label>
                <s:if test="%{(#parameters.insuranceClass[0] eq 'all') or (#parameters.insuranceClass[0] eq '强险')}">
                    <label class="button active">
                        <input type="checkbox" name="sbx" value="jiaoqiang" checked="checked"><span class="icon icon-check text-green"></span>交强险
                    </label>
                </s:if>
                <s:else>
                    <label class="button">
                        <input type="checkbox" name="sbx" value="jiaoqiang"><span class="icon icon-check text-green"></span>交强险
                    </label>
                </s:else>

                <s:if test="%{(#parameters.insuranceClass[0] eq 'all') or (#parameters.insuranceClass[0] eq '商业')}">
                    <label class="button active">
                        <input type="checkbox" name="sbx" value="shangxian" checked="checked"><span class="icon icon-check text-green"></span>商险
                    </label>
                </s:if>
                <s:else>
                    <label class="button">
                        <input type="checkbox" name="sbx" value="shangxian"><span class="icon icon-check text-green"></span>商险
                    </label>
                </s:else>

                <s:if test="%{(#parameters.insuranceClass[0] eq 'all') or (#parameters.insuranceClass[0] eq  '承运')}">
                    <label class="button active">
                        <input type="checkbox" name="sbx" value="chengyunxian" checked="checked"><span class="icon icon-check text-green"></span>承运人责任险
                    </label>
                </s:if>
                <s:else>
                    <label class="button">
                        <input type="checkbox" name="sbx" value="chengyunxian"><span class="icon icon-check text-green"></span>承运人责任险
                    </label>
                </s:else>
            </div>

        </div>

    </div>

</div>

<form action="vehicleSele" method="post" name="vehicleSele">
    <s:hidden name="vehicle.carframeNum" />
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
    <s:hidden name="url" />
    <s:hidden name="insuranceClass" value="%{#parameters.insuranceClass}"></s:hidden>
    <s:hidden name="insurance_end_date" value="%{#parameters.insurance_end_date}"></s:hidden>
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
</body>
</html>
