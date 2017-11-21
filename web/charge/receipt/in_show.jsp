<%@ page import="com.dz.module.charge.receipt.ReceiptRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-28
  Time: 下午11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title></title>
  <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
  <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
  <script src="/DZOMS/res/js/jquery.js"></script>
  <script src="/DZOMS/res/js/pintuer.js"></script>
  <script src="/DZOMS/res/js/respond.js"></script>
  <script src="/DZOMS/res/js/admin.js"></script>
  <script type="text/javascript" src="/DZOMS/res/layer-v2.1/layer/layer.js" ></script>
  <script type="text/javascript" src="/DZOMS/res/js/window.js" ></script>
  <jsp:include page="/common/msg_info.jsp"></jsp:include>
</head>
<body>
<div>
  <div class="panel  margin-small" >
    <div class="panel-head">
       查询结果
    </div>
    <div class="panel-body">
      <table class="table table-bordered table-hover table-striped">
        <tr>
          <th>进货卷数
          </th>
          <th>进货箱数
          </th>
          <th>起始号
          </th>
          <th>终止号
          </th>
          <th>年份
          </th>
          <th>操作
          </th>
        </tr>
        <%int all = 0;%>
        <%Object o = request.getAttribute("records");%>
        <%if(o != null){%>
        <%List<ReceiptRecord> rrs = (List)o;%>
        <%for(ReceiptRecord rr:rrs){%>
        <%int start = rr.getStartNum();int end = rr.getEndNum();
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy");%>
        <tr>
          <%all+=(end-start+1);%>
          <td><%=(end-start+1)/100%>卷</td>
          <td><%=(end-start+1)/10000%>箱</td>
          <td><%=start%></td>
          <td><%=end%></td>
          <td><%=rr.getHappenTime()!=null?sdf.format(rr.getHappenTime()):"-"%></td>
          <td><a href="/DZOMS/charge/receipt/deleteRecord?rr.id=<%=rr.getId()%>&rr.startNum=<%=rr.getStartNum()%>&rr.endNum=<%=rr.getEndNum()%>&rr.proveNum=<%=rr.getProveNum()%>">删除</a></td>
        </tr>
        <%}%>
        <%}%>
      </table>
     
    </div>
     <div class="panel-foot">
        <span>合计金额：</span><span><%=all/100*3.6%>元</span>
        <%int box = all/10000;int bag = (all - box*10000)/1000;int roll = (all-box*10000-bag*1000)/100;int z = all%100;%>
        <span>合计数量：</span><span><%=box%>箱<%=bag%>袋<%=roll%>卷<%=z%>张</span>
      </div>
  </div>
</div>
</body>
<script src="/DZOMS/res/js/apps.js"></script>
<script>
  $(document).ready(function() {
    App.init();
    // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
    // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));

  });
</script>
</html>
