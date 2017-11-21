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
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script type="text/javascript" src="/DZOMS/res/js/itemtool.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
    <script type="text/javascript" src="/DZOMS/res/js/jquery.json.js" ></script>
    <script>
    	
    var slist;
    	 $(document).ready(function(){
//      	getTableList("groupPraise.praiseType", ["praiseClass1","praiseClass2","praiseClass3", "groupPraise.praiseClass"]); //投诉项目
//      setSingleList('groupPraise.praiseType',['praiseClass1','praiseClass2','praiseClass3','groupPraise.praiseClass','grade'],['第一级','第二级','第三级','第四级','分值'])
        	$("#praiseClass1").focusin(function(){
        		$.post('/DZOMS/item_select',{'item.key':'praiseType4'},function(data){
					var dat = $.parseJSON(data);
					list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
					
					if(list == undefined){
						list =[];
					}else if(list["id"] != undefined){
						list = [list];
					}
					
					var l1=[];
					for (var i = 0; i < list.length; i++) {
						var jsonStr = list[i]["value"];
						var json = $.parseJSON(jsonStr);
						
						if (!l1.contains(json['praiseClass1'])) {
							console.info(json['praiseClass1']);
							l1.push(json['praiseClass1']);
						}
					}
					
					console.info(l1.length);
					
					if (l1.length+1!=$("#praiseClass1 option").length) {
						$("#praiseClass1 option").remove();
						$("#praiseClass1").append("<option></option>");
						for(var j=0;j<l1.length;j++){
							$("#praiseClass1").append("<option value='"+l1[j]+"'>" + l1[j] + "</option>");
						}
					}
				});
        	});
        	
        	$("#praiseClass2").focusin(function(){
        		$.post('/DZOMS/item_select',{'item.key':'praiseType4'},function(data){
					var dat = $.parseJSON(data);
					list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
					
					if(list == undefined){
						list =[];
					}else if(list["id"] != undefined){
						list = [list];
					}
					
					var l1=[];
					var praiseClass1 = $("#praiseClass1").val();
					for (var i = 0; i < list.length; i++) {
						var jsonStr = list[i]["value"];
						var json = $.parseJSON(jsonStr);
						
						if (json['praiseClass1']==praiseClass1) {
							if (!l1.contains(json['praiseClass2'])) {
								l1.push(json['praiseClass2']);
							}
						}
					}
					
					
//					if (l1.length+1!=$("#praiseClass2 option").length) {
						$("#praiseClass2 option").remove();
						$("#praiseClass2").append("<option></option>");
						for(var j=0;j<l1.length;j++){
							$("#praiseClass2").append("<option value='"+l1[j]+"'>" + l1[j] + "</option>");
						}
//					}
				});
        	});
        	
        	$("#praiseClass3").focusin(function(){
        		$.post('/DZOMS/item_select',{'item.key':'praiseType4'},function(data){
					var dat = $.parseJSON(data);
					list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
					
					if(list == undefined){
						list =[];
					}else if(list["id"] != undefined){
						list = [list];
					}
					
					var l1=[];
					var praiseClass1 = $("#praiseClass1").val();
					var praiseClass2 = $("#praiseClass2").val();
					for (var i = 0; i < list.length; i++) {
						var jsonStr = list[i]["value"];
						var json = $.parseJSON(jsonStr);
						
						if (json['praiseClass1']==praiseClass1 && json['praiseClass2']==praiseClass2) {
							if (!l1.contains(json['praiseClass3'])) {
								l1.push(json['praiseClass3']);
							}
						}
					}
					
					
//					if (l1.length+1!=$("#praiseClass3 option").length) {
						$("#praiseClass3 option").remove();
						$("#praiseClass3").append("<option></option>");
						for(var j=0;j<l1.length;j++){
							$("#praiseClass3").append("<option value='"+l1[j]+"'>" + l1[j] + "</option>");
						}
//					}
				});
        	});
        	
        	$("#praiseClass4").focusin(function(){
        		$.post('/DZOMS/item_select',{'item.key':'praiseType4'},function(data){
					var dat = $.parseJSON(data);
					list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
					
					if(list == undefined){
						list =[];
					}else if(list["id"] != undefined){
						list = [list];
					}
					
					slist=list;
					
					var l1=[];
					var praiseClass1 = $("#praiseClass1").val();
					var praiseClass2 = $("#praiseClass2").val();
					var praiseClass3 = $("#praiseClass3").val();
					for (var i = 0; i < list.length; i++) {
						var jsonStr = list[i]["value"];
						var json = $.parseJSON(jsonStr);
						
						if (json['praiseClass1']==praiseClass1 && json['praiseClass2']==praiseClass2 && json['praiseClass3']==praiseClass3) {
							if (!l1.contains(json['praiseClass4'])) {
								l1.push(json['praiseClass4']);
							}
						}
					}
					
					
//					if (l1.length+1!=$("#praiseClass4 option").length) {
						$("#praiseClass4 option").remove();
						$("#praiseClass4").append("<option></option>");
						for(var j=0;j<l1.length;j++){
							$("#praiseClass4").append("<option value='"+l1[j]+"'>" + l1[j] + "</option>");
						}
//					}
				});
        	});
        	
        	$("#praiseClass4").change(function(){
        		if ($("#praiseClass4").val().length>0) {
        			var praiseClass1 = $("#praiseClass1").val();
					var praiseClass2 = $("#praiseClass2").val();
					var praiseClass3 = $("#praiseClass3").val();
					var praiseClass4 = $("#praiseClass4").val();
					
//					console.info(slist);
					for (var i = 0; i < slist.length; i++) {
						var jsonStr = slist[i]["value"];
						var json = $.parseJSON(jsonStr);
						
						if (json['praiseClass1']==praiseClass1 && json['praiseClass2']==praiseClass2 && json['praiseClass3']==praiseClass3 && json['praiseClass4']==praiseClass4) {
							$("#grade").val(json['grade']);
							
							$("#praiseClassVal").val(jsonStr);
//							console.info(json);
							break;
						}
					}
        		}
        	});
    	 
    	 });
        
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
        
        function group_praise_submit(){
        	$("#driverlist").html("");
        	$("#table2 :checkbox").each(function(){
        		var $hidden = $('<input type="hidden" name="driverlist"></input>').val($(this).val());
        		$("#driverlist").append($hidden);
        	});
        	//alert($('#driverlist').val());
        	document.addGroupPraise.submit();
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>媒体管理</li>
                <li>添加媒体荣誉</li>
              
        </ul>
</div>
<div class="line">
    <form method="post" name="addGroupPraise" action="addGroupPraise" style="width: 100%;">
    	<div id="driverlist"></div>
    	<div class="line">
    		<div class="panel xm11 margin-small">
    			<div class="panel-head">添加媒体荣誉</div>
    			<div class="panel-body">
    		<table class="table">
            <tr>
                <td style="text-align: right;"><strong>表扬时间</strong></td>
                <td style="text-align: left;"><input class="datepick input input-auto" size="15" type="text" name="groupPraise.praiseTime"></td>
            </tr>
            <tr>
                <td style="text-align: right;"><strong>表扬类型</strong></td>
                <td> <select class="input"  id="praiseClass1" style="max-width: 200px;"></select></td>
                <td> <select class="input"  id="praiseClass2"  style="max-width: 200px;"></select></td>
                <td> <select class="input"  id="praiseClass3"  style="max-width: 200px;"></select></td>
                <td> <select class="input"  id="praiseClass4"  style="max-width: 200px;"></select>
                	<input type="hidden" name="groupPraise.praiseClass" id="praiseClassVal" />
                </td>
                <td><a class="icon icon-wrench" href="javascript:setSingleList('praiseType4',['praiseClass1','praiseClass2','praiseClass3','praiseClass4','grade'],['第一级','第二级','第三级','第四级','分值'])"></a>
                	<!--<a class="icon-wrench" href="javascript:setTableList('groupPraise.praiseType',4)"></a>--></td>
                <td style="text-align: right;"><strong>分值</strong></td>
                <td><input class="input input-auto float-left" size="5" id="grade" name="groupPraise.grade"/></td>
            </tr>
            <tr>
                <td style="text-align: right;"><strong>表扬内容</strong></td>
                <td colspan="5"><textarea rows="5" class="input" name="groupPraise.praiseReason"></textarea> </td>
            </tr>
        </table>
    				
    			</div>
    			
    			
    		</div>
    		
    	</div>
      
    </form>
   </div>
    <div class="line">
        <div class="xm5 margin-small">
            <div class="panel">
                <div class="panel-head">全部驾驶员</div>
                <div class="panel-body">
                   <form class="form-inline">
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
                     
                   </form> 
                  
                    </div>

                    <div style="height: 500px;overflow: scroll">
                        <table class="table table-bordered table-striped" id="table1">
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
                <div class="panel-head"><h3><strong>选择驾驶员</strong></h3></div>
                <div class="panel-body">
                    <div style="height: 50px"></div>
                    <div style="height:500px; overflow: scroll">
                        <table class="table table-bordered table-striped" id="table2">
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
        <button class="button bg-green button-big" onclick="group_praise_submit()">提交</button>
    </div>
</div>
</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>

</html>