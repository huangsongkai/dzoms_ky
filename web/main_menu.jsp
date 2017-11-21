<%@page import="com.dz.common.other.MenuUtil"%>
<%@page import="com.dz.module.user.Authority"%>
<%@ page language="java" import="java.util.*,java.util.Map.Entry" pageEncoding="UTF-8"%>
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
	idMap.put("other","其它");
%>
<div class="margin-small">
<div class="my_menu " id="<%=menu%>">
      
        <ul class="nav nav-menu nav-inline selected-inline margin-small  nav-justified">
			<%
			List<Authority> vehicle = (List<Authority>)menuItems.get(idMap.get(menu));
			Map<String,List<Authority>> map = MenuUtil.convert(vehicle);
			
			for(String key:map.keySet()){
				List<Authority> items = map.get(key);
				if(items.size()==1){
					Authority item = items.get(0);
					//item.getIcon() item.getVisible() item.getCssClass()
					
					out.println("<li class=\""+item.getCssClass()+" firstmenu\">"+"<div>"+"<a href=\""+item.getUrl()+"\" target=\"main\" onclick=\"menuactive2(this)\">"+"<i class=\""+item.getIcon()+"\" style=\"font-size: 40px;color:#ffffff \"></i>"+"<h4><strong style=\"color:#ffffff\">"+item.getMname()+"</strong></h4>"+"</a>"+"</div>"+"</li>");
				}else{
					
					String html="";
					Authority titleItem=null;
					for(Authority item:items){
						if(!item.getVisible()){
							titleItem=item;
							continue;
						}
						html +=("<li class=\""+item.getCssClass()+"\"><div><a href=\""+item.getUrl()+"\" target=\"main\" onclick=\"menuactive2(this)\">"+item.getTname()+"</a></div></li>");
					}
					
					if(titleItem==null){
						out.println("<li class=\"firstmenu\">"+"<a href='#' onclick=\"menuactive2(this),showDefaultSubItem(this)\">"+"<i class=\"icon-user\" style=\"font-size: 40px;color:#ffffff\"></i>"+"<h4><strong style=\"color:#ffffff\">"+key+"</strong></h4>"+"<span class='downward'></span>"+"</a>"+"<ul class='drop-menu'>");
					}else{
						out.println("<li class=\""+titleItem.getCssClass()+" firstmenu\">"+"<div>"+"<a href='#' onclick=\"menuactive2(this),showDefaultSubItem(this)\">"+"<i class=\""+titleItem.getIcon()+"\" style=\"font-size: 40px;color:#ffffff\"></i>"+"<h4><strong style=\"color:#ffffff\">"+key+"</strong></h4>"+"<span class='downward'></span>"+"</a>"+"</div>"+"<ul class='drop-menu'>");
					}
					out.println(html);
					
					out.println("</ul></li>");
				}
			}
			%>
		</ul>
</div>
</div>