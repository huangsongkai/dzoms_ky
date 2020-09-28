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
    String showAll = request.getParameter("showAll");
    String showAll2 = request.getParameter("showAll2");
    String timeString = request.getParameter("time");

    Date time = null;
    try {
        time = sdf.parse(timeString);
    } catch (Exception e) {
//        e.printStackTrace();
    }

    boolean showEverything = false;
    boolean showEverything2 = false;

    if (showAll!=null && showAll.equalsIgnoreCase("yes")){
        showEverything = true;
    }
    if (showAll2!=null && showAll2.equalsIgnoreCase("yes")){
        showEverything2 = true;
    }

    String deptCondition = " ";
    if (department!=null && !department.equalsIgnoreCase("全部")){
        deptCondition = " and c.branch_firm=:dept ";
    }

    Session hsession = HibernateSessionFactory.getSession();

    Query query = hsession.createSQLQuery(
            "SELECT \n" +
            "car_num,\n" +
            "carframe_num,\n" +
            "total_fee,\n" +
            "total_balance,\n" +
            "time\n" +
            "FROM\n" +
            "(SELECT\n" +
            "c.car_num as car_num,\n" +
            "c.carframe_num as carframe_num,\n" +
            "sum(cp.fee) as total_fee,\n" +
            "sum(cp.balance) as total_balance,\n" +
            "cp.time as time\n" +
            "FROM\n" +
            "charge_plan AS cp JOIN contract c\n" +
            "WHERE\n" +
            "cp.contract_id = c.id \n" +
            "AND cp.is_disabled=0 \n" +
            "AND cp.fee_type LIKE 'add_%'\n" +
            "AND cp.balance>0\n" +
            deptCondition+
            "AND YEAR(cp.time)=year(:time) AND MONTH(cp.time)=month(:time)\n" +
            "GROUP BY c.car_num) as temp1\n" +
                    (showEverything2?
            "WHERE EXISTS \n" +
            "(SELECT 1 \n" +
            "FROM month_plan mp,contract cc \n" +
            "WHERE mp.contract_id = cc.id AND cc.carframe_num=temp1.carframe_num\n" +
            "AND mp.arrear>0 ) ":"")
    );

    if (department!=null && !department.equalsIgnoreCase("全部")){
        query.setString("dept",department);
    }
    query.setDate("time",time);
    List<Object[]> incomes = query.list();
    Query query1 = hsession.createQuery("from MonthPlan mp where mp.carframeNum = :carId and mp.arrear>0 ");
    Query query2 = hsession.createQuery("select cp from ChargePlan cp,Contract c " +
            "where cp.contractId=c.id and c.carframeNum=:carId "+
            "AND cp.feeType LIKE 'add_%' " +
            "AND YEAR(cp.time)=year(:time) AND MONTH(cp.time)=month(:time) " + (showEverything?" and cp.balance>0 ":""));
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
    <title>月收入--分配</title>
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

        function makeMonthPlan() {
            if (confirm('将生成月扣款方案，往期的余额将被忽略，可在生成后分配，是否继续？'))
                $.get('/DZOMS/charge/makeMonthPlan?time=<%=timeString%>',function (result) {
                    $('#timestamp').val(new Date().getTime());
                    $('#form').submit();
                });
        }

        function singleAssign(carframeNum,monthPlanId,money) {
            if (confirm('确认将对该车收入单独分配？'))
            $.get('/DZOMS/charge/singleAssign?carframeNum='+carframeNum+'&id='+monthPlanId+'&time=<%=timeString%>',function (result) {
                $('#timestamp').val(new Date().getTime());
                $('#form').submit();
            });
        }

        function defaultAssign() {
            var car_choosed = [];
            $('input[name="car_choose"]:checked').each(function () {
               car_choosed.push(this.value);
            });
            if (car_choosed.length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            if (confirm("确认对选中的"+car_choosed.length+"项执行默认分配？【将按照月份从前往后依次分配】")){
                $.post('/DZOMS/charge/defaultAssign',{
                    time:'<%=timeString%>',
                    car_choosed: JSON.stringify(car_choosed)
                },function (result) {
                    $('#timestamp').val(new Date().getTime());
                    $('#form').submit();
                });
            }
        }

        function assignToMonth() {
            var monthString = prompt('请输入分配到的月份(yyyy/MM)：');
            while (!/^20[0-9]{2}\/((0[1-9])|(1[0-2]))$/.test(monthString)){
                if(!confirm('请按照yyyy/MM格式输入月份，点击确认重新输入，点击取消退出')){
                    return;
                } else {
                    monthString =  prompt('请输入分配到的月份(yyyy/MM)：');
                }
            }
            var car_choosed = [];
            $('input[name="car_choose"]:checked').each(function () {
                car_choosed.push(this.value);
            });
            if (car_choosed.length<=0){
                alert('请选择至少一项数据！');
                return;
            }
            if (confirm("确认对选中的"+car_choosed.length+"项分配到"+monthString+"？")){
                $.post('/DZOMS/charge/assignToMonth',
                    {
                        time:'<%=timeString%>',
                        targetMonth:monthString,
                        car_choosed: JSON.stringify(car_choosed)
                    },function (result) {
                    $('#timestamp').val(new Date().getTime());
                    $('#form').submit();
                });
            }
        }

        function chooseAll() {
            $('input[name="car_choose"]').prop('checked',true);
        }

        function deChooseAll() {
            $('input[name="car_choose"]').prop('checked',false);
        }

        function reverseChoose() {
            $('input[name="car_choose"]').each(function () {
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
            <li>月收入--分配</li>
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
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            只显示未分配的收入项?
                        </label>
                    </div>
                    <div class="field">
                        <input type="radio" name="showAll" value="yes" <%=showEverything?"checked":""%> >是
                        <input type="radio" name="showAll" value="no" <%=showEverything?"":"checked"%> >否
                    </div>
                </div>
                    <div class="form-group">
                        <div class="label padding">
                            <label>
                                不显示计划均已满足的收入项?
                            </label>
                        </div>
                        <div class="field">
                            <input type="radio" name="showAll2" value="yes" <%=showEverything2?"checked":""%> >是
                            <input type="radio" name="showAll2" value="no" <%=showEverything2?"":"checked"%> >否
                        </div>
                    </div>
                    <input type="submit" value="查询" class="button bg-green"/>
                    <input type="button" value="只生成不分配" class="button bg-green" onclick="makeMonthPlan()"/>
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
                        <th>选择</th>
                        <th>序号</th>
                        <th>月份</th>
                        <th>部门</th>
                        <th>车牌号</th>
                        <th>收入项</th>
                        <th>单项收入</th>
                        <th>单项未分配</th>
                        <th>收入总额</th>
                        <th>未分配总额</th>
                        <th>可分配项</th>
                        <th>未缴纳金额</th>
                        <th>可分配金额</th>
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
                    <%if(incomes!=null)
                        for(Object[] record:incomes){
                            String car_num = (String) record[0];
                            String carframe_num = (String) record[1];
                            double total_fee = ((Number) record[2]).doubleValue();
                            double total_balance = ((Number) record[3]).doubleValue();
                            String the_time = record[4].toString();
                            Vehicle vehicle = (Vehicle) hsession.get(Vehicle.class,carframe_num);
                            query1.setString("carId",carframe_num);
                            query2.setString("carId",carframe_num);

                            List<MonthPlan> plans = query1.list();
                            List<ChargePlan> chargePlans = query2.list();
                            //TODO 后续加入提款的查询
                            int planSpan = Math.max(plans.size(),1);
                            int incomeSpan = Math.max(chargePlans.size(),1);
                            int rowSpan = planSpan*incomeSpan/gcd(planSpan,incomeSpan);
                            for (int i = 0; i < rowSpan; i++) {
                    %>
                        <tr>
                            <%if (i==0){%>
                            <td rowspan="<%=rowSpan%>"><input type="checkbox" name="car_choose" value="<%=carframe_num%>"></td>
                            <td rowspan="<%=rowSpan%>"><%=index++%></td>
                            <td rowspan="<%=rowSpan%>"><%=the_time%></td>
                            <td rowspan="<%=rowSpan%>"><%=vehicle.getDept()%></td>
                            <td rowspan="<%=rowSpan%>"><%=car_num%></td>
                            <%}%>
                            <%if (i==0 && chargePlans.size()==0){%>
                            <td rowspan="<%=rowSpan%>">-</td>
                            <td rowspan="<%=rowSpan%>">-</td>
                            <td rowspan="<%=rowSpan%>">-</td>
                            <%}else if ((i*incomeSpan)%rowSpan==0){
                                ChargePlan chargePlan = chargePlans.get(i*incomeSpan/rowSpan);
                            %>
                            <td rowspan="<%=rowSpan/incomeSpan%>"><%=chargePlan.getFeeType()%></td>
                            <td rowspan="<%=rowSpan/incomeSpan%>"><%=chargePlan.getFee()%></td>
                            <td rowspan="<%=rowSpan/incomeSpan%>"><%=chargePlan.getBalance()%></td>
                            <%}%>
                            <%if (i==0){%>
                            <td rowspan="<%=rowSpan%>"><%=total_fee%></td>
                            <td rowspan="<%=rowSpan%>"><%=total_balance%></td>
                            <%}%>
                            <%if (i==0 && plans.size()==0){%>
                            <td rowspan="<%=rowSpan%>"> - </td>
                            <td rowspan="<%=rowSpan%>"> - </td>
                            <td rowspan="<%=rowSpan%>"> - </td>
                            <td rowspan="<%=rowSpan%>"> - </td>
                            <%}else if ((i*planSpan)%rowSpan==0){
                                MonthPlan plan = plans.get(i*planSpan/rowSpan);
                            %>
                            <td rowspan="<%=rowSpan/planSpan%>"> <%=sdf.format(plan.getTime())%>的月计划<%=plan.getPlanAll()%></td>
                            <td rowspan="<%=rowSpan/planSpan%>"> <%=plan.getArrear()%></td>
                            <td rowspan="<%=rowSpan/planSpan%>"> <%=Math.min(total_balance,plan.getArrear().doubleValue())%></td>
                            <td rowspan="<%=rowSpan/planSpan%>"> <button onclick="singleAssign('<%=carframe_num%>',<%=plan.getId()%>,<%=Math.min(total_balance,plan.getArrear().doubleValue())%>)">单独分配</button></td>
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