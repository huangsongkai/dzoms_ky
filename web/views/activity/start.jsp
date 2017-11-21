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
    <title>Title</title>

</head>
<body>
手动生成
    <form method="post">
    </form>

    <div class="form">reacting</div>
</body>


<script>

    var key = window.location.pathname.substring(window.location.pathname.lastIndexOf("/")+1);
    $(".form").attr("url", "/DZOMS/ky/activity/process/getStartFormProperties/"+key);


    function generateForm(data) {
        $.each(data, function (index, item) {
            $($("form")[0]).append("<p>"+item.id+": <input name='"+item.name+"'/></p>");
        })
        $($("form")[0]).append("<input type='submit' value='Submit' />");
        $($("form")[0]).attr("action","/DZOMS/ky/activity/process/startForm/"+key);
    }
    $.ajax({
        type: "GET",
        url: "/DZOMS/ky/activity/process/getStartFormProperties/"+key,
        dataType: 'json',
        contentType : 'application/json',
        success: function(result){
//            if(result.data.constructor == Array && result.data.length>0)
                    generateForm(result.data);
        },
        error: function(result){
            console.log("-------" + result);
            alert("操作失败");
        }
    });
</script>
</html>
