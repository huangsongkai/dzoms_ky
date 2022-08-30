<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://www.hit.edu.cn/permission" prefix="m" %>
<%@ page language="java" import="java.util.*,com.dz.module.user.User" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<m:permission role="驾驶员登记">
<jsp:forward page="/common/forbid.jsp"></jsp:forward>
</m:permission>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>驾驶员登记</title>
<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
<script src="/DZOMS/res/js/jquery.js"></script>
<script src="/DZOMS/res/js/pintuer.js"></script>
<script src="/DZOMS/res/js/respond.js"></script>
<script src="/DZOMS/res/js/admin.js"></script>
<script src="/DZOMS/res/js/itemtool.js"></script>
<link rel="stylesheet" href="/DZOMS/res/css/jquery.datetimepicker.css" />
<script src="/DZOMS/res/js/jquery.datetimepicker.js"></script>
<script src="/DZOMS/res/layer-v2.1/layer/layer.js"></script>
<script src="/DZOMS/res/js/window.js"></script>
<script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
<script type="text/javascript" src="/DZOMS/res/js/fileUpload.js" ></script>
<jsp:include page="/common/msg_info.jsp"></jsp:include>
    <script type="text/javascript">
        var rowcount = -1;
        var colName = new Array();
        colName[0] = "role";
        colName[1] = "name";
        colName[2] = "phoneNum";
        colName[3] = "work";

        function AddRow() {
            rowcount++;
            var table = document.getElementById("tb");
            var tr = document.createElement("tr");
            tr.id = "newRow_" + rowcount;
            for (var i = 0; i < colName.length; i++) {
                var td = document.createElement("td");
                td.innerHTML = "<input type='text' name='families[" + rowcount
                        + "]." + colName[i] + "' style='width:100%'/>";
                tr.appendChild(td);
            }
            table.appendChild(tr);

        }

        function RemoveRow() {
            if (rowcount >= 0) {
                var table = document.getElementById("tb");
                var tr = document.getElementById("newRow_" + rowcount);
                if (tr) {
                    table.removeChild(tr);
                    rowcount--;
                }
            }
        }

        $(document).ready(function(){
            $("td").attr("nowrap","nowrap");
            var mydate = new Date();
            $('input[name="driver.applyTime"]').val( mydate.format("yyyy/MM/dd"));
        });
        
        $(document).ready(function(){
        	getList1('driverNation','driverNation');
        	getList1('cardClass','cardClass');
        	getList1('driverClass','driverClass');
        	getList1('driverTeam','driverTeam');
        	getList1('driverShiftLocation','driverShiftLocation');
        	getList1('driverOldCompany','driverOldCompany');
        	
        });
       
        function deleheadimg(){
            $("#imghead")[0].src="/DZOMS/res/image/driverhead.png";
           
            
            $("#readyimg1").val("");
        }
       
        $(document).ready(function () {
           selectedTableInit();
        });
        
        function adddriverfile(){
            $(".my-selected input").click();
        }
        function changeyn(){
        	$(".my-selected td:last").html('<span class="icon icon-check text-green"></span>');
            
        }
        function deledriverfile(){
            $(".my-selected input").val("");
          
            $(".my-selected td:last").html('<span class="icon icon-times text-red"></span>');
        }
        
        function checkcarFunc(){     	
        	$("#tmpdiv input").click();
        }
        function delecar(){
        	$("#checkcar .my-selected").remove();
        }
        
        function addIntoCheckList(){
        	var $tr = $('<tr ondblclick="showImageNew(this)"></tr>');
        	var $td = $('<td></td>');
        	var $input = $('<input></input>').attr("name","checkcar").val($("#tmpdiv input").val()).hide();
        	$td.append($input);
        	$td.append(fileObjMap[""+$("#tmpdiv input").attr("dz-index")]["filename"]);
        	$tr.append($td);
        	$("#checkcar").append($tr);
        }
       
        function setInfo(idNum){
        	if(idNum.length==18){
        		$.post("/DZOMS/common/doit",{"condition":"from Driver where idNum='"+idNum+"'"},function(data){
        			if ( data["affect"]!= undefined||data["affect"]!=null) {
        				alert("该用户信息已添加。");
        				$('input[name="driver.idNum"]').val("");
        			}else{
        				setTheInfo(idNum);
        			}
        		});
        	}
        }
        
        function setTheInfo(idNum){
        	$('input[name="driver.drivingLicenseNum"]').val(idNum);
        		$.getJSON("/DZOMS/common/distinct.json",function(data){
        			var idNum=$('input[name="driver.idNum"]').val();
        			var f4 = idNum.substring(0,4);
        			//alert(data);
        			var ci = data.cityMap[f4];
        			if(ci.provide=="黑龙江省"){
        				var f6 = idNum.substring(0,6);
        				var ti = data.townMap[f6];
        				if(ti!=undefined)
        					var town = data.townMap[f6].town;
        				else
        					var town ='';
        				$('input[name="driver.accountLocation"]').val(ci.provide+ci.city+town);
        			}else{
        				$('input[name="driver.accountLocation"]').val(ci.provide+ci.city);
        			}
        			
        			$('input[name="driver.address"]').val($('input[name="driver.accountLocation"]').val());
        		});
        		
        		var sex = parseInt(idNum.charAt(16))%2==0?'false':'true';
        		$('select[name="driver.sex"]').val(sex);
        		
        		var beginDate = new Date();
        		beginDate.setFullYear(parseInt(idNum.substring(6,10)),parseInt(idNum.substring(10,12)),1);
        		var di = getMonthAndDay(beginDate,new Date());
        		
        		var age = (di.mounth - (di.mounth+6)%12 +6 )/12;
        		$('input[name="driver.age"]').val(age);
        }
        
        $(document).ready(function(){
        	$("select[name='driver.sex']").val('true');
        });
       
    </script>
  <script>
  $(document).ready(function(){
  	$("select[name='driver.taxiExperience']").change(function(){
  		$("input[name='driver.taxiExperienceYears']").val("");
  		$("input[name='driver.oldLicenseNum']").val("");
  		$("[name='driver.oldCompany']").val("");
  		if($("select[name='driver.taxiExperience']").val()=='true'){
  			$("input[name='driver.taxiExperienceYears']").attr("disabled",false);
  			$("input[name='driver.oldLicenseNum']").attr("disabled",false);
  			$("[name='driver.oldCompany']").attr("disabled",false);
  		}else{
  			$("input[name='driver.taxiExperienceYears']").attr("disabled",true);
  			$("input[name='driver.oldLicenseNum']").attr("disabled",true);
  			$("[name='driver.oldCompany']").attr("disabled",true);
  		}
  	});
  	$("select[name='driver.taxiExperience']").change();
  });
    function loadThePicture(fi,img){
      	   loadTempPicture($(fi),$(img));
      }
  </script>
    <style>
        .my-selected{
            background-color: #56B4DC;
        }
        .input{
            width:60%;
        }
    
        td{
        	text-align: left;
        }
        .label{
         width: 80px;
         text-align: right;
        }
     </style>

<body>
<jsp:include page="/common/load_to_top.jsp"></jsp:include>
<div class="margin-big-bottom">
	<div class="adminmin-bread" style="width: 100%;">
		<ul class="bread text-main" style="font-size: larger;"> 
                <li>驾驶员</li>
                <li>聘用</li>
                <li>聘用</li>
        </ul>
        </div>
</div>
<div class="panel margin">
<div class="panel-body">
	<s:form name="driverAdd" action="driverAdd" method="post"
        theme="simple" cssClass="form-inline form-tips" enctype="multipart/form-data">
   <input type="hidden" name="url" value="/driver/driver_new.jsp" />
   <div class="xm2  ">
        <img src="/DZOMS/res/image/driverhead.png" class="radius img-responsive" style="width: 150px;height: 150px;" id="imghead">
        <br/>
        <div class="container">
        	<a class="button input-file input-file1">
                装入<input class="dz-file" id="readyimg1" name="photo" data-target=".input-file1" sessuss-function="loadThePicture('#readyimg1','#imghead');">
            </a>
            <!--<a class="button input-file bg-green input-file1">
                装入<input type="text" class="dz-file" name="photo" onchange="loadpicture(this,'#headimg')" id="oldimg">
            </a>-->
            <a class="button input-file delebutton1" data-width="50%" data-mask="1">清空</a>
        </div>
    </div>
    <div class="xm10">
        <table class="table table-hover">
            <tr>
                <td style="width: 250px;">
                    <div class="form-group" style="width: 250px;">
                        <div class="label" style="width: 80px;">
                            <label>
                                申请事项
                            :</label>
                        </div>
                        <div class="field" style="width: 170px">
                            <s:select  theme="simple" cssClass="input" name="driver.applyMatter"
                                      list="@com.dz.common.other.JsonListReader@getList('/driver/driver.json','driver.applyMatter')" cssStyle="width: 120px" data-validate="required:必填" >
                            </s:select>
                            <span style="color:red;font-size:large;">*</span>
                        </div>
                    </div>
                </td>
                <td style="width: 250px;">
                    <div class="form-group" style="width: 250px;">
                        <div class="label" style="width: 80px;">
                            <label>
                                申请时间
                            :</label>
                        </div>
                        <div class="field" style="width: 170px;">
                            <s:textfield cssClass="input datepick" cssStyle="width: 100px;"  name="driver.applyTime" readonly="readonly"></s:textfield>
                            
                        </div>
                    </div>
                </td>
                <td style="width: 250px;">
                    <div class="form-group">
                        <div class="label" style="width: 80px;">
                            <label>
                                车牌号
                            :</label>
                        </div>
                        <div class="field" style="width: 150px;">
                            <input class="input input-auto" size="8" value="黑A">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 250px;">
                    <div class="form-group" style="width: 250px;">
                        <div class="label  " style="width: 80px;">
                            <label>
                                驾驶员姓名
                            :</label>
                        </div>
                        <div class="field" style="width: 170;">
                            <s:textfield cssClass="input float-left input-auto"  size="7"  name="driver.name" data-validate="required:必填,chinese:请输入汉字" />
                             <span class="text-red">*</span>
                        </div>
                    </div>
                </td>
                <td style="width: 250px;">
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                驾驶员性别
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input float-left"  name="driver.sex"
                                      list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.sex')" data-validate="required:必填">
                            </s:select>
                            <span class="text-red">*</span>
                        </div>
                    </div>
                </td>
                <td style="width: 250px;">
                    <div class="form-group">
                        <div class="label">
                            <label>
                                年龄
                            :</label>
                        </div>
                        <div class="field" >
                            <s:textfield cssClass="input input-auto" size="5"  name="driver.age" data-validate="plusinteger:请输入数字,compare#<60:年龄介于0-60之间"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 300px;">
                    <div class="form-group">
                        <div class="label" style="width: 80px;">
                            <label>
                                身份证号
                            :</label>
                        </div>
                        <div class="field" style="width: 200px;">
                            <s:textfield cssClass="input float-left input-auto" size="20"  name="driver.idNum" onchange="setInfo(this.value)" data-validate="required:必填,length#==18:请输入18位身份份证号码"/>
                            <span class="text-red">*</span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                婚姻状况
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.maritalStatus"  list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.maritalStatus')"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                民族
                            :</label>
                        </div>
                        <div class="field">
                            <select class="input float-left" id="driverNation"  name="driver.nation" onfocus="getList1('driverNation','driverNation')" ></select>
                            <a class="icon-wrench" href="javascript:openItem('driverNation','民族设置')"></a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 250px;">
                    <div class="form-group" >
                        <div class="label  "style="width: 80px;">
                            <label>
                                户口所在地
                            :</label>
                        </div>
                        <div class="field" style="width: 170px;">
                            <s:textfield cssClass="input"  name="driver.accountLocation" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                联系电话
                            :</label>
                        </div>
                        <div class="field">
                        	
                        		 <s:textfield cssClass="input float-left"  name="driver.phoneNum1" cssStyle="width: 50%" data-validate="required:必填,numbe:请输入数字,length#==11:请输入正确手机号"  />
                        		 <span class="text-red float-left">*</span>
                        	     <s:textfield cssClass="input"  name="driver.phoneNum2"  cssStyle="width:40%;"/>
                        </div>
                    </div>
                </td>
               </tr>
               <tr>
                <td colspan="2" >
                    <div class="form-group" style="width: 500px;">
                        <div class="label" style="width: 80px;">
                            <label>
                                家庭现住址:</label>
                        </div>
                        <div class="field" style="width: 400px;">
                            <s:textfield cssClass="input float-left input-auto" size="40" name="driver.address" data-validate="required:必填" cssStyle="width:100%"/>
                            <span class="text-red">*</span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>

            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                驾驶证号
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.drivingLicenseNum" data-validate="required:必填,length#==18:请输入18位身份份证号码"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label class="tips" data-toggle="hover" data-place="top" title="<h4>驾驶证初领日期</h4>">
                               初领日期
                            :</label>
                        </div>
                        <div class="field">
                       
                            <s:textfield cssClass="input input-auto" size="12"   placeholder="驾驶证"  name="driver.drivingLicenseDate" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                驾驶证类型
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.drivingLicenseType"  list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.drivingLicenseType')"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                资格证号
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input" value="23010" name="driver.qualificationNum" data-validate="number:请输入存数字,length#==12:请输入12位资格证号" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                          <label class="tips" data-toggle="hover" data-place="top" title="<h4>资格证初领日期</h4>">
                                初领日期
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input input-auto" size="12"   placeholder="资格证"  name="driver.qualificationDate"  />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  " style="width: 40%">
                           <label class="tips" data-toggle="hover" data-place="top" title="<h4>资格证有效日期至</h4>">
                                有效日期至:</label>
                        </div>
                        <div class="field" style="width: 60%">
                            <s:textfield cssClass="input datepick  input-auto" size="12"   placeholder="资格证"  name="driver.qualificationValidDate" />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                银行卡类别
                            :</label>
                        </div>
                        <div class="field">
                            <select class="input float-left" id="cardClass"  name="bankCard.cardClass" onfocus="getList1('cardClass','cardClass')" ></select>
                            <a class="icon-wrench" href="javascript:openItem('cardClass','银行卡类别')"></a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                银行卡号
                            :</label>
                        </div>
                        <div class="field">
                            <input class="input input-auto" name="bankCard.cardNumber" style="width: 100%;" data-validate="number:请输入正确银行卡号,length#==19:请输入正确银行卡号">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                驾驶员属性
                            :</label>
                        </div>
                        <div class="field">
                            <select class="input float-left" id="driverClass"  name="driver.driverClass" onfocus="getList1('driverClass','driverClass')" ></select>
                            <a class="icon-wrench" href="javascript:openItem('driverClass','驾次')"></a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                作息时间
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.restTime"
                                      list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.restTime')"></s:select>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                车队
                            :</label>
                        </div>
                        <div class="field">
                             <select class="input float-left" style="width: 100px;" id="driverTeam"  name="driver.team" onfocus="getList1('driverTeam','driverTeam')" ></select>
                            <a class="icon-wrench" href="javascript:openItem('driverTeam','车队')"></a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label">
                            <label>
                                交班地点
                            :</label>
                        </div>
                        <div class="field">
                            <select class="input float-left" style="width: 200px;" id="driverShiftLocation"  name="driver.shiftLocation" onfocus="getList1('driverShiftLocation','driverShiftLocation')"></select>
                            <a class="icon-wrench" href="javascript:openItem('driverShiftLocation','交班地点设置')"></a>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                交班时间
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input timepick"  name="driver.shiftTime"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                加油地点
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.fuelLocation" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                营运场站
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.operatingStation" />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  " style="width: 40%">
                            <label class="tips" data-toggle="hover" data-place="top" title="<h4>是否从事过出租车营运</h4>">
                                是否从事出租车营运:</label>
                        </div>
                        <div class="field" style="width: 60%">
                        	
                        		 <s:select cssClass="input float-left" cssStyle="width:30%;"  name="driver.taxiExperience" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.taxiExperience')"></s:select>
                        	
                        	
                        		  <s:textfield cssClass="input"  cssStyle="width:60%;" name="driver.taxiExperienceYears" placeholder="年" ></s:textfield>
                        	
                          
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                原车牌号
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.oldLicenseNum" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                原所在公司
                            :</label>
                        </div>
                        <div class="field">
                            <select class="input float-left" id="driverOldCompany" style="width: 100px;"  name="driver.oldCompany" onfocus="getList1('driverOldCompany','driverOldCompany')"></select>
                            <a class="icon-wrench" href="javascript:openItem('driverOldCompany','原所在公司')"></a>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                驾驶员身高
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.height" placeholder="cm" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                政治面貌
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.politicalStatus" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.politicalStatus')"></s:select>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label class="tips" data-toggle="hover" data-place="top" title="<h4>面部有无疤痕</h4>">
                                面部有无疤痕
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.scar" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.scar')"></s:select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                特长
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.specialty" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                微信号
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.qq" />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                员工号
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.employeeNum" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                指纹编号
                            :</label>
                        </div>
                        <div class="field">
                            <s:textfield cssClass="input"  name="driver.fingerprintNum" />
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                星级
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input" cssStyle="color: red;font-size: larger;" name="driver.star" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.star')"></s:select>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <table class="table">
            <tr>
                <td style="width: 400px;">
                    <div style="width: 400px;">
                        <div class="float-left">
                            <strong>个人简历:</strong>
                        </div>
                        <div>
                            <s:textarea name="driver.resume" cssStyle="width: 300px;" cssClass="input" rows="6"></s:textarea>
                        </div>
                    </div>
                </td>
                <td style="width: 400px;">
                    <div style="width: 400px;">
                        <div class="float-left ">
                            <strong>
                                兴趣爱好:</strong>
                        </div>
                        <div class="field">
                            <s:textarea name="driver.hobby" cssStyle="width: 300px;" cssClass="input" rows="6"></s:textarea>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <table class="table">
            <tr>
                <td>
                    <div class="panel">
                        <div class="panel-head">
                            <strong>家庭成员</strong>
                        </div>
                        <div class="panel-body">
                            <table class="table" id="tb" style="width:100%">
                                <tr>
                                    <th style="width: 20%">家庭成员</th>
                                    <th style="width: 20%">姓名</th>
                                    <th style="width: 20%">联系电话</th>
                                    <th style="width: 40%">工作单位</th>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
                <td>
                    <input type="button" value="新增成员" onclick="AddRow()" class="button bg-green"/><br>
                    <input type="button" value="删除成员" onclick="RemoveRow()" class="button"  />
                </td>
            </tr>
        </table>
        <hr class="bg-black">
        <table class="table">
            <tr>
                <td style="width: 70%">
                    <div class="panel">
                        <div class="panel-head">
                            <strong>个人档案</strong>
                        </div>
                        <div class="panel-body">
                            <table class="table selected-table">
                                <tr class="unselected-tr">
                                    <th style="width: 50%">文件类别</th>
                                    <th style="width: 20%">有无文件</th>
                                </tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>身份证<input type="text" class="dz-file" name="P_IdCard"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td>
                                </tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>驾驶证<input type="text" class="dz-file" name="P_DriverLicense" sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>从业人员资格证<input type="text" class="dz-file" name="P_Qualification" sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>户口本首页<input type="text" class="dz-file" name="P_Location" sessuss-function="changeyn()"  style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>暂住证（呼兰、阿城除外）<input type="text" class="dz-file" name="P_TempLocton" sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>驾驶员聘用协议<input type="text" class="dz-file" name="P_EmployContract"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>服务质量承诺书<input type="text" class="dz-file" name="P_Server"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>个人免冠彩色一寸照<input type="text" class="dz-file" name="P_photo"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>车体照（四寸）<input type="text" class="dz-file" name="P_vehicle"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>驾驶员登记表<input type="text" class="dz-file" name="P_table"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>户口本本人页<input type="text" class="dz-file" name="P_personal" sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                                <tr ondblclick="showImageNew(this)">
                                    <td>驾驶员表彰证书<input type="text" class="dz-file" name="P_praise"  sessuss-function="changeyn()" style="display: none"></td>
                                    <td><span class="icon icon-times text-red"></span></td></tr>
                            </table>
                        </div>
                    </div>
                </td>
                <td>
                    <input type="button" value="添加" onclick="adddriverfile()" class="button bg-green"/><br>
                    <input type="button" value="删除"  class="button delebutton2" data-width="50%" data-mask="1"/>
                </td>
            </tr>
            <tr>
                <td style="width: 70%">
                    <div class="panel">
                        <div class="panel-head">
                            <strong>现场验车</strong>
                        </div>
                        <div class="panel-body">
                            <table class="table selected-table" id="checkcar">
                                <tr class="unselected-tr">
                                    <th>文件名称</th>
                                </tr>
                            </table>
                            
                        </div>
                    </div>
                </td>
                <td>
                    <input type="button" value="添加" class="button bg-green" onclick="checkcarFunc()"/><br>
                    <input type="button" value="删除" class="button" onclick="delecar()"/>
                    
                </td>
                
            </tr>
        </table>
        
        <table class="table">
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                文化程度
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.educationDegree" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.educationDegree')"></s:select>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label class="tips" data-toggle="hover" data-place="top" title="<h4>语言表达能力</h4>">
                                语言表达能力
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.languageAbility" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.languageAbility')"></s:select>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                健康状况
                            :</label>
                        </div>
                        <div class="field">
                            <s:select cssClass="input"  name="driver.health" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.health')"></s:select>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <div class="label  " style="width: 60%">
                            <label class="tips" data-toggle="hover" data-place="top" title="<h4>对哈市熟悉程度</h4>">
                                对哈市熟悉程度
                            :</label>
                        </div>
                        <div class="field" style="width:40%;">
                            <s:select cssClass="input"  name="driver.cityFamiliarty" list="@com.dz.common.other.JsonListReader@getList('driver/driver.json','driver.cityFamiliarty')"></s:select>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label class="tips" data-toggle="hover" data-place="top" title="<h4>有无前科劣迹</h4>">
                                有无前科劣迹
                            :</label>
                        </div>
                        <div class="field">
                            <select class="input" name="driver.hasBadRecord">
                            	<option value="false">无</option>
                            	<option value="true">有</option>
                            </select>
                        </div>
                    </div>
                </td>
                
            </tr>
            <tr>
               <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                违章记录
                            :</label>
                        </div>
                        <div class="field">
                            <input class="input" name="driver.breakRecord">
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                事故记录
                            :</label>
                        </div>
                        <div class="field">
                            <input class="input" name="driver.accidentRecord">
                        </div>
                    </div>
                </td>
            </tr>
       <!--     <tr>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                测试人
                            :</label>
                        </div>
                        <div class="field">
                            <input class="input">
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  ">
                            <label>
                                登记人
                            :</label>
                        </div>
                        <div class="field">
                            <input class="input" >
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="panel">
                        <div class="panel-head">
                            <strong>测试成绩</strong>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tr>
                                    <th>试卷编号</th>
                                    <th>完成时间</th>
                                    <th>考试分数</th>
                                    <th>合格分数</th>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="form-group">
                        <div class="label  " style="width: 28%">
                            <label>
                                主管副经理意见
                            :</label>
                        </div>
                        <div class="field" style="width: 72%">
                            <textarea class="input" rows="6"></textarea>
                        </div>
                    </div>
                </td>
            </tr>-->
            <tr >
                <td colspan="3" style="text-align:center;">
                	<div class="form-button">
                	<input type="button" class="button bg-green  submitbutton" value="提交" data-width="50%" data-mask="1" />
                	<input type="button" class="button" value="取消"/>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <input type="submit" style="display: none;" id="submit-button"/>
</s:form>
</div>

</div>

<!-- 文件上传隐藏控件 -->
<div id="tmpdiv">
    <input type="text" class="dz-file" name="checkfile" sessuss-function="addIntoCheckList()" style="display:none"/>
</div>

        
<script src="/DZOMS/res/js/DateTimeHelper.js"></script>
<script>
$('[name="driver.qualificationDate"]').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:2000,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	onClose:function(){
		var arr = $('[name="driver.qualificationDate"]').val().split("/");
		arr[0] = parseInt(arr[0])+6;
		$('[name="driver.qualificationValidDate"]').val(""+arr[0]+"/"+arr[1]+"/"+arr[2]);
	}
});

$('[name="driver.drivingLicenseDate"]').datetimepicker({
	lang:"ch",           //语言选择中文
	format:"Y/m/d",      //格式化日期
	timepicker:false,    //关闭时间选项
	yearStart:1980,     //设置最小年份
	yearEnd:2050,        //设置最大年份
	//todayButton:false    //关闭选择今天按钮
	yearOffset:-8
});

</script>
<script>
$(function(){
	$showdialogs=function(e){
		var trigger=e.attr("data-toggle");
		var getid=e.attr("data-target");
		var data=e.attr("data-url");
		var mask=e.attr("data-mask");
		var width=e.attr("data-width");
		var detail="";
		var masklayout=$('<div class="dialog-mask"></div>');
		if(width==null){width="80%";}
		
		if (mask=="1"){
			$("body").append(masklayout);
		}
		detail='<div class="dialog-win" style="position:fixed;width:'+width+';z-index:11;">';
		if(getid!=null){detail=detail+$(getid).html();}
		if(data!=null){detail=detail+$.ajax({url:data,async:false}).responseText;}
		detail=detail+'</div>';
		
		var win=$(detail);
		win.find(".dialog").addClass("open");
		$("body").append(win);
		
		/**
		 * Show next to selector
		 */
		var e_top = e.offset().top-win.outerHeight();
		
		var x=parseInt($(window).width()-win.outerWidth())/2;
		//var y=parseInt($(window).height()-win.outerHeight())/2;
		var y = e_top;
		if (y<=10){y="10"}
		win.css({"left":x,"top":y});
		win.find(".dialog-close,.close").each(function(){
			$(this).click(function(){
				win.remove();
				$('.dialog-mask').remove();
			});
		});
		masklayout.click(function(){
			win.remove();
			$(this).remove();
		});
	};
});
	
	
//	del_but_bind('.delebutton1',deleheadimg);
//	del_but_bind('.delebutton2',deledriverfile)
	button_bind(".delebutton1","确认删除？","deleheadimg()");
	button_bind(".delebutton2","确认删除？","deledriverfile()");
	/*add_but_bind('.submitbutton',function(){
		driverAdd.submit();
	});*/
	button_bind(".submitbutton","确定提交?","$('#submit-button').click();");
	
</script>

</body>
</html>