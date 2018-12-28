<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/22
  Time: 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
    <title>新增项目</title>
    <style>
        div{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
            <form id="addElectirc" action="addElectric" method="post">

                <div>
                    <label for="inputAct" class="col-sm-2 control-label">项目</label>
                    <div>
                        <input type="text"  name="act" class="form-control" id="inputAct" onblur="checkAge()" autocomplete="off">
                    </div>
                </div>

                <div>
                    <label for="grade" class="col-sm-2 control-label">分值</label>
                    <div>
                        <input type="text"  name="grade" class="form-control" id="grade" onblur="checkPhone()" autocomplete="off">
                    </div>
                </div>

                <div>
                    <div>
                        <button onclick="addPerson()" type="submit" id="fs" class="btn btn-success">添加</button>
                        <a href="driverKp/getAllElectric"><button >返回</button></a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
    <script type="javascript">
            $("#fs").click(function () {
                var dataObj = $("#addElectirc").serialize();
                $.ajax({
                    type: "post",
                    contentType : 'application/json',
                    dataType:"json",
                    data:JSON.stringify(dataObj),
                    url:"driverKp/addElectric",
                    success:function(){
                        alert("添加成功");
                    }
                });
            });
</script>

