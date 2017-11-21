<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib
	uri="/struts-tags" prefix="s"%>
<%@page import="org.springframework.web.context.support.*"%>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%@ page language="java"
	import="java.util.*,com.dz.module.user.User,com.dz.module.vehicle.*,com.dz.module.driver.*,com.dz.common.other.*,com.dz.common.global.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
		<title>待岗申请</title>
		<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
<script>
$(document).ready(function(){
$("[name='vehicle.licenseNum']").bigAutocomplete({
	url:"/DZOMS/select/vehicleByLicenseNum",
	condition:" state=1 ",
	callback:function(){
		var licenseNum = $("[name='vehicle.licenseNum']").val();
		var condition1 = "select v from Vehicle v where v.licenseNum ='" + licenseNum + "'";
	
		$.post("/DZOMS/common/doit",{"condition":condition1},function(data){
			if (data!=undefined&&data["affect"]!=undefined) {
				var vehicle = data["affect"];
				$('[name="driver.carframeNum"]').val(vehicle["carframeNum"]);
				
				//VehicleOwner
				$.post("/DZOMS/common/doit",{"condition":"select name from Driver where idNum ='"+vehicle["driverId"]+"'"},function(data2){
					$('#VehicleOwner').val(data2["affect"]);
				});
				
				var driverArray = [vehicle["firstDriver"],vehicle["secondDriver"]];
				$('#idNameSelector').html("");
				$('#idNameSelector').append($('<option></option>'));
				for (var i=0;i<driverArray.length;i++) {
					if(driverArray[i]!=null&&driverArray[i].trim().length>0)
					$.post("/DZOMS/common/doit",{"condition":"from Driver where idNum ='"+driverArray[i].trim()+"'"},function(data2){
						try{
							if(!data2["affect"]["isLeave"])
								$('#idNameSelector').append($('<option></option>').text(data2["affect"]["name"]).val(data2["affect"]["idNum"]));
						}catch(e){
							alert(e);
						}
					});
				}
			}
		});
	}
});
});
</script>
<script>  
    function refresh2(){
    	if ( $('#idNameSelector').val().trim().length>0) {
    		document.leaveApply.action = "/DZOMS/driver/leave/leaveSelect2";
       		document.leaveApply.submit();
    	}
    }
        
    $(document).ready(function(){
    	$('select[name="driverleave.isRepresented"]').change(function(){
    		var val = $(this).find("option:selected").val();
    		$("input[name='driverleave.representName']").val('');
    		$("input[name='driverleave.representIdnum']").val('');
    		if(val=='true'){
    			$("input[name='driverleave.representName']").attr("disabled",false);
                $("input[name='driverleave.representIdnum']").attr("disabled",false);
    		}else{
    			$("input[name='driverleave.representName']").attr("disabled",true);
                $("input[name='driverleave.representIdnum']").attr("disabled",true);
    		}
    	});
    	
    	$('select[name="driverleave.isRepresented"]').change();
    });
</script>
	</head>
	<body>
		<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>待岗管理</li>
                <li>待岗申请</li>
              
        </ul>
        </div>
</div>
		<form action="leaveApply" name="leaveApply" method="post">	
		<div class="line">
			<div class="panel xm10 xm1-move">
				<div class="panel-head">
					待岗申请表
				</div>
				<div class="panel-body">
					<div class="xm3">
				<img src="/DZOMS/data/driver/<s:property value="driver.idNum"/>/photo.jpg" class="radius img-responsive" height="200px">
			</div>
			<div class="xm8">
				<table class="table table-hover ">
        	<tr>
        		<td class="tableleft">车牌号</td>
				<td>
					<s:hidden name="driver.carframeNum"></s:hidden>
					<s:if test="%{driver.carframeNum!=null}">
						<s:textfield name="vehicle.licenseNum" cssClass="input" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',driver.carframeNum).licenseNum}"/>
					</s:if>
					<s:else>
						<s:textfield name="vehicle.licenseNum" cssClass="input" value="黑A"/>
					</s:else>
                	
				</td>
				<td></td>
				<td class="tableleft">承租人</td>
				<td>
					<s:set name="driverId" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.vehicle.Vehicle',driver.carframeNum).driverId}"></s:set>
                    <s:textfield id="VehicleOwner" value="%{@com.dz.common.other.ObjectAccess@getObject('com.dz.module.driver.Driver',#driverId).name}" cssClass="input"/>
				</td>
        	</tr>
        	<tr>
                <td class="tableleft">驾驶员姓名<span style="color: red">*</span></td>
                <td>
                	<select class="input" id="idNameSelector" name="driver.idNum" onchange="refresh2()">
                	<option value="<s:property value="%{driver.idNum}"/>"><s:property value="%{driver.name}"/></option>
                	</select>
                </td>
                <td></td>
                
              <td class="tableleft">身份证号<span style="color: red">*</span></td>
                <td ><s:textfield cssClass="input" name="idNum" value="%{driver.idNum}"/></td>
            </tr>
            
             <tr>
                <td class="tableleft">待岗是否代办<span style="color: red">*</span></td>
                <td>
                	<s:select list="#{'true':'是','false':'否'}" value="false" theme="simple" name="driverleave.isRepresented"></s:select>
                </td>
                <td></td>
            </tr>
            
            <tr>
                <td class="tableleft">代办人姓名<span style="color: red">*</span></td>
                <td><s:textfield cssClass="input"  name="driverleave.representName" /></td>
                <td></td>
                
              <td class="tableleft">代办人身份证号<span style="color: red">*</span></td>
                <td ><s:textfield cssClass="input"  name="driverleave.representIdnum" /></td>
            </tr>
            
            
            <tr>
                <td class="tableleft">驾驶员性别<span style="color: red">*</span></td>
                <td><s:select cssClass="input"  name="driver.sex"
                              list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.sex')"></s:select></td>
            
                <td></td>
                <td class="tableleft">联系电话<span style="color: #ff0000">*</span></td>
                <td><s:textfield cssClass="input"  name="driver.phoneNum1" /></td>
            </tr>
            <tr>
                <td class="tableleft">户口所在地</td>
                <td colspan=2><s:textfield cssClass="input"  name="driver.accountLocation" /></td>
                 <td class="tableleft">家庭现住址<span style="color: red">*</span></td>
                <td colspan=2><s:textfield cssClass="input"  name="driver.address" /></td>
            </tr>
            <tr>
                <td class="tableleft">驾驶证号</td>
                <td><s:textfield cssClass="input"  name="driver.drivingLicenseNum" /></td>
                <td></td>
                <td class="tableleft">驾驶证初领日期</td>
                <td><s:textfield cssClass="input datepick"  name="driver.drivingLicenseDate" /></td>
            </tr>
            <tr><td class="tableleft">驾驶证类型</td>
                     <td><s:select cssClass="input"  name="driver.drivingLicenseType"  list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.drivingLicenseType')"/></td>
                </tr>
            <!--第七行-->
            <tr>
                <td class="tableleft">资格证号</td>
                <td><s:textfield cssClass="input"  name="driver.qualificationNum" /></td>
                <td></td>
                <td class="tableleft">资格证初领日期</td>
                <td><s:textfield cssClass="input datepick"  name="driver.qualificationDate"  /></td>   
            </tr>
            
            <tr>
                <td>录入人</td>
                <td><input class="input" type="text" readonly="readonly" value="<%=((User)session.getAttribute("user")).getUname()%>">
                	<input type="hidden" name="driverleave.operator" value="<%=((User)session.getAttribute("user")).getUid()%>"/></td>
                <td></td>
                <td>申请时间</td>
                <td><input  class="datepick input" readonly="readonly" name="driverleave.opeTime" value="<%=(new  java.text.SimpleDateFormat("yyyy/MM/dd")).format(new java.util.Date()) %>"/></td>
            </tr>
            <tr>
                <td colspan="4"> <div class="form-button"><button class="button bg-green" type="submit">录入</button></div></td>
                <td><div class="form-button"><button class="button">退出</button></div></td>
            </tr>
        </table>
			</div>
					
				</div>
			</div>
			
		</div>
        
        
		</form>
		<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js" ></script>
	</body>
</html>
