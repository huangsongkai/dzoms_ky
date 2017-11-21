<%@page import="com.dz.common.other.ObjectAccess"%>
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
	<title>银行导入查询结果</title>
	
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<script src="/DZOMS/res/js/jquery.js"></script>
	<script src="/DZOMS/res/js/pintuer.js"></script>
	<script src="/DZOMS/res/js/respond.js"></script>
	<script src="/DZOMS/res/js/admin.js"></script>
    <script>
        $(document).ready(function(){
            $("#show_div").find("input").change(resetClass);
            resetClass();
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
	
	$(document).ready(function(){
		var currentPage = parseInt($("input[name='currentPage']").val());
		$("#page-input").val(currentPage + "/<%=pg.getTotalPage()%>");
		
		$("#page-input").change(function(){
			
			var pg_num = parseInt($("#page-input").val());
			toPage(pg_num);
		});
		
		$("#page-input").focus(function(){
			$(this).val("");
		});
	});

$(document).ready(function(){
	//双击查看详情
	$("tr[checkId]").dblclick(function(){//开业审批单
		window.parent.location.href = "/DZOMS/common/selectToList.action?pageSize=30&url=%2fcharge%2fshow_file_import_detail.jsp&className=com.dz.module.charge.BankRecordTmp&condition=+and+fid%3d"+$(this).attr('checkId')+"+and+status%3d1+order+by+licenseNum";
	});

});

</script>
  </head>
 <body>
<div class="line">
   <div class="panel  margin-small" >
          	<div class="panel-head">
          	    <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm6 xm4-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                             
                                     </div>
                                </div>
          	        	</div>
          	        </div>	
          </div>
<div class="panel-body">
<table class="table table-striped table-bordered table-hover">
  <tr>
                        <!--<th>选择</th>-->
		<th class="type selected_able">文件名称</th>
		<th class="name selected_able">导款月份</th>
		<th class="idNum selected_able">导入时间</th>
		<th class="carframeNum selected_able">导入条数</th>
		<th class="licenseNum selected_able">导款总额</th>
  </tr>
  <%
  	String importSize = "select count(*) from BankRecordTmp where fid=";
  %>
  <s:if test="%{#request.list!=null}">
  <s:iterator value="%{#request.list}" var="v">            
		<tr checkId="<s:property value="%{#v.id}"/>" >
		 <td class="type selected_able"><s:property value="%{#v.md5}"/></td>
		 <td class="name selected_able"><s:date name="%{#v.insertMonth}" format="yyyy/MM"/></td>
		 <td class="idNum selected_able"><s:date name="%{#v.insertTime}" format="yyyy/MM/dd HH:mm"/></td>
		 
		 <td class="carframeNum selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from BankRecordTmp where fid='+#v.id)}"/></td>
		 <td class="licenseNum selected_able">
		 	<s:set name="sum_money" value="%{@com.dz.common.other.ObjectAccess@execute('select sum(money) from BankRecordTmp where fid='+#v.id)}"/>
		 	<s:property value="%{@java.lang.String@format('%6.2f',#sum_money)}"/>
		 </td>
		</tr>
  </s:iterator>
  </s:if>
</table>
            <s:if test="%{#request.list!=null}">
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
            <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
        </div>
            </s:if>
    <s:else>
    无查询结果
    </s:else>
    </div>
</div>
 <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="type" checked="checked"><span class="icon icon-check text-green"></span>文件名称</label>
<label class="button active"><input type="checkbox" name="sbx" value="name" checked="checked"><span class="icon icon-check text-green"></span>导款月份</label>
<label class="button active"><input type="checkbox" name="sbx" value="idNum" checked="checked"><span class="icon icon-check text-green"></span>导入时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="carframeNum" checked="checked"><span class="icon icon-check text-green"></span>导入条数</label>
<label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>导款总额</label>
<!--<label class="button active"><input type="checkbox" name="sbx" value="state" checked="checked"><span class="icon icon-check text-green"></span>当前状态</label>
-->            </div>

        </div>

    </div>
   	
   </div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
    <s:hidden name="condition" />
    <s:hidden name="url" />
    <s:hidden name="className" />
    <s:hidden name="pageSize" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>
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
</html>
