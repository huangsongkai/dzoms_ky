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
   </form>
</div>
    <div id="show" style="width: 100%;height: 800px;overflow:scroll;">
        <%=err_mag%>
        <% if(result!=null && result.size()>0){ %>
        <table class="table table-bordered table-responsive">
            <thead>
            <tr>
                <th>月份</th>
                <th>部门</th>
                <th>车牌号</th>
                <th>保险原值</th>
                <th>已摊期数</th>
                <th>未摊期数</th>
                <th>本期金额</th>
                <th>累计金额</th>
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
                for(int i = 0; i < result.size(); i++) {
                Object[] ins = (Object[]) result.get(i);

                int monthRank = (Integer) ins[0];
            %>
            <tr>
                <td><%=startYear%>-<%=startMonth%></td>
                <td><%=ins[1]%></td>
                <td><%=ins[2]%></td>
                <td><%=ins[3]%><%sum = sum.add(BigDecimal.valueOf(((Number) ins[3]).doubleValue()));%></td>
                <td><%=ins[4]%><%sum2 = sum2.add(BigDecimal.valueOf(((Number) ins[4]).doubleValue()));%></td>
                <td><%=ins[5]%><%sum3 = sum3.add(BigDecimal.valueOf(((Number) ins[5]).doubleValue()));%></td>
                <td><%=ins[6]%><%sum4 = sum4.add(BigDecimal.valueOf(((Number) ins[6]).doubleValue()));%></td>
                <td><%=ins[7]%><%sum5 = sum5.add(BigDecimal.valueOf(((Number) ins[7]).doubleValue()));%></td>
                <td><%=ins[8]%><%sum6 = sum6.add(BigDecimal.valueOf(((Number) ins[8]).doubleValue()));%></td>
                <td><%=DateTypeConverter.dateFormat20.format(ins[9])%></td>
            </tr>
            <%}%>
            </tbody>
            <tfoot>
            <tr>
                <td>合计</td>
                <td>-</td>
                <td>-</td>
                <td><%=sum%></td>
                <td><%=sum2%></td>
                <td><%=sum3%></td>
                <td><%=sum4%></td>
                <td><%=sum5%></td>
                <td><%=sum6%></td>
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
