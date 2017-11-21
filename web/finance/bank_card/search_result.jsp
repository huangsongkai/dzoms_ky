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
		var driverId = $("input[name='cbx']:checked").attr("driverId");
		if(selected_val==undefined){
			alert('您没有选择任何一条数据');
			return;
		}
		var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id="+selected_val+"&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id="+driverId+"&url=%2ffinance%2fbank_card%2fcard_show.jsp";
		window.open(url,"银行卡信息",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		var driverId = $("input[name='cbx']:checked").attr("driverId");
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id="+selected_val+"&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id="+driverId+"&url=%2ffinance%2fbank_card%2fcard_update.jsp";
		window.open(url,"银行卡信息修改",'width=800,height=600,resizable=yes,scrollbars=yes');
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
	
	function _detail(){
		var selected_val = $("input[name='cbx']:checked").val();
		var driverId = $("input[name='cbx']:checked").attr("driverId");
		if(selected_val==undefined){
			alert('您没有选择任何一条数据');
			return;
		}
		var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id="+selected_val+"&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id="+driverId+"&url=%2ffinance%2fbank_card%2fcard_show.jsp";
		window.open(url,"银行卡信息",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
	
	function _update(){
		var selected_val = $("input[name='cbx']:checked").val();
		var driverId = $("input[name='cbx']:checked").attr("driverId");
		if(selected_val==undefined)
		alert('您没有选择任何一条数据');
		var url = "/DZOMS/common/getObj?ids[0].className=com.dz.module.contract.BankCard&ids[0].id="+selected_val+"&ids[0].isString=false&ids[1].className=com.dz.module.driver.Driver&ids[1].isString=true&ids[1].id="+driverId+"&url=%2ffinance%2fbank_card%2fcard_update.jsp";
		window.open(url,"银行卡信息修改",'width=800,height=600,resizable=yes,scrollbars=yes');
	}
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
	                               		<s:if test="#session.roles.{?#this.rname=='银行卡修改权限'}.size>0"> 
	                                    	<button onclick="_update()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			                                                            修改</button>
			                              </s:if>
		                                    <button onclick="_toExcel()" type="button" class="button icon-file-excel-o text-blue" style="line-height: 6px;">
			                                                            导出</button>
			                                  <button  onclick="_toPrint()" type="button" class="button icon-print text-green" style="line-height: 6px;">
			                                                            打印</button>
                                     </div>
                                </div>
          	        	</div>
          	        </div>
          	</div>
  
        <div class="panel-body">
        	<div class="tab">
		<div class="tab-head">
			<ul class="tab-nav">
				<li class="active">
					<a href="#tab-table">
						显示结果
					</a>
				</li>
				<li>
					<a href="#tab-div">
						自定义显示项
					</a>
				</li>
			</ul>
		</div>
		<div class="tab-body tab-body-bordered">
		
			<div class="tab-panel active" id="tab-table">
			    <table class="table table-hover table-bordered  table-striped">
               
                <tr>
                    <th>选择</th>
                  <th class="licenseNum  		selected_able">车牌号</th>
<th class="idName selected_able">姓名</th>
<th class="idNumber selected_able">身份证号码</th>
<th class="cardClass selected_able">银行卡类别</th>
<th class="cardNumber selected_able">银行卡号</th>
<!--<th class="isDefaultPay selected_able">是否为主支付卡</th>-->
<!--<th class="isDefaultRecive selected_able">是否为主回款卡</th>-->
<th class="operator selected_able">登记人</th>
<th class="opeTime selected_able">操作时间</th>    

                </tr>
                <s:if test="%{#request.list!=null}">

                    <s:iterator value="%{#request.list}" var="v">
                    	<s:set name="t_driver" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#v.idNumber)}"></s:set>
                    	<%
                    		request.setAttribute("quote","'");
                    	%>
                            <s:set name="t_vehicle" value="%{@com.dz.common.other.ObjectAccess@execute('from com.dz.module.vehicle.Vehicle where driverId='+#request.quote+#v.idNumber+#request.quote)}"></s:set>
                        <tr>
                            <td><input type="radio" name="cbx" value="<s:property value='%{#v.id}'/>" driverId="<s:property value="%{#v.idNumber}"/>" ></td>
                            
<td class="licenseNum selected_able"><s:property value='%{#t_vehicle.licenseNum}'/></td>
<td class="idName selected_able"><s:property value="%{#t_driver.name}"/></td>
<td class="idNumber selected_able"><s:property value="%{#v.idNumber}"/></td>
<td class="cardClass selected_able"><s:property value="%{#v.cardClass}"/></td>
<td class="cardNumber selected_able"><s:property value="%{#v.cardNumber}"/></td>
<!--<td class="isDefaultPay selected_able"><s:property value="%{#v.isDefaultPay?'是':'否'}"/></td>
<td class="isDefaultRecive selected_able"><s:property value="%{#v.isDefaultRecive?'是':'否'}"/></td>-->
<td class="operator selected_able"><s:property value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.user.User',#v.operator).uname}"/></td>
<td class="opeTime selected_able"><s:property value="%{#v.opeTime}"/></td>  
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
                    			<input class="input input-auto" size="4" value="1/<%=pg.getTotalPage()%>" id="page-input" data-validate="required:必填,number:只能填写数字,compare#<<%=pg.getTotalPage()%>:1-<%=pg.getTotalPage()%>之间">
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
			<div class="tab-panel" id="tab-div">
			   <div class="panel  margin-small" >
          	<div class="panel-head">
          		显示项	
          	</div>
        <div class="panel-body">
            <div class="button-group checkbox" id="show_div">
                <label class="button active"><input type="checkbox" name="sbx" value="licenseNum" checked="checked"><span class="icon icon-check text-green"></span>车牌号</label>
<label class="button active"><input type="checkbox" name="sbx" value="idName" checked="checked"><span class="icon icon-check text-green"></span>姓名</label>
<label class="button active"><input type="checkbox" name="sbx" value="idNumber" checked="checked"><span class="icon icon-check text-green"></span>身份证号码</label>
<label class="button active"><input type="checkbox" name="sbx" value="cardClass" checked="checked"><span class="icon icon-check text-green"></span>银行卡类别</label>
<label class="button active"><input type="checkbox" name="sbx" value="cardNumber" checked="checked"><span class="icon icon-check text-green"></span>银行卡号</label>
<!--<label class="button active"><input type="checkbox" name="sbx" value="isDefaultPay" checked="checked"><span class="icon icon-check text-green"></span>是否为主支付卡</label>
<label class="button active"><input type="checkbox" name="sbx" value="isDefaultRecive" checked="checked"><span class="icon icon-check text-green"></span>是否为主回款卡</label>-->
<label class="button active"><input type="checkbox" name="sbx" value="operator" checked="checked"><span class="icon icon-check text-green"></span>登记人</label>
<label class="button active"><input type="checkbox" name="sbx" value="opeTime" checked="checked"><span class="icon icon-check text-green"></span>操作时间</label>    

            </div>

        </div>

    </div>

			</div>
		</div>
	</div>
</div>
        
        </div>

    </div>
 


<form action="/DZOMS/BankCardSearch" method="post" name="vehicleSele">
    <s:hidden name="beginDate" />
    <s:hidden name="endDate" />
    <s:hidden name="bankCard.cardNumber" />
    <s:hidden name="bankCard.idNumber" />
    <s:hidden name="dept" />
    <s:hidden name="bankCard.carNum" />
    <s:hidden name="order" />
    <s:hidden name="rank" />
    <s:hidden name="currentPage" value="%{#request.page.currentPage}" id="currentPage"></s:hidden>
</form>


</body>

</html>