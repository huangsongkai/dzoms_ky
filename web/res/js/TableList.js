function getTableList(name,selectArray){
	var selectName = selectArray[0];
	selectArray = selectArray.splice(1);
	
	$("select[name='"+selectName+"']").focus(function(){
		$.post("/DZOMS/common/getList",{"name":name},function(data,status){
			var firstList=data;//$.parseJSON(data);
			$("select[name='"+selectName+"']").html("");
			for (var i = 0; i < firstList.length; i++) {
				$("select[name='"+selectName+"']").append("<option value='"+firstList[i].id+"'>" + firstList[i].value + "</option>");
			}
		});
	});
	
	if(selectArray.length>0){
		$("select[name='"+selectName+"']").blur(function(){
			getSubList($(this).children('option:selected').val(),selectArray);
		});
	};
}

function getSubList(id,selectArray){
	var selectName = selectArray[0];
	selectArray = selectArray.splice(1);
	
	$("select[name='"+selectName+"']").unbind("focus");
	$("select[name='"+selectName+"']").focus(function(){
		$.post("/DZOMS/common/getSubList",{"listValue.id":id},function(data,status){
			var subList =data;// $.parseJSON(data);
			
			$("select[name='"+selectName+"']").html("");
			for (var i = 0; i < subList.length; i++) {
				$("select[name='"+selectName+"']").append("<option value='"+subList[i].id+"'>" + subList[i].value + "</option>");
			}
		});
	});
	
	if(selectArray.length>0){
		$("select[name='"+selectName+"']").blur(function(){
			getSubList($(this).children('option:selected').val(),selectArray);
		});
	}
}

function getSingleList(name,main_key,keys){

$("select[name='"+main_key+"']").focusin(function(){
	$.post('/DZOMS/item_select',{'item.key':name},function(data){
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		
		if(list == undefined){
			list =[];
		}else
		if(list["id"] != undefined){
			list = [list];
		}
		
		if (list.length+1!=$("select[name='"+main_key+"'] option").length) {
			$("select[name='"+main_key+"'] option").remove();
			$("select[name='"+main_key+"']").append("<option></option>");
			for(var j=0;j<list.length;j++){
				var jsonStr = list[j]["value"];
				var json = $.parseJSON(jsonStr);
				$("select[name='"+main_key+"']").append("<option value='"+jsonStr+"'>" + json[main_key] + "</option>");
			}
		
			$("select[name='"+main_key+"']").unbind("blur change");
			
			$("select[name='"+main_key+"']").bind("blur change",function(){
				var jsonStr =$("select[name='"+main_key+"']").children('option:selected').val();
				if(jsonStr.length!=0){
					var json = $.parseJSON(jsonStr);
					for (var i = 0; i < keys.length; i++) {
						$("[name='"+keys[i]+"']").val(json[keys[i]]);
					}
				}else{
					for (var i = 0; i < keys.length; i++) {
						$("[name='"+keys[i]+"']").val('');
					}
				}
				
			});
		
		}
	});
});

}

function addSingleList(name,keys,fn){
	var obj={};
	for (var i = 0; i < keys.length; i++) {
		obj[keys[i]]=$("input[name='"+keys[i]+"']").val();		
	}
	var data = $.toJSON(obj);
	$.post('/DZOMS/item_add',{'item.key':name,'item.value':data},function(data2){
		if($.trim(data2) == 'success'){
			fn();
		}else{
			alert("添加失败");
		}
	});
}

function setSingleList(name,keys,labels){
	window.showModalDialog("/DZOMS/common/SingleListEditor.jsp",[name,keys,labels],
	'dialogHeight:500px, dialogLeft:100px, dialogTop:100px,dialogWidth:800px, status:0, edge:sunken');
}

function setTableList(name,size){
		window.showModalDialog("/DZOMS/common/TableListEditor.jsp",[name,size,size],
		'dialogHeight:500px, dialogLeft:100px, dialogTop:100px,dialogWidth:800px, status:0, edge:sunken');
}

function getRootId(name,fn){
	$.post("/DZOMS/common/getRootId",{"name":name},function(data,status){
		var id = data;//$.parseJSON(data);
		fn(id);
	});
}

function getFathersValue(id,fn){
	$.post("/DZOMS/common/getFathersValue",{"listValue.id":id},function(data,status){
		var strList = data;//$.parseJSON(data);
		var str="";
		for(var i=0;i<strList.length;i++){
			str += " "+strList[i];
		}
		fn(str);
	});
}
