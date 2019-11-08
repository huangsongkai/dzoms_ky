<%@ page import="com.dz.common.convertor.DateTypeConverter" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%!
    static String nullIf(String val){
        return val==null?"":val;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
%>
<%
    String dept = request.getParameter("dept");
    String startTime = request.getParameter("startTime");
    if(StringUtils.equals("全部",dept)){
        dept = "";
    }
    String doExport = request.getParameter("doExport");
    boolean isDoExport = doExport!=null && StringUtils.equals("yes",doExport);
%>
<%
    String err_mag = "";
    List result = null;

    int startYear;int startMonth;
    Calendar cal = Calendar.getInstance();
    if(StringUtils.isBlank(startTime)){
        startYear = cal.get(Calendar.YEAR);
        startMonth = cal.get(Calendar.MONTH)+1;
    }else{
        startYear = Integer.parseInt(StringUtils.split(startTime.replace("/","-"),"-",2)[0]);
        startMonth = Integer.parseInt(StringUtils.split(startTime.replace("/","-"),"-",2)[1]);
    }

    make_table:
    {
        Session hsession = HibernateSessionFactory.getSession();

        String hql = "select \n" +
                "div.id.monthRank,\n" +
                "v.dept,\n" +
                "ins.id," +
                "v.licenseNum, \n" +
                "sum(div.money),\n" +
                "sum (case when div.id.monthRank<:rank then 1 else 0 end ),\n" +
                "sum (case when div.id.monthRank>:rank then 1 else 0 end ),\n" +
                "sum (case when div.id.monthRank=:rank then div.money else 0 end ),\n" +
                "sum (case when div.id.monthRank<:rank then div.money else 0 end ),\n" +
                "sum (case when div.id.monthRank>:rank then div.money else 0 end ),\n" +
                "ins.beginDate\n" +
                "from InsuranceDivide2 div,Insurance ins,Vehicle v \n" +
                "where div.id.insuranceId = ins.id and ins.carframeNum = v.carframeNum \n" +
                "and div.id.monthRank>:rank-12 and div.id.monthRank<=:rank+12\n" +
                (StringUtils.isBlank(dept)?"":"and v.dept = :dept\n") +
                "group by div.id.insuranceId\n " +
                "having sum(case when div.id.monthRank=:rank then div.money else 0 end )>0\n" +
                "order by (case when v.dept='一部' then 1 when v.dept='二部' then 2 else 3 end),v.licenseNum";

        Query query = hsession.createQuery(hql);
        if(!StringUtils.isBlank(dept)){
            query.setString("dept",dept);
        }

        query.setInteger("rank",startYear*12+startMonth);

        result = query.list();

        HibernateSessionFactory.closeSession();
    }
%>
<%
    if (isDoExport){
        List<String> datasrc = Arrays.asList("year","month","dept","list");
        List datalist = Arrays.asList(startYear,startMonth,dept,result);
        String templatePath = "/vehicle/insurance/insurance_divide_anaylse.xls";
        String outputName = String.format("%4d年%02d月%s保险摊销汇总",startYear,startMonth,dept);
        request.setAttribute("datasrc",datasrc);
        request.setAttribute("datalist",datalist);
        request.setAttribute("templatePath",templatePath);
        request.setAttribute("outputName",outputName);
        request.getRequestDispatcher("/common/outputExcel.action").forward(request,response);
    }
%>
<html>
<head>
    <title>保险摊销查询</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
      $(document).ready(function(){
        $("#doExport").click(function () {
            $("input[name='doExport']").val("yes");
            $("#theform").submit();
            $("input[name='doExport']").val("no");
        });

      });

      var showTableBody = true;
      function toggleTableBody() {
          if (showTableBody){
              $("#divide-table tbody").css("display","none");
          } else {
              $("#divide-table tbody").css("display","table-row-group");
          }
          showTableBody = !showTableBody;
      }


  </script>
</head>
<body>
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>保险管理</li>
                <li>保险摊销查询</li>
    </ul>
</div>
<div class="line">
	<form id="theform" action="#" method="post" class="form-inline">
        <label style="margin-left: 40px;">部门</label>
        <s:select cssClass="input" list="{'一部','二部','三部','全部'}" name="dept" value="#parameters.dept"></s:select>
        <label>月份</label>
        <input type="text" class="input datetimepicker" name="startTime" value="<%=startYear%>-<%=startMonth%>">
        <input type="submit" value="提交" class="button bg-main">
        <input type="hidden" name="doExport" value="no">
        <input id="doExport" type="button" value="导出Excel" class="button bg-main">

        <input type="button" class="button bg-main" value="隐藏/显示摊销内容" onclick="toggleTableBody()">
   </form>
</div>
    <div id="show" style="width: 100%;height: 800px;overflow:scroll;">
        <%=err_mag%>
        <% if(result!=null && result.size()>0){ %>
        <table id="divide-table" class="table table-bordered table-responsive">
            <thead>
            <tr>
                <th>序号</th>
                <th>月份</th>
                <th>部门</th>
                <th>车牌号</th>
                <th>保险原值</th>
                <th>已摊期数</th>
                <th>未摊期数</th>
                <th>本期摊销金额</th>
                <th>累计摊销金额</th>
                <th>期末净值</th>
                <th>投保日期</th>
            </tr>
            </thead>
            <tbody>
            <%
                BigDecimal sum = BigDecimal.ZERO;
                BigDecimal sum2 = BigDecimal.ZERO;
                BigDecimal sum3 = BigDecimal.ZERO;
                BigDecimal sum4 = BigDecimal.ZERO;
                BigDecimal sum5 = BigDecimal.ZERO;
                BigDecimal sum6 = BigDecimal.ZERO;

                BigDecimal col1 = BigDecimal.ZERO;
                BigDecimal col2 = BigDecimal.ZERO;
                BigDecimal col3 = BigDecimal.ZERO;
                BigDecimal col4 = BigDecimal.ZERO;
                BigDecimal col5 = BigDecimal.ZERO;
                BigDecimal col6 = BigDecimal.ZERO;
                for(int i = 0; i < result.size(); i++) {
                Object[] ins = (Object[]) result.get(i);

                int monthRank = (Integer) ins[0];
            %>
            <tr>
                <td><%=i+1%></td>
                <td><%=startYear%>-<%=startMonth%></td>
                <td><%=ins[1]%></td>
                <td><%=ins[2]%></td>
                <td><%col1=BigDecimal.valueOf(((Number) ins[3]).doubleValue());%><%=col1.setScale(2, RoundingMode.HALF_UP)%><%sum = sum.add(col1);%></td>
                <td><%col2=BigDecimal.valueOf(((Number) ins[4]).doubleValue());%><%=col2.setScale(2, RoundingMode.HALF_UP)%><%sum2 = sum2.add(col2);%></td>
                <td><%col3=BigDecimal.valueOf(((Number) ins[5]).doubleValue());%><%=col3.setScale(2, RoundingMode.HALF_UP)%><%sum3 = sum3.add(col3);%></td>
                <td><%col4=BigDecimal.valueOf(((Number) ins[6]).doubleValue());%><%=col4.setScale(2, RoundingMode.HALF_UP)%><%sum4 = sum4.add(col4);%></td>
                <td><%col5=BigDecimal.valueOf(((Number) ins[7]).doubleValue());%><%=col5.setScale(2, RoundingMode.HALF_UP)%><%sum5 = sum5.add(col5);%></td>
                <td><%col6=BigDecimal.valueOf(((Number) ins[8]).doubleValue());%><%=col6.setScale(2, RoundingMode.HALF_UP)%><%sum6 = sum6.add(col6);%></td>
                <td><%=DateTypeConverter.dateFormat20.format(ins[9])%></td>
            </tr>
            <%}%>
            </tbody>
            <tfoot>
            <tr>
                <td>合计</td>
                <td>-</td>
                <td>-</td>
                <td>-</td>
                <td><%=sum.setScale(2,RoundingMode.HALF_UP)%></td>
                <td><%=sum2.setScale(2,RoundingMode.HALF_UP)%></td>
                <td><%=sum3.setScale(2,RoundingMode.HALF_UP)%></td>
                <td><%=sum4.setScale(2,RoundingMode.HALF_UP)%></td>
                <td><%=sum5.setScale(2,RoundingMode.HALF_UP)%></td>
                <td><%=sum6.setScale(2,RoundingMode.HALF_UP)%></td>
                <td>-</td>
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