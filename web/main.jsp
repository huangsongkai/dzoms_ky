<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>后台管理</title>
        <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
     <link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css"/>
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <script src="/DZOMS/res/js/respond.js"></script>
    <script src="/DZOMS/res/js/admin.js"></script>
    <script src="/DZOMS/res/js/apps.js"></script>
    <link href="/DZOMS/res/css/style.css" rel="stylesheet" />
    
     <script>
		function appendWaitDeal(type,url){
			$.post("/DZOMS/common/getWaitDealCount",{"waitType":type},function(data) {
				if(data>0){
					var line = '<tr onclick="goTo(\''+url+'\');"><td>'+type+'</td><td>'+data+'</td><tr>';
					$("#wait_deal").append(line);
				}
			});
		}
		
		function goTo(url){
        	window.location = url;
        }
		
        function refresh(){
        	$("#wait_deal").html("<tr><th>待办类别</th><th>条数</th></tr>");
        	
        	appendWaitDeal("开业审批","/DZOMS/vehicle/CreateApproval/approval_list.jsp");
        	appendWaitDeal("废业审批","/DZOMS/vehicle/AbandonApproval/judge.jsp");
        	appendWaitDeal("合同新增","/DZOMS/contract/contract_new.jsp");
        	appendWaitDeal("合同废止","/DZOMS/contract/contract_abandon.jsp");
            
            appendWaitDeal("投诉处理","/DZOMS/common/waitDealList.jsp?waitDealType=%e6%8a%95%e8%af%89%e5%a4%84%e7%90%86");
            appendWaitDeal("事故处理","/DZOMS/common/waitDealList.jsp?waitDealType=%e4%ba%8b%e6%95%85%e5%a4%84%e7%90%86");
            
             $.post("/DZOMS/driver/driverSearchConditionCount",{"driver.isInCar":true},function(num){
            	$("#driver_number").text(num);
            });
            
            $.post("/DZOMS/contractValidCount",{},function(num){
            	$("#contract_number").text(num);
            });
            
            $.post("/DZOMS/vehicle/vehicleSelectValidCount",{},function(num){
            	$("#vehicle_number").text(num);
            });
        }
        
        $(document).ready(function(){
            refresh();
        });
        
        function menuFocus(selector){
        	$(selector,parent.document).click();
        }
    </script>


</head>
<body>
<!--第一行图标行-->
<div class="line">
    <div class="xm3">
        <div class="widget widget-state bg-blue margin-small">
            <div class="state-icon"><i class="icon icon-user"></i></div>
            <div class="state-info">
                <h4>驾驶员</h4>
                <p id="driver_number">1200</p>
            </div>
            <div class="state-link">
                <a href="javascript:menuFocus('#driverMenuBar');">View Detail <i class="icon-chevron-circle-down"></i></a>
            </div>
        </div>
    </div>
    <div class="xm3">
        <div class="widget widget-state bg-red  margin-small">
            <div class="state-icon"><i class="icon icon-file-text"></i></div>
            <div class="state-info">
                <h4>合同</h4>
                <p id="contract_number">1002</p>
            </div>
            <div class="state-link">
                <a href="javascript:menuFocus('#contractMenuBar');">View Detail <i class="icon-chevron-circle-down"></i></a>
            </div>
        </div>
    </div>
    <div class="xm3">
        <div class="widget widget-state bg-purple  margin-small">
            <div class="state-icon"><i class="icon icon-car"></i></div>
            <div class="state-info">
                <h4>车辆</h4>
                <p id="vehicle_number">600</p>
            </div>
            <div class="state-link">
                <a href="javascript:menuFocus('#vehicleMenuBar');">View Detail <i class="icon-chevron-circle-down"></i></a>
            </div>
        </div>
    </div>
    <div class="xm3">
        <div class="widget widget-state bg-green  margin-small">
            <div class="state-icon"><i class="icon icon-envelope-o"></i></div>
            <div class="state-info">
                <h4>消息提醒</h4>
                <p>5</p>
            </div>
            <div class="state-link">
                <a href="javascript:;">View Detail <i class="icon-thumbs-o-up"></i></a>
            </div>
        </div>
    </div>
</div>
<!--第一行结束第二行开始 界面行（待办事项 日历等）-->
<div class="line">
    <!--左侧-->
    <div class="xm4">
        <div class="panel bg-back margin-small">
            <div class="panel-head bg-black">
                <div class="panel-heading-btn">
                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="icon icon-minus"></i></a>
                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="icon icon-times"></i></a>
                </div>
                <h4 class="text-white">日历</h4>
            </div>
            <div class="panel-body">
               <input type="text" id="datetimepicker3"/>
            </div>


        </div>

        <div class="panel bg-back margin-small">
            <div class="panel-head bg-black">
                <div class="panel-heading-btn">
                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="icon icon-minus"></i></a>
                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="icon icon-times"></i></a>
                </div>
                <h4 class="text-white">计算器</h4>
            </div>
            <div class="panel-body">
                <div id="ri-li"></div>

            </div>
        </div>

    </div>
    <!--右侧-->
    <div class="xm8">
        <div class="panel bg-back margin-small">
            <div class="panel-head bg-black">
                <div class="panel-heading-btn">
                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="icon icon-minus"></i></a>
                    <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="icon icon-times"></i></a>
                </div>
                <h4 class="text-white">待办事项</h4>
            </div>
            <div class="panel-body"> 	
                <table class="table table-hover table-striped" id="wait_deal">
                    
                    <tr>
                        <th>待办类别</th>
                        <th>角色</th>
                        <th>权限</th>
                    </tr>
                   
                   
                </table>
            </div>
        </div>

    </div>
</div>
<!--第二行结束-->


</body>

<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script>
    $('.datetimepicker').datetimepicker();
    $('#datetimepicker3').datetimepicker({
        inline:true,
        format:'d/m/Y',
        formatDate:'Y/m/d',
        timepicker:false,
    });
</script>
<script>
    $(document).ready(function() {
    	try{
    	  App.init();
        // $(".xdsoft_datetimepicker.xdsoft_noselect").show();
        // $("#ri-li").append($(".xdsoft_datetimepicker.xdsoft_noselect"));
    	
    	}catch(e){
    	}
      
    });

</script>


</html>