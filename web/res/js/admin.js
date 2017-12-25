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
    
}

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
