<%@ page import="com.dz.common.global.Page" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Page pg = (Page)request.getAttribute("page");
%>
<html>
<head>
    <title>Title</title>
       <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script>
        function refreshState(id) {
            $.post("/DZOMS/charge/refreshDiscountState.action",{id:id},function(data){
                if(data.status){
                    document.vehicleSele.submit();
                }else{
                    alert(data.msgStr);
                }
            });
        }

        $(document).ready(function () {
            var msg = "${requestScope.msgStr}";
            if(msg.trim().length>0){
                alert(msg);
            }
        });
    </script>
    <script>
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
<div class="panel  margin-small" >
    <div class="panel-head">
        <div class="line">
            <div class="xm2">
                查询结果合计：<%=pg.getTotalCount() %>条记录
            </div>
            <div class="xm6 xm4-move">
                <div class="button-toolbar">
                    <div class="button-group">

                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="panel-body">
        <table class="table table-hover table-bordered bg-white">
            <tr>
                <th>部门</th>
                <th>车号</th>
                <th>计划扣款</th>
                <th>实际扣款</th>
                <th>发起时间</th>
                <th>操作人员</th>
                <th>当前状态</th>
                <th>备注</th>
            </tr>
            <s:if test="#request.list != null">
                <s:iterator value="#request.list" var="bp">
                    <tr>
                        <s:set name="v" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#bp.contract.carframeNum)}"></s:set>
                        <td><s:property value="#v.dept"/></td>
                        <td><s:property value="#v.licenseNum"/></td>
                        <td><s:property value="#bp.planFee"/></td>
                        <td><s:property value="#bp.realFee"/></td>
                        <td><s:property value="#bp.applyTime"/></td>
                        <td><s:property value="#bp.register"/></td>
                        <td>
                            <s:if test="%{#bp.state==0}">
                                处理中
                            </s:if>
                            <s:if test="%{#bp.state==1}">
                                撤销
                            </s:if>
                            <s:if test="%{#bp.state==2}">
                                失败
                            </s:if>
                            <s:if test="%{#bp.state==4}">
                                成功
                            </s:if>
                        </td>
                        <td>
                            <s:property value="#bp.comment"/>
                        </td>
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
        </s:if>
        <s:else>
            无查询结果
        </s:else>
    </div>
    <div class="panel-foot border-red-light bg-red-light">

    </div>
</div>
    <form action="/DZOMS/common/selectToList" class="form-inline" method="post" name="vehicleSele">
        <s:hidden name="condition"></s:hidden>
        <s:hidden name="className"></s:hidden>
        <s:hidden name="url"></s:hidden>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
    </form>
</body>
</html>
