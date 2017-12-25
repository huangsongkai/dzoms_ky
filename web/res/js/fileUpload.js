//文件状态map   index -> state   0 -- 未获取  1 -- 成功  -1 -- 失败
var fileStateMap;
//文件对象map 
var fileObjMap;
//当前index
var index=0;

function getFileName($fileSelector){
	var path = $fileSelector[0].value;
	var pos1 = path.lastIndexOf('/');
	var pos2 = path.lastIndexOf('\\');
	var pos = Math.max(pos1, pos2);
	if (pos<0) {
		return path;
	} else{
		return path.substring(pos+1);
	}
}

function postTempFile($fileSelector,m_index){
	var filename = getFileName($fileSelector);
	fileObjMap[""+m_index]["filename"]=filename;
	var $form = $('<form></form>').attr("name","dz_file_upload_form"+m_index).attr("method","post").attr("enctype","multipart/form-data").attr("action","/DZOMS/fileAdapt/upload").attr("target","dz_file_upload_iframe"+m_index);
	$form.append($fileSelector);
	$('<input name="index" />').val(m_index).appendTo($form);
	var $iframe = $('<iframe></iframe>').attr("name","dz_file_upload_iframe"+m_index).css("display","none");
	$(document.body).append($iframe);
	$(document.body).append($form);
	
	$form.submit();
	$form.hide();
	$iframe.hide();
}

function fileUploadResult(m_index){
	var result = $("#result",window.frames["dz_file_upload_iframe"+m_index].document).val();
	var fileObj = fileObjMap[""+m_index];
	if (result==undefined||result.startsWith("ERROR")) {
    	if (fileObj.exceptFunc==undefined) {
    		alert("文件上传失败。");
    	} else{
    		fileObj.exceptFunc();
    	}
    	fileStateMap[""+m_index] = -1;
    }else{
    	fileStateMap[""+m_index] = 1;
    	fileObj.selector.val(result);
    	if (fileObj.sessussFunc!=undefined) {
    		fileObj.sessussFunc();
    		//alert("文件"+fileName+"上传失败。");
    	}
    }
    $("iframe[name='dz_file_upload_iframe"+m_index+"']").remove();
    $("form[name='dz_file_upload_form"+m_index+"']").remove();
}

function loadTempPicture($seqToSet,$target){
	$target.attr("src","/DZOMS/tmp/"+$seqToSet.val());
}

function loadThePicture(fi,img){
    loadTempPicture($(fi),$(img));
}

function fileRefresh(){
	$('.dz-file').each(function(){
		var $this = $(this);
		
		if($this.hasClass("dz-file-set-ok")){
			return true;
		}
		
		var data_toggle="click";
		var $data_target=$this;
		var exceptFunc = undefined;
		var sessussFunc = undefined;
		
		if ($this.attr("data-toggle")!=undefined) {
			data_toggle = $this.attr("data-toggle");
		}
		
		if ($this.attr("data-target")!=undefined) {
			$data_target = $($this.attr("data-target"));
			$this.css("display","none");
		}
		
		if ($this.attr("error-function")!=undefined) {
			exceptFunc = function(){
				eval($this.attr("error-function"));
			};
		}
		
		if ($this.attr("sessuss-function")!=undefined) {
			sessussFunc = function(){
				eval($this.attr("sessuss-function"));
			};
		}
		
		$data_target.bind(data_toggle,function(){
			var $file = $('<input id="dz-file-selector" name="file" type="file" />').css("display","none");
			$(document.body).append($file);
			$file.change(function(){
				postTempFile($file,$this.attr("dz-index"));
				$file.remove();
			});
			$file.click();
		});
		
		$this.addClass("dz-file-set-ok");
		
		$this.attr("dz-index",index);
		
		fileStateMap[""+index] = 0;//未获取
		
		fileObjMap[""+index] ={
			"selector":$this,
			"exceptFunc":exceptFunc,
			"sessussFunc":sessussFunc
		};
		
		index++;
	});
}

$(document).ready(function(){
	fileObjMap={};
	fileStateMap={};
	
	fileRefresh();
});
