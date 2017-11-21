<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 2017/2/28
  Time: 上午10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/DZOMS/ky/js/jquery-2.2.1.min.js"></script>
    <title>task列表</title>
</head>
<body>
task列表
<div class="list">reacting</div><br>
访问地址
http://127.0.0.1:8082/DZOMS/ky/activity/task/execute/<input id="taskId"/><input type="button" value="执行" onclick="jump()"/>
</body>



<script>
    function jump() {
        window.location = "http://127.0.0.1:8082/DZOMS/ky/activity/task/execute/"+$("#taskId").val();
    }
    $.ajax({
        type: "GET",
        url: "/DZOMS/ky/runtime/tasks",
        dataType: 'json',
        contentType : 'application/json',
        success: function(result){
            $(".list").html(JSON.stringify(result));
            console.log(result);
        },
        error: function(result){
            console.log("-------" + result);
            alert("操作失败");
        }
    });
</script>
</html>
