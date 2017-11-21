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
    <title>process列表</title>
</head>
<body>
可用流程 数据列表(点击启动)
<ul class="list"></ul>
</body>


<script>
    $.ajax({
        type: "GET",
        url: "/DZOMS/ky/repository/process-definitions?latest=true",
        dataType: 'json',
        contentType : 'application/json',
        success: function(result){
            $.each(result.data, function(index, item){
                $(".list").append("<li><a href='/DZOMS/ky/activity/process/start/"+item.key+"'>点击启动</a><span>"+JSON.stringify(item)+"</span></li>");
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
