<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-13
  Time: 下午2:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
  <script>
    $(document).ready(function(){
      var planId = window.dialogArguments['planId'];
      $(".planId").val(planId);
      $.post("/DZOMS/check/getAllUsers",{},function(data){
//        alert(data);
        data = $.parseJSON(data);
        data = data["list"][0];
        data = data["com.dz.module.user.User"];
        for(var i = 0;i < data.length;i++){
          var cur = data[i];
          var td = "<tr>" +
                  "<td><input type='checkbox'></td>" +
                  "<td>"+cur["uid"]+"</td>" +
                  "<td>"+cur["uname"]+"</td>" +
                  "</tr>"
          $("#table1").append(td);
        }
      })
    });
      function tianjia(){

          if($("#table1 :checked:first").parent().parent().html()==undefined){
              alert("您没有勾选任何数据");
          }
          while($("#table1 :checked:first").parent().parent().html()!=undefined){
              var uid = $("#table1 :checked:first").parent().next().text();
              var txt ='<tr>'+$("#table1 :checked:first").parent().parent().html()+ '</tr>'
                      + '<input type="hidden" name="group.checkerIds" value="'+uid+'" id="'+uid+'">';

              $("#table2").append(txt);
              $("#table1 :checked:first").parent().parent().remove();
          }

      }
      function shanchu(){
          if($("#table2 :checked:first").parent().parent().html()==undefined){
              alert("您没有勾选任何数据");
          }
          while($("#table2 :checked:first").parent().parent().html()!=undefined){
              var uid = $("#table2 :checked:first").parent().next().text();
              var txt = '<tr>'+$("#table2 :checked:first").parent().parent().html()+
                      '</tr>';
              $("#table2 :checked:first").parent().parent().next().remove();
              $("#table1").append(txt);
              $("#table2 :checked:first").parent().parent().remove();
          }
      }
  </script>
</head>
<body>
	 <form action="/DZOMS/check/addGroup" method="post" style="width: 100%;" class="form-inline">
	<div class="line">
    <div class="panel margin-small" >
          	<div class="panel-head">
          	  建立自检计划	
          	</div>
          	<div class="panel-body">
                 
                  <input type="hidden" name="plan.id" class="planId input"/>
                  <span>最少检车数</span><s:textfield name="group.minNum" cssClass="input"/>
                  <span>地点</span><s:textfield name="group.location" cssClass="input"/>
                  <span>开始时间</span><s:textfield name="group.startTime" cssClass="input datetimepicker"/>
                  <span>结束时间</span><s:textfield name="group.endTime" cssClass="input datetimepicker"/>
                  <input type="submit" value="提交">
            </div>
            </div>
            </div>
 <div class="line">
 	<div class="xm5">
 		 <div class="panel margin-small" >
          	<div class="panel-head">
          		待选择人员
          	</div>
          	<div class="panel-body">           
                  <table class="table table-hover table-bordered table-striped" id="table1" >
                    <tr>
                           <th>选择</th>
                        <th>标识</th>
                          <th>人名</th>
                   </tr>
                   </table>
           </div>
          </div>
   </div>
   <div class="xm1">
   	 <div class="panel margin-small" >
          	<div class="panel-body">  
          		<div style="height: 120px;"></div>
           <div style="height: 120px;">
       	       <input class="button bg-main" type="button" value="添加" onclick="tianjia()">
               <input class="button bg-red" type="button" value="删除" onclick="shanchu()">
            </div>
   	  
   </div>
   </div>
   </div>
   <div class="xm5">
 		 <div class="panel margin-small" >
          	<div class="panel-head">
          		已选择人员	
          	</div>
          	<div class="panel-body">           
                  <table class="table table-hover table-bordered table-striped" id="table2" >
                     <tr>
                       <th>选择</th>
                        <th>标识</th>
                         <th>人名</th>
                     </tr>
                     </table>
           </div>
          </div>
   </div>
</div>
</form>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
   $('.datetimepicker').datetimepicker({
    	lang:"ch",           //语言选择中文
		
    });
</script>

</html>
