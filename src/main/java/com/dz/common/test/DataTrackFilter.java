package com.dz.common.test;

import com.dz.common.other.Timer;
import com.dz.module.driver.DriverService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.TimerTask;

public class DataTrackFilter implements Filter{

	private static ApplicationContext ctx;

	public static ApplicationContext getCtx() {
		return ctx;
	}

	public void doFilter(ServletRequest trequest, ServletResponse tresponse,
						 FilterChain nextFilter) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) trequest;
		HttpServletResponse response = (HttpServletResponse) tresponse;

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String url = request.getServletPath();

		if(!StringUtils.startsWithAny(url, new String[]{"/res","/login","/user","/uploadFileTo","/isExist","/download","/charge/receipt","/driver/meeting/check","/driver/driverShowApplyCheckPrint"})
				&&!url.trim().equals("/")){
			if(request.getSession().getAttribute("user")==null){
				response.setStatus(401);
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("您尚未登陆，请登录后访问！");
				out.flush();
				out.close();
				return;
			}
		}

		//对资源文件禁用浏览器缓存
		if(StringUtils.startsWith(url,"/data")){
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
		}

		//打印请求内容
		if(!StringUtils.contains(url, "userMessageCount")&&!StringUtils.contains(url, "getWaitDealCount")){
			System.out.print(url);
			String method = request.getMethod();
			System.out.println("\t"+method);
			if(StringUtils.endsWithIgnoreCase("POST",method) && StringUtils.contains(request.getContentType(),"multipart/form-data")){
				MultipartHttpServletRequest multiReq = multipartResolver.resolveMultipart(request);
				request = multiReq;
			}
			Map<String,String[]> maps = request.getParameterMap();
			for(Map.Entry<String,String[]> entry:maps.entrySet()){
				System.out.println(entry.getKey()+"="+decodeStringArray(entry.getValue()));
			}
		}

//		ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());

		nextFilter.doFilter(request, response);
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void init(final FilterConfig filterConfig) throws ServletException {
		String webRootPath =filterConfig.getServletContext().getRealPath("/");
		System.setProperty("com.dz.root" , webRootPath);
		String path =System.getProperty("com.dz.root");
		System.out.println("com.dz.root:"+path);

		new Timer().startTcpServer();

		DataTrackFilter.ctx = WebApplicationContextUtils.getWebApplicationContext(filterConfig.getServletContext());

		java.util.Timer timer = new java.util.Timer();
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
//				ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(filterConfig.getServletContext());
				DriverService driverService = DataTrackFilter.ctx.getBean(DriverService.class);
				driverService.sendMessageToQualification();
			}
		};
		timer.schedule(task,1000,86400000);
	}
	private String decodeStringArray(String[] ss){
		if(ss.length == 0)
			return "";
		if(ss.length == 1)
			return ss[0];
		String s = "";
		for(int i = 0;i < ss.length-1;++i){
			s += ss[i];
			s += " & ";
		}
		s+=ss[ss.length-1];
		return s;
	}  

	private final CommonsMultipartResolver multipartResolver;

	public DataTrackFilter() {
		multipartResolver = new CommonsMultipartResolver();
	}
}
