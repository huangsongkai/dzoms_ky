//admin.js

$(document).ready(function(){
	$(".form-disabled").find("input,select,textarea").prop('readonly',true);
	
	$(".form-disabled .form-not-disabled").find("input,select,textarea").prop('readonly',false);

	$("form").attr('autocomplete','off');
});

document.onkeydown = function(event) {
	var target, code, tag;  
    if (!event) {  
        event = window.event; //针对ie浏览器  
        target = event.srcElement;  
    }else{
    	target = event.target; //针对遵循w3c标准的浏览器，如Firefox
    }
            
    code = event.keyCode;  
    
    //alert(code);
    if (code == 13) {	//回车
        tag = target.tagName;  
        //alert(tag);
        if (tag == "INPUT") {
        	$(target).next().focus();
        	return false;
        }
    }
    
};

function approvalAndSubmit(selector,sub_but){
	$(selector).html($(selector).val()+"同意");
	$(sub_but).click();
}

function approvalApply(selector){
	console.info($(selector).val());
	$(selector).val($(selector).val()+"同意");
	console.info($(selector).val());
}

function itemsDefault(selector,key){
	$.post("/DZOMS/select/itemsDefaultOf"+key,{},function(data){
		$(selector).val(data.data);
	});
}

function MyRequest(url,target) {
	this.url = url;
	this.target = target || "_blank";
	this._method = "post";

	this.params = [];
	this.param = function (name,value) {
		this.params.push({name:name,value:value});
		return this;
	};

	this.method = function (method) {
		this._method = method;
		return this;
	};

	this.submit = function () {
		var $form = $("<form  action='"+this.url+"' method='"+this._method+"' target='"+this.target+"' style='display: none;' />");
		this.params.forEach(function (params) {
			$form.append($('<input />').attr("name",params['name']).val(params['value']));
		});
		$form.appendTo($('body')).submit().remove();
	};

	this.openWindow = function (name,style,callback) {
		name = name || "new window";
		style = style || 'width=800,height=600,resizable=yes,scrollbars=yes';
		this.target = name;
		var iTop = (window.screen.availHeight-600)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.availWidth-800)/2; //获得窗口的水平位置;
		var winObj = window.open('about:blank',name,style);
		this.submit();

		if (callback) {
			var loop = setInterval(function() {
				if(winObj.closed) {
					clearInterval(loop);
					callback();
					//注：子窗口可通过window.opener向原窗口设置参数
				}
			}, 1000);
		}
	};

	return this;
}
