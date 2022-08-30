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
    <title>批量变更约定——文件导入</title>
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
                li["dept"]=columns[2];
                li["Money"]=columns[3];
                li["comment"]=columns[4];
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
        <li>批量变更约定</li>
        <li>文件导入</li>
    </ul>
</div>

<%Object message = request.getAttribute("message");%>
<%if(message != null){%>
<div class="alert alert-green">
    <span class="close rotate-hover"></span><strong>操作结果：</strong><%=message.toString()%></div>
<%}%>
<form method="post" id="fm" action="/DZOMS/charge/approvalBatchPlan" class="form-inline form-tips">
    <div class="line">
        <div class="panel xm12 margin-small">
            <div class="panel-head">
                <strong>新增约定</strong>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定名称
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto" size="40"  value="财务计划" name="batchPlan.title"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            开始日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input  datepick input-auto" size="14" name="batchPlan.startTime" value="%{batchPlan.getStartTime()}"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            结束日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input datepick input-auto" size="14" value="%{batchPlan.getEndTime()}" name="batchPlan.endTime"/>
                    </div>
                </div>
                <input type="hidden" name="isToEnd" value="false">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定类型
                        </label>
                    </div>
                    <div class="field">
                        <select size="1" name="batchPlan.feeType" class="input">
                            <option value="plan_add_insurance">保险费用上调</option>
                            <option value="plan_sub_insurance">保险费用下降</option>
                            <option value="plan_add_contract">合同费用上调</option>
                            <option value="plan_sub_contract">合同费用下降</option>
                            <option value="plan_add_other">其他费用上调</option>
                            <option value="plan_sub_other">其他费用下降</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            备注
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input" name="batchPlan.comment"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="line">
        <div class="xm12">
            <div class="panel margin-small" style="height: 800px" >
                <div class="panel-head">
                    加载文件
                    <a class="button input-file" href="javascript:void(0);">+ 选择文件
                        <input type="file" id="inputFile" onchange="loadFile(this.files)" />
                    </a>
                </div>
                <div class="panel-body">
                    <textarea id="txt" rows="28" class="input" readonly="readonly" ></textarea>
                    <div class="form-group">
                        <div class="field">
                            <input type="hidden" name="jsonStr" />
                            <input type="hidden" name="filename" />
                        </div>
                    </div>
                    <div class="xm8-move">
                        <a href="javascript:anaylse()" class="button bg-green">导入</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datepick').datetimepicker({
        lang:"ch",           //语言选择中文
        format:"Y/m/d",      //格式化日期
        timepicker:false,    //关闭时间选项
        yearStart:2000     //设置最小年份
    });
</script>

</html>
