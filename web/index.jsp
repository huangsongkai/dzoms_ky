<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.dz.module.user.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 request.getAttribute("authority");
    HashMap<String, HashMap<String,String>> menuItems = (HashMap<String, HashMap<String,String>>) session
            .getAttribute("menuItems");
    User user = (User) session.getAttribute("user");
   %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>主界面</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <!--<link rel="stylesheet" href="/DZOMS/res/css/admin.css">-->

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link href="/DZOMS/res/css/style.css"></link>

<script type="text/javascript">   
function iFrameHeight() {
	try{
var ifm= document.getElementById("iframepage");   
var subWeb = document.frames ? document.frames["iframepage"].document : ifm.contentDocument;   
if(ifm != null && subWeb != null) {
   ifm.height = subWeb.body.scrollHeight+200;
}   }catch(e){}
}    

$(document).ready(function(){
	window.setInterval('iFrameHeight();',3600);
});
</script>

<script>
	$(document).ready(function(){
		$(".my_menu").hide();
	});
	
	function hideAll(){
		$(".my_menu").hide();
	}
	
	function showMenu(name){
		$(".my_menu").hide();
		$("#"+name).show();
		$("[name='main']").attr("src",name+"");
	}
	   
        function menuactive(menua){
            $("li.active").attr("class","");
            $(menua).parent().attr("class","active");
        }
        
		  function menuactive2(menua){
		  	    //var pcls = $(menua).parent().attr("class");
            $("li.my-selected").removeClass("my-selected");
            //$(menua).parent().attr("class",pcls);
            $(menua).parent().parent().addClass("my-selected");
            $(menua).parent().parent().parent().parent().addClass("my-selected");
        }
	
	function showDefaultSubItem(menu){
		var path = $(menu).siblings().find("li.default-show").find("a").attr("href");
		
		if(path!=undefined&&path.length>0)
			$("[name='main']").attr("src",path);
	}

    
</script>
<style>
	.my-selected{
		background-color: black;
	}
	
	.my_menu.my-selected{
		background: #d9e0e7;
	}
</style>
</head>
<body style="background:#d9e0e7;">
	
	
<!--<div class="doc-intro">
    <img src="/DZOMS/res/image/head.jpg" class="img-responsive" width="100%">
</div>-->
    
    <!--<span class="float-right"><strong>您好，<%=user.getUname()%>。</strong>
    <a class="button button-little bg-main" href="vehicle/CreateApproval/approval_list.jsp" target="main">查看消息</a>
    <a href="/DZOMS" target="_top">注销登录</a>-->
    <!--</span>-->
        <button class="button icon-navicon margin-small-bottom" data-target="#nav-bg1"></button>
        <div class=" bg-main bg-inverse radius " id="nav-bg1">
            <ul class="nav nav-inline nav-menu clearfix  nav-tabs nav-big ">
               <li class="nav-head"></li>
				<li><a href="main.jsp" target="main" onclick="hideAll();menuactive(this)"  class="icon-home"> 首页</a></li>
                <%
               
                if(menuItems.containsKey("合同")){
                	out.println("<li><a id=\"contractMenuBar\" href=\"javascript:\" class=\"icon-file-text\" onclick=\"menuactive(this);showMenu('contract')\"> 合同管理</a></li>");
                }
                
                if(menuItems.containsKey("车辆"))
	                	out.println("<li><a id=\"vehicleMenuBar\" href=\"javascript:\" class=\"icon-shopping-cart\" onclick=\"menuactive(this);showMenu('vehicle')\"> 车辆管理</a></li>");
	            if(menuItems.containsKey("驾驶员"))
	                	out.println("<li><a id=\"driverMenuBar\" href=\"javascript:\"  class=\"icon-user\" onclick=\"menuactive(this);showMenu('driver')\"> 驾驶员管理</a></li>");
	            if(menuItems.containsKey("财务"))
	                	out.println("<li><a id=\"financeMenuBar\" href=\"javascript:\"  class=\"icon-file\" onclick=\"menuactive(this);showMenu('finance')\"> 财务管理</a></li>");
	            if(menuItems.containsKey("审批管理"))
	                	out.println("<li><a id=\"applyManageMenuBar\" href=\"javascript:showMenu('apply_manage')\"  class=\"icon-file\" onclick=\"menuactive(this)\"> 审批管理</a></li>");
                
                
               /*  String item;
                Iterator<Map.Entry<String, HashMap<String, String>>> iter = menuItems.entrySet().iterator();
              	
                for(int i = 0;i<menuItems.size();i++)
                {
                	item = iter.next().getKey();
                	if(item.equals("合同"))
                		out.println("<li><a href=\"javascript:showMenu('contract')\" class=\"icon-file-text\" onclick=\"menuactive(this)\"> 合同管理</a></li>");
               		if(item.equals("车辆"))
	                	out.println("<li><a href=\"javascript:showMenu('vehicle')\" class=\"icon-shopping-cart\" onclick=\"menuactive(this)\"> 车辆管理</a></li>");
	                if(item.equals("驾驶员"))
	                	out.println("<li><a href=\"javascript:showMenu('driver')\"  class=\"icon-user\" onclick=\"menuactive(this)\"> 驾驶员管理</a></li>");
	                if(item.equals("财务"))
	                	out.println("<li><a href=\"javascript:showMenu('finance')\"  class=\"icon-file\" onclick=\"menuactive(this)\"> 财务管理</a></li>");
	                if(item.equals("审批管理"))
	                	out.println("<li><a href=\"javascript:showMenu('apply_manage')\"  class=\"icon-file\" onclick=\"menuactive(this)\"> 审批管理</a></li>");
	                if(item.equals("其它"))
	                	out.println("<li><a href=\"javascript:showMenu('other')\"  class=\"icon-th-list\" onclick=\"menuactive(this)\"> 其它</a></li>");
                } */ %>
            </ul>
        </div>
        
        <jsp:include page="main_menu.jsp">
        	<jsp:param value="contract" name="menu"/>
        </jsp:include>
        <jsp:include page="main_menu.jsp">
        	<jsp:param value="vehicle" name="menu"/>
        </jsp:include>
        <jsp:include page="main_menu.jsp">
        	<jsp:param value="driver" name="menu"/>
        </jsp:include>
        <jsp:include page="main_menu.jsp">
        	<jsp:param value="finance" name="menu"/>
        </jsp:include>
        <jsp:include page="main_menu.jsp">
        	<jsp:param value="apply_manage" name="menu"/>
        </jsp:include>
<%--         <jsp:include page="menu_other.jsp"></jsp:include>
 --%>   
 <div class="padding">
 
      <div >
      		
      	<!--[if IE]>
      	    <iframe src="main.jsp" name="main" width="100%" id="iframepage" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" onLoad="iFrameHeight()"/>
      	<![endif]-->
		<!--[if !IE]>-->
   			<iframe src="main.jsp" name="main" width="100%" id="iframepage" style="border:none;scrolling:no; frameborder:0;marginheight:0; marginwidth:0;" onLoad="iFrameHeight()" ></iframe>
		<!-- <![endif]-->
      </div>
     
</div>
</body>
</html>