<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="com.dz.module.contract.SysScript" %>
<%@ page import="com.dz.common.other.ObjectAccess" %><%--
  Created by IntelliJ IDEA.
  User: Wang
  Date: 2018/12/11
  Time: 0:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="application/octed-stream" pageEncoding="utf-8" language="java" %>
<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }
%>
<%
    int id = toInt(request.getParameter("id"));
    if(id==0){
%>
(function(){
    alert("文件不存在！");
})()
<%
    }else {
        SysScript script = ObjectAccess.getObject(SysScript.class,id);
        response.setHeader("Content-Disposition", "attachment;fileName=\""+new String((script.getName()+".js").getBytes("UTF-8"), "ISO-8859-1")+"\"");
        out.append(script.getScript());
    }
%>