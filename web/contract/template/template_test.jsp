<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.dz.module.contract.ContractTemplate" %>
<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dz.module.contract.ContractPlanItem" %><%--
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
    double rentTotal = toDouble(request.getParameter("rentTotal"));
    ContractTemplate template = ObjectAccess.getObject(ContractTemplate.class,id);
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
                    发包函数
                </label>
            </div>
            <div class="field">
                <label>
                    <%=nullIf(template.getMethod())%>
                </label>
            </div>
        </div>
    </div>
    <div class="x4">
        <div class="form-group">
            <div class="label">
                <label>
                    函数版本
                </label>
            </div>
            <div class="field">
                <label>
                    <%=nullIf(template.getVersion())%>
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
                    支持到的版本
                </label>
            </div>
            <div class="field">
                <label>
                    <%=nullIf(template.getSupportVersion())%>
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
                    <%=template.getValidate()?"可用":"不可用"%>
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
</div>
<form method="post" action="#">
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
                        总租金
                    </label>
                </div>
                <div class="field">
                    <div class="input-group">
                        <input type="text" class="input" name="rentTotal" maxlength="11" value="<%=rentTotal%>"
                               data-validate="required:请填写总租金,plusdouble:租金应为数字"  placeholder="总租金">
                        <div class="addbtn">
                            <div class="button-group">
                                <input type="submit" class="button" value="测试">
                            </div>
                        </div>
                    </div>
                </div>
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

        checkOk = from.before(to) && rentTotal>0;
    } catch (Exception e) {
//        e.printStackTrace();
    }
%>
<% if(checkOk){%>
<div class="line">
    <% if(template.getValidate()){
        List<ContractPlanItem> rentList = template.generateRents(from,to,rentTotal);
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
    该模块未通过自动测试，不可进行
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
