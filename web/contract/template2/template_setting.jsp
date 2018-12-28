<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.HibernateException" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.dz.module.user.User" %>
<%@ page import="com.dz.module.contract.ContractTemplate2" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>

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
            return 0;
        }
    }

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }
%>
<%
    String name = request.getParameter("name");
    double rentFirst = toDouble(request.getParameter("rentFirst"));
    int rentDivideStages = toInt(request.getParameter("rentDivideStages"));
    String comment = request.getParameter("comment");
    double deposit = toDouble(request.getParameter("deposit"));
    User user = (User)session.getAttribute("user");
    String userDefined = request.getParameter("userDefined");
    String rules = request.getParameter("rules");
    int inputMode = toInt(request.getParameter("inputMode"));
//    Date createTime = new Date();

    String id = request.getParameter("id");
    String message = "";

    int forward_id = toInt(request.getParameter("forward_id"));
    ContractTemplate2 template = null;

    int delete_id = toInt(request.getParameter("delete_id"));
    if(delete_id!=0){
        Session hsession = null;
        Transaction tx = null;
        try {
            hsession = HibernateSessionFactory.getSession();
            tx = hsession.beginTransaction();
            template = (ContractTemplate2) hsession.get(ContractTemplate2.class,delete_id);
            hsession.delete(template);
            tx.commit();
        }catch (HibernateException ex){
            message = ex.getMessage();
            if(tx!=null){
                tx.rollback();
            }
        }finally {
            HibernateSessionFactory.closeSession();
        }
    }else if(forward_id!=0){
        template = ObjectAccess.getObject(ContractTemplate2.class,forward_id);
    }else {
        template = new ContractTemplate2();
        template.setId(toInt(id));
        template.setName(name);
        template.setRentFirst(rentFirst);
        template.setRentDivideStages(rentDivideStages);
        template.setDeposit(deposit);
        template.setEnabled(false);
        template.setCreateTime(new Date());
        template.setUname(user.getUname());
        template.setComment(comment);
        template.setUserDefined(userDefined);
        template.setRules(rules);
        template.setInputMode(inputMode);

        if (name != null && rules!=null && comment!=null && userDefined!=null) {
            try{
//                ContractTemplateUtil util = ContractTemplateUtil.getInstance();
                Session hsession = null;
                Transaction tx = null;
                try {
                    hsession = HibernateSessionFactory.getSession();
                    tx = hsession.beginTransaction();
                    hsession.saveOrUpdate(template);
                    tx.commit();
                }catch (HibernateException ex){
                    message = ex.getMessage();
                    if(tx!=null){
                        tx.rollback();
                    }
                }finally {
                    HibernateSessionFactory.closeSession();
                }
            }catch (RuntimeException ex){
                message = "操作失败！原因是："+ex.getMessage();
            }
        }
    }
%>
<html>
<head>
    <title>合同模版设置</title>
   <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/vue.js" ></script>
    <script>
        var message = "<%=message%>";
        $(document).ready(function(){
            $("#btn_clear").click(function(){
                $('#script_id').val(0);
                $("input[name='name']").val("");
                $("input[name='version']").val("");
                $("input[name='method']").val("");
                $("input[name='comment']").val("");
            });

            if(message.length>0){
                alert(message);
            }
        });

        function doUpdate(id){
            $("#forward_id").val(id);
            $("#my_form").unbind('submit');
            $("#my_form").submit();
        }

        function doDelete(id,name){
            if(confirm("确定删除‘"+name+"’？")){
                $("#delete_id").val(id);
                $("#my_form").unbind('submit');
                $("#my_form").submit();
            }
        }

        function doTest(id){
            layer.open({
                type: 2,
                title: '合同模版测试',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '600px'],
                content: '/DZOMS/contract/template2/template_test.jsp?id='+id
            });
        }

        function doRefresh(){
            window.location.href="/DZOMS/contract/template2/template_setting.jsp";
        }
    </script>
    <style>
        .not-show{
            display: none;
        }
    </style>
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
        <form id="my_form" enctype="application/x-www-form-urlencoded" action="#" class="form-x form-tips" method="post">
            <input type="hidden" id="script_id" name="id" value="<%=template.getId()%>">
            <input type="hidden" id="forward_id" name="forward_id" value="0">
            <input type="hidden" id="delete_id" name="delete_id" value="0">

            <input v-bind:value="toJson" id="rules" name="rules" type="hidden" value='<%=nullIf(template.getRules())%>'>
            <div class="form-group" id="f_1544449584305">
                <div class="label">
                    <label for="f_chinesename_txt">
                        合同模版名称
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_chinesename_txt" name="name" maxlength="15" value="<%=nullIf(template.getName())%>"
                           data-validate="required:请填写模版名称" placeholder="输入模版名称">
                </div>
            </div>

            <div class="form-group" id="f_1544450346872">
                <div class="label">
                    <label>
                        预付金总额
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="rentFirst" maxlength="11"
                           value="<%=template.getRentFirst()%>" data-validate="required:请填写预付金总额,double:预付金总额应为数字" placeholder="输入预付金总额">
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>
                        预付金摊销总期数
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="rentDivideStages" maxlength="11"
                           value="<%=template.getRentDivideStages()%>" data-validate="required:请填写摊销总期数,plusinteger:预付金摊销总期数应为正整数" placeholder="输入摊销总期数">
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>
                        定金
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="deposit" maxlength="11"
                           value="<%=template.getDeposit()%>" data-validate="required:请填写定金,plusdouble:定金应为正数" placeholder="输入定金">
                </div>
            </div>
            <div class="form-group" id="f_1544449645443">
                <div class="label">
                    <label >
                        说明
                    </label>
                </div>
                <div class="field">
                    <textarea type="text" class="input" id="f_address_txt" name="comment" maxlength="500" placeholder="请输入模版说明"><%=nullIf(template.getComment())%></textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label>
                        录入模式
                    </label>
                </div>
                <div class="field">
                    <select class="input" name="inputMode" v-model="inputMode">
                        <option value="0">常规模式</option>
                        <option value="1">专业模式</option>
                    </select>
                </div>
            </div>

            <div class="form-group" v-bind:class="{'not-show':(inputMode==0)}">
                <div class="label">
                    <label >
                        自定义变量区
                    </label>
                </div>
                <div class="field">
                    <textarea type="text" class="input" name="userDefined" maxlength="1000"><%=nullIf(template.getUserDefined())%></textarea>
                </div>
            </div>

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
                            <%--<form class="form-inline" >--%>
                                <div class="form-group" v-if="inputMode==1">
                                    <div class="label">
                                        <label>
                                            匹配条件（表达式）
                                        </label>
                                    </div>
                                    <div class="field">
                                        <input type="text" class="input" v-model="rule.condition" maxlength="161" placeholder="匹配条件">
                                    </div>
                                </div>
                                <div class="form-group" v-else >
                                    <div class="label">
                                        <label>
                                            匹配条件(期数)
                                        </label>
                                    </div>
                                    <div class="field">
                                        <select class="input" v-model="rule.regType">
                                            <option value="0">无</option>
                                            <option value="1">期数=</option>
                                            <option value="2">期数&gt;</option>
                                            <option value="3">期数&ge;</option>
                                            <option value="4">期数&lt;</option>
                                            <option value="5">期数&le;</option>
                                            <option value="6">&le;期数&lt;</option>
                                        </select>
                                        <input type="hidden" v-model="rule.condition">
                                        <div class="input-group" v-if="rule.regType>0 && rule.regType<6">
                                            <span class="addon">期数{{regTypes[rule.regType]}}</span>
                                            <input class="input" type="text" v-model="rule.regValue" size="11" />
                                        </div>
                                        <div class="input-group" v-if="rule.regType==6">
                                            <input class="input"  type="text" v-model="rule.regValue" size="11" />
                                            <span class="addon">&le;期数&lt;</span>
                                            <input class="input"  type="text" v-model="rule.regValue2" size="11" />
                                        </div>
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
                                <div class="form-group" v-bind:class="{'not-show':(inputMode==0)}">
                                    <div class="label">
                                        <label>
                                            生成条数（表达式）
                                        </label>
                                    </div>
                                    <div class="field">
                                        <input type="text" class="input" v-model="rule.itemsCount" maxlength="161" placeholder="约定生成条数">
                                    </div>
                                </div>
                            <%--</form>--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group" v-if="enabled==true">
                <input type="button" class="button bg-red" onclick="doRefresh()" value="添加新模版">
            </div>
            <div class="form-group" v-else >
                <input type="submit" class="button bg-red" value="确认">
                <input class="button bg-yellow form-reset" type="button" id="btn_clear" value="清空">
            </div>
        </form>
    </div>
    <div class="x6">
        <%
            List<ContractTemplate2> templates = ObjectAccess.query(ContractTemplate2.class,null);
        %>
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <th>模版名称</th>
                <th>预付金</th>
                <th>摊销期数</th>
                <th>定金</th>
                <th>录入人</th>
                <th>录入时间</th>
                <th>是否已启用</th>
                <th>测试</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            <%
                for (ContractTemplate2 s : templates) {
            %>
            <tr>
                <td><%=s.getName()%></td>
                <td><%=String.format("%.2f",s.getRentFirst())%></td>
                <td><%=s.getRentDivideStages()%></td>
                <td><%=s.getDeposit()%></td>
                <td><%=s.getUname()%></td>
                <td><%=String.format("%tF %tT",s.getCreateTime(),s.getCreateTime())%></td>
                <td><%=s.isEnabled()?"已启用":"未启用"%></td>
                <td><a href="javascript:doTest(<%=s.getId()%>)">测试</a></td>
                <td><a href="javascript:doUpdate(<%=s.getId()%>)"><%=s.isEnabled()?"查看":"修改"%></a></td>
                <td><a href="javascript:doDelete(<%=s.getId()%>,'<%=s.getName()%>')">删除</a></td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
<script>
//    var regTypes = ["","=",">","≥","<","≤"];
//    var regMappings = ["true","==",">",">=","<","<="];
    var info = new Vue({
        el:"#my_form",
        data:{
            rules:<%=template.getRules()==null?"[]":template.getRules()%>,
            inputMode:<%=template.getInputMode()%>,
            enabled:<%=template.isEnabled()%>,
            regTypes : ["","=",">","≥","<","≤"],
            regMappings : ["true","==",">",">=","<","<="]
        },
        methods:{
            addItem:function () {
                this.rules.push({
                    condition:"true",
                    rent:"",
                    regType:"0",
                    spanBegin:"1",
                    spanEnd:"97",
                    itemsCount:1,
                    regValue:0,
                    regValue2:0
                });
            },
            deleteItem:function(i){
                this.rules.splice(i,1);
            }
        },
        computed:{
            toJson:function(){
                if(this.inputMode==0){
                    this.rules.forEach(function(rule,i,arr){
                        switch (rule.regType){
                            case '0':
                                this.rules[i].condition = "true";
                                return;
                            case '6':
                                this.rules[i].condition = "$[期数] >= "+rule.regValue+" && $[期数] < "+rule.regValue2;
                                return;
                            default:
                                this.rules[i].condition = "$[期数] "+this.regMappings[rule.regType]+" ";
                        }
                    },this);
                }
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
