<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-10-11
  Time: 上午11:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
  <link rel="stylesheet" href="../../res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="../../res/css/jquery.datetimepicker.css"/>

  <script src="../../res/js/jquery.js"></script>
  <script src="../../res/js/pintuer.js"></script>
  <script src="../../res/js/respond.js"></script>
  <link rel="stylesheet" href="../../res/css/admin.css">
  <script src="../../res/js/jquery.js"></script>
  <script>
    function show(id){
      $.post('/DZOMS/accident_CheckRecords',{'accident.accId':id},function(data){
          data = $.parseJSON(data);
          var list = data["list"][0]["com.dz.module.driver.accident.AccidentCheck"];

          if(list.length==undefined){
              list = [list];
          }

          var title_tr = '<tr><td>审核人</td><td>审核时间</td><td>是否通过</td><td>原因</td></tr>';
          $("#context").append(title_tr);
              for(var i=0;i<list.length;i++){
                  var context_tr=
                          '<tr>'
                          +'<td class = '+list[i]["checker"]+'>'+'</td>'
                          +'<td>'+list[i]["acTime"]["$"]+'</td>'
                          +'<td>'+(list[i]["isPassed"] == true?"是":"否")+'</td>'
                          +'<td>'+list[i]["reason"]+'</td>'
                          +'</tr>';
                  $("#context").append(context_tr);
                  var dat = {"className":"com.dz.module.user.User","id":list[i]["checker"]};
                  $.post('/DZOMS/common/getObject',dat,function(dax){
                      var da = $.parseJSON(dax);
                      var x = "."+da["uid"];
                      $(x).html(da["uname"]);
                  });
              }
      });
    };
    $(document).ready(function func(){
      var accidentId = window.dialogArguments[0];
      show(accidentId);
    });
  </script>
</head>
<body>
<div class="container">
    <div class="xb4 xb4-move">
        <table id="context"    class=" table table-bordered table-hover " >
        </table>
    </div>
</div>
</body>
</html>
