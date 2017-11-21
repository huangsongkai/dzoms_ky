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
	
	/*function _detail(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/driver/praise/driverPreshow?driver.idNum="+selected_val;
		window.open(url,"驾驶员明细",'width=800,height=600,resizable=yes,scrollbars=yes');
	}*/
	
	function _deal(){
		var selected_val = $("input[name='cbx']:checked").val();
		if(selected_val==undefined){
			alert('您没有选择任何一条数据');
			return ;
		}
		
		var url = "/DZOMS/driver/praise/predealPraise.action?praise.id="+selected_val;
		window.parent.location = url;
		//window.open(url,"表扬落实",'width=800,height=600,resizable=yes,scrollbars=yes');
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
	                                     <!--	<button onclick="_detail()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		查看</button>-->
	                               				<button onclick="_deal()" type="button" class="button icon-search text-blue" style="line-height: 6px;">
	                               		落实</button>
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
<th class="praiseTime  		selected_able">表扬日期                    </th>
<th class="praiseClass  	selected_able">表扬类别                    </th>
<th class="praiseFromOther  	selected_able">表扬来源                    </th>
<th class="praiseContext  	selected_able">表扬原因                    </th>
<th class="registrant  		selected_able">登记人	                   </th>
<th class="registTime  		selected_able">登记日期                    </th>
<th class="alreadyDeal 		selected_able">是否落实                    </th>
<th class="dealPerson  		selected_able">落实人	                   </th>
<th class="dealTime    		selected_able">落实时间                    </th>
                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value="%{#v.id}"/>" ></td>
<td class="praiseTime selected_able"><s:property value="%{#v.praiseTime}"/></td>
<td class="praiseClass selected_able"><s:property value="%{@com.dz.common.tablelist.TableListService@getFathersValueString(#v.praiseClass)}"/></td>
<td class="praiseFromOther selected_able"><s:property value="%{#v.praiseFromOther}"/></td>
<td class="praiseContext selected_able"><s:property value="%{#v.praiseContext}"/></td>
<td class="registrant selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.registrant).uname}"/></td>
<td class="registTime selected_able"><s:property value="%{#v.registTime}"/></td>
<td class="alreadyDeal selected_able"><s:property value="%{#v.alreadyDeal?'已落实 ':'未落实 '}"/></td>
<td class="dealPerson selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.dealPerson).uname}"/></td>
<td class="dealTime selected_able"><s:property value="%{#v.dealTime}"/></td>
                        </tr>
                    </s:iterator>

            </table>
            <div>

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
                </table>无查询结果
            </s:else>
        </div>
     </div>
  </div>
    <div class="line">
   	<div class="panel  margin-small" >
          	<div class="panel-head">
          	显示项
          		</div>
          		
          		
          		
         
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
              <label class="button active"><input type="checkbox" name="sbx" value="praiseTime" checked="checked"><span class="icon icon-check text-green"></span>表扬日期</label>
<label class="button active"><input type="checkbox" name="sbx" value="praiseClass" checked="checked"><span class="icon icon-check text-green"></span>表扬类别</label>
<label class="button active"><input type="checkbox" name="sbx" value="praiseFromOther" checked="checked"><span class="icon icon-check text-green"></span>表扬类别</label>
<label class="button active"><input type="checkbox" name="sbx" value="praiseContext" checked="checked"><span class="icon icon-check text-green"></span>表扬原因</label>
<label class="button active"><input type="checkbox" name="sbx" value="registrant" checked="checked"><span class="icon icon-check text-green"></span>登记人</label>
<label class="button active"><input type="checkbox" name="sbx" value="registTime" checked="checked"><span class="icon icon-check text-green"></span>登记日期</label>
<label class="button active"><input type="checkbox" name="sbx" value="alreadyDeal" checked="checked"><span class="icon icon-check text-green"></span>是否落实</label>
<label class="button active"><input type="checkbox" name="sbx" value="dealPerson" checked="checked"><span class="icon icon-check text-green"></span>落实人</label>
<label class="button active"><input type="checkbox" name="sbx" value="dealTime" checked="checked"><span class="icon icon-check text-green"></span>落实时间</label>
            </div>

        </div>

    </div>



<form action="/DZOMS/driver/praise/searchPraise" method="post" name="vehicleSele">
    <s:hidden name="beginDate" />
    <s:hidden name="endDate" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>

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
</html>
