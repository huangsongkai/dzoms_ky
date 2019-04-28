<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-4-20
  Time: 下午4:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>保险回执进账信息查询</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
</head>
<body>

<div class="line">
    <div class="panel  margin-small" >
        <div class="panel-head">
            <form action="/DZOMS/common/selectToList" class="form-inline" method="post" name="vehicleSele" target="result_form">
                <input type="hidden" name="url" value="/charge/insuranceBackStates.jsp" />
                <input type="hidden" name="className" value="com.dz.module.charge.insurance.InsuranceBack"/>
                <input type="hidden" name="orderby" value="timestamp,receiptId desc">
                <div class="form-group">
                    <div class="label">
                        <label>状态</label>
                    </div>
                    <div class="field">
                        <select name="condition" class="input">
                            <option value=" and state=0 " selected="selected">未入账</option>
                            <option value=" and state>0 ">已进账</option>
                            <option value=" and state<0 ">进账失败</option>
                            <option value=" ">全部</option>
                        </select>
                        <input type="submit" value="查询">
                    </div>
                </div>
            </form>
        </div>
        <div class="panel-body">
            <iframe name="result_form" width="100%" height="800px" id="result_form" scrolling="no">

            </iframe>
        </div>
    </div>
</div>
</body>
</html>
