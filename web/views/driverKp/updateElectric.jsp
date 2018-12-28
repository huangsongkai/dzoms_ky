<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>更改项目</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        div{
            text-align: center;
        }
    </style>
</head>
<body>


<div class="row_clearfix">
    <div class="col-md-12 column">
        <div class="page-header">
            <h1>
                <small>修改信息</small>
            </h1>

            <form id="updateElectric" action="updateElectric" method="post">
                      <input type="text" name="id" value="${electric.id}"  style="display:none" />
                项目：<input type="text" name="act" value="${electric.act}" autocomplete="off"/><br/><br/>
                分值：<input type="text" name="grade" value="${electric.grade}" autocomplete="off"/><br/><br/>
                <input type="submit" id="tj" value="提交" onclick="updatePerson()"/>
                <a href="driverKp/getAllElectric"><button >返回</button></a>
            </form>
        </div>
    </div>
</div>
</body>
</html>
<script type="javascript">

    $("#tj").click(function () {
        var dataObj = $("#updateElectric").serializeArray();
        $.ajax({
            type: "post",
            contentType : 'application/json',
            dataType:"json",
            data:JSON.stringify(dataObj),
            url:"driverKp/updateElectric",
            success:function(){
                alert("修改成功");
            }
        });
    });
</script>
</div>
