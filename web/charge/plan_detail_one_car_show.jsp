<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-22
  Time: 下午12:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dz.module.charge.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script>
    	var isShow=true;
    function tiggerPlans(){
    	if (isShow) {
    		$("tr.pay").hide();
    	} else{
    		$("tr.pay").show();
    	}
    	
    	isShow = ! isShow;
    }
    
    $(document).ready(function(){
    	tiggerPlans();
    });
    </script>
      <style>
  .plan{
  background-color:yellow
  }
  
  .pay{
  background-color:Chartreuse
  }
  </style>
</head>
<body>
	<div class="panel bg-white" style="height:600px; overflow:auto">
		<div class="panel-head">
			查询结果<input type="button" class="button" onclick="tiggerPlans()" value="显示/隐藏收入详情"></input>
		</div>
		<div class="panel-body">
			<%--<table class="table table-bordered table-striped">
        <tr>
            <td>车牌号</td>
            <td>司机</td>
            <td>部门</td>
            <td>时间</td>
            <td>合同费用</td>
            <td>保险变更</td>
            <td>其他变更</td>
            <td>计划总额</td>
        </tr>
        <s:iterator value="%{#request.table}" var="xx">
        <tr>
            <td><s:property value="%{#xx.carNumber}"/></td>
            <td><s:property value="%{#xx.driverName}"/></td>
            <td><s:property value="%{#xx.dept}"/></td>
            <td><s:property value="%{#xx.time}"/> </td>
            <td><s:property value="%{#xx.heton}"/></td>
            <td><s:property value="%{#xx.baoxian}"/></td>
            <td><s:property value="%{#xx.other}"/></td>
            <td><s:property value="%{#xx.total}"/></td>
        </tr>
        </s:iterator>
        </table>
        
        --%>
        <div>
        	<%List<PlanDetail> tables = (List<PlanDetail>)request.getAttribute("table");%>
           	<%for(PlanDetail record:tables){%>
           		<div>
           		<%Calendar cal = Calendar.getInstance();cal.setTime(record.getTime());%>
           			<p><h2><%=cal.get(Calendar.YEAR)+"年"+(cal.get(Calendar.MONTH)+1)+"月"%></h2></p>
           			<table class="table table-bordered table-responsive">
           				<tr>
           							<th>部门</th>
                    		<th>车牌号</th>
                    		<th>司机</th>
                    		<th>身份证</th>
                    		<th>类型</th>
                    		<th>数额</th>
                    		<th>状态</th>
                		</tr>
                		<%for(ChargePlan plan : record.getPlans()){ %>
                		<%boolean isSub = false;boolean isPlan = true;//计划为黄色 收入为蓝色
                		  String chargeType=null;
                				switch(plan.getFeeType()){
                				 case "plan_base_contract":
                				 	chargeType=("合同费用");
                				 	break;
                				 case "plan_add_insurance":
                				 	chargeType=("保费调整");
                				 	break;
                				 case "plan_sub_insurance":
                				 	chargeType=("保费调整");
                				 	isSub = true;
                				 	break;
                				 case "plan_add_contract":
                				 	chargeType=("合同费用调整");
                				 	break;
                				 case "plan_sub_contract":
                				 	chargeType=("合同费用调整");
                				 	isSub = true;
                				 	break;
                				 case "plan_add_other":
                				 	chargeType=("其它费用调整");
                				 	break;
                				 case "plan_sub_other":
                				 	chargeType=("其它费用调整");
                				 	isSub = true;
                				 	break;
                				 case "add_bank":
                				 	chargeType=("哈尔滨银行回款");
                				 	isPlan = false;
                				 	break;
                				 	case "add_bank2":
                				 	chargeType=("招商银行回款");
                				 	isPlan = false;
                				 	break;
                				 case "add_cash":
                				 	chargeType=("现金回款");
                				 	isPlan = false;
                				 	break;
                				 case "add_oil":
                				 	chargeType=("油补回款");
                				 	isPlan = false;
                				 	break;
                				 case "add_insurance":
                				 	chargeType=("保险转入");
                				 	isPlan = false;
                				 	break;
                				 case "add_other":
                				 	chargeType=("其它回款");
                				 	isPlan = false;
                				 	break;
                				 case "sub_oil":
                				 	chargeType=("油补取款");
                				 	isPlan = false;
                				 	isSub = true;
                				 	break;
                				 case "sub_insurance":
                				 	chargeType=("保险取款");
                				 	isPlan = false;
                				 	isSub = true;
                				 	break;
                				}
                			
                			if(chargeType==null)
                				continue;
                			 %>
                		<tr class="<%=isPlan?"plan":"pay"%>" >
                			<td><%=record.getDept()%></td>
                			<td><%=record.getCarNumber()%></td>
                    		<td><%=record.getDriverName()%></td>
                    		<td><%=record.getDriverId()%></td>
                			<td><%=chargeType %></td>
                			<td><%=isSub?plan.getFee().negate():plan.getFee() %></td>
                			<td><%=plan.getIsClear()?"已结算":"未结算"%></td>
                		</tr>
                		<%} %>
                		
                		<tr>
                			<td>合计：</td>
                			<td>&nbsp;</td>
                			<td>&nbsp;</td>
                			<td>&nbsp;</td>
                			<td>&nbsp;</td>
                			<td><%=record.getTotal()%></td>
                			<td>&nbsp;</td>
                		</tr>
           			</table>
           		</div>
           	<%}%>
           </div>
    
  
  
		</div>
	</div>
    
</body>
</html>
