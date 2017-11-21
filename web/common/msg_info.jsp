<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<script>
	function heredoc(fn) {
   		return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
	}
	
//这里面不是注释！！！
 var msg = heredoc(function(){/*
<s:property value="%{#request.msgStr}"/>
*/});
       
    $(document).ready(function(){
      	if(msg.trim()!=""){
       		alert(msg.trim());
       	}
    });
</script>