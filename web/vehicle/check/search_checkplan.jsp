<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
        uri="/struts-tags" prefix="s"%><%@ page language="java"
                                                import="java.util.*, com.dz.module.user.User"
                                                pageEncoding="UTF-8"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://"
          + request.getServerName() + ":" + request.getServerPort()
          + path + "/";
%><!doctype html>
<html lang="zh-cn">
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>查询投诉信息</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
  <link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <script src="/DZOMS/res/js/admin.js"></script>

  <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
  <script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>

  <script>
    function search() {
      $("#context").html("");
        var title_tr = '<tr>' +
                '<td>计划名称</td>' +
                '<td>开始日期</td>' +
                '<td>结束日期</td>' +
                '<td>修改计划</td>' +
                '<td>执行计划</td>' +
                '<td>删除计划</td>' +
                '</tr>';
        $("#context").append(title_tr);
      $.post('/DZOMS/vehicle/check/selfCheckPlanSearchPlan',{"timePass.startTime":$("#beginDate").val(),"timePass.endTime":$("#endDate").val()},function(data){
          data = $.parseJSON(data);
          data = data["list"][0]["com.dz.module.vehicle.check.SelfCheckPlan"];
          if(data.length == undefined){
              data = [data];
          }
          for(var i = 0;i < data.length;++i){
              var id = data[i]["id"];
              var _id = '"'+id+'"';
              var context_tr='<tr>'
                      +'<td>'+data[i]["plan_name"]+'</td>'
                      +'<td>'+data[i]["startTime"]["$"]+'</td>'
                      +'<td>'+data[i]["endTime"]["$"]+'</td>'
                      +'<td><a onclick="changeOne(this)" id="'+id+'">修改</a></td>'
                      +'<td><a onclick="executeOne(this)" id="'+id+'">执行</a></td>'
                      +'<td><a onclick="removeOne(this)" id="'+id+'">删除</a></td>'
                      +'</tr>';
              $("#context").append(context_tr);
          }
      });
    };
    function lookOne(x){
        var id = x.id;
        alert(id);

    }
    function changeOne(x){
        $("#f2",window.parent.document).attr("src","/DZOMS/vehicle/check/change_checkplan.jsp?id=" + x.id);
    }
    function executeOne(x){
        $("#f2",window.parent.document).attr("src","/DZOMS/vehicle/check/execute_checkplan.jsp?id=" + x.id);
    }
      function removeOne(x){
          $.post("/DZOMS/vehicle/check/selfCheckPlanRemove",{"plan.id": x.id},function(data){
              search();
          });
      };
  </script>
  <script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

</head>
<body>
<div class="adminmin-bread">
  <ul class="bread">
    <li><a href="" class="icon-home"> 开始</a></li>
    <li>查询投诉信息</li>
  </ul>
</div>

<div>
  <!-- 主页面 -->
  <form method="post" class="definewidth m20">
    <table class="table table-stiped table-bordered table-condecsed">
      <tr>
        <td class="tableleft">开始日期</td>
        <td><input type="text" id="beginDate" name="beginDate" class="datetimepicker"/></td>

        <td class="tableleft">结束日期</td>
        <td><input type="text" id="endDate" name="endDate" class="datetimepicker"/></td>
      </tr>
      <tr>
        <td colspan="6" style="text-align:right;">
        </td>
        <td colspan="2"><input type="button" value="查询" onclick="search();"></td>
      </tr>
    </table>
    <table class="table table-striped table-bordered table-condensed" id="context">

    </table>
    <input type="hidden" id="searchcondition"/>
  </form>
</div>

<script>
  $('.datetimepicker').datetimepicker();
</script>
</body>
</html>
