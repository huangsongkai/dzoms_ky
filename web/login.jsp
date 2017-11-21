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
    <link type="image/x-icon" href="/favicon.ico" rel="shortcut icon" />
    <link href="/favicon.ico" rel="bookmark icon" />
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
</head>

<body style="background-image: url('res/image/back.jpg');background-repeat: no-repeat;background-position: center;background-attachment: fixed">
<div class="container">
    <div class="line">
        <div class="xs6 xm4 xs3-move xm4-move" style="margin-right:100px; wide:100px; padding-left:300px; pedding-right:300px;width: 700px;">
            <br /><br />
            <div class="media media-y">
            </div>
            <br /><br /><br /><br /><br /><br /><br /><br /><br />
            <form action="userLogin" method="post">
            <div class="panel">
                <div class="panel-head"><strong>系统登陆</strong></div>
                <div class="panel-body" style="padding:30px;">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" name="user.uname" placeholder="登录账号" data-validate="required:请填写账号,length#>=5:账号长度不符合要求" />
                            <span class="icon icon-user"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="password" class="input" name="user.upwd" placeholder="登录密码" data-validate="required:请填写密码,length#>=1:密码长度不符合要求" />
                            <span class="icon icon-key"></span>
                        </div>
                    </div>
                   <input type="hidden" name="theme" value="1"/>
                   <%--  <s:hidden name="theme" value="1"></s:hidden> --%>
                   <%-- <div class="form-group">
                        <div class="field field-icon-right">
                            <s:radio name="theme" list="#{'0':'风格1','1':'风格2'}" value="0"/>
                       </div>
                    </div>--%>
                    <%-- <div class="form-group">
                        <div class="field">
                            <input type="text" class="input" name="passcode" placeholder="填写右侧的验证码" data-validate="required:请填写右侧的验证码" />
                            <img src="images/passcode.jpg" width="80" height="32" class="passcode" />
                        </div>
                    </div> --%>
                </div>
                <div class="panel-foot text-center"><button class="button button-block bg-main text-big">立即登录</button></div>
            </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>