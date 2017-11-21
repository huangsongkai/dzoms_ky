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
	<title>电子违章查询结果</title>
	
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
        	//更新数据
        	var carlist="";
          $("input[name='cbx']:checked").each(function(){
          	var $this = $(this);
          	carlist+=","+$this.val();
          });
          
          carlist=carlist.substr(1);
          $.post("/DZOMS/vehicle/electricQuery",{"carList":carlist},function(data){
          	if(data){
          		document.vehicleSele.submit();
          	}
          });
        }
        
        function _updateAll(){
        	//更新所有数据
          $.post("/DZOMS/vehicle/electricQueryAll",{"condition":$('[name="condition"]').val()},function(data){
          	if(data){
          		document.vehicleSele.submit();
          	}
          });
        }
        
        function _selectAll(){
        	 $("input[name='cbx']").each(function(){
        	 	$(this).prop("checked",true);
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
          	        	<!--<div class="xm6 xm4-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                   <button onclick="_selectAll()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            本页全选</button>
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            更新所选车辆数据</button>
			                                 <button onclick="_updateAll()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            更新所有车辆数据(含条件)</button>
			                                                    
                                     </div>
                                </div>
          	        	</div>-->
          	        </div>	
          </div>
        <div class="panel-body">
            
          
                <table class="table table-striped table-bordered table-hover">

                    <tr>
                        <!--<th>选择</th>-->
                        <th class="beginDate selected_able">开始日期</th>
                        <th class="endDate selected_able">结束日期</th>
                        <th class="allTimes selected_able">违章总数</th>
                        <th class="allMoney selected">罚款总额</th>
                        <th class="time1 selected_able">一部违章总数</th>
                        <th class="money1 selected">一部罚款总额</th>
                        <th class="time2 selected_able">二部违章总数</th>
                        <th class="money2 selected">二部罚款总额</th>
                        <th class="time3 selected_able">三部违章总数</th>
                        <th class="money3 selected">三部罚款总额</th>
                        <th class="file selected">下载</th>
                    </tr>
                    <s:if test="%{#request.list!=null}">
        
        <s:iterator value="%{#request.list}" var="v">
                   
<tr>
 <%--<td><input type="checkbox" name="cbx" value="<s:property value="%{#v.carframeNum}"/>" ></td>--%>
 <td class="beginDate selected_able"><s:property value="%{#v.beginDate}"/></td>
                        <td class="endDate selected_able"><s:property value="%{#v.endDate}"/></td>
                        <td class="allTimes selected_able"><s:property value="%{#v.allTimes}"/></td>
                        <td class="allMoney selected_able"><s:property value="%{#v.allMoney}"/></td>
                        <td class="time1 selected_able"><s:property value="%{#v.time1}"/></td>
                        <td class="money1 selected_able"><s:property value="%{#v.money1}"/></td>
                        <td class="time2 selected_able"><s:property value="%{#v.time2}"/></td>
                        <td class="money2 selected_able"><s:property value="%{#v.money2}"/></td>
                        <td class="time3 selected_able"><s:property value="%{#v.time3}"/></td>
                        <td class="money3 selected_able"><s:property value="%{#v.money3}"/></td>
                        <td class="file selected_able"><a href="/DZOMS/vehicle/downloadXls?id=<s:property value="%{#v.id}"/>" target="_blank">下载</a></td>
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
                <label class="button active"><input type="checkbox" name="sbx" value="beginDate" checked="checked"><span class="icon icon-check text-green"></span>开始日期</label>
<label class="button active"> <input type="checkbox" name="sbx" value="endDate" checked="checked"><span class="icon icon-check text-green"></span>结束日期</label>
<label class="button active"> <input type="checkbox" name="sbx" value="allTimes" checked="checked"><span class="icon icon-check text-green"></span>违章总数</label>
<label class="button active"> <input type="checkbox" name="sbx" value="allMoney" checked="checked" class="icon icon-check text-green">罚款总额</label>
<label class="button active"> <input type="checkbox" name="sbx" value="time1" checked="checked"><span class="icon icon-check text-green"></span>一部违章总数</label>
<label class="button active">  <input type="checkbox" name="sbx" value="money1" checked="checked"><span class="icon icon-check text-green"></span>一部罚款总额</label>
<label class="button active"> <input type="checkbox" name="sbx" value="time2" checked="checked"><span class="icon icon-check text-green"></span>二部违章总数</label>
<label class="button active">  <input type="checkbox" name="sbx" value="money2" checked="checked"><span class="icon icon-check text-green"></span>二部罚款总额</label>
<label class="button active"> <input type="checkbox" name="sbx" value="time3" checked="checked"><span class="icon icon-check text-green"></span>三部违章总数</label>
<label class="button active">  <input type="checkbox" name="sbx" value="money3" checked="checked"><span class="icon icon-check text-green"></span>三部罚款总额</label>
<label class="button active">   <input type="checkbox" name="sbx" value="file" checked="checked"><span class="icon icon-check text-green"></span>下载</label>
            </div>

        </div>

    </div>
   	
   </div>

<form action="/DZOMS/common/selectToList" method="post" name="vehicleSele">
    <s:hidden name="condition" />
    <input type="hidden" name="className" value="com.dz.module.vehicle.electric.ElectricAnaylse"/>
    <input type="hidden" name="url" value="/vehicle/electric/anaylse_search_result.jsp" />
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
