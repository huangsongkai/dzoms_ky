<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    //    $(document).ready(function(){
    //      $.post("/DZOMS/charge/getCurrentMonth",{},function(data){
    //        $("#currentMonth").html(data);
    //      });
    //    });
  </script>
    <script>
      $(document).ready(function(){
        $.post("/DZOMS/charge/getCurrentTime",{"department":"一部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth1").html("<strong>"+"一部:"+"</strong>"+data["ItemTool"]);
        });
        $.post("/DZOMS/charge/getCurrentTime",{"department":"二部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth2").html("<strong>"+"二部:"+"</strong>"+data["ItemTool"]);
        });
        $.post("/DZOMS/charge/getCurrentTime",{"department":"三部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth3").html("<strong>"+"三部:"+"</strong>"+data["ItemTool"]);
        });
      });
      function carFocus(){
      	$("input[name='licenseNum']").val("黑A");
      }
  </script>
</head>
<body>
<%--<div>当前待结算年月：</div>--%>
<%--<div id="currentMonth"></div>--%>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>收费统计</li>
    </ul>
</div>
<div class="line padding">
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
    <form  style="width: 100%;" method="post" id="form" action="/DZOMS/charge/tongji" class="form-inline">
        <div class="panel margin-small" >
          	<div class="panel-head">
          		查询条件
          		
          	</div>
          	<div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            部门：
                        </label>
                    </div>
                    <div class="field">
                        <select name="department" class="input">
                            <option value="全部">全部</option>
                            <option value="一部">一部</option>
                            <option value="二部">二部</option>
                            <option value="三部">三部</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            状态：
                        </label>
                    </div>
                    <div class="field">
                        <select name="status" class="input">
                            <option value="0">欠费</option>
                            <option value="1">正常</option>
                            <option value="2">未交</option>
                            <option value="3">已交</option>
                            <option value="4" selected="selected">全部</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            车牌号
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto" value="黑A" name="licenseNum" onfocus="carFocus()"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            请输入年月
                        </label>
                    </div>
                    <div class="field">
                        <input class="input datetimepicker"   name="time"  id="time" onblur="showMoney();"/>                    </div>
                </div>
                <input type="submit" value="查询" class="button bg-green"/>
            </div>
        </div>
    </form>
</div>


</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').simpleCanleder();
</script>

</html>
