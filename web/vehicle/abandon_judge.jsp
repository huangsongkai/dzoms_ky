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
    <title>车辆审批</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
</head>

<body>
<div class="lefter">

</div>
<div class="righter nav-navicon" id="admin-nav">
    <div class="mainer">
        <div class="admin-navbar">
            <span class="float-right">
            	<a class="button button-little bg-main" href="#" target="_blank">查看消息</a>
                <a class="button button-little bg-yellow" href="login.html">注销登录</a>
            </span>
            <ul class="nav nav-inline admin-nav">
                <li><a href="../../index.html" class="icon-home"> 开始</a>
                    <ul><li><a href="system.html">系统设置</a></li><li><a href="content.html">车辆管理</a></li><li><a href="#">合同管理</a></li><li><a href="#">驾驶员管理</a></li><li><a href="#">财务管理</a></li></ul>
                </li>
                <li><a href="system.html" class="icon-cog"> 系统</a>
            		<ul><li><a href="#">新增用户</a></li><li class="active"><a href="#">密码修改</a></li><li><a href="#">权限设置</a></li></ul>
                </li>
                <li><a href="content.html" class="icon-file-text"> 合同</a>
					<ul><li><a href="#">合同新增</a></li><li class="active"><a href="#">合同查找</a></li><li><a href="#">合同修改</a></li><li><a href="#">合同废除</a></li></ul>
                </li>
                <li class="active"><a href="#" class="icon-shopping-cart"> 车辆</a>
                    <ul><!-- <li><a href="#">车辆新增</a></li><li><a href="#">车辆查找</a></li><li><a href="#">车辆修改</a></li> --><li class="active"><a href="#">车辆审批</a></li></ul>
                </li>
                <li><a href="#" class="icon-user"> 驾驶员</a>
                    <ul><li><a href="#">驾驶员新增</a></li><li class="active"><a href="#">驾驶员查找</a></li><li><a href="#">驾驶员修改</a></li><li><a href="#">驾驶员删除</a></li></ul>
                </li>
                <li><a href="#" class="icon-file"> 财务</a></li>
                <li><a href="#" class="icon-th-list"> 其它</a></li>
            </ul>
        </div>
        <div class="adminmin-bread">
            <span>您好，admin，欢迎您的光临。</span>
            <ul class="bread">
                <li><a href="index.html" class="icon-home"> 开始</a></li>
                <li>后台首页</li>
            </ul>
        </div>
    </div>
    <!-- 主菜单 -->
</div>

<div class="admin"><!-- 主页面 -->
<form action="index.html" method="post" class="definewidth m20">
<table class="table table-bordered table-hover m10">
    <tr>
        <td style="width: 10%" class="tableleft">所属部门</td>
        <td><input type="text" name="ereason" readonly="readonly" value="运营管理部二部"/></td>

        <td class="tableleft">车号</td>
        <td>黑A<input type="text" name="ereason" readonly="readonly" value="T4098"/></td>
    </tr>
    <tr>
        <td class="tableleft">车型</td>
        <td><input type="text" name="ereason" readonly="readonly" value="捷达"/></td>
   
        <td class="tableleft">车架号</td>
        <td><input type="text" name="ereason" readonly="readonly" value="23173897897987"/></td>
    </tr>
    <tr>
        <td class="tableleft">承租人姓名</td>
        <td><input type="text" name="ereason" readonly="readonly" value="张三"/></td>
   
        <td class="tableleft">月租金</td>
        <td><input type="text" name="ereason" readonly="readonly" value="2000"/></td>
    </tr>
    <tr>
        <td class="tableleft">机动车行驶证核发日期</td>
        <td><input type="text" name="ereason" readonly="readonly" value="2015-03-04"/></td>
   
        <td class="tableleft">运营手续归属</td>
        <td><input type="text" name="ereason" readonly="readonly" value="公司"/></td>
    </tr>
    <tr>
        <td class="tableleft">车辆保险</td>
        <td><input type="text" name="ereason" readonly="readonly" value="含"/></td>
   
        <td class="tableleft">承租合同期限</td>
        <td><input type="text" name="ereason" readonly="readonly" value="2015-05-04"/></td>
    </tr>
    <tr>
        <td class="tableleft">已运营</td>
        <td><input type="text" name="ereason" readonly="readonly" value="0"/>年<input type="text" name="ereason" readonly="readonly" value="2"/>个月</td>
    
        <td class="tableleft">办理事项</td>
        <td><input type="text" name="ereason" readonly="readonly" value="废业"/></td>
    </tr>
    <tr>
        <td class="tableleft">废业原因</td>
        <td><input type="text" name="ereason" readonly="readonly" value="合同终止"/></td>
  
        <td class="tableleft">解除原因</td>
        <td><input type="text" name="ereason" readonly="readonly" value="欠费"/></td>
    </tr>
    <tr>
        <td class="tableleft">承租人申请</td>
        <td><textarea class="input-xlarge" id="textarea1" rows="3" readonly="readonly">审批通过</textarea></td>

        <td class="tableleft">运营管理部意见</td>
        <td><textarea class="input-xlarge" id="textarea2" rows="3" readonly="readonly">审批通过</textarea></td>
    </tr>
    <tr>
        <td>审批意见</td>
        <td><textarea class="input-xlarge" id="textarea2" rows="3"></textarea></td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary" type="button" onClick="javascript :history.back(-1);">通过</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid" onClick="javascript :history.back(-1);">取消</button>
        </td>
    </tr>
</table>
</form>
    
   
</div>


</body>
</html>