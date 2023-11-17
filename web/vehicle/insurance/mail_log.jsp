<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String paramAutomic = request.getParameter("automic");
    String opTimeAfter = request.getParameter("opTimeAfter");
    String currentPage = request.getParameter("page");

// 初始化 SQL 查询语句
    String sql = "FROM insurance_import_log WHERE 1=1";

// 添加 Automic 查询条件
    if ("true".equals(paramAutomic)) {
        sql += " AND automic = 1";
    } else if ("false".equals(paramAutomic)) {
        sql += " AND automic = 0";
    }

// 添加 Op Time After 查询条件
    if (opTimeAfter != null && !opTimeAfter.isEmpty() && opTimeAfter.matches("\\d{4}-\\d{2}-\\d{2}")) {
        sql += " AND op_time > '" + opTimeAfter + "'";
    }

// 构建分页查询语句
    int recordsPerPage = 20;
    int tpage = 1;
    try {
        tpage = Integer.parseInt(currentPage);
    } catch (NumberFormatException e) {
        // 默认为第一页
    }

    Session hsession = HibernateSessionFactory.getSession();
    Query queryCount = hsession.createSQLQuery("SELECT count(*) " +sql);

    int offset = (tpage - 1) * recordsPerPage;
    sql += " ORDER BY op_time DESC ";

    Query query = hsession.createSQLQuery("SELECT id,`automic`, `op_time`, `worklog` " + sql);
    query.setFirstResult(offset);
    query.setMaxResults(recordsPerPage);
    long totalSize = ((Number) queryCount.uniqueResult()).longValue();
    List<Object[]> results = query.list();
%>
<!DOCTYPE html>
<html>
<head>
    <title>保险邮件导入日志</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
</head>
<body>
<h1>保险邮件导入日志</h1>

<!-- 上部：查询条件 -->
<div class="x12 form-group">
    <form action="/DZOMS/vehicle/insurance/mail_log.jsp" method="GET">
        <input type="hidden" name="page" id="pageinput" value="<%=tpage%>">
        <label for="automic">类型:</label>
        <input type="radio" id="automic" name="automic" value="true" <%="true".equals(paramAutomic)?"checked='checked'":""%> > 自动
        <input type="radio" id="automicFalse" name="automic" value="false" <%="false".equals(paramAutomic)?"checked='checked'":""%>> 手动
        <input type="radio" id="automicAll" name="automic" value="all" <%= !("true".equals(paramAutomic)||"false".equals(paramAutomic)) ?"checked='checked'":""%>> 全部
        <label for="opTimeAfter">起始日期:</label>
        <input type="text" id="opTimeAfter" name="opTimeAfter" value="<%=opTimeAfter==null?"":opTimeAfter%>">
        <input class="button" type="submit" value="查询"/>
    </form>
    <button class="button" onclick="startTask()">手动发起任务</button>
</div>

<% if(results != null && results.size()!=0) { %>
<!-- 中间：查询结果 -->
<table class="x12 striped">
    <thead>
    <tr>
        <th>ID</th>
        <th>类型</th>
        <th>开始时间</th>
        <th>日志</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
        for (Object[] row : results) {
            String id = String.valueOf(row[0]);
            int automic = ((Number)row[1]).intValue();
            Date opTime = (Date) row[2];
            String worklog = (String) row[3];
    %>
    <tr>
        <td><%= id %></td>
        <td><%= automic==0 ?"手动":"自动" %></td>
        <td><%= sdf.format(opTime) %></td>
        <td>
            <%
                if (worklog.length() <= 100) {
            %>
            <%= worklog %>
            <%
            } else {
            %>
            <%= worklog.substring(0, 100) %>...
            <button class="button" onclick="showWorklogDetails('<%= id %>')">查看详情</button>
            <%
                }
            %>
        </td>
        <td><button class="button" onclick="showWorklogDetails('<%= id %>')">查看详情</button></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<div class="x12 text-center">
    <span>共<span id="totalRecords"><%=totalSize%></span>条，</span>
    <span><span id="totalPages"><%=(int)((totalSize+1)/20)%></span>页</span>
    <span>当前为第 <span id="currentPage"><%=tpage%></span>页</span>
    <button class="button" id="prevPage" onclick="prevPage()">上一页</button>
    <button class="button" id="nextPage" onclick="nextPage()">下一页</button>
</div>
<% } %>
<!-- 下部：查看详情 -->
<div class="x12" id="worklogDetails">
    <h2>日志详情</h2>
    <button class="button" onclick="refreshWorklogDetails()">刷新</button>
    <pre id="worklogContent">
        点击上方表格内的“查看详情”按钮，即可显示日志详情到此处。
    </pre>
</div>

<script>
    var currentWorklogId = 0;
    function showWorklogDetails(worklogId) {
        currentWorklogId = worklogId;
        $.getJSON('/DZOMS/vehicle/insurance/mail_log_detail_ajax.jsp?id='+worklogId, function (data) {
           $("#worklogContent").text(data.worklog);
        });
    }

    function refreshWorklogDetails() {
        if (currentWorklogId>0){
            $.getJSON('/DZOMS/vehicle/insurance/mail_log_detail_ajax.jsp?id='+currentWorklogId, function (data) {
                $("#worklogContent").text(data.worklog);
            });
        }
    }

    function startTask() {
        $.get('/DZOMS/vehicle/manualDoReceive', function (msg) {
           alert(msg);
            $('form').submit();
        });
    }

    function prevPage() {
        // 实现翻页逻辑，显示上一页的数据
        var currentPage = parseInt($("#currentPage").text());
        if (currentPage>1){
            $("#pageinput").val(currentPage - 1);
            $('form').submit();
        }
    }

    function nextPage() {
        // 实现翻页逻辑，显示下一页的数据
        var currentPage = parseInt($("#currentPage").text());
        if (currentPage< <%=(int)((totalSize+1)/20)%>){
            $("#pageinput").val(currentPage + 1);
            $('form').submit();
        }
    }
</script>
</body>
</html>

