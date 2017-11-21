<%@page import="com.dz.common.other.ObjectAccess"%>
<%@page import="com.dz.module.vehicle.Vehicle"%>
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
	<title>错误数据查询结果</title>
	
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

         function _update(){
            var selected_val = $("input[name='cbx']:checked").val();
            var url = "/DZOMS/vehicle/beforeserviceSaveFromError?serviceError.id="+selected_val+"";
            window.parent.location.href=url;
        }
        
         function _delete(){
            var selected_val = $("input[name='cbx']:checked").val();
            $.post("/DZOMS/common/doit",{condition:"delete from ServiceError where id="+selected_val+""},function(){
            	document.vehicleSele.submit();
            });
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
</script>
  </head>
 <body>
<div class="line">
   <div class="panel  margin-small" >
          	<div class="panel-head">
          	    <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm4 xm6-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
		                                    <button onclick="_delete()" type="button" class="button text-blue" style="line-height: 6px;">
			                                                            删除</button>
                                     </div>
                                </div>
          	        	</div>
          	        </div>	
          </div>
        <div class="panel-body">
            
          
                <table class="table table-striped table-bordered table-hover">

                    <tr>
<th>选择</th>
<th class="licenseNum selected_able">车牌号</th>
<th class="serviceBegin selected_able">起始时间</th>
<th class="serviceEnd selected_able">结束时间</th>
<th class="money selected_able">营运金额</th>
<th class="allDistance selected_able">行驶里程</th>
<th class="times selected_able">营运次数</th>
<th class="uselessDistance selected_able">空驶里程</th>
<th class="effectiveDistance selected_able">营运里程</th>
<th class="distancePer selected_able">空驶率</th>
                    </tr>
       <s:if test="%{#request.list!=null}">
        
        <s:iterator value="%{#request.list}" var="v">
                   
<tr>
 <td><input type="radio" name="cbx" value="<s:property value="%{#v.id}"/>" ></td>
<td class="licenseNum selected_able"><s:property value="%{#v.licenseNum }"/></td>
<td class="serviceBegin selected_able"><s:property value="%{#v.serviceBegin }"/></td>
<td class="serviceEnd selected_able"><s:property value="%{#v.serviceEnd }"/></td>
<td class="money selected_able"><s:property value="%{#v.money }"/></td>
<td class="allDistance selected_able"><s:property value="%{#v.allDistance }"/></td>
<td class="times selected_able"><s:property value="%{#v.times }"/></td>
<td class="uselessDistance selected_able"><s:property value="%{#v.uselessDistance }"/></td>
<td class="effectiveDistance selected_able"><s:property value="%{#v.effectiveDistance }"/></td>
<td class="distancePer selected_able"><s:property value="%{#v.uselessDistance *1.0 / #v.allDistance *100 }"/>%</td>
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
            </s:if>
    <s:else>
    无查询结果
    </s:else>
        
       </div>
        <div class="panel-foot border-red-light bg-red-light">
            合计：<%=pg.getTotalCount() %>条记录。
        </div>
    </div>
</div>
 <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox bg-blue-light" id="show_div">
<label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="serviceBegin" checked="checked"><span class="icon icon-check text-green"></span>起始时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="serviceEnd" checked="checked"><span class="icon icon-check text-green"></span>结束时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="money" checked="checked"><span class="icon icon-check text-green"></span>营运金额</label>
<label class="button active"><input type="checkbox" name="sbx" value="allDistance" checked="checked"><span class="icon icon-check text-green"></span>行驶里程</label>
<label class="button active"><input type="checkbox" name="sbx" value="times" checked="checked"><span class="icon icon-check text-green"></span>营运次数</label>
<label class="button active"><input type="checkbox" name="sbx" value="uselessDistance" checked="checked"><span class="icon icon-check text-green"></span>空驶里程</label>
<label class="button active"><input type="checkbox" name="sbx" value="effectiveDistance" checked="checked"><span class="icon icon-check text-green"></span>营运里程</label>
<label class="button active"><input type="checkbox" name="sbx" value="distancePer" checked="checked"><span class="icon icon-check text-green"></span>空驶率</label>
            </div>

        </div>

    </div>
   	
   </div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
		<input type="hidden" name="url" value="/vehicle/service/search_err_result.jsp" />
		<input type="hidden" name="className" value="com.dz.module.vehicle.service.ServiceError"/>
		<s:hidden name="condition" />
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
