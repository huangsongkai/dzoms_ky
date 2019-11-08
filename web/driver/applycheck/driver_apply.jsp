<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 16-5-19
  Time: 上午11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
    <link rel="stylesheet" href="/DZOMS/res/css/admin.css">
    <script src="/DZOMS/res/js/jquery.js"></script>
    <script src="/DZOMS/res/js/pintuer.js"></script>
    <link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script type="text/javascript" src="/DZOMS/res/js/window.js"></script>
	
    <jsp:include page="/common/msg_info.jsp"></jsp:include>
    <script>
        var sumbittable = true;
        function checkCarOccupied(){
            var licenseNum = $("#licenseNum").val();
            
            //alert(licenseNum.length);
            if((!licenseNum === "")&&licenseNum.length!=7){
            	sumbittable = false;
            	return ;
            }
            
            var applyType = $("#applyType").val();
            if(applyType === "驾驶员"||applyType === "临驾") {
                if (licenseNum === "") {
                    sumbittable = confirm("该驾驶员未输入车牌号，是否继续？");
                } else {
                    $.post("/DZOMS/common/doit", {"condition": "from Vehicle where licenseNum = '" + licenseNum + "'"}, function (data) {
                        if(data["affect"] === undefined){
                            alert("该车不存在");
                            sumbittable = false;
                            return ;
                        }
//                         if (data["affect"]["secondDriver"] != "") {
//                         		var condition1 = "select d.name from Driver d where d.idNum = '" + data["affect"]["secondDriver"] + "'";
	
// 														$.post("/DZOMS/common/doit",{"condition":condition1},function(data){
// 															if (data!=undefined&&data["affect"]!=undefined) {
// 																var name = data["affect"];
// 																alert("该车已有副驾"+name);
// 															}
// 														});
                            
//                             sumbittable = false;
//                             return;
//                         }

                        var condition1 = "select d from Driver d where d.idNum = '" + $('[name="driver.idNum"]').val() + "'";
                        $.post("/DZOMS/common/doit",{"condition":condition1},function(data){
 							if (data!=undefined&&data["affect"]!=undefined) {
 								var driver = data["affect"];
 								if(driver["isInCar"]){
 									alert("该驾驶员在车，请先下车!");
 									sumbittable = false;
 									return;
 								}
 																
 							}
 						});
                        
                        
                        sumbittable = true;
                    });
                }
            }else if(applyType === "新包车"){
            	$.post("/DZOMS/common/doit", {"condition": "from Vehicle where licenseNum = '" + licenseNum + "'"}, function (data) {
                        if(data["affect"] === undefined){
                            sumbittable = confirm("该车不存在，是否继续？");
       
        				if(!sumbittable)
        					$("#licenseNum").val("黑A");
                            return ;
                        }
                        if (data["affect"]["driverId"] != "") {
                            alert("该车已有承包人.");
                            sumbittable = false;
                        } else {
                            sumbittable = true;
                        }
                        
                    });
            }
        }
        
        function checkSubmitable(){
        	var licenseNum = $("#licenseNum").val();
        	var applyType = $("#applyType").val();
        	
        	var fuwubaozhenjing = $('input[name="driver.fuwubaozhengjin"]').val();
        	if (fuwubaozhenjing.length==0||!/^[0-9]+[0-9]*]*$/.test(fuwubaozhenjing)) {
        		//alert("服务保证金应为正整数");
        		$('input[name="driver.fuwubaozhengjin"]').val("0");
        		return false;
        	}
        	
        	if(licenseNum.length!=7){
            	if((applyType === "新包车" ||applyType === "转租" )&& (licenseNum=="黑A" || licenseNum.length==0)) {
            		return true;
            	}
            	alert("车牌号应为7位");
            	return false;
            }
        
            if(sumbittable){
                return true;
            }else{
                alert("当前条件未满足，无法进行申请。");
                return false;
            }
        }
        
        $(document).ready(function(){
         $("#licenseNum").bigAutocomplete({
				url:"/DZOMS/select/vehicleByLicenseNum",
				callback: checkCarOccupied
			});
			
			$("#applyType").change(function(){
				var applyType = $("#applyType").val();
				if((applyType === "新包车" ||applyType === "转租" )){
					$('input[name="driver.fuwubaozhengjin"]').val(0);
					$('input[name="driver.fuwubaozhengjin"]').prop("readonly",true);
				}else{
					$('input[name="driver.fuwubaozhengjin"]').prop("readonly",false);
				}
			});
			
        });
        
     
    </script>
</head>
<body>
<div class="margin-big-bottom">
    <div class="adminmin-bread" style="width: 100%;">
        <ul class="bread text-main" style="font-size: larger;">
            <li>驾驶员</li>
            <li>聘用</li>
            <li>提请聘用</li>

        </ul>
    </div>
</div>
   <div class="container">
       <form action="/DZOMS/driver/driverApply" method="post" class="form-inline form-tips" onsubmit="return checkSubmitable();">
           <div class="panel">
               <div class="panel-head">
                   提请聘用
               </div>
               <div class="panel-body">
                 <div class="form-group">
                       <div class="label"><label>申请事项</label></div>
                       <div class="field">
                           <select id="applyType" name="driver.applyMatter">
                               <option>新包车</option>
                               <option>转包车</option>
                               <option>驾驶员</option>
                               <option>临驾</option>
                       </select>
                       </div>
                   </div>
                   <div class="form-group">
                       <div class="label"><label>姓名</label></div>
                       <div class="field"><input type="text" name="driver.name" class="input input-auto" size="5"   data-validate="required:必填,chinese:请输入汉字"  ></div>
                   </div>
                   <div class="form-group">
                       <div class="label"><label>身份证</label></div>
                       <div class="field"><input type="text" name="driver.idNum" class="input input-auto" size="20"  data-validate="required:必填,length#==18:请输入18位身份份证号码"></div>
                   </div>
                   <div class="form-group">
                       <div class="label"><label>车牌号</label></div>
                       <div class="field">
                           <input type="text" id="licenseNum" name="driver.applyLicenseNum" value="黑A"  onblur="checkCarOccupied();">
                       </div>
                   </div>
                 
                   <div class="form-group">
                       <div class="label"><label>服务保证金</label></div>
                       <div class="field">
                            <input type="text" value="0" name="driver.fuwubaozhengjin">
                       </div>
                   </div>
                   <div class="form-button">
                       <input type="submit" class="button bg-main" value="发起申请"/>
                   </div>
               </div>

           </div>


       </form>
   </div>

</body>
</html>
