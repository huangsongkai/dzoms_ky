<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.HibernateException" %>
<%@ page contentType="text/json;charset=UTF-8" language="java" %>
<%
    String amountString = request.getParameter("amount");
    String insuranceIdString = request.getParameter("insuranceId");
    JSONObject json = new JSONObject();
    Transaction tx = null;
    try {
        int insuranceId = Integer.parseInt(insuranceIdString);
        double amount = Double.parseDouble(amountString);
        Calendar calendar = Calendar.getInstance();
        Session s = HibernateSessionFactory.getSession();
        Query q1 = s.createQuery("select count(*) from InsuranceDivide2 d2 where d2.id.insuranceId=:insuranceId and d2.id.monthRank>=:month ");
        q1.setInteger("insuranceId",insuranceId);
        q1.setInteger("month",calendar.get(Calendar.YEAR)*12 + calendar.get(Calendar.MONTH)+1);
        long size = (Long) q1.uniqueResult();
        if (size>0){
            tx = s.beginTransaction();
            Query q2 = s.createQuery("update InsuranceDivide2 set money=:money where id.insuranceId=:insuranceId and id.monthRank>=:month");
            q2.setInteger("insuranceId",insuranceId);
            q2.setInteger("month",calendar.get(Calendar.YEAR)*12 + calendar.get(Calendar.MONTH)+1);
            q2.setDouble("money",amount/size);
            q2.executeUpdate();
            tx.commit();
        }
        json.put("status",true);
    }catch (Exception ex){
        if (tx!=null){
            tx.rollback();
        }
        json.put("status",false);
        json.put("msg",ex.getMessage());
    }
%>
<%=json.toString()%>
