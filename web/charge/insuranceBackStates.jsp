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
    <title>保险回执进账信息查询结果</title>
       <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script>
        // function refreshState(id) {
        //     $.post("/DZOMS/charge/refreshDiscountState.action",{id:id},function(data){
        //         if(data.status){
        //             document.vehicleSele.submit();
        //         }else{
        //             alert(data.msgStr);
        //         }
        //     });
        // }

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
    <script>
        function _comfirmAccount() {
            var cbxs = $("input[name='cbx']:checked");
            if (cbxs.length==0){
                alert("请选择至少一个");
                return;
            }
            var idArray = [];
            cbxs.each(function () {
                idArray.push($(this).val());
            });
            var ids = idArray.join(",");
            $.post('/DZOMS/charge/confirmChecked',{
                ids:ids
            },function (msg) {
                document.vehicleSele.submit();
            });
        }

        function _rejectAccount() {
            var cbxs = $("input[name='cbx']:checked");
            if (cbxs.length==0){
                alert("请选择至少一个");
                return;
            }

            if (!confirm("确认将所选的"+cbxs.length+"条信息作为错误信息移除？")){
                return;
            }

            var idArray = [];
            cbxs.each(function () {
                idArray.push($(this).val());
            });
            var ids = idArray.join(",");
            $.post('/DZOMS/charge/refuseInsuranceBack',{
                ids:ids
            },function (msg) {
                document.vehicleSele.submit();
            });
        }

        function _selectAll() {
            $("input[name='cbx']").prop('checked',true);
        }

        function _selectReverse() {
            $("input[name='cbx']").each(function () {
                $(this).prop('checked',!$(this).prop('checked'));
            });
        }
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
                        <button onclick="_comfirmAccount()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                            进账</button>
                        <button onclick="_selectAll()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                            全选</button>
                        <button onclick="_selectReverse()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
                            反选</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="panel-body">
        <table class="table table-hover table-bordered bg-white">
            <tr>
                <th>选择</th>
                <th>回执单号</th>
                <th>日期</th>
                <th>金额</th>
                <th>车牌号</th>
                <th>附言</th>
                <th>当前状态</th>
                <%--<th>操作</th>--%>
            </tr>
            <s:if test="#request.list != null">
                <s:iterator value="#request.list" var="bp">
                    <tr>
                        <td>
                            <s:if test="#bp.state==0">
                                <input type="checkbox" name="cbx" value="<s:property value="%{#bp.id}" />" >
                            </s:if>
                            <s:else>
                                -
                            </s:else>
                        </td>
                        <td><s:property value="#bp.receiptId"/></td>
                        <td><s:date format="yyyy/MM/dd" name="#bp.timestamp"></s:date></td>
                        <td><s:property value="#bp.amount"/></td>
                        <td><s:property value="#bp.carNum"/></td>
                        <td><s:property value="#bp.attachment"/></td>
                        <td>
                            <s:if test="%{#bp.state==0}">
                                未入账
                            </s:if>
                            <s:if test="%{#bp.state>0}">
                                已入账<s:property value="#bp.state"></s:property>
                            </s:if>
                            <s:if test="%{#bp.state<0}">
                                入账失败
                            </s:if>
                        </td>
                        <%--<td>--%>
                            <%--<s:if test="%{#bp.states==0}">--%>
                                <%--<a href="#" onclick="refreshState(${bp.id})">更新状态</a>--%>
                            <%--</s:if>--%>
                            <%--<s:else>--%>
                                <%--<a href="/DZOMS/charge/zhaoShangDetailContext.jsp?id=${bp.id}">查看详情</a>--%>
                            <%--</s:else>--%>
                        <%--</td>--%>
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
        <input type="hidden" name="orderby" value="id desc">
        <s:hidden name="condition"></s:hidden>
        <s:hidden name="className"></s:hidden>
        <s:hidden name="url"></s:hidden>
        <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
    </form>
</body>
</html>
