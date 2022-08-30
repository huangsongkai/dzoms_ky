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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>预付金单车查询</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <script src="/DZOMS/res/js/admin.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
      function carFocus(){
          if (!checkLicenseNum($("input[name='licenseNum']").val())) {
              $("input[name='licenseNum']").val("黑A");
          }
      }

      $(document).ready(function(){
          $("input[name='licenseNum']").bigAutocomplete({
              url:"/DZOMS/select/VehicleBylicenseNum"
          });
      });
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
                <li>预付金单车查询</li>
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

    if (StringUtils.isBlank(startTime)){
        startTime = "2000/01";
    }

    if (StringUtils.isBlank(endTime)){
        endTime = "2050/01";
    }
%>
<div class="line">
	<form action="#" method="post" class="form-inline">
        <label style="margin-left: 40px;">车牌号</label>
        <input type="text" class="input" name="licenseNum" value="<%=nullIf(licenseNum)%>" onfocus="carFocus()">
        <label>开始年月</label>
        <input type="text" class="input datetimepicker" name="startTime" value="<%=nullIf(request.getParameter("startTime"))%>">
        <label>结束年月</label>
        <input type="text" class="input datetimepicker" name="endTime" value="<%=nullIf(request.getParameter("endTime"))%>">
        <input type="submit" value="提交" class="button bg-main">
   </form>
</div>
    <%
        String err_mag = "";
        List result = null;
        make_table:
    if(licenseNum!=null && (licenseNum.length()==7 || licenseNum.length()==8) && startTime!=null && endTime!=null){
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

        Query query2 = hsession.createQuery("select c,rd,d from Contract c,RentFirstDivide rd,Driver d " +
                "where c.carframeNum=rd.carframeNum and c.carNum=:carNum and c.idNum=d.idNum "+
                "and YEAR (rd.month)*12+MONTH(rd.month) >= " +
                " YEAR(c.contractBeginDate)*12+MONTH(c.contractBeginDate) " +
                "AND (( c.state=1 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.abandonedFinalTime)*12+MONTH(c.abandonedFinalTime) ) or " +
                "( c.state=0 and YEAR (rd.month)*12+MONTH(rd.month) < YEAR(c.contractEndDate)*12+MONTH(c.contractEndDate) ))" +
                "AND rd.money <> 0 " +
                "and YEAR (rd.month)*12+MONTH(rd.month)>= :s_month " +
                "and YEAR (rd.month)*12+MONTH(rd.month)<= :e_month "
        );
        query2.setString("carNum",licenseNum);
        query2.setInteger("s_month",startYear*12+startMonth);
        query2.setInteger("e_month",endYear*12+endMonth);
        result = query2.list();

        HibernateSessionFactory.closeSession();
    }
    %>
    <div id="show" style="width: 100%;height: 800px;overflow:scroll;">
        <%=err_mag%>
        <% if(result!=null && result.size()>0){
            Date currentMonth = new Date();
            int currentMonthRank = currentMonth.getYear()*12 + currentMonth.getMonth();
        %>
        <table class="table table-bordered table-responsive">
            <tr>
                <th>期号</th>
                <th>部门</th>
                <th>车牌号</th>
                <th>车主</th>
                <th>身份证</th>
                <th>月份</th>
                <th>金额</th>
            </tr>
            <%for(int i = 0; i < result.size(); i++) {
                Object[] res = (Object[]) result.get(i);
                Contract c = (Contract) res[0];
                RentFirstDivide rd = (RentFirstDivide) res[1];
                Driver d = (Driver) res[2];
                int monthRank = rd.getMonth().getYear()*12 + rd.getMonth().getMonth();
                String state = (currentMonthRank==monthRank)?"tr-green":(currentMonthRank<monthRank?"tr-gray":"tr-yellow");
              %>
                <tr class="<%=state%>">
                    <td><%=i+1%></td>
                    <td><%=c.getBranchFirm()%></td>
                    <td><%=c.getCarNum()%></td>
                    <td><%=d.getName()%></td>
                    <td><%=c.getIdNum()%></td>
                    <td><%=sdf.format(rd.getMonth())%></td>
                    <td><%=rd.getMoney()%></td>
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
