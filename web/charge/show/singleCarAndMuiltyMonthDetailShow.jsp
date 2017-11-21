<%@ page import="com.dz.module.charge.ChargePlan" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.collections.CollectionUtils" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.collections.ListUtils" %>
<%@ page import="org.apache.commons.collections.Transformer" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
</head>
<body>
    <%Map<Date,List<ChargePlan>> map = (Map<Date,List<ChargePlan>>)request.getAttribute("map");
        @SuppressWarnings("unchecked")
        List<Date> keys = (List<Date>)CollectionUtils.collect(map.keySet(), new Transformer() {
            @Override
            public Object transform(Object o) {
                return o;
            }
        });
        Collections.sort(keys);
    %>
    <%for(Date now:keys){%>
        <%SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm");%>
        <div><%=sdf.format(now)%></div>
        <%List<ChargePlan> plans = map.get(now);%>
        <div>
            <table class="table table-bordered table-hover table-striped">
                <tr>
                    <th>类型</th>
                    <th>金额</th>
                    <th>记录时间</th>
                    <th>记录人员</th>
                </tr>
                <%BigDecimal bd = new BigDecimal(0.00);%>
                <%for(ChargePlan plan:plans){%>
                <%String rawType = plan.getFeeType();
                  String feeType = null;
                  if(rawType.equals("plan_base_contract")){
                      feeType = "合同基本费用";
                      bd = bd.add(plan.getFee());
                  }else if(rawType.equals("plan_add_insurance")){
                      feeType = "保险费用上调";
                      bd = bd.add(plan.getFee());
                  }else if(rawType.equals("plan_sub_insurance")){
                      feeType = "保险费用下调";
                      bd = bd.subtract(plan.getFee());
                  }else if(rawType.equals("plan_add_contract")){
                      feeType = "合同费用上调";
                      bd = bd.add(plan.getFee());
                  }else if(rawType.equals("plan_sub_contract")){
                      feeType = "合同费用下调";
                      bd = bd.subtract(plan.getFee());
                  }else if(rawType.equals("plan_add_other")){
                      feeType = "其他费用上调";
                      bd = bd.add(plan.getFee());
                  }else if(rawType.equals("plan_sub_other")){
                      feeType = "其他费用下调";
                      bd = bd.subtract(plan.getFee());
                  }%>
                    <tr>
                        <td><%=feeType%></td>
                        <td><%=plan.getFee()%></td>
                        <td><%=plan.getInTime()%></td>
                        <td><%=plan.getRegister()%></td>
                    </tr>
                <%}%>
                <tr>
                    <td>合计</td>
                    <td><%=bd%></td>
                    <td>-</td>
                    <td>-</td>
                </tr>
            </table>
        </div>
    <%}%>

</body>
</html>
