<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 2017/3/30
  Time: 下午12:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/DZOMS/ky/js/jquery-2.2.1.min.js"></script>
    <title>Process History</title>
</head>
<body>
历史流程列表
<ul class="list"></ul>
</body>


<script>
    $.ajax({
        type: "GET",
        url: "/DZOMS/ky/history/historic-process-instances",
        dataType: 'json',
        contentType : 'application/json',
        success: function(result){
            $.each(result.data, function(index, item){
                $(".list").append("<li><span>"+JSON.stringify(item)+"</span></li>");
            });
            console.log(result);
        },
        error: function(result){
            console.log("-------" + result);
            alert("操作失败");
        }
    });
</script>
</html>
