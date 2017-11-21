<%@ page language="java" import="java.util.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
    <title>活动登记</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    <script type="text/javascript">
    
    	var $tableHead = $('<tr><th style="width:5%;">选择</th>'+
    							'<th style="width:15%;">车牌号</th>'+
                                '<th style="width:10%;">驾驶员</th>'+
                                '<th style="width:25%;">身份证号</th>'+
                                '<th style="width:5%;">性别</th>'+
                                '<th style="width:10%;">属性</th>'+
                                '<th style="width:15%;">车队名称</th>'+
                                '<th style="width:15%;">分公司归属</th>'+
                            '<tr>');
                            
    	$(document).ready(function(){
    		$("#search_but").click(function(){
    			$.post("/DZOMS/driver/searchDriverToHtml",
    				{"driver.dept":$("#department").val(),
    				"driver.team":$("#driverTeam").val(),
    				"driver.isInCar":"true"},function(html){
    				$("#table1").html("").append($tableHead).append(html);
    			});
    		});
    		
		});
		
		var i =0;
        function addfilename(){
            var txt=$("<option class='filename'></option>").text($(".addFile:first").val());
            $("#filename").append(txt)
        }
        function addfile(){
            var txt='<input size="100" type="file" class="addFile" name="fileUploads" onchange="addfilename()" style="display:none"/>';
            $(add).after(txt);
            $(".addFile:first").click();
            i=i+1;
        }
        function delefile(){
            for(j=0;j<=i;j++){
                if( $(".filename:selected").val()==$("input.addFile").eq(i).val()){
                    $(".filename:selected").remove();
                    $("input.addFile").eq(i).remove();
                }
                else{
                    file = $("file").next();
                    i=i-1;
                }
            }
        }
    
    
    
        function tianjia(){
            if($("#table1 :checked:first").parent().parent().html()==undefined)
                alert("您没有勾选任何数据");
            while( $("#table1 :checked:first").parent().parent().html()!=undefined)
            {
                var txt ='<tr>'+$("#table1 :checked:first").parent().parent().html()+'</tr>';
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
                $("#table2 :checked:first").parent().parent().remove();
            }
        }
        function quanxuan(){
            $("#table1 :checkbox").prop("checked",true);
            tianjia();
        }
        function qingkong(){
            $("#table2 :checkbox").prop("checked",true);
            shanchu();
            $("#table1 :checkbox").prop("checked",false);
        }
        
        function actity_submit(){
        	$("#driverlist").html("");
        	$("#table2 :checkbox").each(function(){
        		var $hidden = $('<input type="hidden" name="driverlist"></input>').val($(this).val());
        		$("#driverlist").append($hidden);
        	});
        	//alert($('#driverlist').val());
        	document.addActivity.submit();
        }
        
    </script>
    <style>
        .label{
            width: 120px;
            text-align: right;
        }
        .field{
            width: 200px;
        }
        .diy-lable{
            width: 120px;
            text-align: right;
        }
    </style>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>活动</li>
                <li>活动添加</li>
              
        </ul>
    </div>
</div>
<form method="post" class="form-inline" name="addActivity" action="addActivity" enctype="multipart/form-data" style="width:100% ;">
	<div id="driverlist"></div>
    <div class="xm11 margin-small panel">
        <div class="panel-head">新添活动</div>
        <div class="panel-body">
        	 <div class="form-group margin-small">
            <div class="label"><label>活动日期</label></div>
            <div class="field">
                <input class="datepick input"   type="text" name="activity.activityTime">
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="label"><label>活动名称</label></div>
            <div class="field">
                <input class="input" name="activity.activityName"/>
            </div>
        </div>

        <br>

        <div class="form-group margin-small">
            <div class="label"><label>类型</label></div>
            <div class="field">
                <select class="float-left input" style="width: 120px;" name="activity.activityClass" id="activityClass" onfocus="getList1('activityClass','activityClass')"></select>
                <a class="icon icon-wrench" href="javascript:openItem('activityClass','活动类型')"></a>
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="label"><label>分值</label></div>
            <div class="field">
                <input class="input" name="activity.grade">
            </div>
        </div>
        <br>

        <div class="margin-small float-left" style="width:330px">
            <div class="float-left" style="width: 120px;text-align: right;"><strong style="color: rgba(0, 0, 0, 0.99)">活动内容</strong></div>
            <div class="float-left">
                <textarea rows="5" class="input" name="activity.activityContext" style="width: 200px;" ></textarea>
            </div>
        </div>
        <div class="margin-small float-left" style="width: 300px">
            <div class="float-left" style="width: 120px; text-align: right;"><strong  style="color: rgba(0, 0, 0, 0.99)">添加文件</strong></div>
            <div class="float-left">
                <select  id="filename" style="width: 160px; border: 1px solid rgb(221, 221, 221); border-image: none;" size="7">
                </select>
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="margin-small">
                <a id="add" class="button input-file bg-green" href="javascript:addfile();">添加</a>
            </div>
            <div class="margin-small">
                <a  class="button input-file bg-blue" href="javascript:void(0);" onclick="delefile()">删除</a>
            </div>
        </div>

        <br>
        <div class="form-group margin-small" >
            <div class="label"><label>录入人</label></div>
            <div class="field">
                <input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                <input type="hidden" name="activity.registrant" value="<%=((User)session.getAttribute("user")).getUid()%>"/>
            </div>
        </div>
        <div class="form-group margin-small">
            <div class="label"><label>录入时间</label></div>
            <div class="field">
                <input  class="input" readonly="readonly" name="activity.registTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/>
            </div>
        </div>
        </div>
       
        
    </div>



</form>
<div class="line">
        <div class="xm5 margin-small">
            <div class="panel">
                <div class="panel-head">全部驾驶员</div>
                <div class="panel-body">
                	<form class="form-inline">
                    <div  id="selectDiv" class="margin-small">
                    	
                        <div class="form-group">
                            <div class="label" style="width:auto;"><label>公司</label></div>
                            <div class="field" style="width:auto;">
                                <select class="input" style="width: 120px;" id="department" onfocus="getList1('department','department')">
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="label" style="width:auto;" ><label>车队</label></div>
                            <div class="field" style="width:auto;">
                                <select id="driverTeam" class="input" style="width: 120px;" onfocus="getList1('driverTeam','driverTeam')"></select>
                            </div>
                        </div>
                        <input class="button bg-green" type="button" value="查找" id="search_but">
                    </div>
                   </form>

                    <div style="height: 500px;overflow: scroll">
                        <table class="table table-bordered" id="table1">
                            <tr>
                                <th style="width:5%;">选择</th>
                                <th style="width:15%;">车牌号</th>
                                <th style="width:10%;">驾驶员</th>
                                <th style="width:25%;">身份证号</th>
                                <th style="width:5%;">性别</th>
                                <th style="width:10%;">属性</th>
                                <!--<th>手机</th>-->
                                <th style="width:15%;">车队名称</th>
                                <th style="width:15%;">分公司归属</th>
                            
                        </table>
                    </div>
                </div>
                <div class="panel-foot">
                    <strong>合计:</strong>
                </div>
            </div>

        </div>
        <div class="xm1 margin-small">
            <div class="panel">
            	<div class="panel-head"> <strong>操作</strong></div>
               <div class="panel-body">
               	 <div class="form-group">
                    <div style="height: 50px"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="添加" onclick="tianjia()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="删除" onclick="shanchu()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="全选" onclick="quanxuan()"></div>
                    <div class="margin-small" style="margin-left: 0px;"><input type="button" class="button" value="清空" onclick="qingkong()"></div>
                </div>
               </div>
               

            </div>


        </div>
        <div class="xm5 margin-small">
            <div class="panel">
                <div class="panel-head">选择驾驶员</div>
                <div class="panel-body">
                    <div style="height: 50px"></div>
                    <div style="height:500px; overflow: scroll">
                        <table class="table table-bordered" id="table2">
                            <tr>
                                <th style="width:5%;">选择</th>
                                <th style="width:15%;">车牌号</th>
                                <th style="width:10%;">驾驶员</th>
                                <th style="width:25%;">身份证号</th>
                                <th style="width:5%;">性别</th>
                                <th style="width:10%;">属性</th>
                                <!--<th>手机</th>-->
                                <th style="width:15%;">车队名称</th>
                                <th style="width:15%;">分公司归属</th>
                            <tr>
                        </table>
                    </div>
                </div>
                <div class="panel-foot">
                    <strong>合计：</strong>
                </div>
            </div>
        </div>

    </div>
     <div class="xm10-move">
        <button class="button bg-green button-big" onclick="actity_submit()">提交</button>
    </div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>

</html>