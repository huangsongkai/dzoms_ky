<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2017/6/27
  Time: 下午2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>任务详情页</title>
    <link rel="stylesheet" href="/DZOMS/ky/css/style.css"/>
</head>
<body>
<div class="container">
    <div id="header">
        <h2>任务详情</h2>
    </div>
    <div id="taskDetails"></div>
</div>
</body>
<script type="text/javascript">
    var pageUrls ={
        chepaihaoUrl:"/chepaihaoA",   //如果该页有关于车牌号选择的
        submitTasksUrl:"/DZOMS/ky/activity/task/", //提交数据 POST
        getTasksUrl:"/DZOMS/ky/runtime/tasks/",
        getTaskDataUrl:"/DZOMS/ky/history/historic-task-instances/",
        getRuntimeDataUrl:"/DZOMS/ky/form/form-data?taskId=",
        hisProcessUrl:"/DZOMS/ky/history/historic-process-instances/",
        hisVariable:"/DZOMS/ky/history/historic-variable-instances?processInstanceId=",
        jumpUrl:"/DZOMS/ky/activity/task/list",
    }
</script>
<script src="/DZOMS/ky/js/commonV3.js"></script>
<script src="/DZOMS/ky/js/processAll-bundle.js"></script>
</html>

