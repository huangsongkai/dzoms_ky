<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
        uri="/struts-tags" prefix="s"%><%@ page language="java"
                                                import="java.util.*, com.dz.module.user.User"
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
  <script>
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
                    +'<td>'+businessForm+'</td>'
                    +'<td id="'+carframeNum+'">'+licenseNum+'</td>'
                    +'<td>'+contractType+'</td>'
                    +'<td id="status_'+carframeNum+'">已通过</td>'
                    +'<td><input type="button" value="不通过" onclick="unPass(this)" id="but_'+carframeNum+'"/></td>'
                    +'<td id="reason_'+carframeNum+'"></td>'
            '</tr>';
            $("#table2").append(txt);
          }
          $.post("/DZOMS/vehicle/check/selfCheckPlanSelectDisPass",{"plan.id":id},function(data){
            data = $.parseJSON(data);
            data = data["list"][0]["com.dz.module.vehicle.check.PageShow"];
            if(data.length == undefined){
              data = [data];
            }
            for(var i = 0;i < data.length;++i){
              $("#status_"+data[i]["carId"]).html("未通过");
              $("#reason_"+data[i]["carId"]).html(data[i]["unPassReason"]);
              $("#but_"+data[i]["carId"]).attr("value","通过");
              $("#but_"+data[i]["carId"]).unbind("click");
              $("#but_"+data[i]["carId"]).attr("onclick","pass(this)");
            }
          });
        });

        $("#startTime").attr("value",data["startTime"]["$"]);
        $("#endTime").attr("value",data["endTime"]["$"]);
      });
    }
    function unPass(x){
      var id = x.id.slice(4);
      var unPassReason = prompt("请输入不通过理由");
      if(unPassReason == undefined || unPassReason == ""){

      }else{
        $("#status_"+id).html("未通过");
        $("#reason_"+id).html(unPassReason);
        $.post("/DZOMS/vehicle/check/selfCheckPlanUnPass",
                {"plan.id":"<%=request.getParameter("id")%>","unPassReason":unPassReason,"vehicle.carframeNum":id},
                function(data){
        });
        $("#but_"+id).attr("value","通过");
        $("#but_"+data[i]["carId"]).unbind("click");
        $("#but_"+data[i]["carId"]).attr("onclick","pass(this)");
      }
    };
    function pass(x){
      var id = x.id.slice(4);
      $("#status_"+id).html("已通过");
      $("#reason_"+id).html("");
      $.post("/DZOMS/vehicle/check/selfCheckPlanPass",
              {"plan.id":"<%=request.getParameter("id")%>","vehicle.carframeNum":id},
              function(data){
              });
      $("#but_"+id).attr("value","不通过");
      $("#but_"+data[i]["carId"]).unbind("click");
      $("#but_"+data[i]["carId"]).attr("onclick","unPass(this)");
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
  <div>
    <div>检验车辆：</div>
    <div class="margin-small float-left">
      <div class="panel float-left" style="width: 600px;height: 600px;overflow:auto; ">
        <table class="table table-bordered" id="table2">
          <tr>
            <th>档案号</th>
            <th>车牌号</th>
            <th>承包形式</th>
            <th>状态</th>
            <th>操作</th>
            <th>原因</th>
          </tr>
        </table>
      </div>
    </div>
  </div>
</form>
</body>
<script src="js/jquery.datetimepicker.js"></script>
<script>
  $('.datetimepicker').datetimepicker();
</script>
</html>