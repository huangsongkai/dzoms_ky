<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.dz.module.charge.*" %>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>测试</title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
  <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <script>
    //    $(document).ready(function(){
    //      $.post("/DZOMS/charge/getCurrentMonth",{},function(data){
    //        $("#currentMonth").html(data);
    //      });
    //    });
  </script>
    <script>
      $(document).ready(function(){
        $.post("/DZOMS/charge/getCurrentTime",{"department":"一部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth1").html("<strong>"+"一部:"+"</strong>"+data["ItemTool"]);
        });
        $.post("/DZOMS/charge/getCurrentTime",{"department":"二部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth2").html("<strong>"+"二部:"+"</strong>"+data["ItemTool"]);
        });
        $.post("/DZOMS/charge/getCurrentTime",{"department":"三部"},function(data){
        	data = $.parseJSON(data);
          $("#currentMonth3").html("<strong>"+"三部:"+"</strong>"+data["ItemTool"]);
        });
      });
      
      $(document).ready(function(){
      	$("#rawTh tr:eq(0) td").each(function(index){
      		$("#newTh th").eq(index).width($(this).width());
      	})
    	//$("#rawTh").hide();
      });
  </script>
</head>
<body>
<%--<div>当前待结算年月：</div>--%>
<%--<div id="currentMonth"></div>--%>
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>收费统计</li>
    </ul>
</div>
<div class="line padding">
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth1"></span></div>
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth2"></span></div>
<div class="alert xm4"><strong>清账时间：</strong><span id="currentMonth3"></span></div>
</div>
<div class="line">
	<form style="width: 100%;" method="post" id="form" action="/DZOMS/charge/tongji" class="form-inline">
  <div class="panel margin-small" >
          	<div class="panel-head">
          		查询条件
          		
          	</div>
          	<div class="panel-body">
      <div class="form-group">
        <div class="label padding">
          <label>
            部门：
          </label>
        </div>
        <div class="field">
          <s:select name="department" cssClass="input" list="#{'全部':'全部','一部':'一部','二部':'二部','三部':'三部'}" value="%{department}">
          </s:select>
        </div>
      </div>

      <div class="form-group">
        <div class="label padding">
          <label>
            状态：
          </label>
        </div>
        <div class="field">
          <s:select name="status" cssClass="input" list="#{0:'欠费',1:'正常',2:'未交',3:'已交',4:'全部'}" value="%{status}">
          </s:select>
        </div>
      </div>

      <div class="form-group">
        <div class="label padding">
          <label>
            车牌号
          </label>
        </div>
        <div class="field">
          <s:textfield cssClass="input" name="licenseNum" value="%{licenseNum}"/>
        </div>
      </div>

      <div class="form-group">
        <div class="label padding">
          <label>
            请输入年月
          </label>
        </div>
        <div class="field"><s:textfield cssClass="input datetimepicker"  name="time" value="%{time}"/></div>
      </div>
      <input type="submit" value="查询" class="button bg-green"/>
    </div>
  </div>
</form>
</div>
<%List<CheckChargeTable> tables = (List<CheckChargeTable>)request.getAttribute("tables");%>
<div class="line"><div class="xm4 xm4-move">共<%=tables.size() %>条数据。 </div></div>

<div class="line" style="width: 100%;">
	<div class="panel margin-small" >
          	<div class="panel-head">
          		查询结果
          	</div>
          	<div class="panel-body">
<div class="line" style="width: 100%;">
<table class="table table-bordered table-hover table-striped" >
    <tr id="newTh">
    	<th>序号</th>
      <th>车牌号</th>
      <th>司机</th>
      <th>部门</th>
      <th>计划总额</th>
      <th>现金收入</th>
      <th>银行收入</th>
      <th>油补转入</th>
      <th>保险转入</th>
      <th>其它收入</th>
      <th>收入合计</th>
      <th>本月欠款</th>
      <th>上月累欠</th>
      <th>本月存款</th>
      <th>本月累欠</th>
    </tr>
    </table>
</div>

  <div class="line" style="width: 100%;height:540px; overflow:auto">
  <table id="rawTh" class="table table-bordered table-hover table-striped" >
    <!--<tr >
      <th>车牌号</th>
      <th>司机</th>
      <th>部门</th>
      <th>计划总额</th>
      <th>现金收入</th>
      <th>银行收入</th>
      <th>油补转入</th>
      <th>保险转入</th>
      <th>收入合计</th>
      <th>本月欠款</th>
      <th>上月累欠</th>
      <th>本月存款</th>
      <th>本月累欠</th>
    </tr>-->
    
    <%BigDecimal bd1 = new BigDecimal(0.00);%>
    <%BigDecimal bd2 = new BigDecimal(0.00);%>
    <%BigDecimal bd3 = new BigDecimal(0.00);%>
    <%BigDecimal bd4 = new BigDecimal(0.00);%>
    <%BigDecimal bd5 = new BigDecimal(0.00);%>
     <%BigDecimal bd_other = new BigDecimal(0.00);%>
    <%BigDecimal bd6 = new BigDecimal(0.00);%>
    <%BigDecimal bd7 = new BigDecimal(0.00);%>
    <%BigDecimal bd8 = new BigDecimal(0.00);%>
    <%BigDecimal bd9 = new BigDecimal(0.00);%>
    <%BigDecimal bd10 = new BigDecimal(0.00);%>
    <%//Date currentClearTime = (Date)request.getAttribute("currentClearTime");
      //ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
      //ChargeService csv = ctx.getBean(ChargeService.class);
      int index=1;
     %>
    <%for(CheckChargeTable record:tables){
    	//获取余额
    	//record.generated(record.getLastMonthOwe());
    	/*
    	if(record.getContractId()!=0){
    	
    	BigDecimal lastMonthOwe = csv.getlastMontAccountLeft(record.getContractId(), currentClearTime);
    	record.generated(lastMonthOwe);
    	}else{
    	record.generated(BigDecimal.ZERO);
    	}
    	*/
    	//request.setAttribute("r", record);
    %>
   <tr>
   		<td><%=index++%></td>
      <td><%=record.getCarNumber()%></td>
      <td><%=record.getDriverName()%></td>
      <td><%=record.getDept()%></td>
      <td><%=record.getPlanAll()%></td>
      <%bd1 = bd1.add(record.getPlanAll());%>
      <td><%=record.getCash()%></td>
      <%bd2 = bd2.add(record.getCash());%>
      <td><%=record.getBank()%></td>
      <%bd3 = bd3.add(record.getBank());%>
      <td><%=record.getOilAdd()%></td>
      <%bd4 = bd4.add(record.getOilAdd());%>
      <td><%=record.getInsurance()%></td>
      <%bd5 = bd5.add(record.getInsurance());%>
      <td><%=record.getOther()%></td>
      <%bd_other = bd_other.add(record.getOther());%>
      <td><%=record.getTotal()%></td>
      <%bd6 = bd6.add(record.getTotal());%>
      <td><%=record.getThisMonthOwe()%></td>
      <%bd7 = bd7.add(record.getThisMonthOwe());%>
      <td><%=record.getLastMonthOwe()%></td>
      <%bd8 = bd8.add(record.getLastMonthOwe());%>
      <td><%=record.getThisMonthLeft()%></td>
      <%bd9 = bd9.add(record.getThisMonthLeft());%>
      <td><%=record.getThisMonthTotalOwe()%></td>
      <%bd10 = bd10.add(record.getThisMonthTotalOwe());%>
    </tr>
    <%}%>
    <tr>
      <th>合计</th>
      <th>-</th>
      <th>-</th>
      <th>-</th>
      <th><%=bd1%></th>
      <th><%=bd2%></th>
      <th><%=bd3%></th>
      <th><%=bd4%></th>
      <th><%=bd5%></th>
      <th><%=bd_other%></th>
      <th><%=bd6%></th>
      <th><%=bd7%></th>
      <th><%=bd8%></th>
      <th><%=bd9%></th>
      <th><%=bd10%></th>
    </tr>
  </table>
  </div>
    

          		
          	</div>
    </div>
	
</div>


</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>

<script>
   $('.datetimepicker').simpleCanleder();
</script>

</html>
