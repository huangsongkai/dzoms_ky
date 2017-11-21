<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@taglib
	uri="/struts-tags" prefix="s"%><%@ page language="java"
	import="java.util.*, com.dz.module.vehicle.VehicleApproval,com.dz.module.user.User"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>列表编辑</title>
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css" />
					<link rel="stylesheet" href="/DZOMS/res/css/admin.css" />
					<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
					<script src="/DZOMS/res/js/jquery.js"></script>
					<script src="/DZOMS/res/js/pintuer.js"></script>
		
		<script type="text/javascript" src="/DZOMS/res/js/TableList.js" ></script>
		<script>
			var args=window.dialogArguments;
			var name=args[0];
			var size=args[1];
			var level = args[2];
			var rootId;
			$(document).ready(function(){
				var arr=[];
				var trs;
				for(var i=0;i<level-1;i++){
					if(i==level-2){
						 trs='<tr><td>第'+(i+1)+'级</td><td><select name="level'+i+'" id="fatherItem"></select></td><td><a href="javascript:loadLarger()" class="button bg-main">设置</a></td></tr>';
					}else{
						 trs='<tr><td>第'+(i+1)+'级</td><td><select name="level'+i+'"></select></td><td></td></tr>';
					}
					$("#top").append(trs);
					arr.push('level'+i);
				}
				//$('select[name="level'+level-2+'"]')
				
				$("#now").html('以下为设置第'+level+'级！');
				arr.push('list');
				
				getTableList(name,arr);
				getRootId(name,function(id){
					rootId=id;
				});
			});
			
			function loadLarger(){
				window.showModalDialog("/DZOMS/common/TableListEditor.jsp",[name,size,level-1],
		'dialogHeight:500px, dialogLeft:100px, dialogTop:100px,dialogWidth:300px, status:0, edge:sunken');
			}
			
			function addOne(){
				var newone=prompt("名称");
				if($.trim(newone)==""){
					alert("输入不能为空。");
					return;
				}
				var fid;
				if(level==1){
					fid=rootId;
				}else{
					fid = $('#fatherItem').find("option:selected").val();
				}
				$.post("/DZOMS/common/addSubItem",{"listValue.id":fid,"subItemName":newone},function(data){
					if(data>0){
						$("#list").append('<option value="'+data+'">'+newone+'</option>');
					}
				});
			}
			
			function deleteOne(){
				var $selected = $("#list").find("option:selected");
				$.post("/DZOMS/common/deleteItem",{"listValue.id":$selected.val()},function(data){
					if(data){
						$selected.remove();
					}
				});
			}
			
		</script>
	</head>
	<body>
	<div id="top">
	</div>
		<table class="table">
			<tr>
				<td id="now" style="text-align: left;">当前选项</td>
			</tr>
			<tr>
					<td colspan="5">
                            <select  id="list" name="list" size="5" style="width: 300px;">
                            </select>
                    </td>
                    <td>
                        <div class="field">
                            <a class="button input-file bg-main" href="javascript:void(0);" onclick="addOne()">添加</a>
                        </div>
                        <div class="field">
                            <a class="button input-file bg-red" href="javascript:void(0);" onclick="deleteOne()">删除</a>
                        </div>
                    </td>
			</tr>
		</table>
	</body>
</html>
