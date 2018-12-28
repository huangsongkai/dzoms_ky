<%@ page import="com.dz.common.other.ObjectAccess" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.dz.module.contract.SysScript" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="com.dz.module.contract.ContractTemplateUtil" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.hibernate.HibernateException" %>
<%@ page import="org.hibernate.Transaction" %>

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
    String type = request.getParameter("type");
    String name = request.getParameter("name");
    String version = request.getParameter("version");
    String script = request.getParameter("script");
    String isActive = request.getParameter("isActive");
    String id = request.getParameter("id");
    String message = "";

    int forward_id = toInt(request.getParameter("forward_id"));
    SysScript sysScript = null;

    int delete_id = toInt(request.getParameter("delete_id"));
    if(delete_id!=0){
        Session hsession = null;
        Transaction tx = null;
        try {
            hsession = HibernateSessionFactory.getSession();
            tx = hsession.beginTransaction();
            sysScript = (SysScript) hsession.get(SysScript.class,delete_id);
            hsession.delete(sysScript);
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
        sysScript = ObjectAccess.getObject(SysScript.class,forward_id);
    }else {
        sysScript = new SysScript();
        sysScript.setId(toInt(id));
        sysScript.setType(type);
        sysScript.setName(name);
        sysScript.setVersion(version);
        sysScript.setScript(script);
        sysScript.setActive(StringUtils.equalsIgnoreCase(isActive,"yes"));

        if (isActive != null && type!=null && name!=null && version!=null && script!=null) {
            try{
                ContractTemplateUtil util = ContractTemplateUtil.getInstance();
                util.addScript(sysScript);
                message = "操作成功！";
            }catch (RuntimeException ex){
                message = "操作失败！原因是："+ex.getMessage();
            }
        }
    }
%>
<html>
<head>
    <title>自定义函数模块设置</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>

    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        var message = "<%=message%>";
        $(document).ready(function(){
           $("#sFile").change(function(){
               var file =$("#sFile")[0].files[0];
               var reader = new FileReader();
               reader.onload = function(){
                   $("#sVal").val(this.result);
               };
               reader.readAsBinaryString(file);
           });

            $("#btn_clear").click(function(){
                $('#script_id').val(0);
                $("input[name='type'][value='base']").click();
                $("input[name='name']").val("");
                $("input[name='version']").val("");
                $("input[name='script']").val("");
                $("input[name='isActive'][value='no']").click();
            });

            var type = "<%=sysScript.getType()%>";
            if(type!='' && type!='null'){
//                $("input[name='type'][value='"+type+"']").prop("checked",true);
                $("input[name='type'][value='"+type+"']").click();
            }

            var script = "<%=StringEscapeUtils.escapeJava(nullIf(sysScript.getScript()))%>";
            var isActive = "<%=sysScript.isActive()?"yes":"no"%>";

            $("#sVal").val(script);
//            $("input[name='isActive'][value='"+isActive+"']").prop("checked",true);
            $("input[name='isActive'][value='"+isActive+"']").click();

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
    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
    <ul class="bread text-main" style="font-size: larger;">
        <li>合同管理</li>
        <li>自定义函数模块设置</li>
    </ul>
</div>
<div class="line">
    <div class="x6">
        <form id="my_form" enctype="application/x-www-form-urlencoded" action="#" class="form-x form-tips" method="post">
            <input type="hidden" id="script_id" name="id" value="<%=sysScript.getId()%>">
            <input type="hidden" id="forward_id" name="forward_id" value="0">
            <input type="hidden" id="delete_id" name="delete_id" value="0">
            <div class="form-group" id="f_1544449488351">
                <div class="label">
                    <label>
                        脚本类型
                    </label>
                </div>
                <div class="field">
                    <div class="button-group radio">
                        <label class="button active">
                            <input name="type" value="base" checked="checked" type="radio"
                                    data-validate="required:请选择,length#>=1:至少选择1项"> 基础模块
                        </label>
                        <label class="button">
                            <input  name="type" value="extends" type="radio"
                                    data-validate="required:请选择,length#>=1:至少选择1项">扩展模块
                        </label>
                        <label class="button">
                            <input  name="type" value="upgrade" type="radio"
                                    data-validate="required:请选择,length#>=1:至少选择1项">升级模块
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group" id="f_1544449584305">
                <div class="label">
                    <label for="f_chinesename_txt">
                        脚本名称
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_chinesename_txt" name="name" maxlength="15" value="<%=nullIf(sysScript.getName())%>"
                           data-validate="required:请填写脚本名称" placeholder="输入脚本名称">
                </div>
            </div>
            <div class="form-group" id="f_1544449595482">
                <div class="label">
                    <label for="f_englishname_txt">
                        版本号
                    </label>
                </div>
                <div class="field">
                    <input type="text" class="input" id="f_englishname_txt" name="version" maxlength="161"
                           value="<%=nullIf(sysScript.getVersion())%>" data-validate="required:请填写版本号,regexp#(^[0-9a-zA-Z\.]*$):请输入版本号，如1.0.0" placeholder="输入版本号">
                </div>
            </div>
            <div class="form-group" id="f_1544450346872">
                <div class="label">
                    <label>
                        脚本代码文件
                    </label>
                </div>
                <div class="field">
                    <a class="button input-file" href="javascript:void(0);">
                        + 请选择上传脚本文件
                        <input size="100" id="sFile" type="file">
                        <input type="hidden" name="script" data-validate="required:请选择脚本文件,只能上传js|txt格式文件,文件不可为空" id="sVal">
                    </a>
                </div>
            </div>
            <div class="form-group" id="f_1544449645443">
                <div class="label">
                    <label >
                        脚本已激活?
                    </label>
                </div>
                <div class="field">
                    <div class="button-group radio">
                        <label class="button active">
                            <input id="f_work1" name="isActive" value="yes" checked="checked" type="radio"
                                   data-validate="required:请选择,length#>=1:至少选择1项"><span class="icon icon-check"></span> 已激活
                        </label>
                        <label class="button">
                            <input id="f_work0" name="isActive" value="no" type="radio"
                                   data-validate="required:请选择,length#>=1:至少选择1项"><span class="icon icon-times"></span> 未激活
                        </label>
                    </div>
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
        List<SysScript> sysScripts = ObjectAccess.query(SysScript.class,null);
        %>
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <th>脚本类型</th>
                <th>脚本名称</th>
                <th>版本号</th>
                <th>脚本代码</th>
                <th>状态</th>
                <th>修改</th>
                <th>删除</th>
            </tr>
            <%
                for (SysScript s : sysScripts) {
            %>
            <tr>
                <td><%=s.getType()%></td>
                <td><%=s.getName()%></td>
                <td><%=s.getVersion()%></td>
                <td><a href="js_module_download.jsp?id=<%=s.getId()%>">下载</a></td>
                <td><%=s.isActive()?"已启用":"未启用"%></td>
                <td><a href="javascript:doUpdate(<%=s.getId()%>)">修改</a></td>
                <td><a href="javascript:doDelete(<%=s.getId()%>,'<%=s.getName()%>')">删除</a></td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
</body>
</html>
