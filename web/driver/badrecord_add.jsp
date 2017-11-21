<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>驾驶员登记</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script>
        function setProperties(){
        	$("#headimg").attr("src","/DZOMS/data/driver/"+$("#idNum").val()+"/photo.jpg");
        	
            $.post('/DZOMS/driver/driverSelectById',{'driver.idNum':$("#idNum").val()},function(data){
                //data = $.parseJSON(data);
                list = data;
                if(list["name"] == undefined || list["name"]==""){
                    alert("此人不存在,请输入正确身份证号");
                }else{
                    $("#name").attr("value",list["name"]);
                    $("#age").attr("value",list["age"]);
                }
            });
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员管理</li>
                <li>聘用</li>
                <li>驾驶员查询</li>
              
        </ul>
        </div>
</div>
<div class="line">
 <div class="panel xm10 xm1-move">

    <form method="post" action="/DZOMS/driver/badRecordAdd">
        
	    <div class="panel-head ">
	     查询条件
          		
          	
	    </div>
	    <div class="panel-body">
	    	<div class="xm2 padding">
            <img src="/DZOMS/res/image/driverhead.png"class="radius img-responsive" id="headimg">
            </div>
	    	<div class="xm8">
	    		 <table class="table">
                <tr>
                    <td style="width: 100px">身份证号</td>
                    <td style="width: 400px"><input class="input input-auto" size="20" name="driver.idNum" onblur="setProperties()" id="idNum"></td>
                </tr>
                <tr>
                    <td style="width: 100px">姓名</td>
                    <td style="width: 400px"><input class="input input-auto" size="20" id="name" readonly="readonly"></td>
                </tr>
                <tr>
                    <td style="width: 100px">年龄</td>
                    <td style="width: 400px"><input class="input input-auto" size="20" id="age" readonly="readonly"></td>
                </tr>
                <tr>
                    <td style="width: 100px">事由</td>
                    <td style="width: 400px"><textarea rows="5" class="input" style="width: 400px" name="reason"></textarea></td>
                </tr>
                <tr>
                  
                    <td><button class="button bg-green">提交</button> </td>
                    <td><button class="button bg-blue">取消</button> </td>
                </tr>
            </table>
	    		
	    	</div>
           
        </div>

    </form>
   </div>
</div>
</body>
</html>