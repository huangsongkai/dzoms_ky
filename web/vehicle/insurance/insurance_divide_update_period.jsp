<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.vehicle.InsuranceDivide2" %>
<%@ page import="java.util.stream.IntStream" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page contentType="text/json;charset=UTF-8" language="java" %>
<%
    String periodString = request.getParameter("period");
    String insuranceIdString = request.getParameter("insuranceId");
    JSONObject json = new JSONObject();
    Transaction tx = null;
    try {
        int insuranceId = Integer.parseInt(insuranceIdString);
        int period = Integer.parseInt(periodString);
        Calendar calendar = Calendar.getInstance();
        Session s = HibernateSessionFactory.getSession();
        Query q1 = s.createQuery("select count(*),sum(d2.money) from InsuranceDivide2 d2 where d2.id.insuranceId=:insuranceId and d2.id.monthRank>=:month ");
        q1.setInteger("insuranceId",insuranceId);
        q1.setInteger("month",calendar.get(Calendar.YEAR)*12 + calendar.get(Calendar.MONTH)+1);
        Object object = q1.uniqueResult();
        long size = (long) ((Object[])object)[0];
        double amount = (double) ((Object[])object)[1];
        if (size>0){
            tx = s.beginTransaction();
            Query q2 = s.createQuery("delete from InsuranceDivide2 where id.insuranceId=:insuranceId and id.monthRank>=:month");
            q2.setInteger("insuranceId",insuranceId);
            q2.setInteger("month",calendar.get(Calendar.YEAR)*12 + calendar.get(Calendar.MONTH)+1);
            q2.executeUpdate();

            final int baseRank = calendar.get(Calendar.YEAR)*12 + calendar.get(Calendar.MONTH)+1;
            List<InsuranceDivide2> list = IntStream.range(0,period)
                    .mapToObj(i->new InsuranceDivide2(baseRank+i,insuranceId,amount/period))
                    .collect(Collectors.toList());
            for (InsuranceDivide2 divide2 : list) {
                s.saveOrUpdate(divide2);
            }
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
