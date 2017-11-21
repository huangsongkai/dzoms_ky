<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.dz.module.charge.receipt.ReceiptRecord" %>
<%@ page import="java.util.List" %>
<%@taglib uri="/struts-tags" prefix="s"%>

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
    <script>
        function removex(x){
            var data = $(x).attr("id");
            data = data.split("|");
            var id = data[0];
            var startNum = data[1];
            var endNum = data[2];
            var style = data[3];
            validateAndRemove(id,startNum,endNum,style);
        }
        function validateAndRemove(id,startNum,endNum,style){
                    if(style == "进货"){
                        $.post("/DZOMS/charge/receipt/validateOut",{"startNum":startNum,"endNum":endNum},function(data){
                            if(data.startsWith("success")){
                                if(confirm("是否作废此发票？")){
                                    var reason = prompt("请输入作废原因");
                                    $.post("/DZOMS/charge/receipt/inRemove",{"rr.id":id,"rr.startNum":startNum,"rr.endNum":endNum,"reason":reason},function(dax){
                                        $('#form', window.parent.document).submit();
                                    });
                                }
                            }else{
                                alert("该发票段不存在或者已经售出！！！");
                            }
                        });
                    }else{
                        if(confirm("是否作废此发票？")){
                            var reason = prompt("请输入作废原因");
                            $.post("/DZOMS/charge/receipt/outRemove",{"rr.id":id,"rr.startNum":startNum,"rr.endNum":endNum,"reason":reason},function(dax){
                                $('#form', window.parent.document).submit();
                            });
                        }
                    }
        }
        function printSale(){
        	var startTime = $("#startTime").val();
        	var endTime = $("#endTime").val();
        	if(startTime == undefined || startTime==""){
        		startTime = "2000/01/01";
        	}
        	if(endTime==undefined||endTime==""){
        		endTime = "2150/01/01";
        	}
        	var condition = "condition=and+(happenTime+between+'"+startTime+"'+and+'"+endTime+"')+and+style%3d%27%e5%8f%91%e6%94%be%27";//+encodeURI(carlist)+")";
    		var url = "/DZOMS/common/selectToList?className=com.dz.module.charge.receipt.ReceiptRecord&withoutPage=true&"+(condition)+"&url=%2fcharge%2freceipt%2fprint_sale.jsp";
        	window.open(url,"发票发放流向记录",'width=800,height=600,resizable=yes,scrollbars=yes');
        }
    </script>
</head>
<body>
	<div>
   <div class="panel  margin-small" >
        <div class="panel-head">
          	    <div class="line">
          	        	<div class="xm2">查询结果</div>
          	        	<div style="float:right">
           	<div class="button-toolbar">
	            <div class="button-group">
			  <button onclick="printSale()" type="button" class="button icon-pencil text-green" style="line-height: 6px;">
			  打印发放记录</button>
          </div>
          </div>
            </div>
        </div>
       </div>
    <div class="panel-body">
    <s:hidden name="startTime"></s:hidden>
    <s:hidden name="endTime"></s:hidden>
<table class="table table-bordered table-hover table-striped">
  <tr><!-- 车号，承包人，领购人，起止号，时刻，年份排列 -->
    <th>类别</th>
    <th>车号</th>
    <th>承包人</th>
    <th>领购人</th>
    <!-- <th>日期</th> -->
    <!-- <th>收据编号</th> -->
    <!-- <th>张数</th> -->
    <!-- <th>单价</th> -->
    <!-- <th>进货数量</th> -->
    <!-- <th>销售数量</th> -->
    <!-- <th>库存</th> -->
    <!-- <th>总金额</th> -->
    <th>发票号段</th>
    <!-- <th>记录人</th> -->
    <th>记录时间</th>
    <th>年份</th>
    <s:if test="#session.roles.{?#this.rname=='发票作废权限'}.size>0">   	
	       <th>操作</th>
		</s:if>
    
  </tr>
  <%Object o = request.getAttribute("records");%>
  <%if(o != null){%>
    <%List<ReceiptRecord> rrs = (List)o;
    int inNumSum=0,outNumSum=0;
    %>
    <%for(ReceiptRecord rr:rrs){%>
      <%int inNum = 0;int outNum = 0;
      if(rr.getStyle().equals("发放")){
        //outNum = rr.getSoldNum();
        outNumSum+=rr.getEndNum()-rr.getStartNum()+1;
      }else{
        //inNum = rr.getInNum();
        inNumSum+=rr.getEndNum()-rr.getStartNum()+1;
      }%>
      <tr>
        <td><%=rr.getStyle()%></td>
        <td><%=rr.getCarId()==null?"-":rr.getCarId()%></td>
        <td><%=rr.getRenter()==null?"-":rr.getRenter()%></td>
        <td><%=rr.getTaker()==null?"-":rr.getTaker()%></td>
        <%-- <td><%=rr.getHappenTime()==null?"-":rr.getHappenTime()%></td> --%>
        <%-- <td><%=rr.getProveNum()==null?"-":rr.getProveNum()%></td> --%>
        <%-- <td><%=rr.getPaperNum()==0?"0":rr.getPaperNum()%></td> --%>
        <%-- <td><%=rr.getPrice()==null?"-":rr.getPrice()%></td> --%>
        <%-- <td><%=inNum%></td> --%>
        <%-- <td><%=outNum%></td> --%>
        <%-- <td><%=rr.getStorage()%></td> --%>
        <%-- <td><%=rr.getAllPrice()%></td> --%>
        <td><%=rr.getStartNum()%> - <%=rr.getEndNum()%></td>
        <%-- <td><%=rr.getRecorder()==null?"-":rr.getRecorder()%></td> --%>
        <td><%=rr.getRecordTime()==null?"-":rr.getRecordTime()%></td>
        <td><%=rr.getYear()==0?"0":rr.getYear() %></td>
        <s:if test="#session.roles.{?#this.rname=='发票作废权限'}.size>0">   	
	       <td><a id="<%=rr.getId()%>|<%=rr.getStartNum()%>|<%=rr.getEndNum()%>|<%=rr.getStyle()%>" onclick="removex(this)">作废</a></td>
		</s:if>
        
      </tr>
    <%}%>
    <tr>
    <td>合计</td><td>进货：
    <%inNumSum/=1000;
    String txt="";
    if(inNumSum>10){
    	txt +=""+(inNumSum/10)+"箱";
    }
    if(inNumSum%10>0){
    	txt +=""+(inNumSum%10)+"袋";
    }
     %>
    <%= txt%>
    </td><td>发放：
     <%outNumSum/=1000;
     String txt2="";
    if(outNumSum>10){
    	txt2 +=""+(outNumSum/10)+"箱";
    }
    if(outNumSum%10>0){
    	txt2 +=""+(outNumSum%10)+"袋";
    }
     %>
    <%= txt2%></td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td>
    </tr>
  <%}%>
</table>
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
