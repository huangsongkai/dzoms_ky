<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="com.dz.common.test.SpringContextListener" %>
<%@ page import="com.dz.module.charge.MonthPlan" %>
<%@ page import="com.dz.module.contract.ContractDao" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ page import="com.dz.module.driver.Driver" %>
<%@ page import="com.dz.module.charge.IncomeDivide" %>
<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }

    static Contract selectByCarId(String id, Date d,Session session) {
        Contract c = null;
//			Query query = session.createQuery("from Contract where carframeNum = :id and state=0");
            Query query = session.createQuery("from Contract where id=( select max(id) from Contract where carframeNum = :id and state!=3 and state!=2 and state>=0 ) ");
            query.setString("id",id);
            query.setMaxResults(1);
            c = (Contract) query.uniqueResult();

            Calendar dt = Calendar.getInstance();
            if(c!=null&&c.getContractBeginDate()!=null){
                dt.setTime(c.getContractBeginDate());
            }else{
                return c;
            }

            if(dt.get(Calendar.DATE)>26){

                dt.set(Calendar.DATE, 26);
            }else{
                dt.add(Calendar.MONTH, -1);
                dt.set(Calendar.DATE, 26);
            }

//			System.out.println("ContractDaoImpl.selectByCarId(),"+dt.getTime().toString());

            if(dt.getTime().before(d)){
                return c;
            }else{
                while(c.getContractFrom()!=null){
                    Contract last = (Contract) session.get(Contract.class, c.getContractFrom());
                    if(last!=null) c = last;
                    else return c;

                    dt.setTime(c.getContractBeginDate());
                    if(dt.get(Calendar.DATE)>26){
                        dt.set(Calendar.DATE, 26);
                    }else{
                        dt.add(Calendar.MONTH, -1);
                        dt.set(Calendar.DATE, 26);
                    }
//					System.out.println(dt.getTime().toString());

                    if(dt.getTime().before(d))
                        return c;
                }
            }
        return c;
    }

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
%>
<%
    String licenseNum = request.getParameter("licenseNum");
    String startTime = request.getParameter("startTime");
    String endTime = request.getParameter("endTime");
    List<MonthPlan> list = Collections.emptyList();

    Date startMonth = null;Date endMonth = null;
    try {
        startMonth = sdf.parse(startTime);
        endMonth = sdf.parse(endTime);
    } catch (Exception e) {
//        e.printStackTrace();
    }

    Session s = HibernateSessionFactory.getSession();
    Query query = s.createQuery("select mp from MonthPlan mp,Vehicle v where mp.carframeNum=v.carframeNum " +
            "and v.licenseNum=:carNum " +
            "and (year(mp.time)*12+month(mp.time))>=(year(:startTime)*12+month(:startTime)) " +
            "and (year(mp.time)*12+month(mp.time))<=(year(:endTime)*12+month(:endTime)) " +
            "order by mp.time ");
    Query query1 = s.createQuery("select div,cp from IncomeDivide div,ChargePlan cp where div.incomeId=cp.id and div.monthPlanId=:mid ");
//    Query query1 = s.createQuery("select div,cp from IncomeDivide div,ChargePlan cp where div.incomeId=cp.id " +
//    "and year(cp.time)=year(:date) and month(cp.time)=month(:date)  ");
    if (startMonth!=null && endMonth!=null && licenseNum!=null && licenseNum.length()==7){
        query.setString("carNum",licenseNum);
        query.setDate("startTime",startMonth);
        query.setDate("endTime",endMonth);
        list = query.list();
    }
//    ApplicationContext app = SpringContextListener.getApplicationContext();
//    ContractDao contractDao = app.getBean(ContractDao.class);
%>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>单车收费查询</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
    <script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
  <script>
    function setDept(){
      var licenseNum = $("#licenseNum").val();
      if(licenseNum != undefined && licenseNum.trim().length==7){
        $.post("/DZOMS/vehicle/vehicleSelectByLicenseNum",{'vehicle.licenseNum':licenseNum},function (data){
          data = $.parseJSON(data);
          data = data["ItemTool"]["carframeNum"];
          $.post("/DZOMS/selectContractByCarId",{'contract.carframeNum':data},function(dat){
            $("#dept").val(dat["branchFirm"]);
          });
        });
      }
    }
      function search_(){
          // $("#form").attr("action","/DZOMS/charge/getACarChargeTable2");
          $("#form").submit();
      }
      // function exportxls(){
      //     $("#form").attr("action","/DZOMS/charge/exportACarChargeTable2");
      //     $("#form").submit();
      // }
      function carFocus(){
      	$("#licenseNum").val("黑A");
      }

    $(document).ready(function(){
        $("#licenseNum").bigAutocomplete({
            url:"/DZOMS/select/VehicleBylicenseNum",
            callback:setDept
        });
        $(document).ready(function(){
            $("#rawTh tr:eq(0) td").each(function(index){
                $("#newTh th").eq(index).width($(this).width());
            });
        });
    });
  </script>
</head>
<body>
	<div class="line padding" style="height: 300px;">
		<form method="post" id="form" action="#" style="width: 100%;" class="form-inline form-tips">
            <div class="panel">
                <div class="panel-head">
                    <strong>查询条件</strong>
                </div>
        <div class="panel-body">
            <div class="form-group">
                <div class="label padding">
                    <label>
                        车牌号：
                    </label>
                </div>
                <div class="field">
                    <input class="input input-auto" size="9" id="licenseNum" name="licenseNum" value="黑A"  onfocus="carFocus()"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        部门：
                    </label>
                </div>
                <div class="field">
                    <input class="input input-auto" size="4"  id="dept" readonly="readonly"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        起始年月：
                    </label>
                </div>
                <div class="field">
                    <input class="input  datepick  input-auto" size="12"  name="startTime"/>
                </div>
            </div>

            <div class="form-group">
                <div class="label padding">
                    <label>
                        结束年月：
                    </label>
                </div>
                <div class="field">
                    <input class="input datepick input-auto" size="12" name="endTime"/>
                </div>
            </div>
            <input type="button" class="button bg-green" value="查询" onclick="search_()"/>
            <%--<input type="button" class="button bg-green" value="导出" onclick="exportxls()"/>--%>
        </div>
    </div>
</form>
	</div>
    <div class="line">
        <div class="panel">
            <div class="panel-head">
                <strong>明细</strong>
            </div>
            <div class="panel-body">
                <div class="line" style="width: 100%;">
                    <table class="table table-bordered table-hover table-striped" >
                        <tr id="newTh">
                            <th>年月</th>
                            <th>车牌号</th>
                            <th>司机</th>
                            <th>身份证</th>
                            <th>计划总额</th>
                            <th>银行</th>
                            <th>现金</th>
                            <th>保险</th>
                            <th>油补</th>
                            <th>其他</th>
                            <th>收款时间</th>
                            <th>用于本月计划</th>
                            <th>收入合计</th>
                            <%--<th>总存款</th>--%>
                            <th>月欠款总额</th>
                            <th>备注</th>
                        </tr>
                    </table>
                </div>
                <div class="line" style="width: 100%;height:540px; overflow:auto">
                    <%BigDecimal bd1 = new BigDecimal(0.00);%>
                    <%BigDecimal bd2 = new BigDecimal(0.00);%>
                    <%BigDecimal bd3 = new BigDecimal(0.00);%>
                    <%BigDecimal bd4 = new BigDecimal(0.00);%>
                    <%BigDecimal bd5 = new BigDecimal(0.00);%>
                    <%BigDecimal bd6 = new BigDecimal(0.00);%>
                    <%BigDecimal bd7 = new BigDecimal(0.00);%>
                    <%BigDecimal bd8 = new BigDecimal(0.00);%>
                    <%BigDecimal bd9 = new BigDecimal(0.00);%>
                    <%BigDecimal bd10 = new BigDecimal(0.00);%>
                    <%int index=1;%>
                    <table  id="rawTh" class="table table-bordered table-hover">
                        <%if(list!=null)
                            for(MonthPlan record:list){
                                query1.setInteger("mid",record.getId());
                                List<Object[]> plans = query1.list();
                                int rowSpan = Math.max(plans.size(),1);
                                Calendar cal = Calendar.getInstance();cal.setTime(record.getTime());
                                Contract c = selectByCarId(record.getCarframeNum(),record.getTime(),s);
                                Driver driver = (Driver) s.get(Driver.class,c.getIdNum());
                                for (int i = 0; i < rowSpan; i++) {
                        %>
                        <tr >
                            <%if (i==0){%>
                            <td rowspan="<%=rowSpan%>"><%=cal.get(Calendar.YEAR)+"年"+(cal.get(Calendar.MONTH)+1)+"月"%></td>
                            <td rowspan="<%=rowSpan%>"><%=licenseNum%></td>
                            <td rowspan="<%=rowSpan%>"><%=driver.getName()%></td>
                            <td rowspan="<%=rowSpan%>"><%=c.getIdNum()%></td>
                            <td rowspan="<%=rowSpan%>"><%=record.getPlanAll()%></td>
                            <%}%>
                            <% if(plans.size()==0){%>
                            <td>-</td> <td>-</td> <td>-</td>
                            <td>-</td> <td>-</td> <td>-</td> <td>-</td>
                            <% }else {
                                IncomeDivide divide = (IncomeDivide) plans.get(i)[0];
                                ChargePlan chargePlan = (ChargePlan) plans.get(i)[1];
                            %>
                            <td><%=chargePlan.getFeeType().startsWith("add_bank")?chargePlan.getFee():0%></td>
                            <td><%=chargePlan.getFeeType().startsWith("add_cash")?chargePlan.getFee():0%></td>
                            <td><%=chargePlan.getFeeType().startsWith("add_ins")?chargePlan.getFee():0%></td>
                            <td><%=chargePlan.getFeeType().startsWith("add_oil")?chargePlan.getFee():0%></td>
                            <td><%=chargePlan.getFeeType().startsWith("add_other")?chargePlan.getFee():0%></td>
                            <td><%=chargePlan.getTime()%></td>
                            <td><%=divide.getAmount()%></td>
                            <% }%>
                            <%if (i==0){%>
                            <td rowspan="<%=rowSpan%>"><%=record.getPlanAll().subtract(record.getArrear())%></td>
                            <td rowspan="<%=rowSpan%>"><%=record.getArrear()%></td>
                            <%}%>
                            <% if(plans.size()==0){                            %>
                            <td>-</td>
                            <% }else {
                                ChargePlan chargePlan = (ChargePlan) plans.get(i)[1];
                            %>
                            <td><%=chargePlan.getComment()%></td>
                            <% }%>
                        </tr>
                        <%}}%>
                        <%--<tr>--%>
                            <%--<th>合计</th>--%>
                            <%--<th>-</th>--%>
                            <%--<th><%=bd1%></th>--%>
                            <%--<th><%=bd2%></th>--%>
                            <%--<th><%=bd3%></th>--%>
                            <%--<th>-</th>--%>
                        <%--</tr>--%>
                    </table>
                </div>
            </div>

        </div>

    </div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

<script>
    $('.datepick').simpleCanleder();
</script>
</html>
