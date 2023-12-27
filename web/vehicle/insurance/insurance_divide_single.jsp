<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.math.RoundingMode" %>
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
    if(licenseNum!=null && (licenseNum.length()==7 || licenseNum.length()==8) && startTime!=null && endTime!=null){
        Session hsession = HibernateSessionFactory.getSession();
        Query query = hsession.createQuery("from Vehicle where licenseNum=:carNum order by inDate desc ");
        query.setString("carNum",licenseNum);
        query.setMaxResults(1);
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

        Query query2 = hsession.createSQLQuery("select " +
                        " `month`,dept,carframe_num,license_num,insurance_base,rank,begin_date,end_date,insurance_num,insurance_money,third_party_amount " +
                        " from v_insurance_divide \n" +
"where carframe_num=:carno \n" +
"and `month`>=:s_month and `month` <:e_month order by `month`"
        );
        query2.setString("carno",v.getCarframeNum());
        query2.setDate("s_month",new Date(startYear-1900,startMonth-1,1));
        query2.setDate("e_month",new Date(endYear-1900,endMonth-1,1));
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
                <th>月份</th>
                <th>部门</th>
                <th>车牌号</th>
                <th>保单号</th>
                <th>投保金额</th>
                <th>基础保费</th>
                <th>当前期数</th>
                <th>本期摊销金额</th>
            </tr>
            </thead>
            <tbody>
            <%
                BigDecimal sum = BigDecimal.ZERO;
                BigDecimal sum2 = BigDecimal.ZERO;
                Object[] before = (Object[]) result.get(0);
                int before_index = 0;
                for(int i = 1; i < result.size(); i++) {
                    Object[] ins = (Object[]) result.get(i);
                    if (ins[0] == before[0] && i!=result.size()-1){
                        continue;
                    }else if(ins[0] == before[0]) {
                        i++;
                    }
                    {
                    int rowspan = i - before_index;
                    for (int j=0;j<rowspan;j++){
                        Object[] divide2 = (Object[]) result.get(before_index+j);
            %>
            <tr>
                <% if(j==0){ %>
                <td rowspan="<%=rowspan%>"><%=divide2[0]%></td>
                <td rowspan="<%=rowspan%>"><%=divide2[1]%></td>
                <td rowspan="<%=rowspan%>"><%=divide2[3]%></td>
                <%}%>
                <td><%=divide2[8]%></td>
                <td><%
                    double val=((Number)divide2[9]).doubleValue() + ((Number)divide2[10]).doubleValue();
                    sum = sum.add(BigDecimal.valueOf(val));
                %><%=val%></td>
                <td><%
                    double val2=((Number)divide2[4]).doubleValue();
                    sum2 = sum2.add(BigDecimal.valueOf(val2));
                %><%=val2%></td>
                <td><%=divide2[5]%></td>
                <td><%=Math.round(val2 / 12.0 * 100.0) / 100.0 %></td>
            </tr>
            <%
                    }
                    if (ins[0] != before[0] && i==result.size()-1){
            %>
            <tr>
                <td><%=ins[0]%></td>
                <td><%=ins[1]%></td>
                <td><%=ins[3]%></td>

                <td><%=ins[8]%></td>
                <td><%
                    double val=((Number)ins[9]).doubleValue() + ((Number)ins[10]).doubleValue();
                    sum = sum.add(BigDecimal.valueOf(val));
                %><%=val%></td>
                <td><%
                    double val2=((Number)ins[4]).doubleValue();
                    sum2 = sum2.add(BigDecimal.valueOf(val2));
                %><%=val2%></td>
                <td><%=ins[5]%></td>
                <td><%=Math.round(val2 / 12.0 * 100.0) / 100.0 %></td>
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
                <td>-</td>
                <td><%=sum%></td>
                <td><%=sum2%></td>
                <td>-</td>
                <td><%=sum2.divide(BigDecimal.valueOf(12),2, RoundingMode.CEILING) %></td>
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
