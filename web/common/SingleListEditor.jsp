<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>SingleList</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/jquery.json.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
<script type="text/javascript">
var args=window.dialogArguments;
var name=args[0];
var keys=args[1];
var labels=args[2];

var unsaved = false;
var cols = keys.length;

$(document).ready(function (){
	$('#add_button').click(function(){
			addLine();
	});
	refreshPage();
});

function refreshPage(){
	$("#context").html("");

	var title = '<tr>';
	for(var i=0;i<cols;i++){
		title += '<td>'+labels[i]+'</td>'
	}
	title += '<td>操作</td></tr>'	;
	$("#context").append(title);
	
	$.post('/DZOMS/item_select',{'item.key':name},function(data){
		var dat = $.parseJSON(data);
		var tlist = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		
		if(tlist==undefined){
			tlist=[];
		}else
		if(tlist["id"] != undefined){
			tlist = [tlist];
		}
		
		for(var j=0;j<tlist.length;j++){
			var jsonStr = tlist[j]["value"];
			var json = $.parseJSON(jsonStr);
			
			var trs = '<tr id="tr'+j+'" rid="'+tlist[j]["id"]+'">';
			for(var i=0;i<cols;i++){
					trs += '<td>'+json[keys[i]]+'</td>'
			}
			trs += '<td><a href="javascript:delLine('+j+')">删除</a></td></tr>';
			$("#context").append(trs);
		}
	});
}

function addLine(){
	if(unsaved){
		alert("请先保存未保存的条目。");
		return;
	}
	
			var trs = '<tr id="editing">';
			for(var i=0;i<cols;i++){
					trs += '<td>'+'<input name="'+keys[i]+'" />'+'</td>'
			}
			trs += '<td><a href="javascript:saveItem()">保存</a></td></tr>';
			$("#context").append(trs);
			unsaved = true;
}

function saveItem(){
	addSingleList(name,keys,function(){
		unsaved = false;
		refreshPage();
	});
}

function delLine(line){
	var $tr = $("#tr"+line);
	var id=$tr.attr("rid");
	$.post('/DZOMS/item_remove',{'item.id':id},function(data){
		if($.trim(data) == 'success'){
			$("#tr"+line).remove();
		}else{
			alert(data);
		}	
	});
}

</script>
<title >可选项操作</title>
  </head>

  <body>
  <div class="container">
  <div class="xb4 xb4-move">
	<table id="context"    class=" table table-bordered table-hover " >
	</table>
	<button id="add_button" class="button bg-green">添加</button>
	</div>
	</div>
  </body>
</html>
