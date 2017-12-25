function refresh(key,attr){
			var list = null; 
			$.post('/DZOMS/item_select',{'item.key':key},function(data){
				var dat = $.parseJSON(data);
				list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
				$("#context").empty();
			var title_tr = '<tr><td>'+attr+'</td><td>设置</td><td>操作</td></tr>';
			$("#context").append(title_tr);
			if(list["id"] != undefined){
				var jscall1='javascript:delOne('+list["id"]+",\'"+key+"\',\'"+attr+"\')";
				var jscall2="javascript:setAsDefault(\'"+list["value"]+"\',\'"+key+"\',\'"+attr+"\')";
				var context_tr='<tr>'
			        +'<td>'+list["value"]+'</td>'
			        +'<td><a class="button bg-blue" href="'+jscall2+'">设为默认</a></td>'
					+'<td><a class="button bg-blue" href="'+jscall1+'">删除</a></td>'
					+'</tr>';
					$("#context").append(context_tr);
			}else{
				for(var i=0;i<list.length;i++){
				var jscall='javascript:delOne('+list[i]["id"]+",\'"+key+"\',\'"+attr+"\')";
				var jscall2="javascript:setAsDefault(\'"+list[i]["value"]+"\',\'"+key+"\',\'"+attr+"\')";
				var btx = 'bt'+(i+1);
				var context_tr='<tr>'
				    +'<td>'+list[i]["value"]+'</td>'
				    +'<td><a class="button bg-blue" href="'+jscall2+'">设为默认</a></td>'
					+'<td><a class="button bg-blue" href="'+jscall+'">删除</a></td>'
					+'</tr>';
					$("#context").append(context_tr);
				}
			}
			});
};
function delOne(id,key,attr){
	$.post('/DZOMS/item_remove',{'item.id':id},function(data){
		if($.trim(data) == 'success'){
			refresh(key,attr)
		}else{
			alert(data);
		}	
	});
};
function setAsDefault(value,key,attr){
	var list = null; 
	$.post('/DZOMS/item_select',{'item.key':key+".default"},function(data){
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		if(list!=undefined&&list.length==undefined){
			list = [list];
		}
		if (list==undefined) {
			list=[];
		}
		for(var i=0;i<list.length;i++){
			$.post('/DZOMS/item_remove',{'item.id':list[i]["id"]},function(data2){});
		}
		
		$.post('/DZOMS/item_add',{'item.key':key+".default",'item.value':value},function(data3){
			if($.trim(data3) == 'success'){
				refresh(key,attr)
			}else{
				alert(data3);
			}	
		});
	});
	
	
}
function addOne(key,attr,value){
	$.post('/DZOMS/item_add',{'item.key':key,'item.value':value},function(data){
		if($.trim(data) == 'success'){
			refresh(key,attr)
		}else{
			alert(data);
		}	
	});
};
function getList1(key,id){
	var list = null; 
	$.post('/DZOMS/item_select',{'item.key':key},function(data){
		$("#"+id).empty();
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		if(list.length==undefined){
			list = [list];
		}
		
		$("#"+id).append("<option></option>");
		for(var i=0;i<list.length;i++){
			var str = "<option>"+list[i]['value']+"</option>";
			$("#"+id).append(str);
		}
	});
};

function getListX(key,id,valuex){
	var list = null;
	$.post('/DZOMS/item_select',{'item.key':key},function(data){
		$("#"+id).empty();
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		if(list.length==undefined){
			list = [list];
		}

		$("#"+id).append("<option></option>");
		for(var i=0;i<list.length;i++){
			var str = "<option>"+list[i]['value']+"</option>";
			$("#"+id).append(str);
		}
		$("#"+id).val(valuex);
	});
};

function openItem(key,title){
	window.showModalDialog("/DZOMS/common/item_set.jsp",[key,title],
	'dialogHeight:500px, dialogLeft:100px, dialogTop:100px,dialogWidth:300px, status:0, edge:sunken');
};

$(document).ready(function(){
  $(".itemtool").each(function(){
  	 var key = $(this).attr("item-key");
  	 var $this = $(this);
  	 $(this).focus(function(){
  	 	getList1BySelector(key,this);
  	 });
  	 
  	 getList1BySelector(key,this,function(){
  	 	 $.post('/DZOMS/item_select',{'item.key':key+".default"},function(data){
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		
		if(list==undefined){
			return;
		}
		
		if(list.length==undefined){
			list = [list];
		}
		
		//var $option = $this.find("option[text='"+list[0]['value']+"']");
		//$option.prop("selected",true);
		$this.val(list[0]['value']);
		});
  	 });
  });
});

function getList1BySelector(key,selector,callback){
	var list = null; 
	$.post('/DZOMS/item_select',{'item.key':key},function(data){
		$(selector).empty();
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		if(list.length==undefined){
			list = [list];
		}
		
		$(selector).append($('<option></option>'));
		for(var i=0;i<list.length;i++){
			var $option = $('<option></option>').val(list[i]['value']).text(list[i]['value']);
			$(selector).append($option);
		}
		
		if (callback != undefined) {
			callback();
		}
	});
};

function getAsDefaultValue(key,callback){
	$.post('/DZOMS/item_select',{'item.key':key+".default"},function(data){
		var dat = $.parseJSON(data);
		list = dat.list[0]["com.dz.common.itemtool.ItemTool"];
		
		if(list==undefined){
			return undefined;
		}
		
		if(list.length==undefined){
			list = [list];
		}
		
		callback(list[0]['value']);
	});
}
