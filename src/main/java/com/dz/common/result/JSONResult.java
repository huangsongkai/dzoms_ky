package com.dz.common.result;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.util.ValueStack;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.json.JettisonMappedXmlDriver;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.StrutsResultSupport;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 *
 */
public class JSONResult extends StrutsResultSupport{
	private static final long serialVersionUID = 1L;
	private HttpServletResponse res;
	@Override
	protected void doExecute(String arg0, ActionInvocation arg1)
			throws Exception {
        res = ServletActionContext.getResponse();
        res.setCharacterEncoding("utf-8");
        ValueStack vs = arg1.getStack();
        Object jsonObject = vs.findValue("jsonObject") != null?vs.findValue("jsonObject"):new Object();
        XStream xstream = new XStream(new JettisonMappedXmlDriver());
        xstream.alias("ItemTool", jsonObject.getClass());
        String s = xstream.toXML(jsonObject);
        PrintWriter pw = res.getWriter();
		pw.print(s);
		pw.flush();
		pw.close();
	}
}
