<%@ page import="org.hibernate.Session"%>
<%@ page import="com.dz.common.factory.HibernateSessionFactory"%>
<%@ page import="org.hibernate.Query"%>
<%@ page import="org.json.JSONObject"%>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    String logIdString = request.getParameter("id");
    int logId = 0;
    try{
        logId = Integer.parseInt(logIdString);
    }catch (Exception ignored){}

    Session hsession = HibernateSessionFactory.getSession();
    Query query = hsession.createSQLQuery("select worklog from insurance_import_log where id = :id");
    query.setInteger("id", logId);
    query.setMaxResults(1);
    String worklog = (String) query.uniqueResult();
    JSONObject jsonObject = new JSONObject();
    jsonObject.put("worklog", worklog);
%>
<%=jsonObject.toString()%>
