<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.charge.MonthPlan" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
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

    private static int gcd(int a, int b) {
        int t;
        while(b!=0) {
            t=b;
            b=a%b;
            a=t;
        }
        return a;
    }

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
%>
<%
    String department = request.getParameter("department");
    String timeString = request.getParameter("time");

    Date time = null;
    try {
        time = sdf.parse(timeString);
    } catch (Exception e) {
//        e.printStackTrace();
    }

    String deptCondition = " ";
    if (department!=null && !department.equalsIgnoreCase("全部")){
        deptCondition = " and c.branchFirm=:dept ";
    }

    Session hsession = HibernateSessionFactory.getSession();
    Query query = hsession.createQuery("select c.branchFirm,c.carNum,c.carframeNum,\n" +
            "sum(case when cp.feeType like 'plan_sub%' then -cp.fee else cp.fee end ) \n" +
            "from ChargePlan cp,Contract c \n" +
            "where cp.isDisabled=false \n" +
            "and cp.feeType like 'plan_%' \n" +
            "and cp.contractId=c.id \n" +
            "and year(cp.time)=year(:time) \n" +
            "and month(cp.time)=month(:time) \n" + deptCondition +
            "group by c.carframeNum ");

    if (department!=null && !department.equalsIgnoreCase("全部")){
        query.setString("dept",department);
    }
    query.setDate("time",time);
    List<Object[]> month_plans = query.list();
    Query query1 = hsession.createQuery("from MonthPlan where carframeNum=:carId and YEAR(time)=year(:time) and MONTH(time)=month(:time)");
    query1.setDate("time",time);
    query1.setMaxResults(1);
    Query query2 = hsession.createQuery("select cp from ChargePlan cp,Contract c " +
            "where cp.contractId=c.id and c.carframeNum=:carId "+
            "AND cp.feeType LIKE 'add_%' " +
            "AND YEAR(cp.time)*12+MONTH(cp.time)<=year(:time)*12+month(:time) and cp.balance>0 ");
    query2.setDate("time",time);
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>月计划生成--预分配</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/admin.js"></script>

    <script>
        $(document).ready(function(){
            $("#rawTh tr:eq(0) td").each(function(index){
                $("#newTh th").eq(index).width($(this).width());
            });
        });

        function showDetails(contractId) {
            window.open("match_show_detail.jsp?carNum="+contractId,"_blank")
        }

        function singleAssign(planId) {
            if (confirm('确认将对该项收款余额分配到本月计划？'))
                $.get('/DZOMS/charge/assignIncomeToMonth?id='+planId+'&time=<%=timeString%>',function (result) {
                    $('#timestamp').val(new Date().getTime());
                    $('#form').submit();
                });
        }
		
		function withoutAssign() {
			if (confirm('确认生成月计划？(并不会影响收入分配，可以在之后分配)')){
                $.get('/DZOMS/charge/makeMonthPlan?time=<%=timeString%>',function (result) {
                    $('#timestamp').val(new Date().getTime());
                    $('#form').submit();
                });
			}
		}

        function defaultAssign() {
            var car_choosed = [];
            $('input[name="income_choose"]:checked').each(function () {
                car_choosed.push(this.value);
            });
            if (car_choosed.length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            if (confirm("确认对选中的"+car_choosed.length+"项余额执行默认分配？【将按照月份从前往后依次分配】")){
                $.post('/DZOMS/charge/defaultIncomeAssign',{
                    time:'<%=timeString%>',
                    income_choosed: JSON.stringify(car_choosed)
                },function (result) {
                    $('#timestamp').val(new Date().getTime());
                    $('#form').submit();
                });
            }
        }

        function assignToMonth() {
            var monthString = prompt('请输入收款余额所在的月份(yyyy/MM)：');
            while (!/^20[0-9]{2}\/((0[1-9])|(1[0-2]))$/.test(monthString)){
                if(!confirm('请按照yyyy/MM格式输入月份，点击确认重新输入，点击取消退出')){
                    return;
                } else {
                    monthString =  prompt('请输入收款余额所在的月份(yyyy/MM)：');
                }
            }
            var car_choosed = [];
            $('input[name="income_choose"]:checked').each(function () {
                car_choosed.push(this.value);
            });
            if (car_choosed.length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            if (confirm("确认对选中的"+car_choosed.length+"余额进行分配？【注意：只会处理所选余额中在"+monthString+"的记录！】")){
                $.post('/DZOMS/charge/assignIncomeByMonth',
                    {
                        time:'<%=timeString%>',
                        targetMonth:monthString,
                        income_choosed: JSON.stringify(car_choosed)
                    },function (result) {
                        $('#timestamp').val(new Date().getTime());
                        $('#form').submit();
                    });
            }
        }

        function chooseAll() {
            $('input[name="income_choose"]').prop('checked',true);
        }

        function deChooseAll() {
            $('input[name="income_choose"]').prop('checked',false);
        }

        function reverseChoose() {
            $('input[name="income_choose"]').each(function () {
                $(this).prop('checked',!$(this).prop('checked'));
            });
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>月计划生成--预分配</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" action="#" class="form-inline form-tips" style="width: 100%;">
        <input type="hidden" name="timestamp" id="timestamp" value="<%=System.currentTimeMillis()%>">
        <div class="panel  margin-small" >
            <div class="panel-body">
                <%--<div class="form-group">--%>
                <%--<div class="label padding">--%>
                <%--<label>--%>
                <%--车牌号--%>
                <%--</label>--%>
                <%--</div>--%>
                <%--<div class="field">--%>
                <%--<input class="input input-auto" size="9" id="licenseNum" name="licenseNum" value="黑A"  onfocus="carFocus()"/>--%>
                <%--</div>--%>
                <%--</div>--%>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门
                        </label>
                    </div>
                    <div class="field">
                        <select name="department" value="<%=department%>">
                            <option value="全部">全部</option>
                            <option value="一部">一部</option>
                            <option value="二部">二部</option>
                            <option value="三部">三部</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            请输入收入年月：
                        </label>
                    </div>
                    <div class="field">
                        <input class="input datetimepicker" name="time" placeholder="年月即可" id="time" value="<%=nullIf(timeString)%>"/>
                    </div>
                </div>
                <%--<div class="form-group">--%>
                    <%--<div class="label padding">--%>
                        <%--<label>--%>
                            <%--只显示未分配的收入项?--%>
                        <%--</label>--%>
                    <%--</div>--%>
                    <%--<div class="field">--%>
                        <%--<input type="radio" name="showAll" value="yes" <%=showEverything?"checked":""%> >是--%>
                        <%--<input type="radio" name="showAll" value="no" <%=showEverything?"":"checked"%> >否--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                    <%--<div class="label padding">--%>
                        <%--<label>--%>
                            <%--不显示计划均已满足的收入项?--%>
                        <%--</label>--%>
                    <%--</div>--%>
                    <%--<div class="field">--%>
                        <%--<input type="radio" name="showAll2" value="yes" <%=showEverything2?"checked":""%> >是--%>
                        <%--<input type="radio" name="showAll2" value="no" <%=showEverything2?"":"checked"%> >否--%>
                    <%--</div>--%>
                <%--</div>--%>
                <input type="submit" value="查询" class="button bg-green"/>
				<input type="button" value="只生成" class="button bg-green" onclick="withoutAssign()"/>
                <input type="button" value="自动分配" class="button bg-green" onclick="defaultAssign()"/>
                <input type="button" value="指定月份分配" class="button bg-green" onclick="assignToMonth()"/>
            </div>
        </div>
    </form>
</div>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>明细</strong>
            <input type="button" value="全选" onclick="chooseAll()">
            <input type="button" value="全不选" onclick="deChooseAll()">
            <input type="button" value="反选" onclick="reverseChoose()">
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr id="newTh">
                        <th>序号</th>
                        <%--<th>月份</th>--%>
                        <th>部门</th>
                        <th>车牌号</th>
                        <th>当月计划</th>
                        <th>已缴纳金额</th>
                        <th>未缴纳金额</th>
                        <th>历史收款项</th>
                        <th>收款时间</th>
                        <th>收款数额</th>
                        <th>收款余额</th>
                        <th>选择</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:540px; overflow:auto">
                <%BigDecimal bd1 = new BigDecimal(0.00);%>
                <%BigDecimal bd2 = new BigDecimal(0.00);%>
                <%BigDecimal bd3 = new BigDecimal(0.00);%>
                <%int index=1;%>
                <table  id="rawTh" class="table table-bordered table-hover">
                    <%if(month_plans!=null)
                        for(Object[] record:month_plans){
                            String dept = (String) record[0];
                            String car_num = (String) record[1];
                            String carframe_num = (String) record[2];
                            double total_fee = ((Number) record[3]).doubleValue();
//                            Vehicle vehicle = (Vehicle) hsession.get(Vehicle.class,carframe_num);
                            query1.setString("carId",carframe_num);
                            query2.setString("carId",carframe_num);

                            MonthPlan monthPlan = (MonthPlan) query1.uniqueResult();
                            List<ChargePlan> chargePlans = query2.list();
                            //TODO 后续加入提款的查询
                            int rowSpan = Math.max(chargePlans.size(),1);
                            for (int i = 0; i < rowSpan; i++) {
                    %>
                    <tr>
                        <%if (i==0){%>
                        <td rowspan="<%=rowSpan%>"><%=index++%></td>
                        <td rowspan="<%=rowSpan%>"><%=dept%></td>
                        <td rowspan="<%=rowSpan%>"><%=car_num%></td>
                        <td rowspan="<%=rowSpan%>"><%=total_fee%></td>
                        <td rowspan="<%=rowSpan%>"><%=monthPlan==null?'-':monthPlan.getPlanAll().subtract(monthPlan.getArrear())%></td>
                        <td rowspan="<%=rowSpan%>"><%=monthPlan==null?'-':monthPlan.getArrear()%></td>
                        <%}%>
                        <%if (chargePlans.size()==0){%>
                        <td >-</td>
                        <td >-</td>
                        <td >-</td>
                        <td >-</td>
                        <td >-</td>
                        <td >-</td>
                        <%}else {
                            ChargePlan chargePlan = chargePlans.get(i);
                        %>
                        <td ><%=chargePlan.getTime()%></td>
                        <td><%=chargePlan.getFeeType()%></td>
                        <td ><%=chargePlan.getFee()%></td>
                        <td ><%=chargePlan.getBalance()%></td>
                        <td ><input type="checkbox" name="income_choose" value="<%=chargePlan.getId()%>"></td>
                        <td ><button onclick="singleAssign(<%=chargePlan.getId()%>)">单独分配</button></td>
                        <%}%>
                    </tr>
                    <%}%>
                    <%}%>
                    <%--<tr>--%>
                    <%--<th>合计</th>--%>
                    <%--<th>-</th>--%>
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
    $('.datetimepicker').simpleCanleder();
</script>

</html>