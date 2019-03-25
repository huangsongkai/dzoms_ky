package com.dz.module.user;

import com.dz.common.global.GenerateKeyHash;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.BaseAction;
import com.dz.common.other.ObjectAccess;

import javax.servlet.http.Cookie;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
public class UserAction extends BaseAction {

	private final class AuthorityPredicate implements Predicate {
		private String mname,tname;
		
		@SuppressWarnings("unused")
		public AuthorityPredicate(String mname) {
			this(mname,null);
		}
		
		public AuthorityPredicate(String mname,String tname) {
			this.mname=mname;
			this.tname=tname;
			
		}

		@Override
		public boolean evaluate(Object arg0) {
			Authority authority = (Authority) arg0;
			
			return StringUtils.equals(mname, authority.getMname())
					&& StringUtils.equals(tname, authority.getTname());
		}
	}

	private User user; // 定义值对象
	@Autowired
	private ManagerService userService; // 定义值对象
	
	private int theme;

	public ManagerService getUserService() {
		return userService;
	}

	public void setUserService(ManagerService userService) {
		this.userService = userService;
	}

	/**
	 * 通过DomainModel方式接收参数
	 * 
	 * @param user
	 */
	public void setUser(User user) {
		this.user = user;
	}

	public User getUser() {
		return user;
	}

	/*
	 * public String userSave() { System.out.println(user);
	 * 
	 * public String userSave() { boolean flag = userService.saveUser(user); if
	 * (!flag) { return ERROR; }
	 * 
	 * return SUCCESS; }
	 */

	public String userLogin() {
		String result = userService.userLogin(user);

		Relation_urDaoImpl relation = new Relation_urDaoImpl();
		if (result.equals("error_uname")) {
			request.setAttribute("msgStr", "用户名不存在！");
			return "login_failed";
		} else if (result.equals("error_upwd")) {
			request.setAttribute("msgStr", "密码不正确！");
			return "login_failed";
		} else{
			Map<String, List<Authority>> menuItems = new HashMap<String, List<Authority>>();
			ArrayList<Authority> authority  = relation.queryAuthorityByUser(result);
			session.setAttribute("currentmatter", new HashMap<String, ArrayList<String>>());
			session.setAttribute("authority", authority);
			User _user = userService.getUser(user);
			session.setAttribute("user",_user);

			List<Role> roles = relation.queryRoleByUser(""+_user.getUid());
			session.setAttribute("roles", roles);
			
			for(int i = 0;i<authority.size();i++)
			{
				String gname = authority.get(i).getGname();
				String mname = authority.get(i).getMname();
				String tname = authority.get(i).getTname();
				
				if(!menuItems.containsKey(gname))		//添加一级菜单项
				{
					menuItems.put(gname, new ArrayList<Authority>());
				}
				
				if(!CollectionUtils.exists(menuItems.get(gname), new AuthorityPredicate(mname,tname)))	//添加二级菜单项
				{
					menuItems.get(gname).add(authority.get(i));
				}
			}
			session.setAttribute("menuItems", menuItems);
			Cookie cookie;
			try {
				cookie = new Cookie("LoginName", URLEncoder.encode(user.getUname(),"utf-8"));
				cookie.setMaxAge(24*60*60*30); //一个月内有效
				response.addCookie(cookie);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return "login_success";
		}
	}
	
	public void userNames() throws IOException{
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		JSONArray jarr = new JSONArray();
		
		List<User> users = ObjectAccess.query(User.class, null);
		
		for (User user : users) {
			if(!StringUtils.containsAny(user.getUname(), "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")){
				JSONObject json = new JSONObject();
				json.put("name", user.getUname());
				jarr.add(json);
			}
		}
		
		out.print(jarr.toString());
		out.flush();
		out.close();
	}
	
	/*通过.NET客户端登陆*/
	public void userLoginFromOut() throws IOException{
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		JSONObject json = new JSONObject();
		
		String result = userService.userLogin(user);
		Relation_urDaoImpl relation = new Relation_urDaoImpl();
		if (result.equals("error_uname")) {
			json.put("state", "error");
			json.put("msg",  "用户名不存在！");
		} else if (result.equals("error_upwd")) {
			json.put("state", "error");
			json.put("msg",  "密码不正确！");
		} else{
			User _user = userService.getUser(user);
			session.setAttribute("user",_user);

			List<Role> roles = relation.queryRoleByUser(""+_user.getUid());
			session.setAttribute("roles", roles);
			
			JSONArray jarr = new JSONArray();
			for (Role role : roles) {
				if(role.getRname().equals("聘用录入")){
					jarr.add("聘用录入");
				}else if(role.getRname().equals("发票销售")){
					jarr.add("发票销售");
				}else if(role.getRname().equals("驾驶员修改")){
					jarr.add("驾驶员修改");
				}
			}
			
			json.put("state","success");
			json.put("msg",  "登录成功！");
			json.put("roles", jarr);	
		}
		
		out.print(json.toString());
		out.flush();
		out.close();
	}
	
	public String userLogout(){
		session.removeAttribute("user");
		request.setAttribute("msgStr", "账户已退出！");
		return "login_failed";
	}

	
	public void userMessageCount() throws IOException{
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		User user = (User)session.getAttribute("user");
		
		long count = ObjectAccess.execute("select count(*) from MessageToUser where alreadyRead=false and uid="+user.getUid());
		out.print(count);
		out.flush();
		out.close();
	}
	
	public int getTheme() {
		return theme;
	}

	public void setTheme(int theme) {
		this.theme = theme;
	}
	
	
}
