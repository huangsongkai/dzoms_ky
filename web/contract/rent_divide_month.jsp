<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ page import="com.dz.module.contract.RentFirstDivide" %>
<%@ page import="com.dz.module.driver.Driver" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>预付金单月统计</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>

  </script>
    <style>
        tr.tr-yellow{
            background-color: yellow;
        }
        tr.tr-green{
            background-color: green;
        }
        tr.tr-gray{
            background-color: lightgrey;
        }
    </style>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>预付金单月统计</li>
    </ul>
</div>
    <%!
        static String nullIf(String val){
            return val==null?"":val;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
    %>
<%
    String monthString = request.getParameter("month");
%>
<div class="line">
	<form action="#" method="post" class="form-inline">
        <label>月份</label>
        <input type="text" class="input datetimepicker" name="month" value="<%=nullIf(request.getParameter("month"))%>">
        <input type="submit" value="提交" class="button bg-main">
   </form>
</div>
    <%
        String err_mag = "";
        List result = null;

        int monthRank;
        if (StringUtils.isBlank(monthString)){
            Date now = new Date();
            monthRank = (1900 + now.getMonth())*12 + now.getMonth() + 1;
        }else {
            int year = Integer.parseInt(StringUtils.split(monthString.replace("/","-"),"-",2)[0]);
            int month = Integer.parseInt(StringUtils.split(monthString.replace("/","-"),"-",2)[1]);
            monthRank = year*12 + month;
        }

    {
        Session hsession = HibernateSessionFactory.getSession();

        Query query2 = hsession.createQuery("select c.branchFirm, count(distinct c.carNum) as ct,\n" +
"sum(rd.money) as total,\n" +
"sum(case when YEAR (rd.month)*12+MONTH(rd.month)=:month then rd.money else 0 end ) as current,\n" +
"sum(case when YEAR (rd.month)*12+MONTH(rd.month)<:month then rd.money else 0 end ) as finished,\n" +
"sum(case when YEAR (rd.month)*12+MONTH(rd.month)>:month then rd.money else 0 end ) as rest\n" +
"from Contract c,RentFirstDivide rd,Driver d \n" +
"where c.carframeNum=rd.carframeNum and c.idNum=d.idNum \n" +
"and YEAR (rd.month)*12+MONTH(rd.month) >=  YEAR(c.contractBeginDate)*12+MONTH(c.contractBeginDate) \n" +
"AND (( c.state=1 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.abandonedFinalTime)*12+MONTH(c.abandonedFinalTime) ) \n" +
"or ( c.state=0 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.contractEndDate)*12+MONTH(c.contractEndDate) ))\n" +
"AND rd.money <> 0 \n" +
"group by c.branchFirm \n" +
"having sum(case when YEAR (rd.month)*12+MONTH(rd.month)=:month then 1 else 0 end )>0\n" +
"order by (case WHEN c.branchFirm='一部' THEN 1 WHEN c.branchFirm='二部' THEN 2 ELSE 3 END) "
        );
        query2.setInteger("month",monthRank);
        result = query2.list();

        HibernateSessionFactory.closeSession();
    }
    %>
    <div id="show" style="width: 100%;height: 800px;overflow:scroll;">
        <%=err_mag%>
        <% if(result!=null && result.size()>0){
        %>
        <table class="table table-bordered table-responsive">
            <thead>
            <tr>
                <th>部门</th>
                <th>车辆总数</th>
                <th>预付金总额</th>
                <th>本期总额</th>
                <th>累计总额</th>
                <th>未摊销总额</th>
            </tr>
            </thead>
            <tbody>
            <%
                long vehicleNumber=0;
                BigDecimal sum1 = BigDecimal.ZERO;
                BigDecimal sum2 = BigDecimal.ZERO;
                BigDecimal sum3 = BigDecimal.ZERO;
                BigDecimal sum4 = BigDecimal.ZERO;
                for(int i = 0; i < result.size(); i++) {
                Object[] res = (Object[]) result.get(i);
              %>
                <tr>
                    <td><%=res[0]%></td>
                    <td><%=res[1]%><%vehicleNumber += (long)res[1];%></td>
                    <td><%=res[2]%><%sum1 = sum1.add((BigDecimal) res[2]);%></td>
                    <td><%=res[3]%><%sum2 = sum2.add((BigDecimal) res[3]);%></td>
                    <td><%=res[4]%><%sum3 = sum3.add((BigDecimal) res[4]);%></td>
                    <td><%=res[5]%><%sum4 = sum4.add((BigDecimal) res[5]);%></td>
                </tr>
            <%}%>
            </tbody>
            <tfoot>
            <tr>
                <th>全部</th>
                <th><%=vehicleNumber%></th>
                <th><%=sum1%></th>
                <th><%=sum2%></th>
                <th><%=sum3%></th>
                <th><%=sum4%></th>
            </tr>
            </tfoot>
        </table>
        <%}%>
    </div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>
</html>
