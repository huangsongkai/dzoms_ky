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
    <title>保险回执单信息查询</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script>
        function fetchData() {
            $.post('/DZOMS/charge/requestInsuranceReceipt',{
                time:$("#time").val()
            },function (msg) {
                alert(msg);
                document.vehicleSele.submit();
            });
        }
    </script>
</head>
<body>

<div class="line">
    <div class="panel  margin-small" >
        <div class="panel-head">
            <form action="/DZOMS/common/selectToList" class="form-inline" method="post" name="vehicleSele" target="result_form">
                <input type="hidden" name="url" value="/charge/insuranceReciptStates.jsp" />
                <input type="hidden" name="className" value="com.dz.module.charge.insurance.InsuranceReceipt"/>
                <input type="hidden" name="orderby" value="timestamp,receiptId desc">
                <div class="form-group">
                    <div class="label">
                        <label>状态</label>
                    </div>
                    <div class="field">
                        <select name="condition" class="input">
                            <option value=" and state=0 " selected="selected">未进行匹配</option>
                            <option value=" and state>0 ">已匹配</option>
                            <option value=" and state<0 ">匹配失败</option>
                            <option value=" ">全部</option>
                        </select>
                        <input type="submit" value="查询">
                    </div>
                </div>
                <div class="form-group">
                    <div class="label">
                        <label>月份</label>
                    </div>
                    <div class="field">
                        <input class="input input-auto datetimepicker" size="20"  name="time" placeholder="年月即可" id="time">
                        <input type="button" value="从招行获取数据" onclick="fetchData()">
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
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>
</body>
</html>
