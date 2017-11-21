<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8" %>
<%@page import="org.springframework.web.context.support.*" %>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<% String path=request.getContextPath(); String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/"; %>

<!DOCTYPE html>
<html lang="zh-cn">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="renderer" content="webkit" />
<title> 例会签到 </title> 
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.js"> </script> 
<script src="/DZOMS/res/js/pintuer.js"> </script> 
<script src="/DZOMS/res/js/respond.js"> </script> 
<script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script> 
<script src="/DZOMS/res/js/admin.js"> </script> 
<script>

$(document).ready(function(){
	<s:if test="%{#session.errorMsg!=null}">
		alert("签到失败！<s:property value="%{#session.errorMsg}"/>");
	</s:if>
});

function toBeforePage(){
		var currentPage = parseInt($("input[name='nowPage']").val());
		if(currentPage==1){
			alert("没有上一页了。");
			return ;
		}
		$("input[name='nowPage']").val($("input[name='nowPage']").val()-1);
		document.pageForm.submit();
	}
	
	function toNextPage(){
		var currentPage = parseInt($("input[name='nowPage']").val());
		if(currentPage==<s:property value="%{totalPage}"/>){
			alert("没有下一页了。");
			return ;
		}
		$("input[name='nowPage']").val(parseInt($("input[name='nowPage']").val())+1);
		document.pageForm.submit();
	}
	
	function toPage(pg){
		$("input[name='nowPage']").val(pg);
		document.pageForm.submit();
	}
	
	$(document).ready(function(){
		$("#page-input").change(function(){
			
			var pg_num = parseInt($("#page-input").val());
			toPage(pg_num);
		});
		
		$("#page-input").focus(function(){
			$(this).val("");
		});
	});
/*
<s:property value="%{#session.errorMsg}"/>
<s:property value="%{#session.errorMap}"/>
 */
function add1(){
	var idNum = $("input[name='cbx']:checked").val();
	var checkType = $(".dialog-win .checkType").val();
	var checkMethod = $(".dialog-win .checkClass").val();
	var checkTime = $(".dialog-win .checkTime").val();
	
/*	alert(idNum);
	alert(checkType);
	alert(checkMethod);
	alert(checkTime);*/
	
	$("input[name='checkClass']").val(checkType);
	$("input[name='idNum']").val(idNum);
	$("input[name='method']").val(checkMethod);
	$("input[name='checkTime']").val(checkTime);
	
	//alert($("input[name='checkClass']").val());
	document.manmalCheck.submit();
}

var use_tr_pos;

function hand_check(tr){
	$(tr).find("input").click();
	use_tr_pos = true;
	$("#manmalCheckDiv a").click();
}

function checkByFileSubmit(){
	setTimeout("window.refresh(true);",3000);
	document.checkByFile.submit();
}

function clearCheck(){
	var idNum = $("input[name='cbx']:checked").val();
	$("input[name='idNum']").val(idNum);
	document.clearCheck.submit();
}

var times = 0;
function refreshAll(){
	//var inner = $("iframe[name='hid1']").html().trim();

	//if (inner.length>5) {
	//	alert(inner);
		if(times>0)
			document.pageForm.submit();
		else
			times++;
	//}
	
}

</script>

<style>
	.label {
		width: 80 px;
		text-align: right;
	}
	.form-group {
		width: 300 px;
		margin-top: 5 px;
	}
	.changecolor {
		background-color: #0099CC;
	}
							
</style>
</head>

<body>
	<form method="post" action="manmalCheck" name="manmalCheck" style="width: 100%;">
		<s:hidden name="meeting.id"></s:hidden>
		<s:hidden name="meetingId" value="%{meeting.id}"></s:hidden>
		<s:hidden name="checkClass"></s:hidden>
		<s:hidden name="idNum"></s:hidden>
		<s:hidden name="method"></s:hidden>
		<s:hidden name="checkTime"></s:hidden>
		<s:hidden name="nowPage"></s:hidden>
	</form>
	
	<form method="post" action="clearCheck" name="clearCheck" target="hid1">
		<s:hidden name="meeting.id"></s:hidden>
		<s:hidden name="meetingId" value="%{meeting.id}"></s:hidden>
		<s:hidden name="idNum"></s:hidden>
	</form>
	<iframe name="hid1" style="display:none" onload="refreshAll()" ></iframe>
	
	<form  style="width: 100%;" method="post" action="checkByFile" name="checkByFile" class="form-inline form-tips" enctype="multipart/form-data">
		<s:hidden name="meeting.id"></s:hidden>
	    
		<div class="line">
	         <div class="panel  margin-small" >
                	<div class="panel-head">签到
                		<div class="line">
			
				<div class="xm1 xm7-move" id="manmalCheckDiv">
					<a  class="button dialogs bg-gray margin" data-toggle="click" data-target="#mydialog" data-mask="1" data-width="50%">
            	     <span class="h6"><strong>手工</strong></span>
				   </a>
		         </div>
		         <div class="xm1">
		         	<a  class="button  bg-gray margin" onclick="$('#m_file').click()">
				   
            	     <span class="h6"><strong>导入</strong></span>
				   </a>
		         	<input type="file" id="m_file" name="fileCheck" onchange="checkByFileSubmit()" hidden="hidden"/>
		         </div>
			
			 	<div class="xm2">
		         	<a  class="button  bg-gray margin" href="javascript:clearCheck()">
            	     <span class="h6"><strong>清除签到</strong></span>
				   </a>
		         </div>
			
		    </div>
          		
          	</div>
          	<div class="panel-body">
          	
				<table class="table table-bordered table-hover" id="meeting-time-detail">
					<tr>
						<th>选择</th><th>车牌号</th><th>驾驶员</th><th>身份证号</th><th>分公司归属</th> <th>类别</th><th>是否签到</th> <th>签到方式 </th><th>签到时间</th><th>分值</th> <th>手动签到经手人</th><th>手动签到经手时间</th>  
					</tr>
					<s:if test="%{checkList!=null}">
                    <s:iterator value="%{checkList}" var="v">
                    <tr ondblclick="hand_check(this)" class="<s:property value="%{#v.isChecked?'bg-green-light':'bg-red-light'}" />">
<%--<td><input type="radio" name="cbx" value="<s:property value="%{#v.idNum}" />" <s:property value="%{#v.isChecked?'disabled=\"true\"':''}" /> /></td> --%>
<td><input type="radio" name="cbx" value="<s:property value="%{#v.idNum}" />" /></td>
<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNum)}" />
<s:set name="t_meeting" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.meeting.Meeting',#v.meetingId)}" />
<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',#t_driver.carframeNum).licenseNum}"/></td>
<td><s:property value="%{#t_driver.name}"/></td>
<td><s:property value="%{#v.idNum}"/></td>
<td><s:property value="%{#t_driver.dept}"/></td>
<td><s:property value="%{#v.isBuhui()?'补会':'例会'}"/></td>
<td><s:property value="%{#v.isChecked?'是':'否'}"/></td>
<td><s:property value="%{#v.checkMethod}"/></td>
<td><s:date name="%{#v.checkTime}" format="yyyy/MM/dd hh:mm:ss"/></td>
<td><s:property value="%{#t_meeting.grade}"/></td>
<td><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.manmalCheckPerson).uname}"/></td>
<td><s:date name="%{#v.manmalCheckTime}" format="yyyy/MM/dd hh:mm:ss"/></td></tr>

                    </s:iterator>
                    </s:if>
				</table>
				<s:if test="%{checkList!=null}">
            <div class="line padding">
            	<div class="xm5-move">
            		<div>
            			<ul class="pagination">
                    <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                  </ul>
                   <ul class="pagination pagination-group">
                    <li style="border: 0px;">
                    	
                    		<div class="form-group">
                    			<div class="field">
                    			<input class="input input-auto" size="4" value="<s:property value="%{nowPage}"/>/<s:property value="%{totalPage}"/>" id="page-input" >
                    		</div>
                    			</div>
                    	</li>
                   </ul>
                  <ul class="pagination">
                    <li><a href="javascript:toNextPage()">下一页</a></li>
                  </ul>
                  
            		</div>
            	</div>
            </div>
            </s:if>
            <s:else>
                	无查询结果
            </s:else>
			</div>
		</div>
	</div>
		<s:if test="%{errorMap!=null}">
		<div class="line">
	         <div class="panel  margin-small" >
                	<div class="panel-head">
          		<div class="float-left">
          			<h4><strong class="text-black">导入失败的条目:</strong></h4>
          		</div>
          		
          		<div style="text-align: right;">
                    <a href="javascript:;" class="button border-main bg-yellow" data-click="panel-collapse"><i class="icon icon-minus text-white"></i></a>
                    <a href="javascript:;" class="button border-main bg-red" data-click="panel-remove"><i class="icon icon-times text-white"></i></a>
                </div>
          		
          	</div>
          	<div class="panel-body">
			
			<table id="errTable">
				<tr><th>身份证号</th><th>原因</th></tr>
				<s:iterator value="#session.errorMap.keySet()" id="idNum">  
				<tr><td><s:property value="#idNum"/></td><td><s:property value="#session.errorMap[#idNum]"/></td></tr> 
       			</s:iterator> 
			</table>
			</div>
			</div>
		</div>
		</s:if>
	
		
	</form> 
	
	<form action="/DZOMS/driver/meeting/precheckMeeting" method="post" name="pageForm">
		<s:hidden name="nowPage"></s:hidden>
		<s:hidden name="meeting.id"></s:hidden>
	</form>
	
   <div id="mydialog"> 
   		<div class="dialog"> 
   			<div class="dialog-head"> 
   				<span class="close rotate-hover"></span><strong>人工签到</strong> 
   			</div>
   			<div class="dialog-body">
      			<div>
         			<strong>签到类型</strong>
          			<select  class="input checkType">
           			 <option>指纹模糊</option>
           			 <option>未按规定日期参加例会</option>
           			 <option>特殊情况</option>
           			 <option>补会</option>
           			 <option>迟到</option>
           			 <option>收卡</option>
       			   </select>
          			<strong>签到时间</strong>
          			<input  class="datepick input checkTime"/>
          			<strong>签到方式</strong>
          			<select  class="input checkClass" >
            			<option>手动</option>
          			</select>
      			</div>
   			</div>
   			<div class="dialog-foot"> 
   				 <button class="button dialog-close"> 取消</button> 
   				 <button class="button bg-green" onclick="add1()">添加</button> 
   			</div> 
  		</div> 
   </div>
</body> 
 <script src="/DZOMS/res/js/apps.js"></script>
    <script>
    $(document).ready(function() {
        try{
        	App.init();
        }catch(e){
        	//TODO handle the exception
        }
        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

    });
    </script>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"> </script>
<script>
	$(function(){
		$showdialogs=function(e){
		var trigger=e.attr("data-toggle");
		var getid=e.attr("data-target");
		var data=e.attr("data-url");
		var mask=e.attr("data-mask");
		var width=e.attr("data-width");
		var detail="";
		var masklayout=$('<div class="dialog-mask"></div>');
		if(width==null){width="80%";}
		
		if (mask=="1"){
			$("body").append(masklayout);
		}
		detail='<div class="dialog-win" style="position:fixed;width:'+width+';z-index:11;">';
		if(getid!=null){detail=detail+$(getid).html();}
		if(data!=null){detail=detail+$.ajax({url:data,async:false}).responseText;}
		detail=detail+'</div>';
		
		var win=$(detail);
		win.find(".dialog").addClass("open");
		$("body").append(win);
		var x=parseInt($(window).width()-win.outerWidth())/2;
		
		if(use_tr_pos){
			var y=parseInt($("input:checked").offset().top);
			use_tr_pos = false;
		}else{
			var y=parseInt(e.offset().top);
		}

		if (y<=10){y="10"}
		win.css({"left":x,"top":y});
		win.find(".dialog-close,.close").each(function(){
			$(this).click(function(){
				win.remove();
				$('.dialog-mask').remove();
			});
		});
		masklayout.click(function(){
			win.remove();
			$(this).remove();
		});
		
	$('.datepick').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d H:i",      //格式化日期

	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
});
	};
	});
</script>
</html>