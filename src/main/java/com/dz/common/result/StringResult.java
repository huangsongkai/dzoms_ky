package com.dz.common.result;

import com.opensymphony.xwork2.ActionInvocation;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.StrutsResultSupport;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;


/**
 * 在所需要使用返回一条提示信息到ajax客户端的Action新增一个名为ajax_message的String实例域即可。
 *最后在配置文件中转向此结果类型即可。
 */
public class StringResult extends StrutsResultSupport {
	private static final long serialVersionUID = 1L;
	private HttpServletResponse res;

	@Override
	protected void doExecute(String arg0, ActionInvocation arg1)
			throws Exception {
		res = ServletActionContext.getResponse();
		res.setContentType("text/plain");
		res.setCharacterEncoding("utf-8");
		String ajax_message = (String)arg1.getStack().findValue("ajax_message");
		PrintWriter pw = res.getWriter();
		pw.println(ajax_message);
		pw.close();
	}
}
