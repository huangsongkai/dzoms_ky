<%@ page import="com.dz.common.el.ELUtil" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Collections" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="org.apache.commons.jexl3.JexlScript" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Wang
  Date: 2018/12/19
  Time: 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

    public static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }

    public static int calDaysOfDate(Date date){
        int dt = date.getDate();
        if(dt>26){
            return dt - 26;
        }else {
            return dt + 4;
        }
    }

    public int calDateSpan(Date beginDate,Date endDate){
        int monthDiff = (endDate.getYear() - beginDate.getYear())*12 + endDate.getMonth()-beginDate.getMonth();
        return monthDiff*30 + calDaysOfDate(endDate)-calDaysOfDate(beginDate);
    }

    static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    public Date toDate(String dateString){
        try {
            return simpleDateFormat.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
%>
<%
    String name = request.getParameter("name");
    String beginDate = request.getParameter("beginDate");
    String endDate = request.getParameter("endDate");
    String userDefined = request.getParameter("userDefined");
//    String totalCount = request.getParameter("totalCount");
    String rules = request.getParameter("rules");
%>
<html>
<head>
    <title>合同模版设置</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">

    <script type="text/javascript" src="/DZOMS/res/js/vue.js" ></script>
    <script>
        $(document).ready(function(){
           $("#submit_btn").click(function(){
              $("#my_form").submit();
           });

            $("#submit_btn_final").click(function(){
                $("#addToDB").val(1);
                $("#my_form").submit();
            });
        });
    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>合同管理</li>
        <li>合同模版设置</li>
    </ul>
</div>
<div class="line">
    <div class="x6">
        <form id="my_form" enctype="application/x-www-form-urlencoded" action="/DZOMS/contract/template/template_setting2.jsp" class="form-x form-tips" method="post">
            <input v-bind:value="toJson" id="rules" name="rules" type="hidden" value='<%=nullIf(rules)%>'>
            <input id="addToDB" name="addToDB" value="0">
            <div class="form-group" id="f_1544449584305">
                <div class="label">
                    <label for="f_chinesename_txt">
                        合同模版名称
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_chinesename_txt" name="name" maxlength="15" value="<%=nullIf(name)%>"
                           data-validate="required:请填写模版名称" placeholder="输入模版名称">
                </div>
            </div>
            <div class="form-group" id="f_1544450346872">
                <div class="label">
                    <label>
                        测试起始日期
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="beginDate" maxlength="12"
                           value="<%=nullIf(beginDate)%>" data-validate="required:请填写测试起始日期,regexp#(^20[0-9]{2}-[0-9]{2}-[0-9]{2}$):日期yyyy-MM-dd" placeholder="输入起始日期">
                </div>
            </div>
            <div class="form-group" id="f_1544449595482">
                <div class="label">
                    <label for="f_englishname_txt">
                        测试终止日期(不含当日)
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_englishname_txt" name="endDate" maxlength="161"
                           value="<%=nullIf(endDate)%>" data-validate="required:请填写测试终止日期,regexp#(^20[0-9]{2}-[0-9]{2}-[0-9]{2}$):日期yyyy-MM-dd" placeholder="输入终止日期">
                </div>
            </div>
            <div class="form-group" id="f_1544449645443">
                <div class="label">
                    <label >
                        自定义变量区
                    </label>
                </div>
                <div class="field">
                    <textarea type="text" class="input" id="f_address_txt" name="userDefined" maxlength="1000"><%=nullIf(userDefined)%></textarea>
                </div>
            </div>
            <%--<div class="form-group">--%>
                <%--<div class="label">--%>
                    <%--<label>--%>
                        <%--约定总条数（表达式）--%>
                    <%--</label>--%>
                <%--</div>--%>
                <%--<div class="field">--%>
                    <%--<input type="text" class="input" name="totalCount" maxlength="161"--%>
                           <%--value="<%=nullIf(totalCount)%>" data-validate="required:请填写约定总条数" placeholder="约定总条数">--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="form-group">
                <div class="label">
                    <label>
                        约定规则<a class="button" v-on:click="addItem">添加</a>
                    </label>
                </div>
                <div class="field">
                    <div class="panel" v-for="(rule, index) in rules">
                        <div class="panel-head">
                            约定{{index+1}} <a class="button" v-on:click="deleteItem(index)">删除</a>
                        </div>
                        <div class="panel-body">
                            <form class="form-inline" >
                                <div class="form-group">
                                    <div class="label">
                                        <label>
                                            匹配条件（表达式）
                                        </label>
                                    </div>
                                    <div class="field">
                                        <input type="text" class="input" v-model="rule.condition" maxlength="161" placeholder="匹配条件">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="label">
                                        <label>
                                            月租金（表达式）
                                        </label>
                                    </div>
                                    <div class="field">
                                        <textarea type="text" class="input" v-model="rule.rent" maxlength="1000" placeholder="月租金（表达式）"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="label">
                                        <label>
                                            起始月（表达式）
                                        </label>
                                    </div>
                                    <div class="field">
                                        <input type="text" class="input" v-model="rule.spanBegin" maxlength="161" placeholder="起始月">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="label">
                                        <label>
                                            结束月(不含)（表达式）
                                        </label>
                                    </div>
                                    <div class="field">
                                        <input type="text" class="input" v-model="rule.spanEnd" maxlength="161" placeholder="结束月">
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div>

                </div>
            </div>
            <div class="form-group" id="f_1544449663516">
                <input type="button" class="button bg-red" value="测试" id="submit_btn">
                <input class="button bg-yellow form-reset" type="button" id="btn_clear" value="清空">
                <input type="button" class="button bg-green" value="提交到数据库" id="submit_btn_final">
            </div>
        </form>
    </div>
    <div class="x6">
        <%
            Map<String,Object> elMap = new HashMap<>();
            elMap.put("page",this);
            elMap.put("math",Math.class);
            ELUtil el = new ELUtil(elMap);
//            el.getEngine().getFunctions().put("page",this);
            el.setVariable("模板名称",name);
            if(beginDate!=null && endDate!=null){
                el.setVariable("起始日期(字符串)",beginDate);
                el.setVariable("结束日期(字符串)",endDate);
                el.compileAndEvaluate("$[起始日期]=page:toDate($[起始日期(字符串)])");
                el.compileAndEvaluate("$[结束日期]=page:toDate($[结束日期(字符串)])");
                el.compileAndEvaluate("$[总天数]=page:calDateSpan($[起始日期],$[结束日期])");
                el.compileAndEvaluate("$[总期数]=math:ceil($[总天数]/30.0)");
                el.compileAndEvaluate(nullIf(userDefined));
            }

//            el.setVariable("约定总条数",el.compileAndEvaluate(nullIf(totalCount)));

            Map variableMap = (Map) el.getContext().get("variableMap");
        %>
        <div class="panel"><div class="panel-head">内置变量</div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>名称</th>
                        <th>类型</th>
                        <th>取值</th>
                    </tr>
                    <%for (Object o : variableMap.keySet()) {%>
                    <tr>
                        <td><%=o%></td>
                        <td><%=variableMap.get(o)==null?"-":variableMap.get(o).getClass().getCanonicalName()%></td>
                        <td><%=variableMap.get(o)%></td>
                    </tr>
                    <%}%>
                </table>
            </div>
        </div>
        <div class="panel"><div class="panel-head">约定展示</div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>起始月</th>
                        <th>结束月(不含)</th>
                        <th>月租金</th>
                    </tr>
                    <%
                        if(rules!=null){
                            JSONArray jarr = JSONArray.fromObject(rules);
                            for (int i = 0; i < jarr.size(); i++) {
                                JSONObject jobj = jarr.getJSONObject(i);
                                JexlScript script = el.getEngine().createScript(jobj.getString("condition"),"$0");
                                Object condition = script.execute(el.getContext(),i);
//                                System.out.println(condition);
                                if(condition== null || condition.equals(false) ){
                                    continue;
                                }
                    %>
                        <tr>
                            <td><%=el.compileAndEvaluate(jobj.getString("spanBegin"))%></td>
                            <td><%=el.compileAndEvaluate(jobj.getString("spanEnd"))%></td>
                            <td><%=el.compileAndEvaluate(jobj.getString("rent"))%></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    var info = new Vue({
        el:"#my_form",
        data:{
            rules:<%=rules==null?"[]":rules%>
        },
        methods:{
            addItem:function () {
                this.rules.push({
                    condition:"true",
                    rent:"",
                    spanBegin:"1",
                    spanEnd:"96",
                    itemsCount:1
                });
            },
            deleteItem:function(i){
                this.rules.splice(i,1);
            }
        },
        computed:{
            toJson:function(){
                return JSON.stringify(this.rules);
            }
        }
    });

    <%--if($("#rules").val().length>2){--%>
        <%--info["rules"] = JSON.parse('<%=rules==null?"[]":rules%>');--%>
    <%--}--%>
</script>
</body>
</html>
