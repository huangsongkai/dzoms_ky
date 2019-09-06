<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
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
    <title>查询结果</title>

    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
    <script>
        $(document).ready(function(){
            $("#show_div").find("input").change(resetClass);
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
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }

            var url = "/DZOMS/driver/driverPreshow?driver.idNum="+selected_val;
            window.open(url,"驾驶员明细",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _update(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
            var url = "/DZOMS/driver/driverPreupdate?driver.idNum="+selected_val;
            //window.open(url,"驾驶员修改",'width=800,height=600,resizable=yes,scrollbars=yes');

            //$("#container > iframe:nth-child(2)",window.parent.window.parent.window.parent.window.document).attr("height","2500px");
            $("#container > iframe:nth-child(2)",window.parent.window.parent.window.parent.window.document).css("height","2500px");
            $("#body-right",window.parent.window.parent.window.document).attr("height","2500px");
            window.parent.window.location.href = url;
        }

        function _toExcel(){
            var path = $("[name='vehicleSele']").attr("action");
            var target = $("[name='vehicleSele']").attr("target");

            var url = "/DZOMS/driver/driverToExcel";
            $("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();

            $("[name='vehicleSele']").attr("action",path);
            $("[name='vehicleSele']").attr("target",target);
        }

        function _toExcel2(){
            var path = $("[name='vehicleSele']").attr("action");
            var target = $("[name='vehicleSele']").attr("target");

            var url = "/DZOMS/driver/driverToExcel?templatePath=driver%2fmeeting%2fdriver_for_meeting.xls";
            $("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();

            $("[name='vehicleSele']").attr("action",path);
            $("[name='vehicleSele']").attr("target",target);
        }

        function _toPrint(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
            var url = "/DZOMS/driver/driverPreprint?driver.idNum="+selected_val;
            window.open(url,"驾驶员打印",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _toPrintApply(){
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }

            var url = "/DZOMS/driver/driverPreprint_apply?driver.idNum="+selected_val;
            window.open(url,"驾驶员申请表打印",'width=800,height=600,resizable=yes,scrollbars=yes');
        }

        function _toPrintContract() {
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }

            var url = "/DZOMS/driver/driver_print_contract.jsp?idNum="+selected_val;
            window.open(url,"_blank");
        }

        function _toPrintCard() {
            var url = "/DZOMS/driver/driverCardPrint.html";
            window.open(url,"_blank");
        }

        function showDetail(id){
            //alert(id);
            layer.open({
                type: 2,
                title: '人员档案',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                content: '/DZOMS/driver/driver_photo.html?id='+id
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
<div>
    <div class="panel  margin-small" >
        <div class="panel-head">
            <div class="line">
                <div class="xm2">查询结果</div>
                <div class="xm4 xm6-move">
                    <div class="button-toolbar">
                        <div class="button-group">
                            <button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                                查看</button>
                            <s:if test="#session.roles.{?#this.rname=='驾驶员修改权限'}.size>0">
                                <button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                    修改</button>
                            </s:if>
                            <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
                                导出</button>
                            <button onclick="_toExcel2()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
                                导出例会表</button>
                            <button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                打印申请表</button>
                            <button  onclick="_toPrintApply()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                打印录入表</button>
                            <button  onclick="_toPrintContract()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                打印驾驶员聘用协议</button>
                            <button  onclick="_toPrintCard()" type="button" class="button icon-print text-green" style="line-height: 6px;">
                                打印驾驶员档案卡</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        <div class="panel-body">
            <table class="table table-hover table-bordered  table-striped">

                <tr>
                    <th>选择</th>
                    <th class="licenseNum              selected_able">车牌号      </th>
                    <th class="name                    selected_able">姓名        </th>
                    <th class="sex                     selected_able">性别        </th>
                    <th class="driverClass selected_able">驾驶员属性</th>
                    <th class="driverClass selected_able">班次	</th>
                    <th class="phoneNum1 selected_able">电话号码</th>
                    <%--<th class="qualificationNum        selected_able">资格证号(旧)</th>--%>
                    <th class="qualificationNum        selected_able">资格证号    </th>
                    <th class="idNum                   selected_able">身份证号    </th>
                    <th class="employeeNum             selected_able">员工号      </th>
                    <th class="politicalStatus         selected_able">政治面貌    </th>
                    <th class="age                     selected_able">年龄        </th>
                    <th class="fingerprintNum          selected_able">指纹编号    </th>
                    <th class="star                    selected_able">星级        </th>
                    <th class="isInCar                 selected_able">是否在车    </th>
                    <th class="department              selected_able">分公司归属  </th>
                    <th class="archive selected_able">档案详情</th>
                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.idNum}'/>" ></td>
                            <td class="licenseNum         selected_able"><s:property value='%{@com.dz.common.other.ObjectAccess@getObject("com.dz.module.vehicle.Vehicle", #v.carframeNum).licenseNum}'/></td>
                            <td class="name               selected_able"><s:property value='%{#v.name}'/></td>
                            <td class="sex                selected_able"><s:property value="%{#v.sex?'男':'女'}"/></td>
                            <td class="driverClass selected_able"><s:property value="%{#v.driverClass}"/></td>
                            <td class="driverClass selected_able"><s:property value="%{#v.restTime}"/></td>
                            <td class="phoneNum1 selected_able"><s:property value="%{#v.phoneNum1}"/></td>

                            <%--<td class="qualificationNum   selected_able"><s:property value='%{#v.qualificationNo}'/></td>--%>
                            <td class="qualificationNum   selected_able"><s:property value='%{#v.qualificationNum}'/></td>
                            <td class="idNum              selected_able"><s:property value='%{#v.idNum}'/></td>
                            <td class="employeeNum        selected_able"><s:property value='%{#v.employeeNum}'/></td>
                            <td class="politicalStatus    selected_able"><s:property value='%{#v.politicalStatus}'/></td>
                            <td class="age                selected_able"><s:property value='%{#v.age}'/></td>

                            <td class="fingerprintNum     selected_able"><s:property value='%{#v.fingerprintNum}'/></td>

                            <td class="star               selected_able"><s:property value='%{#v.star}'/></td>
                            <td class="isInCar            selected_able"><s:property value="%{#v.isInCar?'是':'否'}"/></td>

                            <td class="department         selected_able"><s:property value='%{#v.dept}'/></td>
                            <td class="archive selected_able"><a href="javascript:showDetail('${v.idNum}')">档案详情</a></td>
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
                <div class="panel-foot border-red-light bg-red-light">
                    合计：<%=pg.getTotalCount() %>条记录。
                </div>
            </s:if>
            <s:else>
                无查询结果
            </s:else>
        </div>

    </div>
    <div class="panel  margin-small" >
        <div class="panel-head">

            显示项



        </div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="name" checked="checked"><span class="icon icon-check text-green"></span>姓名       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="sex" checked="checked"><span class="icon icon-check text-green"></span>性别       </label>
                <label class="button"><input type="checkbox" name="sbx" value="politicalStatus"><span class="icon icon-check text-green"></span>政治面貌   </label>
                <label class="button"><input type="checkbox" name="sbx" value="age"><span class="icon icon-check text-green"></span>年龄       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="phoneNum1" checked="checked"><span class="icon icon-check text-green"></span>电话号码 </label>
                <label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span class="icon icon-check text-green"></span>身份证号   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="driverClass" checked="checked"><span class="icon icon-check text-green"></span>驾驶员属性</label>
                <label class="button active"><input type="checkbox" name="sbx" value="employeeNum" checked="checked"><span class="icon icon-check text-green"></span>员工号     </label>
                <label class="button active"><input type="checkbox" name="sbx" value="fingerprintNum" checked="checked"><span class="icon icon-check text-green"></span>指纹编号   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="qualificationNum" checked="checked"><span class="icon icon-check text-green"></span>资格证号   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="star" checked="checked"><span class="icon icon-check text-green"></span>星级       </label>
                <label class="button active"><input type="checkbox" name="sbx" value="isInCar" checked="checked"><span class="icon icon-check text-green"></span>是否在车   </label>
                <label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号     </label>
                <label class="button active"><input type="checkbox" name="sbx" value="department" checked="checked"><span class="icon icon-check text-green"></span>分公司归属 </label>
                <label class="button active">
                    <input type="checkbox" name="sbx" value="archive" checked="checked"><span class="icon icon-check text-green"></span>档案详情
                </label>
            </div>
        </div>
    </div>

    <form action="/DZOMS/driver/searchDriver" method="post" name="vehicleSele">
        <input type="hidden" name="url" value="/driver/search_result.jsp" />
        <input type="hidden" name="className" value="com.dz.module.driver.Driver"/>
        <s:hidden name="condition" />
        <s:hidden name="beginDate" />
        <s:hidden name="endDate" />
        <s:hidden name="idNum"/>
        <s:hidden name="name"/>
        <s:if test="%{isInCar!=null}">
            <s:hidden name="isInCar"/>
        </s:if>
        <s:hidden name="driver.dept"></s:hidden>
        <s:hidden name="licenseNum"></s:hidden>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage" />
    </form>
</div>
</body>
</html>
