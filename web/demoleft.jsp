<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page language="java" import="java.util.*,java.util.Map.Entry"%>
<%@page import="com.dz.common.other.MenuUtil"%>
<%@page import="com.dz.module.user.Authority"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	Map<String, List<Authority>> menuItems = 
		(Map<String, List<Authority>>) session.getAttribute("menuItems");
	
	String menu = request.getParameter("menu");
	
	Map<String,String> idMap=new HashMap<String,String>();
	idMap.put("contract","合同");
	idMap.put("vehicle","车辆");
	idMap.put("driver","驾驶员");
	idMap.put("finance","财务");
	idMap.put("apply_manage","审批管理");
	idMap.put("activity","新功能展示");
	idMap.put("manage","系统管理");
	idMap.put("statistics","统计分析");
%>
<!DOCTYPE html>
<html>
	<head>
  <meta charset="utf-8">
  
  <!-- DNS prefetch -->
  <link rel=dns-prefetch href="//fonts.googleapis.com">

  <!-- Use the .htaccess and remove these lines to avoid edge case issues.
       More info: h5bp.com/b/378 -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title>Table :: Grape - Professional &amp; Flexible Admin Template</title>
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Mobile viewport optimized: j.mp/bplateviewport -->
  <meta name="viewport" content="width=device-width,initial-scale=1">

  <!-- Place favicon.ico and apple-touch-icon.png in the root directory: mathiasbynens.be/notes/touch-icons -->

  <!-- CSS: implied media=all -->
  <!-- CSS concatenated and minified via ant build script-->
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
  <link rel="stylesheet" href="/DZOMS/res/mainPage/css/jquery-ui-1.8.15.custom.css"> <!-- jQuery UI, optional -->
  <!-- end CSS-->
  
  <!-- Fonts -->
 <!-- <link href="//fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet" type="text/css">-->
  <!-- end Fonts-->

  <!-- More ideas for your <head> here: h5bp.com/d/head-Tips -->

  <!-- All JavaScript at the bottom, except for Modernizr / Respond.
       Modernizr enables HTML5 elements & feature detects; Respond is a polyfill for min/max-width CSS3 Media Queries
       For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->
  <script src="/DZOMS/res/mainPage/js/libs/modernizr-2.0.6.min.js"></script>
  <script src="/DZOMS/res/mainPage/js/libs/jquery-1.6.2.min.js"></script>
  <script>
	 function setiframeH(size){
	 	if (size<1000) {
	 		size=1000;
	 	} 
	 	$("#body-right").height([size]);
	 	$('[name="body"]',window.parent.document).height([size]);
	 };

function refreshMsgCount(){
	$.post("/DZOMS/userMessageCount",{},function(data){
		try{
			var c = parseInt(data);
			$("#msg_count").text(c);
		}catch(e){
			$("#msg_count").text(0);
		}
	});
}

var ck =0,ct=0;
function setApprovalCount(){
	if (ck >= 2) {
		$("#approval_count").text(ct);
	}
}

function refreshApprovalCount(){
	ck =0;
	ct=0;
	$.post("/DZOMS/common/getWaitDealCount",{waitType:'废业审批'},function(data){
		try{
			var c = parseInt(data);
			ct+=c;
		}catch(e){
			
		}
		ck++;
		setApprovalCount();
	});
	$.post("/DZOMS/common/getWaitDealCount",{waitType:'开业审批'},function(data){
		try{
			var c = parseInt(data);
			ct+=c;
		}catch(e){
			
		}
		ck++;
		setApprovalCount();
	});
}


$(document).ready(function(){
	refreshMsgCount();
	refreshApprovalCount();
	setInterval(refreshMsgCount,10000);
	setInterval(refreshApprovalCount,10000);
});

  </script>
</head>
	<body>
	
<div id="container">
  	<!-- Begin of #header -->
  
    
    <!--<div class="fix-shadow-bottom-height"></div>-->
	<!-- Begin of Sidebar -->
    <aside id="sidebar">
    	
    
		<i></i>
		<!-- Begin of #login-details -->
		<section id="login-details">
    		<img class="img-left framed" src="/DZOMS/res/mainPage/img/misc/avatar_small.png" alt="Hello Admin">
    		<h3>用户名</h3>
    		<h2><a class="user-button" href="javascript:void(0);"><s:property value='%{#session.user.uname}'/>&nbsp;<span class="arrow-link-down"></span></a></h2>
    		<ul class="dropdown-username-menu">
    			<li><a href="/DZOMS/message.jsp" target="body-right">消息</a></li>
    			<li><a href="/DZOMS/userLogout" target="_top">登出</a></li>
    		</ul>
    		<a id="msg_count" href="/DZOMS/message.jsp" class="button red" target="body-right">0</a>
    		<a id="approval_count" href="/DZOMS/apply_manage/" class="button" target="body-right">0</a>
    		<div class="clearfix"></div>
  		</section> <!--! end of #login-details -->
    	
    	<!-- Begin of Navigation -->
    	<nav id="nav">
	    	<ul class="menu collapsible shadow-bottom">
	    		
	    	<%
			List<Authority> vehicle = (List<Authority>)menuItems.get(idMap.get(menu));
			Map<String,List<Authority>> map = MenuUtil.convert(vehicle);
			
			for(String key:map.keySet()){
				List<Authority> items = map.get(key);
				if(items.size()==1){
					Authority item = items.get(0);
					//item.getIcon() item.getVisible() item.getCssClass()
			%>
			<li>
				<a onclick="setiframeH(<%=item.getFrameSize()%>)" href="<%=item.getUrl()%>" target="body-right">
			<% 		if(org.apache.commons.lang3.StringUtils.isEmpty(item.getImg())){ %>
					<img src="/DZOMS/res/mainPage/img/icons/packs/fugue/16x16/ui-tab-content.png">
			<% 		}else{ %>
					<img src="/DZOMS/res/mainPage/img/icons/packs/fugue/16x16/<%=item.getImg()%>.png">
			<% 		}%>
						<%=item.getMname()%>
						<!--<span class="badge">2</span>-->
				</a>
			</li>
			<%
				}else{
					
					String html="";
					Authority titleItem=null;
					
					int showItemSize=0;
					for(Authority item:items){
						if(!item.getVisible()){
							titleItem=item;
							continue;
						}
						showItemSize++;
					}
					
					if(titleItem==null){
			%>
			
			<li>
	    		<a href="javascript:void(0);">
	    			<img src="/DZOMS/res/mainPage/img/icons/packs/fugue/16x16/ui-tab-content.png">
	    				<%=key%>
	    				<span class="badge grey"><%=showItemSize%></span>
	    		</a>
	    		<ul class="sub">
	    			
			<%
					}else{
			%>
			<li>
	    		<a href="javascript:void(0);">
	    	<% 			if(org.apache.commons.lang3.StringUtils.isEmpty(titleItem.getImg())){ %>
					<img src="/DZOMS/res/mainPage/img/icons/packs/fugue/16x16/clipboard-list.png">
			<% 			}else{ %>
					<img src="/DZOMS/res/mainPage/img/icons/packs/fugue/16x16/<%=titleItem.getImg()%>.png">
			<% 			}%>
	    				<%=key%>
	    				<span class="badge grey"><%=showItemSize%></span>
	    		</a>
	    		<ul class="sub">
			<% 		}
					
					for(Authority item:items){
						if(!item.getVisible()){
							titleItem=item;
							continue;
						}
			%>
					<li>
						<a onclick="setiframeH(<%=item.getFrameSize()%>)" href="<%=item.getUrl()%>"  target="body-right"><%=item.getTname()%></a>
					</li>
			<%
					}
			%>
				</ul>
			</li>
			<%
				}
			}
			%>
	    	</ul>
	    	
    	</nav> <!--! end of #nav -->
    	
    </aside> <!--! end of #sidebar -->
    
    <!-- Begin of #main -->
    <div id="main" role="main">
    	
    	
		<!--<div id="title-bar">
			<ul id="breadcrumbs">
				<li><a href="dashboard.html" title="Home"><span id="bc-home"></span></a></li>
				<li class="no-hover">合同管理</li>
			</ul>
		</div>
		
		<div class="shadow-bottom shadow-titlebar"></div>
		-->
		<!-- Begin of #main-content -->
		<div id="main-content">
			  <iframe  id="body-right" src="/DZOMS/<%=menu%>/" width="100%" scrolling="no" height="12000px" name="body-right"  style="border: 0px;"></iframe>
		</div> <!--! end of #main-content -->
  </div> <!--! end of #main -->
  </div> <!--! end of #container -->


  <!-- scripts concatenated and minified via ant build script-->
  <script defer src="/DZOMS/res/mainPage/js/plugins.js"></script> <!-- lightweight wrapper for consolelog, optional -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery-ui-1.8.15.custom.min.js"></script> <!-- jQuery UI -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.notifications.js"></script> <!-- Notifications  -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.uniform.min.js"></script> <!-- Uniform (Look & Feel from forms) -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.validate.min.js"></script> <!-- Validation from forms -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.dataTables.min.js"></script> <!-- Tables -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.tipsy.js"></script> <!-- Tooltips -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/excanvas.js"></script> <!-- Charts -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.visualize.js"></script> <!-- Charts -->
  <script defer src="/DZOMS/res/mainPage/js/mylibs/jquery.slidernav.min.js"></script> <!-- Contact List -->
  <script defer src="/DZOMS/res/mainPage/js/common.js"></script> <!-- Generic functions -->
  <script defer src="/DZOMS/res/mainPage/js/script.js"></script> <!-- Generic scripts -->
  
 
  <!-- end scripts-->

  <!-- Prompt IE 6 users to install Chrome Frame. Remove this if you want to support IE 6.
       chromium.org/developers/how-tos/chrome-frame-getting-started -->
  <!--[if lt IE 7 ]>
    <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
    <script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
  <![endif]-->
  
</body>
</html>