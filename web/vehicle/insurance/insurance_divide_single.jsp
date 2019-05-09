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
          if ($("input[name='licenseNum']").val().length<7)
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
        <input type="text" class="input" name="licenseNum" value="<%=nullIf(licenseNum)%>" onfocus="carFocus()">
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
        int startYear;int startMonth;

        //Calendar cal = Calendar.getInstance();
        if(StringUtils.isBlank(startTime)){
          //  startYear = cal.get(Calendar.YEAR);
            //startMonth = cal.get(Calendar.MONTH)+1;
            startYear = 2000;
            startMonth = 1;
        }else{
            startYear = Integer.parseInt(StringUtils.split(startTime.replace("/","-"),"-",2)[0]);
            startMonth = Integer.parseInt(StringUtils.split(startTime.replace("/","-"),"-",2)[1]);
        }

        int endYear; int endMonth;
        if(StringUtils.isBlank(endTime)){
            endYear = 2100;
            endMonth = 1;
        }else{
            endYear = Integer.parseInt(StringUtils.split(endTime.replace("/","-"),"-",2)[0]);
            endMonth = Integer.parseInt(StringUtils.split(endTime.replace("/","-"),"-",2)[1]);
        }

        Query query2 = hsession.createQuery("from InsuranceDivide2 divide\n" +
"where exists (select 1 from Insurance ins where ins.carframeNum=:carno and ins.id=divide.id.insuranceId) \n" +
"and divide.id.monthRank>=:s_month and divide.id.monthRank <:e_month order by divide.id.monthRank"
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
            <thead>
            <tr>
                <th>车牌号</th>
                <th>月份</th>
                <th>保单号</th>
                <th>金额</th>
            </tr>
            </thead>
            <tbody>
            <%
                BigDecimal sum = BigDecimal.ZERO;
                InsuranceDivide2 before = (InsuranceDivide2) result.get(0);
                int before_index = 0;
                for(int i = 1; i < result.size(); i++) {
                InsuranceDivide2 ins = (InsuranceDivide2) result.get(i);
                if (ins.getId().getMonthRank() == before.getId().getMonthRank() && i!=result.size()-1){
                    continue;
                }else if(ins.getId().getMonthRank() == before.getId().getMonthRank()) {
                    i++;
                }
                    {
                    int rowspan = i - before_index;
                    for (int j=0;j<rowspan;j++){
                        InsuranceDivide2 divide2 = (InsuranceDivide2) result.get(before_index+j);
            %>
            <tr>
                <% if(j==0){ %>
                <td rowspan="<%=rowspan%>"><%=licenseNum%></td>
                <td rowspan="<%=rowspan%>"><%=(divide2.getId().getMonthRank()-1)/12%>-<%=(divide2.getId().getMonthRank()-1)%12+1%></td>
                <%}%>
                <td><%=divide2.getId().getInsuranceId()%></td>
                <td><% double val=Math.round(divide2.getMoney()*100)/100.0;sum = sum.add(BigDecimal.valueOf(val));%><%=val%></td>
            </tr>
            <%
                    }
                    if (ins.getId().getMonthRank() != before.getId().getMonthRank() && i==result.size()-1){
            %>
            <tr>
                <td><%=licenseNum%></td>
                <td><%=(ins.getId().getMonthRank()-1)/12%>-<%=(ins.getId().getMonthRank()-1)%12+1%></td>
                <td><%=ins.getId().getInsuranceId()%></td>
                <td><% double val=Math.round(ins.getMoney()*100)/100.0;sum = sum.add(BigDecimal.valueOf(val));%><%=val%></td>
            </tr>
            <%
                    }
                    before = ins;
                    before_index = i;
                }
            }
            %>
            </tbody>
            <tfoot>
            <tr>
                <td>合计</td>
                <td>-</td>
                <td>-</td>
                <td><%=sum%></td>
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
