<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.module.vehicle.InsuranceDivide2" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>保险未摊销查询</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
      $(document).ready(function () {
          $("#divide").click(function () {

          });
      });
  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>保险管理</li>
                <li>保险未摊销查询</li>
    </ul>
</div>
    <%!
        static String nullIf(String val){
            return val==null?"":val;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
    %>
<%
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
%>
<div class="line">
	<form action="#" method="post" class="form-inline">
        <label>开始年月</label>
        <input type="text" class="input datetimepicker" name="startTime" value="<%=nullIf(startTime)%>">
        <label>结束年月</label>
        <input type="text" class="input datetimepicker" name="endTime" value="<%=nullIf(endTime)%>">
        <input type="submit" value="查询" class="button bg-main">
        <input id="divide" type="button" value="批量生成摊销" class="button bg-main">
   </form>
</div>
    <%
        String err_mag = "";
        List result = null;

        if(startTime==null){
            startTime = "2010-01";
        }
        if (endTime==null){
            endTime = "2100-01";
        }

        make_table:
    {
        Session hsession = HibernateSessionFactory.getSession();
        Query query = hsession.createQuery("select v.licenseNum,v.carframeNum,ins.insuranceNum,ins.insuranceMoney,ins.beginDate,ins.endDate,v.insuranceBase\n" +
                "from Insurance ins,Vehicle v \n" +
                "where ins.carframeNum = v.carframeNum \n" +
                "and ins.insuranceClass = \"商业保险单\"\n" +
                "AND ins.beginDate >= :beginDate\n" +
                "and ins.endDate <= :endDate\n" +
                "AND NOT EXISTS(SELECT 1 from InsuranceDivide2 d WHERE d.id.insuranceId=ins.id) ");
        query.setString("beginDate",startTime);
        query.setString("endDate",endTime);

        result = query.list();
        HibernateSessionFactory.closeSession();
    }
    %>
    <div id="show" style="width: 100%;height: 800px;overflow:scroll;">
        <%=err_mag%>
        <% if(result!=null && result.size()>0){ %>
        <table class="table table-bordered table-responsive">
            <thead>
            <tr>
                <th>车牌号</th>
                <th>车架号</th>
                <th>保单号</th>
                <th>金额</th>
                <th>起始时间</th>
                <th>结束时间</th>
                <th>基础保费</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(int i = 1; i < result.size(); i++) {
                    Object[] data = (Object[]) result.get(i);
            %>
            <tr>
                <td><%=data[0]%></td>
                <td><%=data[1]%></td>
                <td><%=data[2]%></td>
                <td><%=data[3]%></td>
                <td><%=data[4]%></td>
                <td><%=data[5]%></td>
                <td><%=data[6]%></td>
            </tr>
            <%
                    }
            %>
            </tbody>
        </table>
        <%}%>
    </div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>
</html>
