<%@page import="java.net.URLDecoder"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>登录</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>

    <link rel="stylesheet" href="/DZOMS/res/jqx/jqx.base.css" />
    <script type="text/javascript" src="/DZOMS/res/jqx/jqxcore.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/jqx/jqxdata.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/jqx/jqxbuttons.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/jqx/jqxscrollbar.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/jqx/jqxlistbox.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/jqx/jqxcombobox.js" ></script>

    <link type="image/x-icon" href="/favicon.ico" rel="shortcut icon" />
    <link href="/favicon.ico" rel="bookmark icon" />
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
    <%
        Cookie[] cookies = request.getCookies();
        String uname = "";
        if(cookies!=null)
            for(Cookie cookie:cookies){
                if(cookie.getName().equals("LoginName")){
                    uname = URLDecoder.decode(cookie.getValue(),"utf-8");
                    break;
                }
            }
    %>
    <script>

        $(document).ready(function() {

            var url = "/DZOMS/userNames.action";
            var source = {
                datatype: "json",
                datafields: [{
                    name: 'name'
                }],
                url: url,
                async: false
            };
            var dataAdapter = new $.jqx.dataAdapter(source); // Create a jqxComboBox
            var uname="<%=uname%>";

            $("#jqxWidget").on('bindingComplete', function(event) {
                //alert($("#jqxWidget input[type='textarea']").attr('value'));
                $("#jqxWidget").val(uname);
                $("#jqxWidget input").val(uname);
                $('input[name="user.uname"]').val(uname);
                $("#jqxWidget input[type='textarea']").attr('value',uname);
                //alert($("#jqxWidget input[type='textarea']").attr('value'));
            });

            $("#jqxWidget").jqxComboBox({
                selectedIndex: 0,
                source: dataAdapter,
                displayMember: "name",
                valueMember: "name",
                width: 300,
                height: 25
            });

            // trigger the select event.
            $("#jqxWidget").on('select', function(event) {
                if(event.args) {
                    var item = event.args.item;
                    if(item) {
                        $('input[name="user.uname"]').val($("#jqxWidget input[type='textarea']").val());
                    }
                }
            });

            //alert($("#jqxWidget input[type='textarea']").val());
            //$("#jqxWidget input[type='textarea']")[0].value = (uname);

        });

        function beforeSubmit(){
            //$('input[name="user.uname"]').val($("#jqxWidget").val());
            $('input[name="user.uname"]').val($("#jqxWidget input[type='textarea']").val());
            return true;
        }

    </script>
</head>

<body style="background-image: url('res/image/back.jpg');background-repeat: no-repeat;background-position: center;background-attachment: fixed">
<div class="container">
    <div class="line">
        <div class="xs6 xm4 xs3-move xm4-move" style="margin-right:100px; wide:100px; padding-left:300px; pedding-right:300px;width: 700px;">
            <br /><br />
            <div class="media media-y">
            </div>
            <br /><br /><br /><br /><br /><br /><br /><br /><br />
            <form action="userLogin" method="post" onsubmit="return beforeSubmit();">
                <div class="panel">
                    <div class="panel-head"><strong>系统登陆</strong></div>
                    <div class="panel-body" style="padding:30px;">
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <div id='jqxWidget'></div>
                                <input type="hidden" class="input" name="user.uname"/>
                                <span class="icon icon-user"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="upwd" class="input" name="user.upwd" placeholder="登录密码" data-validate="required:请填写密码,length#>=1:密码长度不符合要求" />
                                <span class="icon icon-key"></span>
                            </div>
                        </div>
                        <input type="hidden" name="theme" value="1"/>
                    </div>
                    <div class="panel-foot text-center"><button class="button button-block bg-main text-big">立即登录</button></div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>