<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="com.dz.module.vehicle.newcheck.CheckRecord" %>
<%@ page import="com.dz.module.vehicle.newcheck.Group" %>
<%@ page import="com.dz.module.user.User" %>
<%--
  Created by IntelliJ IDEA.
  User: doggy
  Date: 15-12-14
  Time: 下午11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<script src="/DZOMS/res/js/jquery.js"></script>
		<script type="text/javascript" src="/DZOMS/res/bootstrap-3.3.5-dist/js/bootstrap-select.js"></script>
		<link rel="stylesheet" type="text/css" href="/DZOMS/res/bootstrap-3.3.5-dist/css/bootstrap-select.css" />

		<link href="/DZOMS/res/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="/DZOMS/res/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>

	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	
  <style>
     
  	 .form-group{
  	 	margin-top: 10px;
  	  width: 300px;
  	 }
  	 label{
  	 	width: 80px;
  	 }
  	 input{
  	 	width: 170px;
  	 }
  	
   
      
      div.btn-group.bootstrap-select.show-tick.bla.bli{
      	width: 200px;
      }
  </style>
  <script type="text/javascript" src="/DZOMS/res/js/JsonList.js" ></script>
    <%Object o = request.getAttribute("group");%>
    <%Group g = (Group)o;%>
    <script>
    	
        var names = [];
        function setAll(){
            var licenseNum = $("#licenseNum").val();
            $.post("/DZOMS/common/doit",{
                "condition":"from Driver where idNum=(select driverId from Vehicle where licenseNum='"+licenseNum+"')"
            },function(data){
                var driver = data["affect"];
                if(driver==undefined){
                	return;
                }
                $("#driver").val(driver["name"]);
            });
            $.post("/DZOMS/common/doit",{
                "condition":"from Vehicle where licenseNum='"+licenseNum+"'"
            },function(data){
                data = data["affect"];
                
                if(data==undefined){
                	return;
                }
                
                $("#carFrameNum").val(data["carframeNum"]);
                $("#dept").val(data["dept"]);
                $("#inCarDriver").html("");
                $("#inCarDriver").append("<option id=' '></option>");
                var firstId = data["firstDriver"];
                var secondId = data["secondDriver"];
                var thirdId = data["thirdDriver"];
                var forthId = data["forthDriver"];
                var tempId = data["tempDriver"];
                
                if(firstId!=undefined&&firstId.length>0)
                $.post("/DZOMS/common/doit",{
                    "condition":"from Driver where idNum='"+firstId+"'"
                },function(data){
                    data = data["affect"];
                    var option = "<option  id='"+firstId+"'>"+data["name"]+"</option>";
                    $("#inCarDriver").append(option);
                });
                if(secondId!=undefined&&secondId.length>0)
                $.post("/DZOMS/common/doit",{
                    "condition":"from Driver where idNum='"+secondId+"'"
                },function(data){
                    data = data["affect"];
                    var option = "<option  id='"+secondId+"'>"+data["name"]+"</option>";
                    $("#inCarDriver").append(option);
                });
                if(thirdId!=undefined&&thirdId.length>0)
                $.post("/DZOMS/common/doit",{
                    "condition":"from Driver where idNum='"+thirdId+"'"
                },function(data){
                    data = data["affect"];
                    var option = "<option  id='"+thirdId+"'>"+data["name"]+"</option>";
                    $("#inCarDriver").append(option);
                });
                if(forthId!=undefined&&forthId.length>0)
                $.post("/DZOMS/common/doit",{
                    "condition":"from Driver where idNum='"+forthId+"'"
                },function(data){
                    data = data["affect"];
                    var option = "<option  id='"+forthId+"'>"+data["name"]+"</option>";
                    $("#inCarDriver").append(option);
                });
                if(tempId!=undefined&&tempId.length>0)
                $.post("/DZOMS/common/doit",{
                    "condition":"from Driver where idNum='"+tempId+"'"
                },function(data){
                    data = data["affect"];
                    var option = "<option  id='"+tempId+"'>"+data["name"]+"</option>";
                    $("#inCarDriver").append(option);
                });
            });
        
        		$.post("/DZOMS/common/doit",{
                "condition":"from Contract where idNum=(select driverId from Vehicle where licenseNum='"+licenseNum+"')"
            },function(data){
                data = data["affect"];
                
                if(data==undefined){
                	return;
                }
                
                $("#contractNum").val(data["contractId"]);
            });
        }
        
        $(document).ready(function(){
            $.post("/DZOMS/check/getUserNamesByGroupId",{"groupId":<%=g.getId()%>},function(data){
                data = $.parseJSON(data);
                data = data["list"][0]["string"];
                if(typeof data == "string")
                	data = [data];
                	var op = "";
                for(var i = 0;i < data.length;++i){
                	op +="<option>"+data[i]+"</option>";
                
                }
                
                $("#id_select").append(op);
               
                //执行检车人
                 $('.selectpicker').selectpicker({
			                'selectedText': 'cat'
			            });
            });
            
           $("#licenseNum").bigAutocomplete({
						url:"/DZOMS/select/vehicleByLicenseNum",
						callback:setAll
					});
        });
        
        function hideColumn(x){
            if($(x).is(":checked")){
                $(".sl",window.frames[0].document).show();
            }else{
                $(".sl",window.frames[0].document).hide();
            }
        }
        
        function makesubmit(){
			var isPassed = $("#isPassed").is(":checked");
			if(isPassed){
				$("#form").submit();
				alert("添加成功！");
			 location.reload();
//				location.href = location.href;
			}else{
				$("#sb").remove();
				$("#form").submit();
				$("#div_frame").toggle();
				$("div_plan").attr("disabled","disabled");
			}
        }
      
        function assi(){
        	 var id= $("#inCarDriver :selected").attr("id");
        	 $("#inCarDriverId").val(id);
        }        
    </script>
	</head>

	<body>

	
         


<div class="container">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" ><a href="#home" aria-controls="home" role="tab" data-toggle="tab">检车</a></li>
    <li role="presentation" class="active"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">检车记录</a></li>
  </ul>

  <!-- Tab panes -->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane" id="home">
       	<div class="container" style="width: 95%;">
			<div class="panel panel-default">
				<div class="panel-heading">检车</div>
				<div class="panel-body">
					<%String name = ((User)session.getAttribute("user")).getUname();%>
						<form action="/DZOMS/check/addRecord" method="post" class="form-inline" target="unPassReasonAdd" id="form">
							<s:hidden value="%{groupId}" name="group.id"></s:hidden>
							<div class="row">
								<div class="form-group">

									<label>车牌号</label>

									<input type="text" id="licenseNum" name="checkRecord.licenseNum" class="form-control" onblur="setAll()" value="黑A">

								</div>

								<div class="form-group">

									<label>承包人</label>

									<input type="text" name="checkRecord.driver" class="form-control" id="driver">

								</div>
								<div class="form-group">

									<label>车架号</label>

									<input type="text" id="carFrameNum" class="form-control" name="checkRecord.carFrameNum">

								</div>
								<div class="form-group">

									<label>档案号</label>

									<input type="text" id="contractNum" class="form-control" name="checkRecord.contractNum">

								</div>

							</div>
							<div class="row">

								<div class="form-group">

									<label>驾驶员</label>

									<select name="checkRecord.inCarDriver" onchange="assi()" class="form-control" id="inCarDriver">
									</select>

								</div>
								<div class="form-group">

									<label>身份证号</label>

									<input type="text" id="inCarDriverId" class="form-control" name="checkRecord.inCarDriverId">

								</div>
								<div class="form-group">

									<label>部门</label>

									<input type="text" name="checkRecord.dept" class="form-control" id="dept">

								</div>
							</div>
							<div class="row">
								<div class="form-group">

									<label>检车日期</label>

									<input type="text" class="form-control" name="checkRecord.recordTime" value="<%=(new  java.text.SimpleDateFormat(" yyyy/MM/dd ")).format(new java.util.Date()) %>">

								</div>
								<div class="form-group">

									<label>检车人</label>
									<select id="id_select" style="width: 180px;" class="selectpicker bla bla bli" multiple data-live-search="true" name="checkRecord.recorder"name="checkRecord.recorder">
										
									</select>

								

								</div>
								<div class="form-group">

									<label>联合检车</label>

									<input type="checkbox" style="height: 15px;" class="form-control" id="isTogether" name="checkRecord.isTogether" onclick="hideColumn(this)">

								</div>
							</div>
							<div class="row">
								<div class="form-group">

									<label>满意度</label>

									<input type="text" class="form-control" name="checkRecord.fullDegree" >

								</div>
								<div class="form-group">

									<label>是否通过</label>

									<input id="isPassed" type="checkbox" name="isPassed" checked>

								</div>
							</div>

							<div class="row">

								<div class="form-group">

									<label>记录人</label>

									<input type="text" class="form-control" name="checkRecord._recorder" value="<%=((User)session.getAttribute("user")).getUname()%>" readonly>

								</div>

								<div class="form-group">

									<label>记录日期</label>

									<input type="text" class="form-control" name="checkRecord._recordTime" readonly value="<%=(new  java.text.SimpleDateFormat(" yyyy/MM/dd ")).format(new java.util.Date()) %>">

								</div>
								<input type="button" value="提交" class="btn btn-success" onclick="makesubmit()" id="sb">

							</div>

						</form>

				</div>
			</div>
		</div>
		<div class="container" style="width: 95%;">
		       <iframe name="unPassReasonAdd"  style="width: 100%;height: 500px; border: 0px;" id="iframe"></iframe>
		</div>
		
    </div>
    <div role="tabpanel" class="tab-pane  active" id="profile">
    <div class="container">
    <div class="panel" >
          	<div class="panel-body">
  <%if(o!=null){%>
    <%Group group = (Group)o;%>
    <table class="table table-bordered table-hover table-striped">
      <tr>
        <th>车牌号</th>
        <th>承包人</th>
        <th>部门</th>
        <th>是否通过</th>
        <!-- <th>理由</th>-->
        <th>检车人</th>
        <th>检车时间</th>
        <th>删除</th>
      </tr>
      <%for(CheckRecord checkRecord:group.getCheckRecords()){%>
        <tr>
          <td><%=checkRecord.getLicenseNum()%></td>
          <td><%=checkRecord.getDriver()%></td>
          <td><%=checkRecord.getDept()%></td>
          <td><%=checkRecord.getIsPassed()?"是":"否"%></td>
          <!-- <td><%=checkRecord.getUnPassReason()==null?"无":checkRecord.getUnPassReason()%></td> -->
          <td><%=checkRecord.getRecorder()%></td>
          <td><%=checkRecord.getRecordTime()%></td>
          <%if(checkRecord.getRecorder() != null && checkRecord.getRecorder().contains(name)){%>
            <td><a href="/DZOMS/check/deleteRecord?recordId=<%=checkRecord.getId()%>&groupId=<%=group.getId()%>" >删除</a></td>
          <%}else{%>
            <td>无</td>
          <%}%>
        </tr>
      <%}%>
    </table>
  <%}%>
          	</div>
    </div>
</div>
    </div>
  </div>

</div>
</body>

</html>