/**
 * Created by java_c on 2015/11/25.
 */
function del_but_bind(seletor,fn){
    $(seletor).on('click', function(){
        layer.open({
            type: 0,
            content:"<strong>确认删除？</strong>",
            shade: [0.8, '#393D49'],
            skin: 'layui-layer-lan',
            offset:getPos(seletor),
            btn: ['确认', '取消'],
            area: ['200px', '200px'],
            btn1:function(){
                fn();
            }
        });
    });
}
function add_but_bind(seletor,fn){
    $(seletor).on('click', function(){
        layer.open({
            type: 0,
            content:"<strong>确认提交？</strong>",
            shade: [0.8, '#393D49'],
            skin: 'layui-layer-lan',
            btn: ['确认', '取消'],
            area: ['200px', '200px'],
            offset:getPos(seletor),
           	btn1:function(){
                fn();
            }
        });
    });
}

function getPos(seletor){
	var top = $(seletor).offset().top - 200;
	//var left = $(seletor).offset().left;
	return top;//[top,left];
}

//tr 可选的table 初始化    selected-table  unselected-tr 
function selectedTableInit(){
    $(".selected-table tr").addClass("selected-able");
    $(".unselected-tr").removeClass("selected-able");
    $(".selected-able").click(function(){
         $(".selected-able").removeClass("my-selected");
         $(this).addClass("my-selected");
    });
}

function loadpicture(srcFile,target){
	if($(srcFile)[0].files!=undefined)
    if($(srcFile)[0].files.length>0){
        var file = $(srcFile)[0].files[0];
        var reader = new FileReader();
        reader.onload = function(){
            $(target).attr("src",this.result);
        };
        reader.readAsDataURL(file);
    }
}

function showImage(obj){
   	var $this = $(obj);
   	var file = $this.find("input")[0].files;
   	
   	if(file==undefined){
   		alert("文件不存在。");
   		return;
   	}
   	
   	var reader = new FileReader();
   	reader.onload=function(){
   		var path = this.result;
   		
   		var ImgObj = new Image(); //判断图片是否存在  
		ImgObj.src = path;
   		window.open(path,"图片预览",'width='+(ImgObj.width+10)+',height='+(ImgObj.height+10)+',resizable=no,scrollbars=no');
   		
   	};
   	reader.readAsDataURL(file[0]);
}

function showImage2($file){
   	var file = $file[0].files;
   	
   	if(file==undefined){
   		alert("文件不存在。");
   		return;
   	}
   	
   	var reader = new FileReader();
   	reader.onload=function(){
   		var path = this.result;
   		
   		var ImgObj = new Image(); //判断图片是否存在  
		ImgObj.src = path;
   		window.open(path,"图片预览",'width='+(ImgObj.width+10)+',height='+(ImgObj.height+10)+',resizable=no,scrollbars=no');
   		
   	};
   	reader.readAsDataURL(file[0]);
}

function showImageNew(obj){
   	var $this = $(obj);
   	var file = $this.find("input").val();
   	
   	if(file==undefined||file.length<30){
   		alert("文件不存在。");
   		return;
   	}
   	
   window.open("/DZOMS/tmp/"+file,"图片预览",'resizable=no,scrollbars=no');
}
   
function showPic(obj){
	var $img = $(obj).find("img");
	var path = $img.attr("src");
	
   	var ImgObj = new Image(); //判断图片是否存在  
	ImgObj.src = path;

	if (ImgObj.fileSize > 0 || (ImgObj.width >0 &&ImgObj.height > 0)){
		window.open(path,"图片预览",'width='+(ImgObj.width+10)+',height='+(ImgObj.height+10)+',resizable=no,scrollbars=no');
	}else
   	{alert("图片不存在！");}
}
   
function showImagePic(obj){
   	var $this = $(obj);
   	if(!$this.hasClass("file-exist")){
   		alert("图片不存在！");
   		return;
   	}
   	
   	var $input_file = $this.find("input");
   	
   	if($input_file.length>0){
   		showImage(obj);
   	}else{
   		showPic(obj);
   	}
}

var button_bind_len=0;
function button_bind_html(seletor,innerHtml,fnName){
	var $butOK = $('<button class="button bg-green dialog-close but-ok" onclick="'+fnName+'">确认</button>');
	var $innerDiv = $('<div class="dialog-foot"></div>')
				.append('<button class="button dialog-close">取消</button>')
				.append($butOK);
	var $dialogbody = $('<div class="dialog-body"></div>')
				.html(innerHtml);
	var $div = $('<div class="dialog"></div>')
		.addClass('button_bind'+button_bind_len)
		.append($dialogbody)
		.append($innerDiv);
	var $bind_div = $('<div id="button_bind'+button_bind_len+'"></div>').append($div);
	$("body").append($bind_div);
		
	$(seletor).addClass("dialogs");
	$(seletor).attr('data-toggle','click');
	$(seletor).attr('data-target','#button_bind'+button_bind_len);
	if(innerHtml instanceof Function){
		$(seletor).attr('data-function',innerHtml.getName());
	}
	button_bind_len++;
}

function button_bind(seletor,msg,fnName){
	button_bind_html(seletor,'<h3><strong>'+msg+'</strong></h3>',fnName);
}

function button_bind_url(seletor,url){	
	var $butOK = $('<button id="'+seletor+'">弹出</button>');
	
	$butOK.addClass("dialogs");
	$butOK.attr('data-toggle','click');
	$butOK.attr('data-url',url);
	$butOK.attr('data-mask',1);
	$("#"+seletor).remove();
	$("body").append($butOK);
}

function enable_selected(selector,urlData,callback){
	$(selector).bigAutocomplete({
		url:urlData,
		callback:callback
	});
}
