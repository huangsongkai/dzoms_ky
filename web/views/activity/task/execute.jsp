<%--
  Created by IntelliJ IDEA.
  User: song
  Date: 2017/3/29
  Time: 上午11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
task表单数据:
<div class="form">form</div><br>
手动提交(目前测试只有一个表单信息 isApproved,后面有jxw扩充form动态生成)
<div class="manual"></div><br>
task详细信息:
<div class="detail">reacting</div><br>
process信息:
<div class="process">reacting</div><br>
流程图:
<div class="diagram"></div><br>
</body>
process历史信息:
<div class="history">reacting</div><br>
process变量信息:
<div class="variables">reacting</div><br>
</body>
<script src="/DZOMS/ky/js/jquery-2.2.1.min.js"></script>
<script>
    var key = window.location.pathname.substring(window.location.pathname.lastIndexOf("/")+1);
    window.processInstanceId = "";
    $(".manual").append("<form action='/DZOMS/ky/activity/task/"+key+"' method='post'><input name='isApproved'/><input type='submit'></input></form><br>");
    $.ajax({
        type: "GET",
        url: "/DZOMS/ky/form/form-data?taskId="+key,
        dataType: 'json',
        contentType : 'application/json',
        success: function(result){
            window.processInstanceId = result.processInstanceId;
            $(".form").html(JSON.stringify(result));
            console.log(result);
        },
        error: function(result){
            console.log("-------" + result);
            alert("操作失败");
        }
    });


    $.ajax({
        type: "GET",
        url: "/DZOMS/ky/runtime/tasks/"+key,
        dataType: 'json',
        contentType : 'application/json',
        success: function(result){
            $(".detail").html(JSON.stringify(result));
            console.log(result);
            window.processInstanceId = result.processInstanceId;
            $.ajax({
                type: "GET",
                url: "/DZOMS/ky/history/historic-process-instances/"+ window.processInstanceId,
                dataType: 'json',
                contentType : 'application/json',
                success: function(result){
                        $(".history").html(JSON.stringify(result));
                        console.log(result);
                    },
                    error: function(result){
                    console.log("-------" + result);
                    alert("操作失败");
                }
            });
            $.ajax({
                type: "GET",
                url: "/DZOMS/ky/history/historic-variable-instances?processInstanceId="+window.processInstanceId,
                dataType: 'json',
                contentType : 'application/json',
                success: function(result){
                    $(".variables").html(JSON.stringify(result));
                    $(".diagram").append("<image src='/DZOMS/ky/runtime/process-instances/"+result.data[0].processInstanceId+"/diagram'/>")
                    console.log(result);
                },
                error: function(result){
                    console.log("-------" + result);
                    alert("操作失败");
                }
            });

        },
        error: function(result){
            console.log("-------" + result);
            alert("操作失败");
        }
    });


</script>
</html>
