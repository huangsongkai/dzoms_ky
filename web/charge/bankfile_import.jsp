<%@ page import="com.dz.module.user.User" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-17
  Time: 上午11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
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
    <script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
    <script>
        function loadFile(files){
            if(files.length>0)
            {
                var file = files[0];
                $("input[name='filename']").val(file.name);
                var reader = new FileReader();
                reader.onload = function(){
                    $("#txt").val(this.result);
                };
                reader.readAsText(file,"gbk");
            }
        }

        function anaylse(){
            var txt = $("#txt").val().trim();
            //$("#result").val("");

            var lines = txt.split("\n");
            var lst=[];
            for(var i=0;i<lines.length;i++){
                var columns = lines[i].split("|");
                var li ={};
                li["licenseNum"]=columns[0];
                li["name"]=columns[1];
                li["cardNum"]=columns[2];
                li["Money"]=columns[3];
                lst.push(li);
            }
            
            var lastline = lst.pop();
            if (lastline["licenseNum"].startWith("黑")) {
            	lst.push(lastline);
            }

            var jsonStr=$.toJSON(lst);
            $("input[name='jsonStr']").val(jsonStr);
            $("#fm").submit();
        }
    </script>

    <script>
        function showAll(){
            var time = $("#time").val();
            if(time != undefined && time != ""){
                $(".time").val(time);
                $(".form").submit();
            }
        }
        function importToSql(){
            $(".time").val($("#time").val());
            $("#import").submit();
        }
        function clearTmp(){
            $(".time").val($("#time").val());
            $("#clear").submit();
        }
        $(document).ready(function(){
            showAll();
            $.post("/DZOMS/charge/getCurrentTime",{"department":"全部"},function(data){
                data = $.parseJSON(data);
                var rt = data["ItemTool"];
                var t = rt.replace(/-/g,"/");
                $("#time").val(t);
            });
        });
    </script>
</head>
<body>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>银行导入</li>
    </ul>
    </div>
    
  <%Object message = request.getAttribute("message");%>
        <%if(message != null){%>
        	<div class="alert alert-green">
		      <span class="close rotate-hover"></span><strong>操作结果：</strong><%=message.toString()%></div>
        <%}%>
<div class="line">
    <div class="xm5">
        <div class="panel margin-small" style="height: 800px" >
          	<div class="panel-head">
          		加载文件
          	</div>
          	<div class="panel-body">
            <a class="button input-file" href="javascript:void(0);">+ 选择文件
                <input type="file" id="inputFile" onchange="loadFile(this.files)" />
            </a>
            <br/>
            
            <textarea id="txt" rows="28" class="input" readonly="readonly" ></textarea>

            <form method="post" id="fm" action="/DZOMS/charge/analyseFile" class="form-inline form-tips">

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            年&nbsp;&nbsp;&nbsp;月：
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield cssClass="input datetimepicker"  value="%{time}" name="time" placeholder="年月" id="time" onblur="showAll();"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            记录人：
                        </label>
                    </div>
                    <div class="field">
                        <input type="text" name="recorder" class="input" value="<%=((User)session.getAttribute("user")).getUname()%>" readonly="readonly">
                        <input type="hidden" name="jsonStr" />
                        <input type="hidden" name="filename" />
                    </div>
                </div>
                <br>

                <div class="xm8-move">
                    <a href="javascript:anaylse()" class="button bg-green">录入</a>
                </div>
            </form>
        </div>
         </div>
    </div>

    <div class="xm6">
    	<div class="tab panel margin-small"  style="height: 800px;">
	       <div class="tab-head">
		         <ul class="tab-nav">
			        <li class="active"><a href="#tab-start2">已导入数据</a> </li>
			        <li><a href="#tab-css2">已处理数据</a> </li>
			        <li><a href="#tab-units2">错误数据</a> </li>
		        </ul>
	       </div>
	       <div class="tab-body">
		     <div class="tab-panel active" id="tab-start2">
			        <div class="panel margin-small" >
          	      <div class="panel-head">
          		已导入数据
          	     </div>
          	      <div class="panel-body">
                  <iframe name="frame1" width="100%" style="height: 600px;" ></iframe>
                  <form method="post" action="/DZOMS/charge/showBankRecords?x=1" target="frame1" class="form" style="width: 100%;">
                         <input type="hidden" name="status" value="0">
                         <input type="hidden" name="time" class="time">
                         <input type="hidden" class="time">
                  </form>
                   <div><a onclick="importToSql();" class="button bg-green">进账</a></div>
                  </div>
               </div>
		     </div>
		     <div class="tab-panel" id="tab-css2">
			         <div class="panel margin-small" >
          	<div class="panel-head">
          	已处理数据
            </div>
          	<div class="panel-body">
            <iframe name="frame3" width="100%" style="height: 600px;"></iframe>
            <form method="post" action="/DZOMS/charge/showBankRecords?x=3" target="frame3" class="form" style="width: 100%;">
                <input type="hidden" name="status" value="1">
                <input type="hidden" name="time" class="time">
                <input type="hidden" class="time">
            </form>
            <form method="post" action="/DZOMS/charge/fromTmpToSql" id="import">
                <input type="hidden" name="time" class="time">
            </form>
            </div>
         </div>
		     </div>
		     <div class="tab-panel" id="tab-units2">
			       <div class="panel margin-small" >
          	<div class="panel-head">
          		错误数据
          	</div>
          	<div class="panel-body">
            <iframe name="frame2" width="100%" style="height: 600px;"> </iframe>
            <form method="post" action="/DZOMS/charge/showBankRecords?x=2" target="frame2" class="form" style="width: 100%;">
                <input type="hidden" name="status" value="2">
                <input type="hidden" name="time" class="time">
                <input type="hidden" class="time">
            </form>
            <form method="post" action="/DZOMS/charge/clearDirtyTmp" id="clear">
                <input type="hidden" name="time" class="time">
            </form>
            <div><a onclick="clearTmp();" class="button bg-green">清除</a></div>
       </div>
       </div>
		     
		     </div>
	</div>
</div>
 </div>


</div>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker({
    	lang:"ch",           //语言选择中文
		format:"Y/m/d",      //格式化日期
		timepicker:false,    //关闭时间选项
		yearStart:2000,     //设置最小年份
    });
</script>

</html>
