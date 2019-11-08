<%@ page import="com.dz.module.driver.UrlAttachBean" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-19
  Time: 下午2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%List<UrlAttachBean> urlAttachBeen = (List)request.getAttribute("urlAttachBeen");
    int totalSize = urlAttachBeen.size();
    int pageSize = 15;
    int i = 0;
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script>
        var currentPage = 1;
        function toBeforePage(){
            if(currentPage==1){
                alert("没有上一页了。");
                return ;
            }
            toPage(currentPage-1);
        }

        function toNextPage(){
            if(currentPage==<%=(totalSize+pageSize-1)/pageSize%>){
                alert("没有下一页了。");
                return ;
            }
            toPage(currentPage+1);
        }

        function toPage(pg){
            currentPage = pg;
            $(".page-x").hide();
            $(".page"+pg).show();
        }

        $(document).ready(function(){
            toPage(1);

            if($("#applyLicenseNum").val().length==0){
                $("#applyLicenseNum").val("黑A");
            }
        });

    </script>
    <style>
        .page-x{
            display: none;
        }
    </style>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>驾驶员</li>
            <li>聘用</li>
            <li>聘用审核</li>
        </ul>
    </div>
</div>
<div class="panel">
    <div class="panel-head">
        聘用审核
    </div>
    <div class="panel-body">
        <div class="line padding">
            <form action="driverCheck" method="post" class="form form-inline">
                <div class="form-group">
                    <div class="label">
                        <label for="applyLicenseNum">车牌号</label>
                    </div>
                    <div class="field">
                        <s:textfield id="applyLicenseNum" cssClass="input input-auto" name="driver.applyLicenseNum" size="11" placeholder="车牌号" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label for="部门">部门</label>
                    </div>
                    <div class="field">
                        <s:select id="部门" name="driver.dept" cssClass="input input-auto" list="#{'全部':'全部','一部':'一部','二部':'二部','三部':'三部','未指定':'未指定'}"></s:select>
                    </div>

                    <div class="label">
                        <label for="申请日期">申请日期 &ge; </label>
                    </div>
                    <div class="field">
                        <s:textfield id="申请日期" cssClass="input input-auto" name="driver.applyTime" size="11" placeholder="申请日期" />
                    </div>

                    <div class="label">
                        <label for="申请事项（驾驶员属性）">申请事项</label>
                    </div>
                    <div class="field">
                        <s:select id="申请事项（驾驶员属性）" cssClass="input input-auto" name="driver.applyMatter" list="#{'全部':'全部','新包车':'新包车','转包车':'转包车','驾驶员':'驾驶员','临驾':'临驾'}"></s:select>
                        <input type="submit" class="button" value="查询" />
                    </div>
                </div>
            </form>
        </div>

        <table class="table">
            <tr>
                <th>姓名</th>
                <th>车牌号</th>
                <th>身份证</th>
                <th>操作</th>
            </tr>

            <%for(UrlAttachBean uab:urlAttachBeen)
//          	if(!uab.getUrl().contains("driverPreupdate"))
            {%>
            <tr class="page-x page<%=i++/pageSize+1%>">
                <td><%=uab.getName()%></td>
                <td><%=uab.getCarNum()%></td>
                <td><%=uab.getIdNum()%></td>
                <td><a href="<%=uab.getUrl()%>" class="button bg-blue">审核</a></td>
            </tr>
            <%}%>
        </table>
        <div class="line padding">
            <div>
                <div>
                    <ul class="pagination">
                        <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                    </ul>
                    <%
                        for (i = 0; i<(totalSize+pageSize-1)/pageSize; i++) {
                    %>
                    <ul class="pagination">
                        <li> <a href="javascript:toPage(<%=i+1%>)"><%=i+1%></a></li>
                    </ul>
                    <%
                        }
                    %>
                    <ul class="pagination">
                        <li><a href="javascript:toNextPage()">下一页</a></li>
                    </ul>

                </div>
            </div>
        </div>
        <div class="panel-foot border-red-light bg-red-light">
            合计：<%=totalSize %>条记录。
        </div>
    </div>
</div>

</body>
</html>
