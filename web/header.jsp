<%@ page language="java" import="java.util.*,java.util.Map.Entry,
    com.dz.module.user.User"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    request.getAttribute("authority");
    HashMap<String, HashMap<String,String>> menuItems = (HashMap<String, HashMap<String,String>>) session
            .getAttribute("menuItems");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>后台管理</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
</head>
<body>

    <!-- 主页面 -->
    <div class="admin-navbar" style="height:130px;background-image: url('res/image/head.jpg');"></div>
    <div class="adminmin-bread" style="text-align:right;">
            <span class="float-right">您好，<%=user.getUname()%>，欢迎您的光临。
                <a class="button button-little bg-main" href="vehicle/CreateApproval/approval_list.jsp" target="firstmain">查看消息</a>
                <a class="button button-little bg-yellow" href="/DZOMS" target="_top">注销登录</a>
            </span>
            <div style="text-align:left;">
            <ul class="nav nav-inline admin-nav">
                <li><a href="main.jsp" target="firstmain"  class="icon-home"> 开始</a></li>
                <%
                String item;
                Iterator<Entry<String, HashMap<String, String>>> iter = menuItems.entrySet().iterator();
                for(int i = 0;i<menuItems.size();i++)
                {
                	item = iter.next().getKey();
                	if(item.equals("合同"))
                		out.println("<li><a href=\"main_menu.jsp?menu=contract\" target=\"firstmain\" class=\"icon-file-text\"> 合同</a></li>");
               		if(item.equals("车辆"))
	                	out.println("<li><a href=\"main_menu.jsp?menu=vehicle\" target=\"firstmain\" class=\"icon-shopping-cart\"> 车辆</a></li>");
	                if(item.equals("驾驶员"))
	                	out.println("<li><a href=\"main_menu.jsp?menu=driver\" target=\"firstmain\" class=\"icon-user\"> 驾驶员</a></li>");
	                if(item.equals("财务"))
	                	out.println("<li><a href=\"main_menu.jsp?menu=finance\" target=\"firstmain\" class=\"icon-file\"> 财务</a></li>");
	                if(item.equals("其它"))
	                	out.println("<li><a href=\"main_menu.jsp?menu=other\" target=\"firstmain\" class=\"icon-th-list\"> 其它</a></li>");
                } %>
            </ul>
            </div>
    </div>
   

</body>
</html>