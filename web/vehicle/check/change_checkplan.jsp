<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*, com.dz.module.user.User"
                                                pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
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
    <script type="text/javascript">
        function tianjia(){
            if($("#table1 :checked:first").parent().parent().html()==undefined)
                alert("您没有勾选任何数据");
            while( $("#table1 :checked:first").parent().parent().html()!=undefined)
            {
                var txt ='<tr>'+$("#table1 :checked:first").parent().parent().html()+'</tr>';
                var tid = $("#table1 :checked:first").parent().attr("id").slice(2);
                var id = "hidden"+tid;
                //添加一个表单隐藏yu
                var hide = '<input type="hidden" name="carIds" value="'+tid+'" id="'+id+'" />';
                $("#form").append(hide);
                $("#table2").append(txt);
                $("#table1 :checked:first").parent().parent().remove();
            }
        }
        function shanchu(){
            if($("#table2 :checked:first").parent().parent().html()==undefined)
                alert("您没有勾选任何数据");
            while( $("#table2 :checked:first").parent().parent().html()!=undefined)
            {
                var txt ='<tr>'+$("#table2 :checked:first").parent().parent().html()+'</tr>';
                $("#table1").append(txt);
                //移除表单隐藏yu
                var id = "hidden"+$("#table2 :checked:first").parent().attr("id").slice(2);
                $("#"+id).remove();
                $("#table2 :checked:first").parent().parent().remove();
            }
        }
    </script>
    <script>
        function addPlanName(){
            $("#plan_name").remove();
            var year = $('#year').val();
            var month = $('#month').val();
            var name = $('#name').val();
            var txt = year+"年"+month+"月"+name;
            txt = '<input type="hidden" name="plan.plan_name" id="plan_name" value="'+txt+'">';
            $("#form").append(txt);
        };
        function setList(){
            $.post("/DZOMS/vehicle/check/selfCheckPlanSelectById",{"plan.id":"<%=request.getParameter("id")%>"},function(data){
                data = $.parseJSON(data);
                data = data["ItemTool"];
                var plan_name = data["plan_name"];
                var year = (plan_name.split("年"))[0];
                var month = ((plan_name.split("年"))[1].split("月"))[0];
                var name = ((plan_name.split("年"))[1].split("月"))[1]
                $("#year").attr("value",year);
                $("#month").attr("value",month);
                $("#name").attr("value",name);

                var id = data["id"];
                $.post("/DZOMS/vehicle/check/selfCheckPlanSelectGetPageShowByPlan",{"plan.id":id},function(data){
                    alert(data);
                    data = $.parseJSON(data);
                    data = data["list"][0]["com.dz.module.vehicle.check.PageShow"];
                    if(data.length == undefined){
                        data = [data];
                    }
                    for(var i = 0;i < data.length;++i){
                        var carframeNum = data[i]["carId"];
                        var businessForm = data[i]["contractId"];
                        var contractType = data[i]["rentStyle"];
                        var licenseNum = data[i]["license_num"];
                        var txt = '<tr>'
                                +'<td id="td'+carframeNum+'"><input type="checkbox"/></td>'
                                +'<td>'+businessForm+'</td>'
                                +'<td id="'+carframeNum+'">'+licenseNum+'</td>'
                                +'<td>'+contractType+'</td>'
                        '</tr>';
                        var tid = carframeNum;
                        var id = "hidden"+tid;
                        //添加一个表单隐藏yu
                        var hide = '<input type="hidden" name="carIds" value="'+tid+'" id="'+id+'" />';
                        $("#form").append(hide);
                        $("#table2").append(txt);
                    }
                    addPlanName();
                });

                $("#startTime").attr("value",data["startTime"]["$"]);
                $("#endTime").attr("value",data["endTime"]["$"]);
            });
        }
        $(document).ready(function(){
            setList();
        });
    </script>
</head>
<body>
<form method="post" id="form" action="/DZOMS/vehicle/check/selfCheckPlanUpdate">
    <input type="hidden" name="plan.id" value="<%=request.getParameter("id")%>"/>
    <div class="float-left margin-small">计划标题：</div>
    <div class="float-left margin-small">
        <input class="input input-auto" size="15" id="year" onblur="addPlanName();"><strong>年</strong>
    </div>
    <div class="float-left margin-small">
        <input class="input input-auto " size="15" id="month" onblur="addPlanName();"><strong>月</strong>
    </div>
    <div class="float-left margin-small">
        <input class="input input-auto" size="40"  value="车辆自检计划" id="name" onblur="addPlanName();"/>
    </div>
    <div class="float-left margin-small">开始日期：</div>
    <div class="float-left margin-small">
        <input  class="input input-auto datetimepicker"  size="30" name="plan.startTime" id="startTime"/>
    </div>
    <div class="float-left margin-small">结束日期：</div>
    <div class="margin-small">
        <input  class="input input-auto datetimepicker" size="30" name="plan.endTime" id="endTime"/>
    </div>

    <div><p> </p></div>
    <!--不知原因的乱格式只能加DIV处理 -->
    <div class="float-left">
        <div>全部车辆：</div>
        <div class="margin-small float-left">
            <div class="panel float-left" style="width: 600px;height: 600px;overflow:auto; ">
                <table class="table table-bordered" id="table1">
                    <tr>
                        <th>选择</th>
                        <th>档案号</th>
                        <th>车牌号</th>
                        <th>承包形式</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="float-left">
        <div style="height: 200px"></div>
        <div class="margin-small"><input type="button" class="button bg-gray" value="添加->" onclick="tianjia()"></div>
        <div class="margin-small"><input type="button" class="button bg-gray" value="<-删除" onclick="shanchu()"></div>
    </div>
    <div>
        <div>检验车辆：</div>
        <div class="margin-small float-left">
            <div class="panel float-left" style="width: 600px;height: 600px;overflow:auto; ">
                <table class="table table-bordered" id="table2">
                    <tr>
                        <th>选择</th>
                        <th>档案号</th>
                        <th>车牌号</th>
                        <th>承包形式</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <input type="submit" value="更新"/>
</form>
</body>
<script src="js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker();
</script>
</html>