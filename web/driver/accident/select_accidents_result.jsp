<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.dz.module.driver.accident.Accident" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'select_accidents_result.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
      <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css"/>
      <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
      <link rel="stylesheet" href="/DZOMS/res/css/admin.css">

      <script src="/DZOMS/res/js/jquery.js"></script>
      <script src="/DZOMS/res/js/pintuer.js"></script>
      <script src="/DZOMS/res/js/respond.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
      <script>
          function openView(view,args,type){
              window.showModalDialog(view,args,
                      'status:0, edge:sunken,resizable:yes,dialogWidth:1024');
//              $("#f2",window.parent.document).attr("src","/DZOMS/accident_Selects?selectStyle=4");
              $("#form1").submit();
          };
          function show(){
              alert("show");
          };
      </script>


  </head>
  
  <body>
  <form method="post" action="/DZOMS/accident_Selects?selectStyle=4" id="form1">

  </form>
    <table class="table table-bordered table-striped table-hover">
		<tr>
			<th>车牌号</th>
            <th>身份证号</th>
            <%--<th></th>--%>
			<th>时间</th>
			<th>操作</th>
			<th>审核记录</th>
		</tr>
        <% for(Accident accident:(List<Accident>)request.getAttribute("accident_list")){%>
            <tr>
                <td><%=accident.getCarId()%></td>
                <td><%=accident.getDriverId()%></td>
                <%--<td><%=accident.getDriverId()%></td>--%>
                <td><%=accident.getTime()%></td>
                <%String show;
                    String func;
                    String func1 = "openView('/DZOMS/driver/accident/accident_check_history.jsp',["+accident.getAccId()+"],0);";
                    switch (accident.getStatus()){
                      case 0:
                          show = "待审核";
                          func = "openView('/DZOMS/driver/accident/accident_check.jsp',["+accident.getAccId()+"],0);";
                          break;
                      case 1:
                          show = "待修改";
                          func = "openView('/DZOMS/driver/accident/accident_change.jsp',["+accident.getAccId()+"],0);";
                          break;
                      case 2:
                          show = "待赔付";
                          func = "openView('/DZOMS/driver/accident/accident_paid.jsp',["+accident.getAccId()+"],0);";
                          break;
                      case 3:
                          show = "查看详细";
                          func = "openView('/DZOMS/driver/accident/accident_detail.jsp',["+accident.getAccId()+"],0);";
                          break;
                      default:
                          show = "";
                          func = "";
                          break;
                  }%>
                <td><a href="javascript:void(0);" onclick="<%=func%>"><%=show%></a></td>
                <td><a href="javascript:void(0);" onclick="<%=func1%>">审核记录</a></td>
            </tr>
        <%}%>
	</table>
  </body>
</html>
