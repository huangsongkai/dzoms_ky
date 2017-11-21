<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>测试</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script>
        $(document).ready(function(){
            $.post("/DZOMS/charge/getCurrentTime",{"department":"一部"},function(data){
                data = $.parseJSON(data);
                $("#currentMonth1").html("<strong>"+"一部:"+"</strong>"+data["ItemTool"]);
            });
            $.post("/DZOMS/charge/getCurrentTime",{"department":"二部"},function(data){
                data = $.parseJSON(data);
                $("#currentMonth2").html("<strong>"+"二部:"+"</strong>"+data["ItemTool"]);
            });
            $.post("/DZOMS/charge/getCurrentTime",{"department":"三部"},function(data){
                data = $.parseJSON(data);
                $("#currentMonth3").html("<strong>"+"三部:"+"</strong>"+data["ItemTool"]);
            });
        });
        function show(){
            $("#form").attr("action","/DZOMS/charge/getCheckChargeTable");
            $("#form").submit();
        }
        function exp(){
            $("#form").attr("action","/DZOMS/charge/getCheckChargeTableToExcel");
            $("#form").submit();
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>财务对账表</li>
        </ul>
    </div>
</div>
<div class="line padding">
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
    <div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <div class="panel  margin-small" >
        <div class="panel-head">
            查询条件
        </div>
        <div class="panel-body">
            <form method="post" id="form" action="/DZOMS/charge/getCheckChargeTable" class="form-inline form-tips">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门
                        </label>
                    </div>
                    <div class="field">
                        <s:select name="department" list="#{'全部':'全部','一部':'一部','二部':'二部','三部':'三部'}" value="%{department}"></s:select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            请输入年月
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto  datetimepicker" size="20"  name="time" id="time"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            类型
                        </label>
                    </div>
                    <div class="field">
                        <select class="input input-auto"  name="status" id="status">
                            <option value="4" selected="selected">全部</option>
                            <option value="0">欠费</option>
                            <option value="1">正常</option>
                            <option value="2">银行未交</option>
                            <option value="3">银行已交</option>
                        </select>
                    </div>
                </div>
                <input type="button" value="查询" class="button bg-green" onclick="show()"/>
                <input type="button" value="导出" class="button bg-green" onclick="exp()"/>
            </form>
        </div>

    </div>
</div>


</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>

</html>
