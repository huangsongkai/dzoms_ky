<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="com.dz.module.contract.ContractTemplate" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="org.hibernate.HibernateException" %>
<%@ page import="com.dz.module.contract.ContractTemplateUtil" %>

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

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }
%>
<%
    String name = request.getParameter("name");
    String method = request.getParameter("method");
    String version = request.getParameter("version");
    String comment = request.getParameter("comment");

    String id = request.getParameter("id");
    String message = "";

    int forward_id = toInt(request.getParameter("forward_id"));
    ContractTemplate template = null;

    int delete_id = toInt(request.getParameter("delete_id"));
    if(delete_id!=0){
        Session hsession = null;
        Transaction tx = null;
        try {
            hsession = HibernateSessionFactory.getSession();
            tx = hsession.beginTransaction();
            template = (ContractTemplate) hsession.get(ContractTemplate.class,delete_id);
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
        template = ObjectAccess.getObject(ContractTemplate.class,forward_id);
    }else {
        template = new ContractTemplate();
        template.setId(toInt(id));
        template.setMethod(method);
        template.setName(name);
        template.setVersion(version);
        template.setComment(comment);

        if (name != null && method!=null && comment!=null && version!=null) {
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
                content: '/DZOMS/contract/template/template_test.jsp?id='+id
            });
        }
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
        <form id="my_form" enctype="application/x-www-form-urlencoded" action="#" class="form-x form-tips" method="post">
            <input type="hidden" id="script_id" name="id" value="<%=template.getId()%>">
            <input type="hidden" id="forward_id" name="forward_id" value="0">
            <input type="hidden" id="delete_id" name="delete_id" value="0">
            <div class="form-group" id="f_1544449584305">
                <div class="label">
                    <label for="f_chinesename_txt">
                        合同模版名称
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_chinesename_txt" name="name" maxlength="15" value="<%=nullIf(template.getName())%>"
                           data-validate="required:请填写脚本名称" placeholder="输入脚本名称">
                </div>
            </div>
            <div class="form-group" id="f_1544450346872">
                <div class="label">
                    <label>
                        发包函数
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="method" maxlength="161"
                           value="<%=nullIf(template.getMethod())%>" data-validate="required:请填写发包函数,regexp#(^[0-9a-zA-Z\._]*$):请输入发包函数" placeholder="输入发包函数名称">
                </div>
            </div>
            <div class="form-group" id="f_1544449595482">
                <div class="label">
                    <label for="f_englishname_txt">
                        函数版本
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_englishname_txt" name="version" maxlength="161"
                           value="<%=nullIf(template.getVersion())%>" data-validate="required:请填写版本号,regexp#(^[0-9a-zA-Z\.]*$):请输入版本号，如1.0.0" placeholder="输入版本号">
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
            <div class="form-group" id="f_1544449663516">
                <input type="submit" class="button bg-red" value="确认">
                <input class="button bg-yellow form-reset" type="button" id="btn_clear" value="清空">
            </div>
        </form>
    </div>
    <div class="x6">
        <%
            List<ContractTemplate> templates = ObjectAccess.query(ContractTemplate.class,null);
        %>
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <th>模版名称</th>
                <th>模版函数</th>
                <th>版本</th>
                <th>状态</th>
                <th>支持到的版本</th>
                <th>测试</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            <%
                for (ContractTemplate s : templates) {
            %>
            <tr>
                <td><%=s.getName()%></td>
                <td><%=s.getMethod()%></td>
                <td><%=s.getVersion()%></td>
                <td><%=s.getValidate()?"可用":"不可用"%></td>
                <td><%=s.getSupportVersion()%></td>
                <td><a href="javascript:doTest(<%=s.getId()%>)">测试</a></td>
                <td><a href="javascript:doUpdate(<%=s.getId()%>)">修改</a></td>
                <td><a href="javascript:doDelete(<%=s.getId()%>,'<%=s.getName()%>')">删除</a></td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
</body>
</html>
