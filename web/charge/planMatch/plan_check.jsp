<%@ page import="com.dz.common.factory.HibernateSessionFactory" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="org.apache.commons.lang3.math.NumberUtils" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.dz.module.charge.MonthPlan" %>
<%@ page import="com.dz.module.charge.IncomeDivide" %>
<%@ page import="com.dz.module.vehicle.Vehicle" %>
<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="com.dz.module.contract.Contract" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    static int toInt(String text){
        try {
            return NumberUtils.createInteger(text);
        }catch (NumberFormatException|NullPointerException ex){
            return 0;
        }
    }

    static String nullIf(String text){
        return StringUtils.isBlank(text)?"":text;
    }

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
	
	static void repairOne(Session hsession, int repairId){
		Transaction tx = null;
		try {
		  tx = hsession.beginTransaction();
		  ChargePlan cp = (ChargePlan)hsession.get(ChargePlan.class,repairId);
		  Query query = hsession.createQuery("from IncomeDivide where incomeId=:incomeId");
		  query.setInteger("incomeId",cp.getId());
		  List<IncomeDivide> divs = query.list();
		  
		  BigDecimal sum1 = BigDecimal.ZERO;
		  for( IncomeDivide div : divs ){
			  sum1 = sum1.add(div.getAmount());
		  }
		  
		  if(cp.getFee().compareTo(sum1)>=0){
			cp.setBalance(cp.getFee().subtract(sum1));
			hsession.update(cp);
		  }
		  else{
			BigDecimal resolve = sum1.subtract(cp.getFee());
			for(IncomeDivide div : divs){
			  if(resolve.compareTo(div.getAmount())==0){
				  MonthPlan mp = (MonthPlan)hsession.get(MonthPlan.class,div.getMonthPlanId());
				  mp.setArrear(mp.getArrear().add(div.getAmount()));
				  hsession.update(mp);
				  hsession.delete(div);
				  resolve = BigDecimal.ZERO;
				  break;
			  }
			}
			
			Collections.reverse(divs);
			for(IncomeDivide div : divs){
			  MonthPlan mp = (MonthPlan)hsession.get(MonthPlan.class,div.getMonthPlanId());
			  if(resolve.compareTo(div.getAmount())>=0){  
				  mp.setArrear(mp.getArrear().add(div.getAmount()));
				  resolve = resolve.subtract(div.getAmount());
				  hsession.update(mp);
				  hsession.delete(div);
			  }else{
				  div.setAmount(div.getAmount().subtract(resolve));
				  mp.setArrear(mp.getArrear().add(resolve));
				  hsession.update(mp);
				  hsession.delete(div);
				  resolve = BigDecimal.ZERO;
				  break;
			  }
			}
			
			cp.setBalance(BigDecimal.ZERO);
			hsession.update(cp);
		  }
		  
		  tx.commit();
		} catch (Exception ex) {
		  if (tx != null)
			tx.rollback(); 
		  ex.printStackTrace();
		} 
	}
	
	static void repairOneMonth(Session hsession, int repairId){
		Transaction tx = null;
		try {
		  tx = hsession.beginTransaction();
		  MonthPlan mp = (MonthPlan)hsession.get(MonthPlan.class,repairId);
		  Query query = hsession.createQuery("from IncomeDivide where monthPlanId=:monthPlanId and type=0");
		  query.setInteger("monthPlanId",mp.getId());
		  List<IncomeDivide> divs = query.list();
		  
		  BigDecimal sum1 = BigDecimal.ZERO;
		  for( IncomeDivide div : divs ){
			  sum1 = sum1.add(div.getAmount());
		  }
		  
		  if(mp.getPlanAll().compareTo(sum1)>=0){
			mp.setArrear(mp.getPlanAll().subtract(sum1));
			hsession.update(mp);
		  }
		  else{
			BigDecimal resolve = sum1.subtract(mp.getPlanAll());
			for(IncomeDivide div : divs){
			  if(resolve.compareTo(div.getAmount())==0){
				  ChargePlan cp = (ChargePlan)hsession.get(ChargePlan.class,div.getIncomeId());
				  cp.setBalance(cp.getBalance().add(div.getAmount()));
				  hsession.update(cp);
				  hsession.delete(div);
				  resolve = BigDecimal.ZERO;
				  break;
			  }
			}
			
			Collections.reverse(divs);
			for(IncomeDivide div : divs){
				ChargePlan cp = (ChargePlan)hsession.get(ChargePlan.class,div.getIncomeId());
				if(resolve.compareTo(div.getAmount())>=0){  
					cp.setBalance(cp.getBalance().add(div.getAmount()));
					resolve = resolve.subtract(div.getAmount());
					hsession.update(cp);
					hsession.delete(div);
				}else{
					div.setAmount(div.getAmount().subtract(resolve));
					cp.setBalance(cp.getBalance().add(resolve));
					hsession.update(cp);
					hsession.delete(div);
					resolve = BigDecimal.ZERO;
					break;
				}
			}
			
			mp.setArrear(BigDecimal.ZERO);
			hsession.update(mp);
		  }
		  
		  tx.commit();
		} catch (Exception ex) {
		  if (tx != null)
			tx.rollback(); 
		  ex.printStackTrace();
		} 
	}
	
	static void repairAllError(Session hsession){
		Query query = hsession.createSQLQuery(queryString);
		List<Object[]> plans = query.list();
		for(Object[] row : plans){
			int id = ((Number)row[0]).intValue();
			repairOne(hsession,id);
		}
		Query query2 = hsession.createSQLQuery(queryString2);
		List<Object[]> monthPlans = query2.list();
		for(Object[] row : monthPlans){
			int id = ((Number)row[0]).intValue();
			repairOneMonth(hsession,id);
		}
	}
	
	static String queryString = "SELECT\n" +
                "id,\n" +
                "fee_type,\n" +
                "time,\n" +
                "fee,\n" +
                "balance,\n" +
                "(case when  outcome is null THEN 0 ELSE  outcome end)\n" +
                "FROM\n" +
                "(SELECT\n" +
                "id,\n" +
                "fee_type,\n" +
                "time,\n" +
                "fee,\n" +
                "balance,\n" +
                "(SELECT SUM(amount) FROM income_divide WHERE income_id=cp.id) AS outcome\n" +
                "FROM\n" +
                "charge_plan cp\n" +
                "WHERE cp.is_disabled=0\n" +
                ") as temp\n" +
                "WHERE \n" +
                "temp.fee_type LIKE 'add%' \n" +
                "AND temp.fee- (case when  outcome is null THEN 0 ELSE  outcome end) != temp.balance";
				
	static String queryString2 ="SELECT\n" +
                "id,\n" +
                "plan_all,\n" +
                "arrear,\n" +
                "(case when income is null THEN 0 ELSE income end)\n" +
                "FROM\n" +
                "(SELECT\n" +
                "mp.id as id,\n" +
                "mp.carframe_num as car_num,\n" +
                "mp.time as time,\n" +
                "mp.plan_all as plan_all,\n" +
                "mp.arrear as arrear,\n" +
                "(SELECT SUM(dv.amount) FROM income_divide dv WHERE dv.month_plan_id=mp.id AND dv.type=0) as income\n" +
                "FROM\n" +
                "month_plan mp\n" +
                ") as temp1\n" +
                "WHERE plan_all-(case when income is null THEN 0 ELSE income end)!=arrear";
%>
<%
    String repair = request.getParameter("repair");
    String repairType = request.getParameter("repairType");
	boolean repairAll = "all".equalsIgnoreCase(repairType);
	int repairId = toInt(repair);
	
	Session hsession = HibernateSessionFactory.getSession();
	if(repairAll){
		repairAllError(hsession);
	}
	else if(repairId>0){
		if("ChargePlan".equalsIgnoreCase(repairType)){
			repairOne(hsession,repairId);
		}
		else{
			repairOneMonth(hsession,repairId);
		}
	}
    
    Query query = hsession.createSQLQuery(queryString);
    List<Object[]> plans = query.list();
	
	Query query2 = hsession.createSQLQuery(queryString2);
    List<Object[]> monthPlans = query2.list();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>收入分配纠错</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
    <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>

    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/admin.js"></script>

    <script>
        $(document).ready(function(){
            $("#rawTh tr:eq(0) td").each(function(index){
                $("#newTh th").eq(index).width($(this).width());
            });
        });

        function showIncomeDetails(incomeId) {
            window.open("match_show_income_detail.jsp?incomeId="+incomeId,"_blank")
        }
		
		function showDetails(carnum) {
            window.open("match_show_detail.jsp?showAll=yes&carNum="+carnum,"_blank")
        }
		
		function showMonthPlanDetails(monthPlanId) {
			window.open("match_show_monthplan_detail.jsp?monthPlanId="+monthPlanId,"_blank")
		}

        function singleRepair(planId) {
            if (confirm('确认修复该项收款数据？')){
				$('#repairType').val("ChargePlan");
				$('#repair').val(planId);
				$('#form').submit();
			}
        }
		
		function singleRepairMonthPlan(mpId){
			if (confirm('确认修复该项月计划数据？')){
				$('#repairType').val("MonthPlan");
				$('#repair').val(mpId);
				$('#form').submit();
			}
		}

        function defaultAssign() {
            if (confirm('确认修复全部错误数据？')){
				$('#repairType').val("all");
				$('#form').submit();
			}
        }

        function chooseAll() {
            $('input[name="income_choose"]').prop('checked',true);
        }

        function deChooseAll() {
            $('input[name="income_choose"]').prop('checked',false);
        }

        function reverseChoose() {
            $('input[name="income_choose"]').each(function () {
                $(this).prop('checked',!$(this).prop('checked'));
            });
        }
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>财务管理</li>
            <li>收入分配纠错</li>
        </ul>
    </div>
</div>
<div class="line">
    <form id="form" action="#" class="form-inline form-tips" style="width: 100%;">
        <input type="hidden" name="repair" id="repair" value="">
        <input type="hidden" name="repairType" id="repairType" value="">
	</form>
        <div class="panel  margin-small" >
            <div class="panel-body">
                <input type="button" value="全部修复" class="button bg-green" onclick="defaultAssign()"/>
            </div>
        </div>
</div>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>收入数据出错</strong>
             <%if(plans!=null){%>
				 <p>当前共<%=plans.size()%>条错误数据</p>
			 <%}else{%>
				<p>当前无错误数据！</p>
			 <%}%>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr id="newTh">
                        <th>收款ID</th>
                        <th>部门</th>
                        <th>车牌号</th>
                        <th>收款类型</th>
						<th>收款月份</th>
                        <th>收款数额</th>
                        <th>分配金额</th>
                        <th>收款余额(异常)</th>
                        <th>操作时间</th>
                        <th>操作1</th>
                        <th>操作2</th>
                        <th>操作3</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:300px; overflow:auto">
                <table  id="rawTh" class="table table-bordered table-hover">
                    <%if(plans!=null)
                        for(Object[] record:plans){
							int id = ((Number)record[0]).intValue();
							ChargePlan cp = (ChargePlan)hsession.get(ChargePlan.class,id);
							double outcome = ((Number) record[5]).doubleValue();
							Contract c = (Contract)hsession.get(Contract.class,cp.getContractId());
                            String dept = c.getBranchFirm();
                            String car_num = c.getCarNum();
                            String carframe_num = c.getCarframeNum();
                    %>
                    <tr>
                        <td><%=cp.getId()%></td>
                        <td><%=dept%></td>
                        <td><%=car_num%></td>
                        <td><%=cp.getFeeType()%></td>                     
                        <td><%=cp.getTime()%></td>                     
                        <td><%=cp.getFee()%></td>                     
                        <td><%=outcome%></td>                     
                        <td><%=cp.getBalance()%></td>                     
                        <td><%=cp.getInTime()%></td>  
						<td><button onclick="showIncomeDetails(<%=cp.getId()%>)">查看收费详情</button></td>  						
						<td><button onclick="showDetails('<%=carframe_num%>')">查看车辆详情</button></td>  						
						<td><button onclick="singleRepair(<%=cp.getId()%>)">单独修复</button></td>  						
                    </tr>
                    <%}%>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
<div class="line">
    <div class="panel">
        <div class="panel-head">
            <strong>月计划数据出错</strong>
             <%if(monthPlans!=null){%>
				 <p>当前共<%=monthPlans.size()%>条错误数据</p>
			 <%}else{%>
				<p>当前无错误数据！</p>
			 <%}%>
        </div>
        <div class="panel-body">
            <div class="line" style="width: 100%;">
                <table class="table table-bordered table-hover table-striped" >
                    <tr id="newTh">
                        <th>月计划ID</th>
                        <th>部门</th>
                        <th>车牌号</th>
						<th>月份</th>
                        <th>计划总额</th>
                        <th>分配金额</th>
                        <th>计划余额(异常)</th>
                        <th>操作1</th>
                        <th>操作2</th>
                        <th>操作3</th>
                    </tr>
                </table>
            </div>
            <div class="line" style="width: 100%;height:300px; overflow:auto">
                <table  id="rawTh" class="table table-bordered table-hover">
                    <%if(monthPlans!=null)
                        for(Object[] record:monthPlans){
							int id = ((Number)record[0]).intValue();
							MonthPlan mp = (MonthPlan)hsession.get(MonthPlan.class,id);
							double outcome = ((Number) record[3]).doubleValue();
							Vehicle v = (Vehicle)hsession.get(Vehicle.class,mp.getCarframeNum());
                            String dept = v.getDept();
                            String car_num = v.getLicenseNum();
                            String carframe_num = v.getCarframeNum();
                    %>
                    <tr>
                        <td><%=mp.getId()%></td>
                        <td><%=dept%></td>
                        <td><%=car_num%></td>
                        <td><%=mp.getTime()%></td>                     
                        <td><%=mp.getPlanAll()%></td>                     
                        <td><%=outcome%></td>                     
                        <td><%=mp.getArrear()%></td>                     
						<td><button onclick="showMonthPlanDetails(<%=mp.getId()%>)">查看月计划详情</button></td>  						
						<td><button onclick="showDetails('<%=carframe_num%>')">查看车辆详情</button></td>  						
						<td><button onclick="singleRepairMonthPlan(<%=mp.getId()%>)">单独修复</button></td>  						
                    </tr>
                    <%}%>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>