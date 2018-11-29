<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ page import="com.dz.module.contract.RentFirstDivide" %>
<%@ page import="com.dz.module.driver.Driver" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.dz.module.vehicle.InsuranceDivide" %><%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-22
  Time: 下午12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>保险摊销单车查询</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
      function carFocus(){
      	$("input[name='licenseNum']").val("黑A");
      }

      $(document).ready(function(){
          $("input[name='licenseNum']").bigAutocomplete({
              url:"/DZOMS/select/VehicleBylicenseNum"
          });
      });
  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>保险管理</li>
                <li>保险摊销单车查询</li>
    </ul>
</div>
    <%!
        static String nullIf(String val){
            return val==null?"":val;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
    %>
<%
    String licenseNum = request.getParameter("licenseNum");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
%>
<div class="line">
	<form action="#" method="post" class="form-inline">
        <label style="margin-left: 40px;">车牌号</label>
        <input type="text" class="input" value="黑A" name="licenseNum" value="<%=nullIf(licenseNum)%>" onfocus="carFocus()">
        <label>开始年月</label>
        <input type="text" class="input datetimepicker" name="startTime" value="<%=nullIf(startTime)%>">
        <label>结束年月</label>
        <input type="text" class="input datetimepicker" name="endTime" value="<%=nullIf(endTime)%>">
        <input type="submit" value="提交" class="button bg-main">
   </form>
</div>
    <%
        String err_mag = "";
        List result = null;
        make_table:
    if(licenseNum!=null && licenseNum.length()==7 && startTime!=null && endTime!=null){
        Session hsession = HibernateSessionFactory.getSession();
        Query query = hsession.createQuery("from Vehicle where licenseNum=:carNum");
        query.setString("carNum",licenseNum);
        Vehicle v = (Vehicle) query.uniqueResult();
        if(v==null){
            err_mag = "车辆不存在！";
            break make_table;
        }
        int startYear = Integer.parseInt(StringUtils.split(startTime.replace("/","-"),"-",2)[0]);
        int startMonth = Integer.parseInt(StringUtils.split(startTime.replace("/","-"),"-",2)[1]);
        int endYear = Integer.parseInt(StringUtils.split(endTime.replace("/","-"),"-",2)[0]);
        int endMonth = Integer.parseInt(StringUtils.split(endTime.replace("/","-"),"-",2)[1]);

        Query query2 = hsession.createQuery("select new com.dz.module.vehicle.InsuranceDivide(\n" +
                "    mm.rank,ins.id,mm.name,ins.insuranceClass,ins.carframeNum,\n" +
                "    ins.insuranceNum,ins.insuranceMoney,ROUND(ins.insuranceMoney/12.0,2)) \n" +
                "from Insurance ins,MyMonth mm \n" +
                "where ins.carframeNum=:carno and YEAR(ins.beginDate)*12+MONTH(ins.beginDate) <= mm.rank \n" +
                "AND YEAR(ins.endDate)*12+MONTH(ins.endDate) > mm.rank \n" +
                "and mm.rank>=:s_month and mm.rank <:e_month " +
                "order by ins.id,mm.rank "
        );
        query2.setString("carno",v.getCarframeNum());
        query2.setInteger("s_month",startYear*12+startMonth);
        query2.setInteger("e_month",endYear*12+endMonth);
        result = query2.list();

        HibernateSessionFactory.closeSession();
    }
    %>
    <div id="show" style="width: 100%;height: 800px;overflow:scroll;">
        <%=err_mag%>
        <% if(result!=null && result.size()>0){ %>
        <table class="table table-bordered table-responsive">
            <tr>
                <th>险种</th>
                <th>车牌号</th>
                <th>保险单</th>
                <th>金额</th>
                <th>月份</th>
            </tr>
            <%for(int i = 0; i < result.size(); i++) {
                InsuranceDivide ins = (InsuranceDivide) result.get(i);
              %>
                <tr>
                    <td><%=ins.getInsuranceClass()%></td>
                    <td><%=licenseNum%></td>
                    <td><%=ins.getInsuranceNum()%></td>
                    <td><%=ins.getDivideMoney()%></td>
                    <td><%=ins.getMonth()%></td>
                </tr>
            <%}%>
        </table>
        <%}%>
    </div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>
</html>
