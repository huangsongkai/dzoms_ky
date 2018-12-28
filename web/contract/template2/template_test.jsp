<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.dz.module.contract.ContractTemplate2" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.contract.ContractPlanItem" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Transaction" %><%--
  Created by IntelliJ IDEA.
  User: Wang
  Date: 2018/12/11
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

    static double toDouble(String text){
        try {
            return NumberUtils.createDouble(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0.0;
        }
    }

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%
    int id = toInt(request.getParameter("id"));
    String beginDate = request.getParameter("beginDate");
    String endDate = request.getParameter("endDate");
    String toSetEnable = request.getParameter("toSetEnable");

    ContractTemplate2 template;
    if(StringUtils.equalsIgnoreCase(toSetEnable,"true")){
        Session hsession = HibernateSessionFactory.getSession();
        Transaction tx = hsession.beginTransaction();
        template = (ContractTemplate2) hsession.get(ContractTemplate2.class,id);
        template.setEnabled(true);
        hsession.saveOrUpdate(template);
        tx.commit();
        HibernateSessionFactory.closeSession();
    }else {
        template = ObjectAccess.getObject(ContractTemplate2.class,id);
    }
%>
<html>
<head>
    <title>合同模版测试</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        $(document).ready(function(){
           $("#but_enable").click(function(){
               if(confirm("确认启用该模版？启用后将不可修改！")){
                   $("#toSetEnable").val(true);
                   $('form').submit();
               }
           });
        });
    </script>
</head>
<body>
<div class="line">
    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    合同模版名称
                </label>
            </div>
            <div class="field">
                <label>
                    <%=nullIf(template.getName())%>
                </label>
            </div>
        </div>
    </div>

    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    预付金总额
                </label>
            </div>
            <div class="field">
                <label>
                    <%=template.getRentFirst()%>
                </label>
            </div>
        </div>
    </div>
    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    预付金摊销总期数
                </label>
            </div>
            <div class="field">
                <label>
                    <%=template.getRentDivideStages()%>
                </label>
            </div>
        </div>
    </div>
</div>
<div class="line">
    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    定金
                </label>
            </div>
            <div class="field">
                <label>
                    <%=template.getDeposit()%>
                </label>
            </div>
        </div>
    </div>
    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    备注
                </label>
            </div>
            <div class="field">
                <label>
                    <%=nullIf(template.getComment())%>
                </label>
            </div>
        </div>
    </div>
    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    状态
                </label>
            </div>
            <div class="field">
                <label>
                    <%=template.isEnabled()?"已启用":"未启用"%>
                </label>
            </div>
        </div>
    </div>
</div>
<form method="post" action="#">
    <input type="hidden" id="toSetEnable" name="toSetEnable" value="false">
    <div class="line">
        <div class="x4">
            <div class="form-group">
                <div class="label">
                    <label>
                        起始日期
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input datetimepicker" name="beginDate" maxlength="11" value="<%=nullIf(beginDate)%>"
                           placeholder="选取起始日期">
                </div>
            </div>
        </div>
        <div class="x4">
            <div class="form-group">
                <div class="label">
                    <label>
                        结束日期(不含)
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input datetimepicker" name="endDate" maxlength="11" value="<%=nullIf(endDate)%>"
                           placeholder="选取结束日期">
                </div>
            </div>
        </div>
        <div class="x4">
            <div class="form-group">
                <div class="label">
                    <label>
                        <input type="submit" class="button" value="测试">
                    </label>
                </div>
                <%
                    if(!template.isEnabled()){
                %>
                <div class="field">
                    <input id="but_enable" type="button" class="button" value="启用该模版">
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</form>
<%
    boolean checkOk = false;
    Date from = null;
    Date to = null;
    try {
        from = sdf.parse(beginDate);
        to = sdf.parse(endDate);

        checkOk = from.before(to);
    } catch (Exception e) {
//        e.printStackTrace();
    }
%>
<% if(checkOk){%>
<div class="line">
    <% if(StringUtils.isNotBlank(template.getRules())){
        List<ContractPlanItem> rentList = template.generateRents(from,to);
    %>
    <table class="table table-striped table-bordered table-hover">
        <tr>
            <th>起始日期</th>
            <th>结束日期(不含)</th>
            <th>月租金</th>
        </tr>
        <%
            for (ContractPlanItem s : rentList) {
        %>
        <tr>
            <td><%=sdf.format(s.getFrom())%></td>
            <td><%=sdf.format(s.getTo())%></td>
            <td><%=String.format("%.2f",s.getRent())%></td>
        </tr>
        <%}%>
    </table>
    <%}else {%>
    该模块未添加任何约定，不可测试
    <%}%>
</div>
<%}%>
<script>
    $('.datetimepicker').datetimepicker({
        lang:"ch",           //语言选择中文
        format:"Y-m-d",      //格式化日期
        timepicker:false,    //关闭时间选项
        yearStart:2000,     //设置最小年份
        yearEnd:2050        //设置最大年份
        //todayButton:false    //关闭选择今天按钮
    });
</script>
</body>
</html>
