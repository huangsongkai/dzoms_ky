<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.user.User" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-11-15
  Time: 下午8:12
  To change this template use File | Settings | File Templates.
--%>
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
    <script type="text/javascript">
        function tianjia(){
            if($("#table1 :checked:first").parent().parent().html()==undefined)
                alert("您没有勾选任何数据");
            while( $("#table1 :checked:first").parent().parent().html()!=undefined)
            {
                var txt ='<tr>'+$("#table1 :checked:first").parent().parent().html()+'</tr>';
                var tid = $("#table1 :checked:first").parent().attr("id").slice(2);
                var id = "hidden"+tid;
                //添加一个表单隐藏yu
                var hide = '<input type="hidden" name="batchPlan.contractIdList" value="'+tid+'" id="'+id+'" />';
                $("#formx").append(hide);
                $("#table2").append(txt);
                $("#table1 :checked:first").parent().parent().remove();
                i1=0;i2=0;i3=0;
            }
            
        }
        function shanchu(){
            if($("#table2 :checked:first").parent().parent().html()==undefined)
                alert("您没有勾选任何数据");
            while( $("#table2 :checked:first").parent().parent().html()!=undefined)
            {
                var txt ='<tr>'+$("#table2 :checked:first").parent().parent().html()+'</tr>';
                $("#table1").append(txt);
                //移除表单隐藏yu
                var id = "hidden"+$("#table2 :checked:first").parent().attr("id").slice(2);
                $("#"+id).remove();
                $("#table2 :checked:first").parent().parent().remove();
                i1=0;i2=0;i3=0;
            }
            
        }
    </script>
    <script>
        <%-- //TODO--%>
        var i1=0,i2=0,i3=0;
        function setList(){
            $.post("/DZOMS/contractSearchAllAvilable",{},function(data){
                data = $.parseJSON(data);
                data = data["list"][0]["com.dz.module.contract.Contract"];
                if(data.length == undefined){
                    data = [data];
                }
                var part1 = [];
                var part2 = [];
                var part3 = [];
                for(var i = 0;i < data.length;++i){
                    if(data[i]["branchFirm"] == "一部"){
                        part1.push(data[i]);
                    }else if (data[i]["branchFirm"] == "二部"){
                        part2.push(data[i]);
                    }else if (data[i]["branchFirm"] == "三部"){
                        part3.push(data[i]);
                    }
                }
                //添加一部信息
                var ph1 = "<tr>" +
                        "<td><input id='pc1' type='checkbox' onchange='active_all(this)'></td>" +
                        "<td>一部</td>" +
                        "<td>-</td>" +
                        "<td>-</td></tr>"
//                $("#table1").append(ph1);
                for(var i = 0;i < part1.length;++i){
                    var carframeNum = part1[i]["carframeNum"];
                    var contractId = part1[i]['id'];
                    var businessForm = part1[i]["contractId"];
                    var contractType = part1[i]["businessForm"];
                    var txt = '<tr>'
                            +'<td id="td'+contractId+'" class="part1"><input type="checkbox"/></td>'
                            +'<td>'+businessForm+'</td>'
                            +'<td id="'+carframeNum+'">'+'</td>'
                            +'<td>'+contractType+'</td>'
                    '</tr>';
                    $("#table1").append(txt);
                    $.post("/DZOMS/vehicle/vehicleSelectById",{"vehicle.carframeNum":carframeNum},function(data){
                        data = $.parseJSON(data);
                        data = data["ItemTool"];
                        $("#"+data["carframeNum"]).html(data["licenseNum"]);
                    });
                }
                //添加二部信息
                var ph2 = "<tr>" +
                        "<td><input id='pc2' type='checkbox' onchange='active_all(this)'></td>" +
                        "<td>二部</td>" +
                        "<td>-</td>" +
                        "<td>-</td></tr>"
//                $("#table1").append(ph2);
                for(var i = 0;i < part2.length;++i){
                    var carframeNum = part2[i]["carframeNum"];
                    var contractId = part2[i]['id'];
                    var businessForm = part2[i]["contractId"];
                    var contractType = part2[i]["businessForm"];
                    var txt = '<tr>'
                            +'<td id="td'+contractId+'" class="part2"><input type="checkbox"/></td>'
                            +'<td>'+businessForm+'</td>'
                            +'<td id="'+carframeNum+'">'+'</td>'
                            +'<td>'+contractType+'</td>'
                    '</tr>';
                    $("#table1").append(txt);
                    $.post("/DZOMS/vehicle/vehicleSelectById",{"vehicle.carframeNum":carframeNum},function(data){
                        data = $.parseJSON(data);
                        data = data["ItemTool"];
                        $("#"+data["carframeNum"]).html(data["licenseNum"]);
                    });
                }
                //添加三部信息
                var ph3 = "<tr>" +
                        "<td><input id='pc3' type='checkbox' onchange='active_all(this)'></td>" +
                        "<td>三部</td>" +
                        "<td>-</td>" +
                        "<td>-</td></tr>"
//                $("#table1").append(ph3);
                for(var i = 0;i < part3.length;++i){
                    var carframeNum = part3[i]["carframeNum"];
                    var contractId = part3[i]['id'];
                    var businessForm = part3[i]["contractId"];
                    var contractType = part3[i]["businessForm"];
                    var txt = '<tr>'
                            +'<td id="td'+contractId+'" class="part3"><input type="checkbox"/></td>'
                            +'<td>'+businessForm+'</td>'
                            +'<td id="'+carframeNum+'">'+'</td>'
                            +'<td>'+contractType+'</td>'
                    '</tr>';
                    $("#table1").append(txt);
                    $.post("/DZOMS/vehicle/vehicleSelectById",{"vehicle.carframeNum":carframeNum},function(data){
                        data = $.parseJSON(data);
                        data = data["ItemTool"];
                        $("#"+data["carframeNum"]).html(data["licenseNum"]);
                    });
                }
            });
        }
        $(document).ready(function(){
            setList();
            addPlanName();
            
        });
        function active_all(check_father){
          if($(check_father).attr("id")=='pc1'){
              if(i1%2==0){
                  $(".part1").children().prop("checked",true);
              }
              else{
                  $(".part1").children().prop("checked",false);

              }
              $(check_father).prop("checked",false);
              i1=i1%2+1;
          }
            if($(check_father).attr("id")=='pc2'){
                if(i2%2==0){
                    $(".part2").children().prop("checked",true);
                }
                else{
                    $(".part2").children().prop("checked",false);

                }
                $(check_father).prop("checked",false);
                i2=i2%2+1;
            }
            if($(check_father).attr("id")=='pc3'){
                if(i3%2==0){
                    $(".part3").children().prop("checked",true);
                }
                else{
                    $(".part3").children().prop("checked",false);

                }
                $(check_father).prop("checked",false);
                i3=i3%2+1;
            }
        

        }
           function tiao(){
           	window.parent.parent.miaodian();
           }
		function btnClk(){
			var carlist = $('input[name="batchPlan.contractIdList"]').val();
			var startTime = $('input[name="batchPlan.startTime"]').val();
			var endTime = $('input[name="batchPlan.endTime"]') .val();
			var isToEnd = $('input[name="isToEnd"]').is(':checked');
			var type = $('select[name="batchPlan.feeType"]').val();
			var fee = $('input[name="batchPlan.fee"]').val();
			if(carlist == undefined){
				alert("未选择车辆");
				return;
			}
			if(startTime == undefined || startTime == ""){
				alert("未选择开始日期");
				return;
			}
			if((endTime == undefined || endTime == "") && isToEnd == false){
				alert("未选择结束日期");
				return;
			}
			if(fee == undefined || fee == ""){
				alert("未填写费用");
				return;
			}
			if(fee < 0){
				$('input[name="batchPlan.fee"]').val(-fee);
				if(type == "plan_add_insurance"){
					$('select[name="batchPlan.feeType"]').val("plan_sub_insurance");
				}
				if(type == "plan_add_contract"){
					$('select[name="batchPlan.feeType"]').val("plan_sub_contract");
				}
				if(type == "plan_add_other"){
					$('select[name="batchPlan.feeType"]').val("plan_sub_other");
				}
			}
			$('#formx')[0].submit();
		}
	
    </script>
</head>
<body onload="tiao()">
<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>财务管理</li>
                <li>批量变更约定</li>
    </ul>
</div>
<form method="post" id="formx" action="/DZOMS/charge/addBatchPlan" class="form-tips form-inline" style="width: 100%">
    <div class="line">
        <div class="panel xm11 margin-small">
            <div class="panel-head">
                <strong>新增约定</strong>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定名称
                        </label>
                    </div>
                    <div class="field">
                        <input class="input input-auto" size="40"  value="财务计划" name="batchPlan.title"/>
                    </div>
                </div>

                <br>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            开始日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input  datepick input-auto" size="14" name="batchPlan.startTime" value="%{batchPlan.getStartTime()}"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            结束日期
                        </label>
                    </div>
                    <div class="field">
                        <s:textfield  cssClass="input datepick input-auto" size="14" value="%{batchPlan.getEndTime()}" name="batchPlan.endTime"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            使用合同结束日期
                        </label>
                    </div>
                    <div class="field">
                        <input type="checkbox" name="isToEnd">
                    </div>
                </div>
                <br>
                	
               
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            约定类型
                        </label>
                    </div>
                    <div class="field">
                        <select size="1" name="batchPlan.feeType" class="input">
                            <option value="plan_add_insurance">保险费用</option>
                            <option value="plan_sub_insurance" style="display:none">保险费用下降</option>
                            <option value="plan_add_contract">合同费用</option>
                            <option value="plan_sub_contract" style="display:none">合同费用下降</option>
                            <option value="plan_add_other">其他费用</option>
                            <option value="plan_sub_other" style="display:none">其他费用下降</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="label padding">
                        <label>
                            费用
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input "  name="batchPlan.fee" placeholder="单位（元）"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label padding">
                        <label>
                            备注
                        </label>
                    </div>
                    <div class="field">
                        <input  class="input" name="batchPlan.comment"/>
                    </div>
                </div>
                <input type="button" value="提交" class="button bg-main" onclick="btnClk()"/>
            </div>
        </div>
        </div>
        <div class="line">
        	<div class="xm11 margin-small">
        		<%Object message = request.getAttribute("message");%>
          <%if(message != null){%>
          <div class="alert">
		      <span class="close rotate-hover"></span><strong>操作结果：</strong><%=message.toString()%></div>
           <%}%>
        	</div>
        	
        
        	
        </div>

       
            <div class="line">
                <div class="xm5">
                    <div class="panel" style="height: 600px;overflow:auto; ">
                        <div class="panel-head">
                            <strong>全部车辆:</strong>
                            <label>一部</label><input id='pc1' type='checkbox' onchange='active_all(this)'>
                            <label>二部</label><input id='pc2' type='checkbox' onchange='active_all(this)'>
                            <label>三部</label><input id='pc3' type='checkbox' onchange='active_all(this)'>
                        </div>
                        <table class="table table-bordered" id="table1">
                            <tr>
                                <th>选择</th>
                                <th>档案号</th>
                                <th>车牌号</th>
                                <th>承包形式</th>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="xm1">
                    <div style="height: 200px"></div>
                    <div class="margin-small"><input type="button" class="button bg-gray" value="添加->" onclick="tianjia()"></div>
                    <div class="margin-small"><input type="button" class="button bg-gray" value="<-删除" onclick="shanchu()"></div>
                </div>
                <div class="xm5">

                    <div class="panel" style="height: 600px;overflow:auto; ">
                        <div class="panel-head">
                            <strong>选择车辆:</strong>
                        </div>
                        <table class="table table-bordered" id="table2">
                            <tr>
                                <th>选择</th>
                                <th>档案号</th>
                                <th>车牌号</th>
                                <th>承包形式</th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>


      
  
        <input type="hidden" name="batchPlan.register" value="<%=((User)session.getAttribute("user")).getUname()%>"/>

   

</form>

</body>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/js/DateTimeHelper.js">
</script>
</html>
