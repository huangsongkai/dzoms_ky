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
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes" />
    <meta name="renderer" content="webkit">
    <title>大众信息化管理平台</title>
  <link rel="shortcut icon" href="/DZOMS/res/mainPage/img/htmllogo.png" type="image/x-icon" />
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/style.css"> <!-- Generic style (Boilerplate) -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/960.fluid.css"> <!-- 960.gs Grid System -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/main.css"> <!-- Complete Layout and main styles -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/buttons.css"> <!-- Buttons, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/lists.css"> <!-- Lists, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/icons.css"> <!-- Icons, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/notifications.css"> <!-- Notifications, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/typography.css"> <!-- Typography -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/forms.css"> <!-- Forms, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/tables.css"> <!-- Tables, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/charts.css"> <!-- Charts, optional -->
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/jquery-ui-1.8.15.custom.css"> 
	<script src="/DZOMS/res/mainPage/js/libs/modernizr-2.0.6.min.js"></script>
	
<!--	<script type="text/javascript" src="/DZOMS/res/js/jquery.js" ></script>
-->	<script type="text/javascript" src="/DZOMS/res/mainPage/js/libs/jquery-1.6.2.js" ></script>
  <script defer src="/DZOMS/res/mainPage/js/plugins.js"></script> <!-- lightweight wrapper for consolelog, optional -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery-ui-1.8.15.custom.min.js"></script> <!-- jQuery UI -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.notifications.js"></script> <!-- Notifications  -->
  
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.validate.min.js"></script> <!-- Validation from forms -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.dataTables.min.js"></script> <!-- Tables -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.tipsy.js"></script> <!-- Tooltips -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/excanvas.js"></script> <!-- Charts -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.visualize.js"></script> <!-- Charts -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.slidernav.min.js"></script> <!-- Contact List -->
  <script defer src="/DZOMS/res/mainPage/js/common.js"></script> <!-- Generic functions -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.uniform.js"></script>
  <script defer src="/DZOMS/res/mainPage/js/script.js"></script> 
<script type="text/javascript">   
function setTheIframeH(size){
	if (size<1000) {
	 	size=1000;
	 } 
	 try{
	 	$('[name="body"]').height([size]);
	 	$("#body-right",document.frames("body").document).height([size]);
	 }catch(e){
	 	//TODO handle the exception
	 }
};
  function miaodian(){
	 	
	 	$("#loct").click();
	 }
</script>

</head>
<body id="top">
	<a id="top_anchor"></a>
	<a href="#top_anchor"><span style="display: none;" class="top-anchor-span-for-click">跳到顶部</span></a>

	<div id="container">
       <div id="header-surround"style="padding-bottom: 1px;">
       	<header id="header" style="height:120px;">
    	
    	<!-- Place your logo here -->
		<img src="/DZOMS/res/mainPage/img/123.png" alt="Grape" class="logo" style="width: 220px;">
		
		<div class="divider-header divider-vertical"></div>
		<!--<a href="javascript:void(0);" onclick="$('#info-dialog').dialog({ modal: true });"><span class="btn-info"></span></a>
		
			
			<div id="info-dialog" title="About" style="display: none;">
				<p>系统更新时间：2015年2月8日</p>
			    <p> 系统版本号：DZ-00313</p>
				<p>技术提供哈尔滨工业大学</p>
			</div> -->
		
	<ul class="shortcut-list toolbox-header">
		<li>
			<a href="main2.jsp" onclick="setTheIframeH(600)" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/agt_home.png">
									首页
			</a>
		</li>

		<% if(menuItems.containsKey("合同")){ %><li>
			<a href="demoleft.jsp?menu=contract" onclick="setTheIframeH(1350)" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/kate.png" style="width: 50px;">
								       合同管理
			</a>
		</li><% } %>
		<% if(menuItems.containsKey("车辆")){ %><li>
			<a href="demoleft.jsp?menu=vehicle" onclick="setTheIframeH(1350)" target="body">
				<img src="res/mainPage/img/icons/packs/crystal/48x48/apps/package_games_arcade.png" style="width: 50px;">
								       车辆管理
			</a>
		</li><% } %>
		<% if(menuItems.containsKey("驾驶员")){ %><li>
			<a href="demoleft.jsp?menu=driver" onclick="setTheIframeH(1350)" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/kuzer.png">
									驾驶员管理
			</a>
		</li><% } %>
		<% if(menuItems.containsKey("财务")){ %><li>
			<a href="demoleft.jsp?menu=finance" onclick="setTheIframeH(800)"  target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/mimetypes/vcard.png">
									财务管理
			</a>
		</li><% } %>
		<% if(menuItems.containsKey("审批管理")){ %><li>
			<a href="demoleft.jsp?menu=apply_manage" onclick="setTheIframeH(800)" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/mimetypes/kexi_kexi.png">
									审批管理
			</a>
		</li><% } %>

		<%-- <% if(menuItems.containsKey("档案")){ %> --%>
		<li>
			<a href="javascript:void(0);">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/mydocuments.png">
									计划管理
			</a>
		</li>
		<%-- <% } %> --%>
		<% if(menuItems.containsKey("统计分析")){ %>
		<li>
			<a href="demoleft.jsp?menu=statistics" onclick="setTheIframeH(800)" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/xmag.png">
									统计分析
			</a>
		</li>
		<% } %>
		<%-- <% if(menuItems.containsKey("数据分析")){ %> --%>
		<% if(menuItems.containsKey("系统管理")){ %><li>
			<a href="demoleft.jsp?menu=manage" onclick="setTheIframeH(1350)" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/personal.png">
									系统管理
			</a>
		</li><% } %>
	
		<%-- <% } %> --%>
		<%-- <% if(menuItems.containsKey("系统管理")){ %> --%>
		<li>
			<a href="chart.html" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/systemtray.png">
									个人管理
			</a>
		</li>
		<li>
			<a href="demoleft.jsp?menu=activity" target="body">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/mydocuments.png">
									新功能展示
			</a>
		</li>
		<%-- <% } %> --%>
		<li>
			<a href="/DZOMS/userLogout">
				<img src="/DZOMS/res/mainPage/img/icons/packs/crystal/48x48/apps/logout.png">
									退出登陆
			</a>
		</li>
	</ul>
    </header>
    
    </div> <!--! end of #header -->


    <iframe  	name="body"  width="100%" style="min-height: 6000px;overflow-y: auto;"  src="main2.jsp" scrolling="no"></iframe>
    
    <a href="#top"><span id="loct"></span></a>
    <!--<footer id="footer"><div class="container_12">
		<div class="grid_12">
    		<div class="footer-icon align-center"><a class="top" href="#top"></a></div>
		</div>
    </div>
    </footer>-->
  </div> <!--! end of #container -->
</body>
</html>