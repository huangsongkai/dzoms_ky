<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.dz.module.vehicle.InsuranceDividePlan" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="org.hibernate.HibernateException" %>
<%@ page import="org.springframework.http.HttpHeaders" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="java.util.List" %>

<%!
    static String nullIf(String val){
        return val==null?"":val;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
    
    private enum Operation{
        SEARCH, ADD, DELETE, UPDATE
    }
%>
<%
    String operationString = request.getParameter("operation");
    Operation operation = Operation.SEARCH;
    if (operationString!=null)
    try {
        operation = Operation.valueOf(operationString);
    }catch (IllegalArgumentException ex){
        operation = Operation.SEARCH;
    }

    String fromMonthString = request.getParameter("fromMonth");//用于查询
    Date fromMonth;
    try {
        fromMonth = sdf.parse(fromMonthString);
    } catch (ParseException|NullPointerException e) {
        fromMonth = new Date();
    }
    String toMonthString = request.getParameter("toMonth");//用于查询
    Date toMonth;
    try {
        toMonth = sdf.parse(toMonthString);
    } catch (ParseException|NullPointerException e) {
        toMonth = new Date();
    }
    String dept = request.getParameter("dept");//用于查询
    
    String idString = request.getParameter("id"); //用于删除、修改
    String monthRankString = request.getParameter("monthRank"); //用于新增、修改
    String typeString = request.getParameter("type"); //用于新增、修改
    String moneyString = request.getParameter("money"); //用于新增、修改
    String carCountString = request.getParameter("carCount"); //用于新增、修改
    String deptString = request.getParameter("deptString"); //用于新增、修改

    Session s = HibernateSessionFactory.getSession();

    if (operation!=Operation.SEARCH) {
        InsuranceDividePlan plan = new InsuranceDividePlan();
        if (operation == Operation.ADD || operation == Operation.UPDATE){
            plan.setMonthRank(Integer.parseInt(monthRankString));
            plan.setType(Integer.parseInt(typeString));
            plan.setCarCount(Integer.parseInt(carCountString));
            plan.setMoney(BigDecimal.valueOf(Double.parseDouble(moneyString)));
            plan.setDept(deptString);
        }
        if (operation == Operation.DELETE || operation == Operation.UPDATE){
            plan.setId(Integer.parseInt(idString));
        }

        Transaction tx = null;

        JSONObject json = new JSONObject();
        json.put("isSuccess", true);
        try {
            tx = s.beginTransaction();
            switch (operation) {
                case ADD:
                    s.save(plan);
                    break;
                case DELETE:
                    s.delete(plan);
                    break;
                case UPDATE:
                    s.update(plan);
                    break;
            }
            tx.commit();
        }catch (HibernateException ex){
            if (tx!=null){
                tx.rollback();
            }
            json.put("isSuccess", false);
            json.put("errorMsg",ex.getMessage());
        }finally {
            HibernateSessionFactory.closeSession();
            response.setHeader(HttpHeaders.CONTENT_TYPE,"text/json;charset=UTF-8");
            out.print(json);
            out.flush();
            out.close();
        }
        return;
    }

    String hql = "from InsuranceDividePlan \n" +
            "where type>=0 \n" +
            "and monthRank>= YEAR(:fromMonth)*12+MONTH(:fromMonth) \n" +
            "and  monthRank<= YEAR(:toMonth)*12+MONTH(:toMonth) \n";
    if(dept!=null && dept.length()>0){
        hql+="and dept=:dept";
    }
    Query query = s.createQuery(hql);
    query.setDate("fromMonth",fromMonth);
    query.setDate("toMonth",toMonth);
    if(dept!=null && dept.length()>0)
        query.setString("dept",dept);

    List<InsuranceDividePlan> list = query.list();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>保险摊销计划管理</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/window.js"></script>

    <script>
        function Plan(id,monthRank,type,money,carCount,dept) {
            this.id = id;
            this.monthRank = monthRank;
            this.type = type;
            this.money = money;
            this.carCount = carCount;
            this.dept = dept;
        }

        Plan.prototype.add = function (callback) {
            $.post("#",{
                operation:"ADD",
                monthRank:this.monthRank,
                type:this.type,
                money:this.money,
                carCount:this.carCount,
                dept:this.dept
            },callback);
        };

        Plan.prototype.delete = function (callback) {
            $.post("#",{
                operation:"DELETE",
                id:this.id
            },callback);
        };

        Plan.prototype.update = function (callback) {
            $.post("#",{
                operation:"UPDATE",
                id:this.id,
                monthRank:this.monthRank,
                type:this.type,
                money:this.money,
                carCount:this.carCount,
                dept:this.dept
            },callback);
        };

        function makeMonthRank(){
            var $div = $('<div/>').addClass("line");
            var $label = $('<label/>').text("起始月份");
            var $input = $('<input class="plan-month">').addClass("input input-auto")
                .val(monthRank)
                .simpleCanleder({
                    separator:"-"
                });
            return $div.append($label).append($input);
        }

        function makeType(){
            var $div = $('<div/>').addClass("line");
            var $label = $('<label/>').text("类型");
            var $input = $('<select class="plan-type"/>').addClass("input input-auto")
                .append($('<option/>').val('0').text('上年运营额'))
                .append($('<option/>').val('1').text('废业减少额'))
                .append($('<option/>').val('2').text('新车保险额'))
                .val(type);
            return $div.append($label).append($input);
        }

        function makeMoney(){
            var $div = $('<div/>').addClass("line");
            var $label = $('<label/>').text("总金额");
            var $input = $('<input class="plan-money">').addClass("input input-auto")
                .val(money);
            return $div.append($label).append($input);
        }

        function makeCarCount(){
            var $div = $('<div/>').addClass("line");
            var $label = $('<label/>').text("涉及车辆总数");
            var $input = $('<input class="plan-count">').addClass("input input-auto")
                .val(carCount);
            return $div.append($label).append($input);
        }

        function makeDept(){
            var $div = $('<div/>').addClass("line");
            var $label = $('<label/>').text("部门");
            var $input = $('<select class="plan-dept" />').addClass("input input-auto")
                .append($('<option/>').val('一部').text('一部'))
                .append($('<option/>').val('二部').text('二部'))
                .append($('<option/>').val('三部').text('三部'))
                .val(dept);
            return $div.append($label).append($input);
        }

        var monthRank,type,money,carCount,dept;
        window.add_plan_callback = function () {
            var id = 0;
            monthRank = $('div.plan-root:last input.plan-month').val();
            type = $('div.plan-root:last select.plan-type').val();
            money = $('div.plan-root:last input.plan-money').val();
            carCount = $('div.plan-root:last input.plan-count').val();
            dept = $('div.plan-root:last select.plan-dept').val();
            
            if (!(typeof money === 'number' && !isNaN(money))){
                alert('总金额应为一个数值！');
                return;
            }
            if (!(typeof carCount === 'number' && !isNaN(carCount))){
                alert('车辆总数应为一个数值！');
                return;
            }
            
            var plan = new Plan(id,monthRank,type,money,carCount,dept);
            plan.add(function (data) {
                if (data != null) {
                    if (data.isSuccess) {
                        alert("添加成功！");
                        $('form').submit();
                    } else {
                        alert("添加失败！原因是：" + data.errorMsg);
                    }
                }
            });
            // console.info(plan);
        };

        var id;
        window.update_plan_callback = function () {
            monthRank = $('div.plan-root:last input.plan-month').val();
            type = $('div.plan-root:last select.plan-type').val();
            money = $('div.plan-root:last input.plan-money').val();
            carCount = $('div.plan-root:last input.plan-count').val();
            dept = $('div.plan-root:last select.plan-dept').val();

            if (!(typeof money === 'number' && !isNaN(money))){
                alert('总金额应为一个数值！');
                return;
            }
            if (!(typeof carCount === 'number' && !isNaN(carCount))){
                alert('车辆总数应为一个数值！');
                return;
            }

            var plan = new Plan(id,monthRank,type,money,carCount,dept);
            plan.update(function (data) {
                if (data != null) {
                    if (data.isSuccess) {
                        alert("修改成功！");
                        $('form').submit();
                    } else {
                        alert("修改失败！原因是：" + data.errorMsg);
                    }
                }
            });
            // console.info(plan);
        };

        function make_add_plan() {
            var $div = $('<div class="plan-root"/>').addClass("line");
            $div.append(makeDept())
                .append(makeType())
                .append(makeMonthRank())
                .append(makeMoney())
                .append(makeCarCount());
            return $div;
        }

        $(document).ready(function () {
            button_bind_html('#add-plan',make_add_plan,'add_plan_callback()');
            button_bind_html('#update-plan',make_add_plan,'update_plan_callback()');
        });

        function _update() {
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }

            id = selected_val;
            monthRank = $('tr.tr-'+selected_val).find('td.td-month').text();
            type = $('tr.tr-'+selected_val).attr('data-type');
            money = $('tr.tr-'+selected_val).find('td.td-money').text();
            carCount = $('tr.tr-'+selected_val).find('td.td-count').text();
            dept = $('tr.tr-'+selected_val).find('td.td-dept').text();

            $('#update-plan').click();
        }

        function _delete() {
            var selected_val = $("input[name='cbx']:checked").val();
            if(selected_val==undefined){
                alert('您没有选择任何一条数据');
                return;
            }
            var plan = new Plan(selected_val);
            plan.delete(function (data) {
                if (data != null) {
                    if (data.isSuccess) {
                        alert("删除成功！");
                        $('form').submit();
                    } else {
                        alert("删除失败！原因是：" + data.errorMsg);
                    }
                }
            });
        }
    </script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>保险管理</li>
        <li>保险摊销计划管理</li>
    </ul>
</div>
<div class="line">
    <form id="theform" action="#" method="post" class="form-inline">
        <label style="margin-left: 40px;">部门</label>
        <s:select cssClass="input" list="{'一部','二部','三部','全部'}" name="dept" value="#parameters.dept"></s:select>
        <label>计划发布月份</label>
        <input type="text" class="input datetimepicker" name="fromMonth" value="<%=fromMonth.getYear()+1900%>-<%=fromMonth.getMonth()+1%>"> ——
        <input type="text" class="input datetimepicker" name="toMonth" value="<%=toMonth.getYear()+1900%>-<%=toMonth.getMonth()+1%>">
        <input type="submit" value="查询" class="button bg-main">
    </form>
</div>
<div class="line">
    <div class="button-toolbar">
        <div class="button-group">
            <button id="add-plan" type="button" class="button icon-pencil text-blue" style="line-height: 6px;">
                新增计划</button>
            <button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                修改计划</button>
            <button onclick="_delete()" type="button" class="button icon-pencil text-blue" style="line-height: 6px;">
                删除计划</button>
        </div>
    </div>
</div>
<div id="show" style="width: 100%;height: 800px;overflow:scroll;">
    <% if(list!=null && list.size()>0){ %>
    <table id="divide-table" class="table table-bordered table-responsive">
        <thead>
        <tr>
            <th>选择</th>
            <th>部门</th>
            <th>计划类型</th>
            <th>起始月份</th>
            <th>结束月份</th>
            <th>计划总额</th>
            <th>每月分摊额</th>
            <th>相关车辆总数</th>
        </tr>
        </thead>
        <tbody>
        <%
            BigDecimal val1,val2;

            BigDecimal sum = BigDecimal.ZERO;
            BigDecimal sum2 = BigDecimal.ZERO;
            int sum3 = 0;
            for(int i = 0; i < list.size(); i++) {
                InsuranceDividePlan plan = list.get(i);
                int monthRank = plan.getMonthRank();
        %>
        <tr class="tr-<%=plan.getId()%>">
            <td><input type="radio" name="cbx" value="<%=plan.getId()%>" ></td>
            <td class="td-dept"><%=plan.getDept()%></td>
            <td class="td-type" data-type="<%=plan.getType()%>"><%switch (plan.getType()){
                case 0:
                    out.write("上年运营额");
                    break;
                case 1:
                    out.write("废业减少额");
                    break;
                case 2:
                    out.write("新车保险额");
                    break;
            }%></td>
            <td class="td-month"><%=(monthRank-1)/12%>-<%=(monthRank-1)%12+1%></td>
            <td><%=(monthRank+11)/12%>-<%=(monthRank+11)%12+1%></td>
            <td class="td-money"><%val1=plan.getMoney().setScale(2,BigDecimal.ROUND_HALF_EVEN);sum = sum.add(val1);%><%=val1%></td>
            <td><%val2=plan.getMoney().divide(BigDecimal.valueOf(12)).setScale(2,BigDecimal.ROUND_HALF_EVEN);sum2=sum2.add(val2);%><%=val2%></td>
            <td class="td-count"><%=plan.getCarCount()%><% sum3+=plan.getCarCount();%></td>
        </tr>
        <%}%>
        </tbody>
        <tfoot>
        <tr>
            <td>合计</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td><%=sum%></td>
            <td><%=sum2%></td>
            <td><%=sum3%></td>
        </tr>
        </tfoot>
    </table>
    <%}%>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder({
        separator:"-"
    });
</script>
</body>
</html>
