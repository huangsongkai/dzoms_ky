<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.driver.Driver"%>
<%@page import="com.dz.common.global.Page"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Page pg = (Page)request.getAttribute("page");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="renderer" content="webkit">
	<title>查询结果</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
	<script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
<script>
	$(document).ready(function(){
		$("#show_div").find("input").change(resetClass);
	});
	
	function resetClass(){
		$(".selected_able").hide();
		var selects = [];
		$("input[name='sbx']:checked").each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
      selects.push($(this).val());//将选中的值添加到数组chk_value中    
    });
	//	alert(selects);
		
		for(var i = 0;i<selects.length;i++){
			$("."+selects[i]).show();
		}
	}
	
	function _detail(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined){
				alert('您没有选择任何一条数据');
				return;
		}
	
		var url = "/DZOMS/driver/meeting/preshowMeeting?meeting.id="+selected_val;
		window.open(url,"例会明细",'width=1000,height=600,resizable=yes,scrollbars=yes');
	}

	function _delete() {
        var selected_val = $("input[name='cbx']:checked").val();
        if(selected_val==undefined){
            alert('您没有选择任何一条数据');
            return;
        }
        $.get('/DZOMS/driver/meeting/deleteMeeting?meeting.id='+selected_val,function (data) {
            alert(data.msg);
            window.location.reload();
        });
    }
	
	function _check(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined){
				alert('您没有选择任何一条数据');
				return;
		}
		var url = "/DZOMS/driver/meeting/precheckMeeting?meeting.id="+selected_val;
		window.open(url,"例会签到",'width=1000,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _anaylse(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined){
				alert('您没有选择任何一条数据');
				return;
		}
		var url = "/DZOMS/driver/meeting/preanaylseMeeting?meeting.id="+selected_val;
		window.open(url,"例会统计",'width=1000,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _export(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined){
				alert('您没有选择任何一条数据');
				return;
		}
		var url = "/DZOMS/driver/meeting/meetingToExcel?meetingId="+selected_val;
		window.open(url);
	}
	
/*	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/driver/driverPreupdate?driver.idNum="+selected_val;
		window.open(url,"驾驶员修改",'width=800,height=600,resizable=yes,scrollbars=yes');
	}*/
	
	function toBeforePage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==1){
			alert("没有上一页了。");
			return ;
		}
		$("input[name='currentPage']").val($("input[name='currentPage']").val()-1);
		document.vehicleSele.submit();
	}
	
	function toNextPage(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		if(currentPage==<%=pg.getTotalPage()%>){
			alert("没有下一页了。");
			return ;
		}
		$("input[name='currentPage']").val(parseInt($("input[name='currentPage']").val())+1);
		document.vehicleSele.submit();
	}
	
	function toPage(pg){
		
		$("input[name='currentPage']").val(pg);
		document.vehicleSele.submit();
	}
	
</script>
  </head>
 <body>
<div>
      <div class="panel  margin-small" >
          	<div class="panel-head">
          	   <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm2 xm8-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                     	<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		签到</button>
	                                    	<button onclick="_anaylse()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                                查看</button>
                                           <button onclick="_export()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                               导出</button>
                                           <button onclick="_delete()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
                                               导出</button>
                                     </div>
                                </div>
          	        	</div>
          	        </div>
          	
          		
          		
          	</div>
   
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
                    <th>选择</th>
<th class="meetingName 		selected_able">例会名称	 </th>
<th class="meetingTime		selected_able">例会时间	 </th>
<th class="meetingContext	selected_able">例会内容	 </th>
<th class="registrant		selected_able">制定人	 </th>
<th class="registTime		selected_able">制定时间	 </th>
<th class="meetingNum		selected_able">驾驶员数量</th>
<!-- <th class="checkedNum		selected_able">已签到人数</th>
<th class="uncheckedNum		selected_able">未签到人数</th> -->
                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value="%{#v.id}"/>" ></td>
<td class="meetingName selected_able"><s:property value="%{#v.meetingName}"/></td>
<td class="meetingTime selected_able"><s:property value="%{#v.meetingTime}"/></td>
<td class="meetingContext selected_able"><s:property value="%{#v.meetingContext}"/></td>
<td class="registrant selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.registrant).uname}"/></td>
<td class="registTime selected_able"><s:property value="%{#v.registTime}"/></td>
<td class="meetingNum selected_able"><s:property value="%{#v.driverList}"/></td>
<%-- <td class="checkedNum selected_able"><s:property value="%{#v.checkedNum}"/></td>
<td class="uncheckedNum selected_able"><s:property value="%{#v.uncheckedNum}"/></td>--%>
                        </tr>
                    </s:iterator>

            </table>
           

      <div class="line padding">
            	<div class="xm5-move">
            		<div>
            			<ul class="pagination">
                    <li> <a href="javascript:toBeforePage()">上一页</a> </li>
                  </ul>
                   <ul class="pagination pagination-group">
                    <li style="border: 0px;">
                    	<form>
                    		<div class="form-group">
                    			<div class="field">
                    			<input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>" id="page-input" >
                    		</div>
                    			</div>
                    	</form>
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
    <div class="panel  margin-small" style="display: none;">
          	<div class="panel-head">
          	显示项
          		
          		
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="meetingName" checked="checked"><span class="icon icon-check text-green"></span>例会名称</label>
<label class="button active"><input type="checkbox" name="sbx" value="meetingTime" checked="checked"><span class="icon icon-check text-green"></span>例会时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="meetingContext" checked="checked"><span class="icon icon-check text-green"></span>例会内容</label>
<label class="button active"><input type="checkbox" name="sbx" value="registrant" checked="checked"><span class="icon icon-check text-green"></span>制定人</label>
<label class="button active"><input type="checkbox" name="sbx" value="registTime" checked="checked"><span class="icon icon-check text-green"></span>制定时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="meetingNum" checked="checked"><span class="icon icon-check text-green"></span>驾驶员数量</label>
<%-- <label class="button active"><input type="checkbox" name="sbx" value="checkedNum" checked="checked"><span class="icon icon-check text-green"></span>已签到人数</label>
<label class="button active"><input type="checkbox" name="sbx" value="uncheckedNum" checked="checked"><span class="icon icon-check text-green"></span>未签到人数</label>
  --%>           </div>

        </div>

    </div>



<form action="/DZOMS/driver/meeting/searchMeeting" method="post" name="vehicleSele">
    <s:hidden name="beginDate" />
    <s:hidden name="endDate" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>



</body>

 <script src="/DZOMS/res/js/apps.js"></script>
    <script>
    $(document).ready(function() {
        App.init();
        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

    });
    </script>
</html>

