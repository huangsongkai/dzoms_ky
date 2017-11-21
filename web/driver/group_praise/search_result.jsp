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
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.driver.praise.GroupPraise&ids[0].id="+selected_val+"&ids[0].isString=false"+"&url=%2fdriver%2fgroup_praise%2fgroup_praise_show.jsp";
		window.open(url,"查看明细",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/insurance/insurancePreupdate?insurance.id="+selected_val;
		window.open(url,"保险修改",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _toExcel(){
		var path = $("[name='vehicleSele']").attr("action");
		var target = $("[name='vehicleSele']").attr("target");
		
		var url = "/DZOMS/driver/driverToExcel";
		$("[name='vehicleSele']").attr("action",url).attr("target","_blank").submit();
	}
	
	function _toPrint(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/driver/driverPreprint?driver.idNum="+selected_val;
		window.open(url,"驾驶员打印",'width=800,height=600,resizable=yes,scrollbars=yes');
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
<div>
   <div class="panel  margin-small" >
          	<div class="panel-head">
          	<div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div class="xm4 xm6-move">
          	        		       	<div class="button-toolbar">
	                                   <div class="button-group">
	                                     	<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		查看</button>
	                                    	<!--<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
		                                    <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出</button>
			                                  <button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
			                                                            打印</button>-->
                                     </div>
                                </div>
          	        	</div>
          	        </div>
          		
          	</div>
     
        <div class="panel-body">
            <table class="table table-bordered table-hover table-striped">

                <tr>
                    <th>选择</th>
                   <th class="praiseTime 	selected_able">表扬时间		</th>
<th class="praiseClass	selected_able">表扬类型(第一级)		</th>
<th class="praiseClass	selected_able">表扬类型(第二级)		</th>
<th class="praiseClass	selected_able">表扬类型(第三级)		</th>
<th class="praiseClass	selected_able">表扬类型(第四级)		</th>
<th class="praiseGrade  selected_able">分值			</th>
<th class="praiseNumber	selected_able">参与人数		</th>
<th class="registrant	selected_able">录入人		</th>
                </tr>
               <s:if test="%{#request.list!=null&&#request.list.size()!=0}">  
        <s:iterator value="%{#request.list}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.id}'/>" ></td>
							
							<td class="praiseTime selected_able"><s:property value="%{#v.praiseTime}"/></td>
<td class="praiseClass selected_able"><s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(#v.praiseClass,'praiseClass1')}"/></td>
<td class="praiseClass selected_able"><s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(#v.praiseClass,'praiseClass2')}"/></td>
<td class="praiseClass selected_able"><s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(#v.praiseClass,'praiseClass3')}"/></td>
<td class="praiseClass selected_able"><s:property value="%{@com.dz.common.tablelist.TableListService@getValueOfJson(#v.praiseClass,'praiseClass4')}"/></td>
<td class="praiseGrade selected_able"><s:property value="%{#v.grade}"/></td>
<td class="praiseNumber selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@execute('select count(*) from GroupPraiseDriver where groupPraiseId='+#v.id)}"/></td>
<td class="registrant selected_able"><s:property value="#v.registrant"/></td>
                        </tr>
                    </s:iterator>
</s:if>
            </table>
         <s:if test="%{#request.list!=null&&#request.list.size()!=0}">
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
   <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
			
			<label class="button active"><input type="checkbox" name="sbx" value="praiseTime" checked="checked"><span class="icon icon-check text-green"></span>表扬时间</label>
<label class="button active"><input type="checkbox" name="sbx" value="praiseClass" checked="checked"><span class="icon icon-check text-green"></span>表扬类型</label>
<label class="button active"><input type="checkbox" name="sbx" value="praiseGrade" checked="checked"><span class="icon icon-check text-green"></span>分值</label>
<label class="button active"><input type="checkbox" name="sbx" value="praiseNumber" checked="checked"><span class="icon icon-check text-green"></span>参与人数</label>
<label class="button active"><input type="checkbox" name="sbx" value="registrant" checked="checked"><span class="icon icon-check text-green"></span>录入人</label>

            </div>

        </div>

    </div>
   	
   </div>
  
<form action="/DZOMS/driver/group_praise/searchGroupPraise" method="post" name="vehicleSele">
    <s:hidden name="beginDate" />
    <s:hidden name="endDate" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>


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
</html>
