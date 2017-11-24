<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" import="java.util.*,com.dz.module.vehicle.*,com.dz.module.user.User" pageEncoding="UTF-8" %>
<%@page import="org.springframework.web.context.support.*" %>
<%@page import="org.springframework.context.*" %>
<%@page import="org.apache.commons.collections.*" %>
<%
	String path=request.getContextPath();
	String basePath=request.getScheme()+ "://"+request.getServerName()+ ":"+request.getServerPort()+path+ "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.2, user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="renderer" content="webkit" />
	<title> 例会签到 </title>
	<link rel="stylesheet" href="/DZOMS/res/css/pintuer.css">
	<link rel="stylesheet" href="/DZOMS/res/css/admin.css">
	<link rel="stylesheet" type="text/css" href="/DZOMS/res/css/jquery.datetimepicker.css" />
	<script src="/DZOMS/res/js/jquery.js"> </script>
	<script src="/DZOMS/res/js/pintuer.js"> </script>
	<script src="/DZOMS/res/js/respond.js"> </script>
	<script type="text/javascript" src="/DZOMS/res/js/itemtool.js"></script>
	<script src="/DZOMS/res/js/admin.js"> </script>
	<link rel="stylesheet" href="/DZOMS/res/css/jquery.bigautocomplete.css" />
	<script type="text/javascript" src="/DZOMS/res/js/jquery.bigautocomplete.js" ></script>
	<script>
        $(document).ready(function(){
            $('[name="vehicleSele"]').submit(function(e){
                var dept = $("[name='dept']").val();
                var licenseNum = $("[name='licenseNum']").val();
                var licenseCondition = " ";

                if(licenseNum.trim().length>0){
                    licenseCondition = " and v.licenseNum like '%"+licenseNum.trim()+"%' ";
				}

                var filter = $("[name='filter']").val();
                var condition = "from MeetingCheck mc,Driver d,Vehicle v " +
                    "where mc.meetingId=${meeting.id} and mc.idNum=d.idNum and d.carframeNum=v.carframeNum " +
                    dept+licenseCondition+filter+
                    "order by v.dept,v.licenseNum";
                $('[name="condition"]').val(condition);
                return true;
            });

            $("[name='licenseNum']").bigAutocomplete({
                url:"/DZOMS/select/VehicleBylicenseNum",
                condition:" 1=1 order by licenseNum ",
                doubleClick:true,
                doubleClickDefault:'黑A'
            });
        });

        //<%--导入Excel--%>
        function checkByFileSubmit(){
            var formData = new FormData();
            formData.append("meeting.id","${meeting.id}");
            formData.append("fileCheck",$('#m_file')[0].files[0]);
            $.ajax({
                url : "checkByFile2",
                type : 'POST',
                data : formData,
// 告诉jQuery不要去处理发送的数据
                processData : false,
// 告诉jQuery不要去设置Content-Type请求头
                contentType : false,
                beforeSend:function(){
                    console.log("开始上传Excel...");
                },
                success : function(html) {
                    $('#errMap').html(html);
                },
                error : function(responseStr) {
                    console.log("上传失败");
                }
            });
        }
	</script>
	<style>
	</style>
</head>
<body>
<div class="line" >
	<div class="panel  margin-small" >
		<div class="panel-head">
			<form action="/DZOMS/common/selectToList2" class="form-inline" method="post" name="vehicleSele" target="result_form">
				<input type="hidden" name="url" value="/driver/meeting/meeting_show_result.jsp" />
				<input type="hidden" name="column" value="mc"/>
				<input type="hidden" name="condition" value=" from MeetingCheck mc,Driver d,Vehicle v where mc.idNum=d.idNum and d.carframeNum=v.carframeNum order by v.dept,v.licenseNum"/>
				<s:hidden name="meetingId" value="%{meeting.id}"></s:hidden>
				<div class="form-group">
					<div class="label">
						<label>部门</label>
					</div>
					<div class="field">
						<select name="dept" class="input">
							<option value=" " selected="selected">全部</option>
							<option value=" and v.dept='一部' " >一部</option>
							<option value=" and v.dept='二部' " >二部</option>
							<option value=" and v.dept='三部' " >三部</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>车牌号</label>
					</div>
					<div class="field">
						<input name="licenseNum" class="input" value="黑A"></input>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>状态</label>
					</div>
					<div class="field">
						<select name="filter" class="input">
							<option value=" ">全部</option>
							<option value=" and (mc.isChecked=false or mc.isChecked is null) " selected="selected">未签到</option>
							<option value=" and mc.isChecked=true ">已签到</option>
							<option value=" and mc.checkClass='迟到' ">迟到</option>
						</select>
					</div>
				</div>
				<div class="form-button">
					<input class="button  bg-gray" type="submit" value="查询">
					<a class="button  bg-gray" onclick="$('#m_file').click()">
						<span class="h6"><strong>导入</strong></span>
					</a>
				</div>
			</form>
		</div>
		<div class="panel-body">
			<iframe name="result_form" width="100%" height="1200px" id="result_form" scrolling="auto">

			</iframe>
		</div>
	</div>
</div>
<div id="errMap"></div>
<%--导入Excel--%>
<form style="width: 100%;" method="post" action="checkByFile" name="checkByFile" class="form-inline form-tips"
	  enctype="multipart/form-data">
	<s:hidden name="meeting.id"></s:hidden>
	<input type="file" id="m_file" name="fileCheck" onchange="checkByFileSubmit()" hidden="hidden"/>
</form>
<script src="/DZOMS/res/js/jquery.datetimepicker.js"> </script>
<script type="text/javascript" src="/DZOMS/res/js/DateTimeHelper.js"> </script>
</body>
</html>