<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="com.dz.module.contract.ContractTemplate2"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.dz.common.convertor.DateTypeConverter"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.dz.module.contract.ContractPlanItem"%>
<%@ page import="java.util.Calendar"%><%@ page import="net.sf.json.JSONArray"%><%@ page import="net.sf.json.JSONObject"%>
<%@ page contentType="application/json" pageEncoding="utf-8" language="java" %>
<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

     static double toDouble(String text){
        try {
            return NumberUtils.createDouble(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0.0;
        }
    }
%>
<%
    int id = toInt(request.getParameter("id"));
    String beginDate = request.getParameter("beginDate");
    String endDate = request.getParameter("endDate");

    DateTypeConverter converter = new DateTypeConverter();

    try{
         ContractTemplate2 template = ObjectAccess.getObject(ContractTemplate2.class,id);
         Date from = (Date) converter.convertFromString(null,new String[]{beginDate},null);
         Date to = (Date) converter.convertFromString(null,new String[]{endDate},null);
         Calendar toCalender = Calendar.getInstance();
         toCalender.setTime(to);
         toCalender.add(Calendar.DATE,1);
         List<String> rentlist = new ArrayList<>();
         List<ContractPlanItem> items = template.generateRents(from,toCalender.getTime());
         for (ContractPlanItem item : items) {
             rentlist.add(item.toStringForPage());
         }
         String lst = ("["+StringUtils.join(rentlist,",")+"]");
         JSONArray jarr = JSONArray.fromObject(lst);
         JSONObject jsonObject = new JSONObject();
         jsonObject.put("id",template.getId());
         jsonObject.put("name",template.getName());
         jsonObject.put("rentFirst",template.getRentFirst());
         jsonObject.put("rentDivideStages",template.getRentDivideStages());
         jsonObject.put("deposit",template.getDeposit());

         jsonObject.put("rentlist",jarr);
         out.print(jsonObject.toString());
    }catch (Exception ex){
        out.print("{}");
    }
%>
